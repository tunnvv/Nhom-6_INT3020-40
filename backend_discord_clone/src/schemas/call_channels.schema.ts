import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Transform, Type } from "class-transformer";
import mongoose, { ObjectId, Document } from "mongoose";
import { User } from "./user.schema";

export type CallChannelDocument = CallChannel & Document;

@Schema()
export class CallChannel {
    @Transform(({ value }) => value.toString())
    _id: ObjectId;

    @Prop()
    name: string;

    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    })
    @Type(() => User)
    members: User;
}
export const CallChannelSchema = SchemaFactory.createForClass(CallChannel);