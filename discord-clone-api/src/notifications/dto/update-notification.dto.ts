import { Prop } from '@nestjs/mongoose';
import { ApiProperty } from '@nestjs/swagger';

export class UpdateNotificationDto {
  @ApiProperty({ required: false, default: false })
  @Prop({ required: false, default: false })
  isResponse: boolean;

  @ApiProperty({ required: false, default: false })
  @Prop({ required: false, default: false })
  isAccept: boolean;
}
