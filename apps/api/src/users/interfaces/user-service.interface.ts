import { RegisterUserDto } from '../dto/register-user.dto';
import { UpdateUserDto } from '../dto/update-user.dto';
import { User } from '@prisma/client';

export interface IUserService {
  register(dto: RegisterUserDto): Promise<Omit<User, 'password'>>;
  findByEmail(email: string): Promise<User | null>;
  isEmailTaken(email: string): Promise<boolean>;
  getUsers(): Promise<User[]>;
  updateUser(id: string, dto: UpdateUserDto): Promise<Omit<User, 'password'>>;
}
