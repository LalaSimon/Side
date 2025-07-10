import { IsString, IsOptional, IsUrl, IsPhoneNumber } from 'class-validator';

export class CreateCompanyDto {
  @IsString()
  name: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsString()
  @IsOptional()
  address?: string;

  @IsUrl()
  @IsOptional()
  website?: string;

  @IsPhoneNumber()
  @IsOptional()
  phoneNumber?: string;

  @IsString()
  @IsOptional()
  headAdminId?: string;
}
