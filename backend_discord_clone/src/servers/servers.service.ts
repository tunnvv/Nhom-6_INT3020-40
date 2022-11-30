import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreateServerDto, UpdateServerDto } from './dto';
import { Server, ServerDocument } from './schemas';

@Injectable()
export class ServersService {
  constructor(
    @InjectModel(Server.name) private serverModel: Model<ServerDocument>,
  ) {}

  async create(createServerDto: CreateServerDto) {
    const server = new this.serverModel(createServerDto);
    return server.save();
  }

  async findAll() {
    const servers = await this.serverModel
      .find()
      .populate('members', ['_uid', 'name', 'avatar'])
      .populate('chatChannels')
      .populate('callChannels')
      .exec();

    return servers;
  }

  async findOne(id: string) {
    const server = await this.serverModel
      .findOne({ id })
      .populate('members', ['_uid', 'name', 'avatar'])
      .populate('chatChannels')
      .populate('callChannels')
      .exec();

    return server;
  }

  async update(id: string, updateServerDto: UpdateServerDto) {
    const server = this.serverModel.findOne({ _id: id }).exec();

    if (updateServerDto.members) {
      updateServerDto.members = updateServerDto.members.concat(
        (await server).members,
      );
    }

    if (updateServerDto.chatChannels) {
      updateServerDto.chatChannels = updateServerDto.chatChannels.concat(
        (await server).chatChannels,
      );
    }

    if (updateServerDto.callChannels) {
      updateServerDto.callChannels = updateServerDto.callChannels.concat(
        (await server).callChannels,
      );
    }

    return this.serverModel.findOneAndUpdate({ _id: id }, updateServerDto);
  }

  async remove(id: string) {
    const server = await this.serverModel.deleteOne({ id }).exec();

    return server;
  }
}
