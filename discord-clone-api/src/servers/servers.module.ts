import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { ServersService } from './servers.service';
import { ServersController } from './servers.controller';
import { Server, ServerSchema } from './schemas';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Server.name, schema: ServerSchema }]),
  ],
  controllers: [ServersController],
  providers: [ServersService],
  exports: [ServersService],
})
export class ServersModule {}
