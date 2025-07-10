import { User } from '@prisma/client';
import { RegisterUserDto } from '../dto/register-user.dto';
import { UpdateUserDto } from '../dto/update-user.dto';

export interface IUserService {
  register(registerUserDto: RegisterUserDto): Promise<User>;
  getUsers(): Promise<User[]>;
  findOne(id: string): Promise<User>;
  update(id: string, updateUserDto: UpdateUserDto): Promise<User>;
  remove(id: string): Promise<User>;
  findByEmail(email: string): Promise<User | null>;
}
