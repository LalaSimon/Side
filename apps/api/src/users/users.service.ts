import {
  Injectable,
  ConflictException,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { RegisterUserDto } from './dto/register-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User, UserRole } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { IUserService } from './interfaces/user-service.interface';

@Injectable()
export class UsersService implements IUserService {
  constructor(private prisma: PrismaService) {}

  async register(registerUserDto: RegisterUserDto): Promise<User> {
    const { company, ...userData } = registerUserDto;

    const existingUser = await this.prisma.user.findUnique({
      where: { email: userData.email },
    });

    if (existingUser) {
      throw new ConflictException(
        `User with email "${userData.email}" already exists`,
      );
    }

    const hashedPassword = await bcrypt.hash(userData.password, 10);

    if (company) {
      return this.prisma.$transaction(async (tx) => {
        const newCompany = await tx.company.create({
          data: company,
        });

        return tx.user.create({
          data: {
            ...userData,
            password: hashedPassword,
            role: UserRole.HEAD_ADMIN,
            company: {
              connect: { id: newCompany.id },
            },
            headAdminFor: {
              connect: { id: newCompany.id },
            },
          },
        });
      });
    }

    // If no company data, create regular user
    return this.prisma.user.create({
      data: {
        ...userData,
        password: hashedPassword,
      },
    });
  }

  async getUsers(): Promise<User[]> {
    return this.prisma.user.findMany({
      include: {
        company: {
          select: {
            id: true,
            name: true,
          },
        },
      },
    });
  }

  async findOne(id: string): Promise<User> {
    const user = await this.prisma.user.findUnique({
      where: { id },
      include: {
        company: true,
      },
    });

    if (!user) {
      throw new NotFoundException(`User with ID "${id}" not found`);
    }

    return user;
  }

  async update(id: string, updateUserDto: UpdateUserDto): Promise<User> {
    await this.findOne(id); // Verify user exists

    if (updateUserDto.password) {
      updateUserDto.password = await bcrypt.hash(updateUserDto.password, 10);
    }

    return this.prisma.user.update({
      where: { id },
      data: updateUserDto,
    });
  }

  async remove(id: string): Promise<User> {
    await this.findOne(id); // Verify user exists

    return this.prisma.user.delete({
      where: { id },
    });
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.prisma.user.findUnique({
      where: { email },
      include: {
        company: true,
      },
    });
  }
}
