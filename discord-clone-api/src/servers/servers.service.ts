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

    // host add this new server to the server list
    this.usersService.updateServerList(
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

    // SERVER UPDATE MEMBERS ADN MEMBERS UPDATE SERVER
    if (updateServerDto.members) {
      // find users is really exist, assign them to updateServerDto.members
      const findedUsers = [];
      updateServerDto.members.forEach((userId) => {
        if (this.usersService.findByObjID(userId)) {
          findedUsers.push(userId);
        }
      });
      updateServerDto.members = findedUsers;

      // members update servers, checked unique servers for members
      updateServerDto.members.forEach((member) => {
        this.usersService.updateServerList(member, server._id);
      });

      // server update members, check unique servers for members
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

  // ADD A NEW USER TO MEMBER LIST
  // - need to check the members are not duplicated
  //      + check when adding member to member list
  async updateMemberList(_id: string, userId: string) {
    const server = await this.serverModel.findById({ _id }).lean().exec();
    const user = await this.usersService.findByObjID(userId);

    if (!server || !user) {
      return null;
    }

    // add this server to the server list of user
    this.usersService.updateServerList(userId, server._id.toString());

    // add this user to member list of server
    let newMembers = [userId].concat(server.members);
    const tmp = [];
    newMembers = newMembers.reduce((memberListNotDuplicate, element) => {
      if (!tmp.includes(element.toString())) {
        memberListNotDuplicate.push(element);
        tmp.push(element.toString());
      }
      return memberListNotDuplicate;
    }, []);

    return this.serverModel.updateOne({ _id }, { members: newMembers });
  }

  // ADD A NEW CHANNEL TO CHANNEL LIST
  // Don't need check channel is unique,
  // because the function is only called when a new channel is created
  async updateChannelList(_id: string, updateServerDto: UpdateServerDto) {
    return this.serverModel.updateOne({ _id }, updateServerDto);
  }

  async remove(_id: string, hostId: string) {
    const server = await this.serverModel.deleteOne({ _id, hostId }).exec();
    return server;
  }
}
