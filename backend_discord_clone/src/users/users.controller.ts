import {
  Controller,
  Get,
  Body,
  Patch,
  Param,
  NotFoundException,
  UseGuards,
  Req,
} from '@nestjs/common';

import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';

import { AuthGuard } from '@nestjs/passport';

import { UsersService } from './users.service';
import { UpdateUserDto } from './dto/update-user.dto';
import { ShortUserInfo } from './schemas';

import ResponseData from 'src/utils/response-data';

@ApiTags('Người dùng')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Không có quyền truy cập' })
@UseGuards(AuthGuard('jwt'))
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOperation({
    summary: 'Lấy toàn bộ thông tin người dùng đang đăng nhập',
    description: 'Lấy toàn bộ thông tin người dùng đang đăng nhập',
  })
  @ApiOkResponse({
    description: 'Lấy toàn bộ thông tin người dùng đang đăng nhập thành công',
  })
  @ApiBadRequestResponse({
    description: 'Lấy toàn bộ thông tin người dùng đang đăng nhập thất bại',
  })
  @Get('me')
  async me(@Req() request) {
    const { _id } = request.user;
    const user = await this.usersService.getMe(_id);
    const { hashedPassword, ...userInfo } = user;
    return userInfo;
  }

  @ApiOperation({
    summary: 'Lấy một phần thông tin người dùng',
    description: 'Lấy một phần thông tin người dùng',
  })
  @ApiOkResponse({
    description: 'Lấy một phần thông tin người dùng thành công',
  })
  @ApiBadRequestResponse({
    description: 'Lấy một phần thông tin người dùng thất bại',
  })
  @ApiNotFoundResponse({ description: "The user's id doesn't exist" })
  @Get('u/:id')
  async getUserbyObjId(@Param('id') id: string): Promise<ShortUserInfo> {
    const user = await this.usersService.findByObjID(id);
    if (!user) {
      throw new NotFoundException("The user's id doesn't exist");
    }
    return user;
  }

  @ApiOperation({
    summary: 'Cập nhật thông tin người dùng đang đăng nhập',
    description: 'Cập nhật thông tin người dùng đang đăng nhập',
  })
  @ApiOkResponse({
    description: 'Cập nhật thông tin người dùng đang đăng nhập thành công',
  })
  @ApiBadRequestResponse({
    description: 'Cập nhật thông tin người dùng đang đăng nhập thất bại',
  })
  @Patch('me')
  async update(@Req() request, @Body() updateUserDto: UpdateUserDto) {
    const { _id } = request.user;
    await this.usersService.update(_id, updateUserDto);
    return new ResponseData(
      true,
      { message: 'Cập nhật thông tin người dùng đang đăng nhập thành công' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Thêm id vào danh sách bạn bè của user ngược lại',
    description:
      'Thêm id vào danh sách bạn bè của user và thêm user vào danh sách bạn bè của id',
  })
  @ApiOkResponse({
    description: 'Cập nhật danh sách bạn bè của cả 2 thành công',
  })
  @ApiBadRequestResponse({
    description: 'Cập nhật danh sách bạn bè của cả 2 thất bại',
  })
  @Patch('friends/update-both/:id')
  async updateFriendList(@Param('id') sender: string, @Req() request) {
    const { _id } = request.user;
    await this.usersService.updateFriendListById(_id, sender);
    await this.usersService.updateFriendListById(sender, _id);

    return new ResponseData(true, { message: 'Các bạn đã là bạn bè' }, null);
  }
}
