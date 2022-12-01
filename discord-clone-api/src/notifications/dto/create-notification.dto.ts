import { Prop } from '@nestjs/mongoose';
import { ApiProperty } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import mongoose from 'mongoose';
import { CallChannel } from 'src/call_channels/schemas';
import { ChatChannel } from 'src/chat_channels/schemas';
import { Server } from 'src/servers/schemas';
import { User } from 'src/users/schemas';

export class CreateNotificationDto {
  @ApiProperty({ required: true })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
  @Type(() => User)
  sender: string;

  @ApiProperty({ required: true })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
  @Type(() => User)
  receiver: string;

  @ApiProperty({ required: true })
  @Prop({ required: true })
  type: 'FRIEND' | 'MESSAGE' | 'SERVER' | 'CALL' | 'CHAT';

  @ApiProperty({ required: false, default: false })
  @Prop({ required: false, default: false })
  isResponse: boolean;

  @ApiProperty({ required: false, default: false })
  @Prop({ required: false, default: false })
  isAccept: boolean;

  @ApiProperty({ required: false })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'Server' })
  @Type(() => Server)
  serverId: string;

  @ApiProperty({ required: false })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'ChatChannel' })
  @Type(() => ChatChannel)
  chatId: string;

  @ApiProperty({ required: false })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'CallChannel' })
  @Type(() => CallChannel)
  callId: string;

  @ApiProperty({ required: true })
  @Prop({ required: true })
  content: string;
}
