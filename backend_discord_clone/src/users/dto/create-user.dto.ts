import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty } from 'class-validator';

export class CreateUserDto {
    
    _uid: string;

    @ApiProperty({required: true})
    name: string;

    @ApiProperty({required: true})
    email: string;

    @ApiProperty({default:null ,required: false})
    phone?: string;

    @ApiProperty({required: true})
    pwd: string;
    
    @ApiProperty({default:null ,required: false})
    status?: string;

    @ApiProperty({default:null ,required: false})
    wallpaper?: string;

    @ApiProperty({default:null ,required: false})
    avatar?: string;

    @ApiProperty({default:null ,required: false})
    bio?: string;

    @ApiProperty({default:null ,required: false})
    servers?: [];

    @ApiProperty({default:null ,required: false})
    friends?: [];
}
