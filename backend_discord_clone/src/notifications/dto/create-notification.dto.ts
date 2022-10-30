export class CreateNotificationDto {
    id: string;
    sender: string;
    reciever: string;
    content: string;
    chat_channel: string;
    create_at: string;
    is_reply: boolean;
}
