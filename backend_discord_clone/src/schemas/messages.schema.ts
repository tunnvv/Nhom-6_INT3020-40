import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";

export type MessageDocument = Message & Document;

@Schema()
export class Message {
    @Prop()
    id: String;

    @Prop({
        type: mongoose.Types.ObjectId,
        ref: 'User',
    })
    user_id: User;

    @Prop()
    content: String;

    @Prop()
    create_at: String;

    @Prop()
    update_at: String;

    @Prop({
        type: mongoose.Types.ObjectId,
        ref: 'Message',
    })
    reply: Message
}
export const MessageSchema = SchemaFactory.createForClass(Message);