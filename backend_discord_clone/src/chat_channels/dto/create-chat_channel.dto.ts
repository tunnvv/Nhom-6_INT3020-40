export class CreateChatChannelDto {
    id: String;
    name: String;
    members: [];  // list user_id
    messages: []; // list message_id
}
