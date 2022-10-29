import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ChatChannel } from 'src/schemas/chat_channels.schema';
import { CreateChatChannelDto } from './dto/create-chat_channel.dto';
import { UpdateChatChannelDto } from './dto/update-chat_channel.dto';

@Injectable()
export class ChatChannelsService {

  constructor(@InjectModel(ChatChannel.name) private chatChannelModel: Model<ChatChannel>) {}

  async create(createChatChannelDto: CreateChatChannelDto): Promise<any> {
    const chat_channel = new this.chatChannelModel(createChatChannelDto);
    return chat_channel.save();
  }

  async findAll(): Promise<any> {
    const chat_channels = await this.chatChannelModel.find().exec();
    if (!chat_channels || !chat_channels[0]) {
      throw new HttpException("Not Found", 404);
    }
    return chat_channels;
  }

  async findOne(id: string) {
    const chat_channel = await this.chatChannelModel.findOne({id}).exec();
    if (!chat_channel) {
      throw new HttpException("Not Found", 404);
    }
    return chat_channel;
  }

  async update(id: string, updateChatChannelDto: UpdateChatChannelDto) {
    return `This action updates a #${id} chatChannel`;
  }

  async remove(id: string) {
    const chat_channel = await this.chatChannelModel.deleteOne({id}).exec();
    if (chat_channel.deletedCount === 0) {
      throw new HttpException("Not Found", 404);
    }
    return chat_channel;
  }
}
