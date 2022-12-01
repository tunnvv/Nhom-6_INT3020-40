import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UsersService } from 'src/users/users.service';
import { CreateServerDto, UpdateServerDto } from './dto';
import { Server, ServerDocument } from './schemas';

@Injectable()
export class ServersService {
  constructor(
    @InjectModel(Server.name) private serverModel: Model<ServerDocument>,
    private usersService: UsersService,
  ) {}

  async create(createServerDto: CreateServerDto) {
    const server = new this.serverModel(createServerDto);

    this.usersService.updateServerListById(
      createServerDto.hostId,
      server._id.toString(),
    );

    return server.save();
  }

  async findOne(_id: string, hostId: string) {
    return this.serverModel.findOne({ _id, hostId }).lean().exec();
  }

  async update(_id: string, hostId: string, updateServerDto: UpdateServerDto) {
    const server = await this.serverModel
      .findOne({ _id, hostId })
      .lean()
      .exec();

    if (!server) {
      return null;
    }

    if (updateServerDto.members) {
      let newFriends = updateServerDto.members.concat(server.members);
      const tmp = [];
      newFriends = newFriends.reduce((friendListNotDuplicate, element) => {
        if (!tmp.includes(element.toString())) {
          friendListNotDuplicate.push(element);
          tmp.push(element.toString());
        }
        return friendListNotDuplicate;
      }, []);

      updateServerDto.members = newFriends;
    }

    return this.serverModel.updateOne({ _id, hostId }, updateServerDto);
  }

  async updateFromChannel(_id: string, updateServerDto: UpdateServerDto) {
    return this.serverModel.updateOne({ _id }, updateServerDto);
  }

  async remove(_id: string, hostId: string) {
    const server = await this.serverModel.deleteOne({ _id, hostId }).exec();
    return server;
  }
}
