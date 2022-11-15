import { ApiProperty } from "@nestjs/swagger";

export class CreateMessageDto {
    _id: string;

    @ApiProperty({required: true})
    user_id: string;

    @ApiProperty({required: true})
    content: string;

    @ApiProperty({required: true})
    create_at: string;

    @ApiProperty({required: false})
    update_at: string;

    @ApiProperty({required: false})
    reply: string;      // message_id
}
