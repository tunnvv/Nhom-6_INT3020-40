import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CallChannel, CallChannelDocument } from 'src/schemas/call_channels.schema';
import { CreateCallChannelDto } from './dto/create-call_channel.dto';
import { UpdateCallChannelDto } from './dto/update-call_channel.dto';

@Injectable()
export class CallChannelsService {

  constructor(@InjectModel(CallChannel.name) private callChannelModel: Model<CallChannelDocument>) {}

  async create(createCallChannelDto: CreateCallChannelDto): Promise<CallChannel> {
    const user = new this.callChannelModel(createCallChannelDto);
    return user.save();
  }

  async findAll(): Promise<any> {
    const call_channels = await this.callChannelModel.find().exec();
    if (!call_channels || !call_channels[0]) {
      throw new HttpException('Not Found', 404);
    }
    return call_channels;
  }

  async findOne(id: string) {
    const user = await this.callChannelModel.findOne({id}).exec();
    if (!user) {
      throw new HttpException('Not Found', 404);
    }
    return user;
  }

  async update(id: string, updateCallChannelDto: UpdateCallChannelDto) {
    return `This action updates a #${id} user`;
  }

  async remove(id: string) {
    const user = await this.callChannelModel.deleteOne({id}).exec();
    if (user.deletedCount === 0) {
      throw new HttpException('Not Found', 404);
    }
    return user;
  }

  // create(createCallChannelDto: CreateCallChannelDto) {
  //   return 'This action adds a new callChannel';
  // }

  // findAll() {
  //   return `This action returns all callChannels`;
  // }

  // findOne(id: number) {
  //   return `This action returns a #${id} callChannel`;
  // }

  // update(id: number, updateCallChannelDto: UpdateCallChannelDto) {
  //   return `This action updates a #${id} callChannel`;
  // }

  // remove(id: number) {
  //   return `This action removes a #${id} callChannel`;
  // }
}
