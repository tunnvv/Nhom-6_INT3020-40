import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Server, ServerDocument } from 'src/schemas/servers.schema';
import { CreateServerDto } from './dto/create-server.dto';
import { UpdateServerDto } from './dto/update-server.dto';

@Injectable()
export class ServersService {

  constructor(@InjectModel(Server.name) private serverModel: Model<ServerDocument>) {}

  async create(createServerDto: CreateServerDto) {
    const server = new this.serverModel(createServerDto);
    return server.save();
  }

  async findAll() {
    const servers = await this.serverModel.find().populate(['members', 'chat_channels', 'call_channels']);
    if (!servers || !servers[0]) {
      throw new HttpException("Not Found", 404);
    }
    return servers;
  }

  async findOne(id: string) {
    const server = await this.serverModel.findOne({id}).exec();
    if (!server) {
      throw new HttpException("Not Found", 404);
    }
    return server;
  }

  async update(id: string, updateServerDto: UpdateServerDto) {
    return `This action updates a #${id} server`;
  }

  async remove(id: string) {
    const server = await this.serverModel.deleteOne({id}).exec();
    if (server.deletedCount === 0) {
      throw new HttpException("Not Found", 404);
    }
    return server;
  }
}
