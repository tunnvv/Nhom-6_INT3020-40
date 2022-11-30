import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { CreateUserDto, UpdateUserDto } from './dto';
import { User, UserDocument } from './schemas';
import { gen_user_id } from 'src/utils/func.backup';

@Injectable()
export class UsersService {
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}

  // Create a user with input infomation
  // Auto gen user_id: name + "#" + rand_number(0000 -> 9999)

  async createUser(createUserDto: CreateUserDto): Promise<User> {
    const user = new this.userModel(createUserDto);

    // create new uid
    let uid = gen_user_id(user.name);
    // if duplication, create new uid
    while (await this.userModel.findOne({ _uid: uid })) {
      uid = gen_user_id(user.name);
    }
    // set final uid
    user._uid = uid;
    return user.save();
  }

  async findAll(name?: string): Promise<User[]> {
    const users = await this.userModel
      .find()
      .populate('friends', ['_uid', 'name', 'avatar'])
      .exec();

    if (name) {
      return users.filter((user) => user.name === name);
    }
    return users;
  }

  async findUserByObjID(id: string): Promise<User> {
    const user = await this.userModel.findOne({ _id: id }).exec();
    return user;
  }

  async findUserByNameID(uid: string): Promise<User> {
    const user = await this.userModel.findOne({ uid: uid }).exec();
    return user;
  }

  async findUserByEmail(email: string): Promise<User> {
    const user = await this.userModel.findOne({ email: email }).exec();
    return user;
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    const user = this.userModel.findOne({ _id: id }).exec();

    // if name changed, must change _uid
    if (updateUserDto.name) {
      // create new uid
      let uid = gen_user_id(updateUserDto.name);
      // if duplication, create new uid
      while (await this.userModel.findOne({ _uid: uid })) {
        uid = gen_user_id(updateUserDto.name);
      }
      // set final uid
      updateUserDto._uid = uid;
    }

    // add new friend
    if (updateUserDto.friends) {
      updateUserDto.friends = updateUserDto.friends.concat(
        (await user).friends,
      );
    }

    // add new server
    if (updateUserDto.servers) {
      updateUserDto.servers = updateUserDto.servers.concat(
        (await user).servers,
      );
    }

    return this.userModel.updateOne({ _id: id }, updateUserDto);
  }

  async remove(id: string) {
    const user = await this.userModel.deleteOne({ _id: id }).exec();
    return user;
  }
}
