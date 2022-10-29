export class CreateMessageDto {
    id: string;
    user_id: string;
    content: string;
    create_at: string;
    update_at: string;
    reply: string;      // message_id
}
