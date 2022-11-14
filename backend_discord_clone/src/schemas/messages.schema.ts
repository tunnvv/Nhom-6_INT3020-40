import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Transform, Type } from "class-transformer";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";

export type MessageDocument = Message & Document;

@Schema()
export class Message {
    @Transform(({ value }) => value.toString())
    _id: string;

    @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
    @Type(() => User)
    user_id: User;

    @Prop()
    content: string;

    @Prop()
    create_at: string;

    @Prop()
    update_at: string;

    @Prop({ type: mongoose.Types.ObjectId, ref: 'Message' })
    @Type(() => Message)
    reply: Message
}
export const MessageSchema = SchemaFactory.createForClass(Message);