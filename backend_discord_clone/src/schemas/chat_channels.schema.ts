import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { Message } from "./messages.schema";
import { User } from "./user.schema";

export type ChatChannelDocument = ChatChannel & Document;

@Schema()
export class ChatChannel {
    @Prop()
    id: String;

    @Prop()
    name: String;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }] 
    })
    members: User[];

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Message' }] 
    })
    messages: Message[];
}
export const ChatChannelSchema = SchemaFactory.createForClass(ChatChannel);