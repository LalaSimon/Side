import { IsString, IsEmail, IsOptional, IsEnum } from 'class-validator';
import { UserRole } from '@prisma/client';

export class CreateCompanyUserDto {
  @IsEmail()
  email: string;

  @IsString()
  password: string;

  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsEnum(UserRole)
  @IsOptional()
  role?: UserRole = UserRole.EMPLOYEE;

  @IsString()
  @IsOptional()
  position?: string;

  @IsString()
  @IsOptional()
  phoneNumber?: string;

  @IsString()
  @IsOptional()
  department?: string;
}
