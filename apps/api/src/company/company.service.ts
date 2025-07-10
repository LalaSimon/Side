import {
  Injectable,
  NotFoundException,
  ConflictException,
} from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { Company, User } from '@prisma/client';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';
import { CreateCompanyUserDto } from './dto/create-company-user.dto';
import { ICompanyService } from './interfaces/company-service.interface';
import * as bcrypt from 'bcrypt';

@Injectable()
export class CompanyService implements ICompanyService {
  constructor(private prisma: PrismaService) {}

  async create(createCompanyDto: CreateCompanyDto): Promise<Company> {
    return this.prisma.company.create({
      data: createCompanyDto,
    });
  }

  async findAll(): Promise<Company[]> {
    return this.prisma.company.findMany();
  }

  async findOne(id: string): Promise<Company> {
    const company = await this.prisma.company.findUnique({
      where: { id },
    });

    if (!company) {
      throw new NotFoundException(`Company with ID "${id}" not found`);
    }

    return company;
  }

  async update(
    id: string,
    updateCompanyDto: UpdateCompanyDto,
  ): Promise<Company> {
    await this.findOne(id); // Verify company exists

    return this.prisma.company.update({
      where: { id },
      data: updateCompanyDto,
    });
  }

  async remove(id: string): Promise<Company> {
    await this.findOne(id); // Verify company exists

    return this.prisma.company.delete({
      where: { id },
    });
  }

  async findByName(name: string): Promise<Company> {
    const company = await this.prisma.company.findUnique({
      where: { name },
    });

    if (!company) {
      throw new NotFoundException(`Company with name "${name}" not found`);
    }

    return company;
  }

  async deactivate(id: string): Promise<Company> {
    await this.findOne(id); // Verify company exists

    return this.prisma.company.update({
      where: { id },
      data: { isActive: false },
    });
  }

  async activate(id: string): Promise<Company> {
    await this.findOne(id); // Verify company exists

    return this.prisma.company.update({
      where: { id },
      data: { isActive: true },
    });
  }

  async assignUser(companyId: string, userId: string): Promise<Company> {
    // Verify company exists
    await this.findOne(companyId);

    // Verify user exists and update their company
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
    });

    if (!user) {
      throw new NotFoundException(`User with ID "${userId}" not found`);
    }

    // Update user's company
    return this.prisma.company.update({
      where: { id: companyId },
      data: {
        users: {
          connect: { id: userId },
        },
      },
      include: {
        users: true,
      },
    });
  }

  async createCompanyUser(
    companyId: string,
    createCompanyUserDto: CreateCompanyUserDto,
  ): Promise<User> {
    await this.findOne(companyId);

    const existingUser = await this.prisma.user.findUnique({
      where: { email: createCompanyUserDto.email },
    });

    if (existingUser) {
      throw new ConflictException(
        `User with email "${createCompanyUserDto.email}" already exists`,
      );
    }

    const hashedPassword = await bcrypt.hash(createCompanyUserDto.password, 10);

    return this.prisma.user.create({
      data: {
        ...createCompanyUserDto,
        password: hashedPassword,
        company: {
          connect: { id: companyId },
        },
      },
    });
  }
}
