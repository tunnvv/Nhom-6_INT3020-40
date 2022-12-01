import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ServersModule } from 'src/servers/servers.module';
import { ChatChannelsController } from './chat_channels.controller';
import { ChatChannelsService } from './chat_channels.service';
import { ChatChannel, ChatChannelSchema } from './schemas';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: ChatChannel.name, schema: ChatChannelSchema },
    ]),
    ServersModule,
  ],
  controllers: [ChatChannelsController],
  providers: [ChatChannelsService],
})
export class ChatChannelsModule {}
