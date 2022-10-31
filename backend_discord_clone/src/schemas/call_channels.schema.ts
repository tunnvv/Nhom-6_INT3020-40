import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { User } from "./user.schema";

export type CallChannelDocument = CallChannel & Document;

@Schema()
export class CallChannel {
    @Prop()
    id: String;

    @Prop()
    name: String;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }] 
    })
    members: User[];
}
export const CallChannelSchema = SchemaFactory.createForClass(CallChannel);