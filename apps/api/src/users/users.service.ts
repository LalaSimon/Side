import {
  Injectable,
  ConflictException,
  BadRequestException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { RegisterUserDto } from './dto/register-user.dto';
import { IUserService } from './interfaces/user-service.interface';
import { User } from '@prisma/client';
import { hash } from 'bcrypt-ts';

@Injectable()
export class UsersService implements IUserService {
  private readonly SALT_ROUNDS = 10;

  constructor(private readonly prisma: PrismaService) {}

  async register(dto: RegisterUserDto): Promise<Omit<User, 'password'>> {
    await this.validateRegistration(dto);

    const hashedPassword = await this.hashPassword(dto.password);

    const alreadyCreated = await this.isEmailTaken(dto.email);
    if (alreadyCreated) {
      throw new ConflictException('Email already exists');
    }
    const user = await this.prisma.user.create({
      data: {
        ...dto,
        password: hashedPassword,
      },
      select: {
        id: true,
        email: true,
        firstName: true,
        lastName: true,
        role: true,
        position: true,
        phoneNumber: true,
        department: true,
        createdAt: true,
        updatedAt: true,
        lastLoginAt: true,
        isActive: true,
        avatar: true,
      },
    });

    return user;
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.prisma.user.findUnique({
      where: { email },
    });
  }

  async isEmailTaken(email: string): Promise<boolean> {
    const user = await this.findByEmail(email);
    return !!user;
  }

  private async validateRegistration(dto: RegisterUserDto): Promise<void> {
    if (await this.isEmailTaken(dto.email)) {
      throw new ConflictException('Email already exists');
    }
  }

  private async hashPassword(password: string): Promise<string> {
    if (!password) throw new BadRequestException('Password is required');
    return hash(password, this.SALT_ROUNDS);
  }

  async getUsers(): Promise<User[]> {
    return this.prisma.user.findMany();
  }
}
