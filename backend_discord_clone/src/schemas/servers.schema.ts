import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { CallChannel } from "./call_channels.schema";
import { ChatChannel } from "./chat_channels.schema";
import { User } from "./user.schema";

export type ServerDocument = Server & Document;

@Schema()
export class Server {
    @Prop()
    id: String;

    @Prop()
    name: String;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }] 
    })
    members: User[];

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'ChatChannel' }] 
    })
    chat_channels: ChatChannel[];

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'CallChannel' }] 
    })
    call_channels: CallChannel[];
}
export const ServerSchema = SchemaFactory.createForClass(Server);