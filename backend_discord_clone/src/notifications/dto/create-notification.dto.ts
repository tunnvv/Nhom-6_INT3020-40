export class CreateNotificationDto {
    id: string;
    sender: string;
    receiver: string;
    content: string;
    chat_channel: string;
    create_at: string;
    is_reply: boolean;
}
