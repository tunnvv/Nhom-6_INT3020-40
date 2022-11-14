import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Transform, Type } from "class-transformer";
import mongoose, { ObjectId, Document } from "mongoose";
import { ChatChannel } from "./chat_channels.schema";
import { Message } from "./messages.schema";
import { User } from "./user.schema";

export type NotificationDocument = Notification & Document;

@Schema()
export class Notification {
    @Transform(({ value }) => value.toString())
    _id: ObjectId;

    @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
    @Type(() => User)
    sender: User;

    @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
    @Type(() => User)
    receiver: User;

    @Prop()
    content: string;

    @Prop({ type: mongoose.Types.ObjectId, ref: 'ChatChannel' })
    @Type(() => ChatChannel)
    chat_channel: ChatChannel;

    @Prop()
    create_at: string;

    @Prop({default: false})
    is_reply: boolean;
}
export const NotificationSchema = SchemaFactory.createForClass(Notification);