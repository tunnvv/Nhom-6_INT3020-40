import {
  Controller,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

import {
  ApiBadRequestResponse,
  ApiBearerAuth,
  ApiForbiddenResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';

import ResponseData from 'src/utils/response-data';
import { CallChannelsService } from './call_channels.service';
import { CreateCallChannelDto, UpdateCallChannelDto } from './dto';

@ApiTags('Call channels')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('call-channels')
export class CallChannelsController {
  constructor(private readonly callChannelsService: CallChannelsService) {}

  @ApiOperation({
    summary: 'Create a new call channel',
    description: 'Create a new call channel',
  })
  @ApiOkResponse({ description: 'Create a new call channel successfully' })
  @ApiBadRequestResponse({ description: 'Create a new call channel failed' })
  @Post()
  async create(
    @Req() request,
    @Body() createCallChannelDto: CreateCallChannelDto,
  ) {
    const { _id } = request.user;
    createCallChannelDto.hostId = _id;
    await this.callChannelsService.create(createCallChannelDto);
    return new ResponseData(
      true,
      { message: 'Create a new call channel successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner updates a call channel by ID',
    description: 'Owner updates a call channel by ID',
  })
  @ApiOkResponse({ description: 'Update a call channel by ID successfully' })
  @ApiBadRequestResponse({ description: 'Update a call channel by ID failed' })
  @Patch(':id')
  async update(
    @Req() request,
    @Param('id') id: string,
    @Body() updateCallChannelDto: UpdateCallChannelDto,
  ) {
    const { _id: hostId } = request.user;
    await this.callChannelsService.update(id, hostId, updateCallChannelDto);
    return new ResponseData(
      true,
      { message: 'Update a call channel by ID successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner deletes a call channel by ID',
    description: 'Owner deletes a call channel by ID',
  })
  @ApiOkResponse({ description: 'Delete a call channel by ID successfully' })
  @ApiBadRequestResponse({ description: 'Delete a call channel by ID failed' })
  @ApiNotFoundResponse({ description: "Can't find call channel to delete" })
  @Delete(':id')
  async remove(@Req() request, @Param('id') callChannelId: string) {
    const { _id: hostId } = request.user;
    await this.callChannelsService.remove(callChannelId, hostId);
    return new ResponseData(
      true,
      { message: 'Delete a call channel by ID successfully' },
      null,
    );
  }
}
