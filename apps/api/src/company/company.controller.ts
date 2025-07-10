import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { CompanyService } from './company.service';
import { CreateCompanyDto } from './dto/create-company.dto';
import { UpdateCompanyDto } from './dto/update-company.dto';
import { CreateCompanyUserDto } from './dto/create-company-user.dto';

@Controller('company')
export class CompanyController {
  constructor(private readonly companyService: CompanyService) {}

  @Post()
  create(@Body() createCompanyDto: CreateCompanyDto) {
    return this.companyService.create(createCompanyDto);
  }

  @Get()
  findAll() {
    return this.companyService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.companyService.findOne(id);
  }

  @Get('name/:name')
  findByName(@Param('name') name: string) {
    return this.companyService.findByName(name);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCompanyDto: UpdateCompanyDto) {
    return this.companyService.update(id, updateCompanyDto);
  }

  @Delete(':id')
  @HttpCode(HttpStatus.NO_CONTENT)
  remove(@Param('id') id: string) {
    return this.companyService.remove(id);
  }

  @Patch(':id/deactivate')
  deactivate(@Param('id') id: string) {
    return this.companyService.deactivate(id);
  }

  @Patch(':id/activate')
  activate(@Param('id') id: string) {
    return this.companyService.activate(id);
  }

  @Patch(':id/assign-user/:userId')
  assignUser(@Param('id') companyId: string, @Param('userId') userId: string) {
    return this.companyService.assignUser(companyId, userId);
  }

  @Post(':id/users')
  createCompanyUser(
    @Param('id') companyId: string,
    @Body() createCompanyUserDto: CreateCompanyUserDto,
  ) {
    return this.companyService.createCompanyUser(
      companyId,
      createCompanyUserDto,
    );
  }
}
