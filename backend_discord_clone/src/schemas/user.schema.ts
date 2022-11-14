import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Exclude, Transform, Type } from "class-transformer";
import mongoose, { Document, ObjectId } from "mongoose";
import { Server } from "./servers.schema";

import {} from '@nestjs/common'
import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsString, MaxLength, MinLength } from "class-validator";


export type UserDocument = User & Document;


@Schema()
export class User {
    @Transform(({ value }) => value.toString())
    _id: ObjectId;

    @Prop({unique: true})
    _uid: string // nguyenvantu#1234

    @ApiProperty({required: true})
    @IsString()
    @MinLength(4)
    @MaxLength(20)
    @Prop({required: true})
    name: string;

    @ApiProperty({required: true})
    @IsEmail()
    @IsString()
    @MinLength(4)
    @Prop({unique: true})
    email: string;

    @ApiProperty()
    @Prop({unique: true})
    phone: string;

    @ApiProperty({required: true})
    @IsString()
    @MinLength(8)
    @Prop({required: true})
    @Exclude()
    pwd: string;

    @ApiProperty({required: false})
    @Prop()
    status?: string;

    @ApiProperty({required: false})
    @Prop()
    wallpaper?: string;

    @ApiProperty({required: false})
    @Prop()
    avatar?: string;

    @ApiProperty({required: false})
    @Prop()
    bio?: string;


    @ApiProperty({required: false})
    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Server' }],
    })
    @Type(() => Server)
    servers?: Server;


    @ApiProperty({required: false})
    @Prop({
        type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    })
    @Type(() => User)
    friends?: User;
}
export const UserSchema = SchemaFactory.createForClass(User);