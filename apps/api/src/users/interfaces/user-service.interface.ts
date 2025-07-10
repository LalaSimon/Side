import { RegisterUserDto } from '../dto/register-user.dto';
import { User } from '@prisma/client';

export interface IUserService {
  register(dto: RegisterUserDto): Promise<Omit<User, 'password'>>;
  findByEmail(email: string): Promise<User | null>;
  isEmailTaken(email: string): Promise<boolean>;
  getUsers(): Promise<User[]>;
}
