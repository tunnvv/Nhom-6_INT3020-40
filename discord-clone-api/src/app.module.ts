import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './authentication/auth.module';
import { CallChannelsModule } from './call_channels/call_channels.module';
import { ChatChannelsModule } from './chat_channels/chat_channels.module';
import { MessagesModule } from './messages/messages.module';
import { NotificationsModule } from './notifications/notifications.module';
import { ServersModule } from './servers/servers.module';
import { UsersModule } from './users/users.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    MongooseModule.forRoot(
      process.env.DATABASE_URL
      // 'mongodb://localhost/discord_clone',
    ),
    AuthModule,
    UsersModule,
    CallChannelsModule,
    MessagesModule,
    ChatChannelsModule,
    ServersModule,
    NotificationsModule,
  ],
})
export class AppModule {}
