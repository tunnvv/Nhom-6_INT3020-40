import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UpdateNotificationDto } from 'src/notifications/dto/update-notification.dto';
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
      if (createNotificationDto.type == 'FRIEND') {
        const receiver = await this.userServices.findByNameID(
          createNotificationDto.friendUID,
        );
        if (!receiver) {
          console.log('abc');
          return null;
        }

        createNotificationDto.receiver = receiver._id;
      }

      const notification = await this.notificationModel.create(
        createNotificationDto,
      );

      await notification.save();
      return notification;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  async findAllForReceiver(userId: string) {
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

    return notifications;
  }

  async findOne(_notiId: string, requestId: string) {
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

  async update(
    notificationId: string,
    receiver: string,
    updateNotificationDto: UpdateNotificationDto,
  ) {
    const notification = await this.notificationModel
      .findOne({ _id: notificationId, receiver })
      .lean()
      .exec();

    if (!notification) {
      return null;
    }

    return this.notificationModel.updateOne(
      { _id: notificationId },
      updateNotificationDto,
    );
  }

  async remove(_notiId: string, requestId: string) {
    const notification = await this.notificationModel
      .deleteOne({ _id: _notiId, receiver: requestId })
      .exec();
    if (notification.deletedCount === 0) {
      throw new HttpException('Notification not found', 404);
    }
    return notification;
  }
}
