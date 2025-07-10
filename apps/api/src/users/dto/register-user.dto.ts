import {
  IsString,
  IsEmail,
  IsOptional,
  IsObject,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';

class CompanyRegistrationDto {
  @IsString()
  name: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsString()
  @IsOptional()
  address?: string;

  @IsString()
  @IsOptional()
  website?: string;

  @IsString()
  @IsOptional()
  phoneNumber?: string;
}

export class RegisterUserDto {
  @IsEmail()
  email: string;

  @IsString()
  password: string;

  @IsString()
  firstName: string;

  @IsString()
  lastName: string;

  @IsString()
  @IsOptional()
  position?: string;

  @IsString()
  @IsOptional()
  phoneNumber?: string;

  @IsString()
  @IsOptional()
  department?: string;

  @IsObject()
  @IsOptional()
  @ValidateNested()
  @Type(() => CompanyRegistrationDto)
  company?: CompanyRegistrationDto;
}
