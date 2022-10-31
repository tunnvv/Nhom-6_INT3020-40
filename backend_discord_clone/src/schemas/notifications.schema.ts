import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { ChatChannel } from "./chat_channels.schema";
import { Message } from "./messages.schema";
import { User } from "./user.schema";

export type NotificationDocument = Notification & Document;

@Schema()
export class Notification {
    @Prop()
    id: String;

    @Prop({
        type: mongoose.Types.ObjectId,
        ref: 'User',
    })
    sender: User;

    @Prop({
        type: mongoose.Types.ObjectId,
        ref: 'User',
    })
    receiver: User;

    @Prop()
    content: String;

    @Prop({
        type: mongoose.Types.ObjectId,
        ref: 'ChatChannel',
    })
    chat_channel: ChatChannel;

    @Prop()
    create_at: String;

    @Prop({default: false})
    is_reply: Boolean;
}
export const NotificationSchema = SchemaFactory.createForClass(Notification);