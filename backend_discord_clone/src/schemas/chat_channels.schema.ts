import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Transform, Type } from "class-transformer";
import mongoose, { ObjectId, Document } from "mongoose";
import { Message } from "./messages.schema";
import { User } from "./user.schema";

export type ChatChannelDocument = ChatChannel & Document;

@Schema()
export class ChatChannel {
    @Transform(({ value }) => value.toString())
    _id: ObjectId;

    @Prop()
    name: string;

    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    })
    @Type(() => User)
    members: User;

    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Message' }],
    })
    @Type(() => Message)
    messages: Message;
}
export const ChatChannelSchema = SchemaFactory.createForClass(ChatChannel);