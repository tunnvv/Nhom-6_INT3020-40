import {
  Controller,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
  Req,
  Patch,
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
import ResponseData from 'src/utils/response-data';
import { ServersService } from './servers.service';
import { CreateServerDto, UpdateServerDto } from './dto';

@ApiTags('Servers')
@ApiBearerAuth()
@ApiForbiddenResponse({ description: 'Permission denied' })
@UseGuards(AuthGuard('jwt'))
@Controller('servers')
export class ServersController {
  constructor(private readonly serversService: ServersService) {}

  @ApiOperation({
    summary: 'Create a new server',
    description: 'Create a new server',
  })
  @ApiOkResponse({ description: 'Create a new server successfully' })
  @ApiBadRequestResponse({ description: 'Create a new server failed' })
  @Post()
  create(@Req() req, @Body() createServerDto: CreateServerDto) {
    const _id = req.user;
    createServerDto.hostId = _id;
    return this.serversService.create(createServerDto);
  }

  @ApiOperation({
    summary: 'Owner updates server information by ID',
    description: 'Owner updates server information by ID',
  })
  @ApiOkResponse({ description: 'Update server information successfully' })
  @ApiBadRequestResponse({ description: 'Update server informationi failed' })
  @Patch(':id')
  async update(
    @Req() request,
    @Param('id') id: string,
    @Body() updateServerDto: UpdateServerDto,
  ) {
    const { _id: hostId } = request.user;
    await this.serversService.update(id, hostId, updateServerDto);
    return new ResponseData(
      true,
      { message: 'Update server information successfully' },
      null,
    );
  }

  @ApiOperation({
    summary: 'Owner deletes a server by ID',
    description: 'Owner deletes a server by ID',
  })
  @ApiOkResponse({ description: 'Successfully deleted server' })
  @ApiNotFoundResponse({ description: "Can't find server to delete" })
  @Delete(':id')
  async remove(@Req() req, @Param('id') serverId: string) {
    const { _id: hostId } = req.user;
    await this.serversService.remove(serverId, hostId);
    return new ResponseData(
      true,
      { message: 'Delete a server by ID successfully' },
      null,
    );
  }
}
