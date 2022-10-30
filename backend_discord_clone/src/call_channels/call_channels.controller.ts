import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CallChannelsService } from './call_channels.service';
import { CreateCallChannelDto } from './dto/create-call_channel.dto';
import { UpdateCallChannelDto } from './dto/update-call_channel.dto';

@Controller('call-channels')
export class CallChannelsController {
  constructor(private readonly callChannelsService: CallChannelsService) {}

  @Post()
  create(@Body() createCallChannelDto: CreateCallChannelDto) {
    return this.callChannelsService.create(createCallChannelDto);
  }

  @Get()
  findAll() {
    return this.callChannelsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.callChannelsService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCallChannelDto: UpdateCallChannelDto) {
    return this.callChannelsService.update(id, updateCallChannelDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.callChannelsService.remove(id);
  }
}
