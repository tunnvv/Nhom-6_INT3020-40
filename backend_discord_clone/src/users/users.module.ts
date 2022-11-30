import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { User, UserSchema } from './schemas';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

@Module({
  // xac dinh model nao duoc dang ky
  imports: [
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
  ],

  //
  controllers: [UsersController],

  //
  providers: [UsersService],
  exports: [UsersService],
})
export class UsersModule {}
