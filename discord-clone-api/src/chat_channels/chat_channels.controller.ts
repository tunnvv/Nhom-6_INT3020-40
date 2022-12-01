import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  UseGuards,
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
import { ChatChannelsService } from './chat_channels.service';
import { CreateChatChannelDto, UpdateChatChannelDto } from './dto';
import ResponseData from 'src/utils/response-data';

@Controller('chat-channels')
@ApiTags('Chat channels')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('chat-channels')
export class ChatChannelsController {
  constructor(private readonly chatChannelsService: ChatChannelsService) {}

  @ApiOperation({
    summary: 'Create a new chat channel',
    description: 'Create a new chat channel',
  })
  @ApiOkResponse({ description: 'Create a new chat channel successfully' })
  @ApiBadRequestResponse({ description: 'Create a new chat channel failed' })
  @Post()
  async create(
    @Req() request,
    @Body() createChatChannelDto: CreateChatChannelDto,
  ) {
    const { _id } = request.user;
    createChatChannelDto.hostId = _id;
    await this.chatChannelsService.create(createChatChannelDto);
    return new ResponseData(
      true,
      { message: 'Create a new chat channel successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner updates a chat channel by ID',
    description: 'Owner updates a chat channel by ID',
  })
  @ApiOkResponse({ description: 'Update a chat channel by ID successfully' })
  @ApiBadRequestResponse({ description: 'Update a chat channel by ID failed' })
  @Patch(':id')
  async update(
    @Req() request,
    @Param('id') id: string,
    @Body() updateChatChannelDto: UpdateChatChannelDto,
  ) {
    const { _id: hostId } = request.user;
    await this.chatChannelsService.update(id, hostId, updateChatChannelDto);
    return new ResponseData(
      true,
      { message: 'Update a chat channel by ID successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner deletes a chat channel by ID',
    description: 'Owner deletes a chat channel by ID',
  })
  @ApiOkResponse({ description: 'Delete a chat channel by ID successfully' })
  @ApiBadRequestResponse({ description: 'Delete a chat channel by ID failed' })
  @ApiNotFoundResponse({ description: "Can't find chat channel to delete" })
  @Delete(':id')
  async remove(@Req() request, @Param('id') chatChannelId: string) {
    const { _id: hostId } = request.user;
    await this.chatChannelsService.remove(chatChannelId, hostId);
    return new ResponseData(
      true,
      { message: 'Delete a chat channel by ID successfully' },
      null,
    );
  }
}
