import {
  ForbiddenException,
  HttpException,
  HttpStatus,
  Injectable,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateMessageDto, UpdateMessageDto } from './dto';
import { Message, MessageDocument } from './schemas';

@Injectable()
export class MessagesService {
  constructor(
    @InjectModel(Message.name) private messageModel: Model<MessageDocument>,
  ) {}

  async create(createMessageDto: CreateMessageDto) {
    // get current miliseconds time and set to create_at
    const message = new this.messageModel(createMessageDto);

    return message.save();
  }

  async findOneByObjID(id: string) {
    try {
      const message = await this.messageModel
        .findOne({ _id: id })
        .populate('ownerId', ['_uid', 'name', 'avatar'])
        .populate('replyMessageId', ['_id', 'content']);
      return message;
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('Message not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  async update(
    mesId: string,
    ownerId: string,
    updateMessageDto: UpdateMessageDto,
  ) {
    try {
      const message = await this.messageModel.findOneAndUpdate(
        { _id: mesId, ownerId: ownerId },
        updateMessageDto,
      );

      return message;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  async remove(mesId: string, _ownerId: string) {
    try {
      const message = await this.messageModel
        .deleteOne({ _id: mesId, ownerId: _ownerId })
        .exec();

      return message;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }
}
