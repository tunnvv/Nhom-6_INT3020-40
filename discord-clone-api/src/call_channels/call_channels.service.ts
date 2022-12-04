import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { ServersService } from 'src/servers/servers.service';
import { CreateCallChannelDto, UpdateCallChannelDto } from './dto';
import { CallChannel, CallChannelDocument } from './schemas';

@Injectable()
export class CallChannelsService {
  constructor(
    @InjectModel(CallChannel.name)
    private callChannelModel: Model<CallChannelDocument>,
    private serversService: ServersService,
  ) {}

  async create(createCallChannelDto: CreateCallChannelDto) {
    const { hostId, serverId } = createCallChannelDto;
    const server = await this.serversService.findOne(serverId, hostId);

    if (!server) {
      return null;
    }

    const callChannel = new this.callChannelModel(createCallChannelDto);
    callChannel.members.push(hostId);
    await callChannel.save();

    const newCallChannelList = [callChannel._id].concat(server.callChannels);
    return this.serversService.updateChannelList(serverId, {
      callChannels: newCallChannelList,
    });
  }

  async update(
    _id: string,
    hostId: string,
    updateCallChannelDto: UpdateCallChannelDto,
  ) {
    const channel = await this.callChannelModel.findOne({ _id, hostId }).lean();

    if (!channel) {
      return null;
    }

    if (updateCallChannelDto.members) {
      let newFriends = updateCallChannelDto.members.concat(channel.members);
      const tmp = [];
      newFriends = newFriends.reduce((friendListNotDuplicate, element) => {
        if (!tmp.includes(element.toString())) {
          friendListNotDuplicate.push(element);
          tmp.push(element.toString());
        }
        return friendListNotDuplicate;
      }, []);

      updateCallChannelDto.members = newFriends;
    }

    return this.callChannelModel.updateOne(
      { _id, hostId },
      updateCallChannelDto,
    );
  }

  async remove(_id: string, hostId: string) {
    const channel = await this.callChannelModel
      .deleteOne({ _id, hostId })
      .exec();
    if (channel.deletedCount === 0) {
      throw new HttpException('Không tồn tại call channel', 404);
    }
    return channel;
  }
}
