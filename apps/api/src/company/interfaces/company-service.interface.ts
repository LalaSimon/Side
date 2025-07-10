import { Company, User } from '@prisma/client';
import { CreateCompanyDto } from '../dto/create-company.dto';
import { UpdateCompanyDto } from '../dto/update-company.dto';
import { CreateCompanyUserDto } from '../dto/create-company-user.dto';

export interface ICompanyService {
  create(createCompanyDto: CreateCompanyDto): Promise<Company>;
  findAll(): Promise<Company[]>;
  findOne(id: string): Promise<Company>;
  update(id: string, updateCompanyDto: UpdateCompanyDto): Promise<Company>;
  remove(id: string): Promise<Company>;
  findByName(name: string): Promise<Company>;
  deactivate(id: string): Promise<Company>;
  activate(id: string): Promise<Company>;
  assignUser(companyId: string, userId: string): Promise<Company>;
  createCompanyUser(
    companyId: string,
    createCompanyUserDto: CreateCompanyUserDto,
  ): Promise<User>;
}
