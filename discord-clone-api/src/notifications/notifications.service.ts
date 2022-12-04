import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UsersService } from 'src/users/users.service';
import { CreateNotificationDto } from './dto/create-notification.dto';
import { Notification, NotificationDocument } from './schemas';

@Injectable()
export class NotificationsService {
  constructor(
    @InjectModel(Notification.name)
    private notificationModel: Model<NotificationDocument>,
    private userServices: UsersService,
  ) {}

  async create(createNotificationDto: CreateNotificationDto) {
    try {
      const notification = await new this.notificationModel(
        createNotificationDto,
      );
      const receiver = await this.userServices.findByNameID(
        createNotificationDto.friendUID,
      );
      notification.receiver = receiver._id;
      await notification.save();
      return notification;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  async findAllForReceiver(userId: string) {
    // console.log(userId);
    const notifications = await this.notificationModel
      .find({
        receiver: userId,
      })
      .lean()
      .populate('sender', ['_uid', 'name', 'avatar'])
      .populate('serverId', ['name', 'hostId'])
      .populate('chatId', ['name'])
      .populate('callId', ['name'])
      .exec();
    if (!notifications || !notifications[0]) {
      return [];
    }
    return notifications;
  }

  async findOne(_notiId: string, requestId: string) {
    // console.log(_notiId, requestId);
    const notification = await this.notificationModel
      .findOne({ _id: _notiId, receiver: requestId })
      .lean()
      .populate('sender', ['_uid', 'name', 'avatar'])
      .exec();
    if (!notification) {
      throw new HttpException('Notification not found', 404);
    }
    return notification;
  }

  async remove(_notiId: string, requestId: string) {
    // console.log(requestId);
    const notification = await this.notificationModel
      .deleteOne({ _id: _notiId, receiver: requestId })
      .exec();
    if (notification.deletedCount === 0) {
      throw new HttpException('Notification not found', 404);
    }
    return notification;
  }
}
