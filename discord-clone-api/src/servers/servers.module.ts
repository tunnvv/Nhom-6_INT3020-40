import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { ServersService } from './servers.service';
import { ServersController } from './servers.controller';
import { Server, ServerSchema } from './schemas';
import { UsersService } from 'src/users/users.service';
import { User, UserSchema } from 'src/users/schemas';
import { JwtService } from '@nestjs/jwt';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Server.name, schema: ServerSchema },
      { name: User.name, schema: UserSchema },
    ]),
  ],
  controllers: [ServersController],
  providers: [ServersService, UsersService, JwtService],
  exports: [ServersService],
})
export class ServersModule {}
