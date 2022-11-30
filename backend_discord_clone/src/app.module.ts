import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CallChannelsModule } from './call_channels/call_channels.module';
import { ChatChannelsModule } from './chat_channels/chat_channels.module';
import { MessagesModule } from './messages/messages.module';
import { NotificationsModule } from './notifications/notifications.module';
import { ServersModule } from './servers/servers.module';
import { UsersModule } from './users/users.module';

@Module({
  imports: [
    MongooseModule.forRoot(
      'mongodb+srv://nvtuu:8o6eEszG4nTna901@cluster0.paz9bs4.mongodb.net/my_discord_clone_db?retryWrites=true&w=majority',
    ),
    UsersModule,
    CallChannelsModule,
    MessagesModule,
    ChatChannelsModule,
    ServersModule,
    NotificationsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
