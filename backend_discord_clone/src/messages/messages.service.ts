import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Message, MessageDocument } from 'src/schemas/messages.schema';
import { CreateMessageDto } from './dto/create-message.dto';
import { UpdateMessageDto } from './dto/update-message.dto';

@Injectable()
export class MessagesService {

  constructor(@InjectModel(Message.name) private messageModel: Model<MessageDocument>) {}

  async create(createMessageDto: CreateMessageDto) {
    const message = new this.messageModel(createMessageDto);
    return message.save();
  }

  async findAll() {
    const messages = await this.messageModel.find().exec();
    if (!messages || messages[0]) {
      throw new HttpException("Not Found", 404);
    }
    return messages;
  }

  async findOneByObjID(id: string) {
    const message = await this.messageModel.findOne({id}).exec();
    if (!message) {
      throw new HttpException("Not Found", 404);
    }
    return message;
  }

  async update(id: string, updateMessageDto: UpdateMessageDto) {
    return `This action updates a #${id} message`;
  }

  async remove(id: string) {
    const message = await this.messageModel.deleteOne({id}).exec();
    if ((await message).deletedCount === 0) {
      throw new HttpException("Not Found", 404);
    }
    return message;
  }
}
