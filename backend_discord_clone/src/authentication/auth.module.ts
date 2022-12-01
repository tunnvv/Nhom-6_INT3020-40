import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { JwtService } from '@nestjs/jwt';

import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { JwtStratege } from './strategy';

import { UsersService } from 'src/users/users.service';
import { User, UserSchema } from 'src/users/schemas';

@Module({
  // xac dinh model nao duoc dang ky
  imports: [
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
  ],
  controllers: [AuthController],
  providers: [UsersService, AuthService, JwtService, JwtStratege],
  exports: [AuthService],
})
export class AuthModule {}
