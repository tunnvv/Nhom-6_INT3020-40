import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { Server } from "./servers.schema";

export type UserDocument = User & Document;

@Schema()
export class User {
    @Prop()
    id: String;

    @Prop()
    name: String;

    @Prop()
    email: String;

    @Prop()
    phone: String;

    @Prop()
    pwd: String;

    @Prop()
    status: String;

    @Prop()
    wallpaper: String;

    @Prop()
    avatar: String;

    @Prop()
    bio: String;

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Server' }] 
    })
    servers: Server[];

    @Prop({ 
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }] 
    })
    friends: User[];
}
export const UserSchema = SchemaFactory.createForClass(User);