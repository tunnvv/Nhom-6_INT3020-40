import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Transform, Type } from "class-transformer";
import mongoose, { Document } from "mongoose";
import { CallChannel } from "./call_channels.schema";
import { ChatChannel } from "./chat_channels.schema";
import { User } from "./user.schema";

export type ServerDocument = Server & Document;

@Schema()
export class Server {
    @Transform(({ value }) => value.toString())
    _id: string;

    @Prop({required: true})
    name: string;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    })
    @Type(() => User)
    members: User;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'ChatChannel' }], 
    })
    @Type(() => ChatChannel)
    chat_channels: ChatChannel;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'CallChannel' }], 
    })
    @Type(() => CallChannel)
    call_channels: CallChannel;
}
export const ServerSchema = SchemaFactory.createForClass(Server);