export class CreateUserDto {
    id: string;
    name: string;
    email: string;
    phone: string;
    pwd: string;
    status: string;
    wallpaper: string;
    avatar: string;
    bio: string;
    servers: [];
    friends: [];
}
