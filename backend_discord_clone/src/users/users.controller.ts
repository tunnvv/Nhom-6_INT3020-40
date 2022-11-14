import { Controller, Get, Post, Body, Patch, Param, Delete, Query, Put, NotFoundException } from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { ApiBadRequestResponse, ApiCreatedResponse, ApiNotFoundResponse, ApiOkResponse, ApiQuery, ApiTags } from '@nestjs/swagger';
import { User } from 'src/schemas/user.schema';

@ApiTags('users')
@Controller()
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @ApiOkResponse({type: User, description: "Successfully created user account"})
  @Post('register')
  async register(@Body() createUserDto: CreateUserDto) {
    return this.usersService.createUser(createUserDto);
  }
  

  @ApiQuery({name: 'name', description: 'name', required: false})
  @ApiOkResponse({type: User, isArray: true, description: "Finished filtering by user's name"})
  @Get('users')
  async getUsers(@Query('name') name: string): Promise<User[]> {
    const users = this.usersService.findAll(name);
    return users;
  }


  @ApiOkResponse({type: User, description: "Successfully retrieved user information" })
  @ApiNotFoundResponse({description: "The user's id doesn't exist"})
  @Get('users/:id')
  async getUserbyObjId(@Param('id') id: string): Promise<User> {
    const user = this.usersService.findUserByObjID(id);
    if (!user) {
      throw new NotFoundException("The user's id doesn't exist")
    }
    return user
  }

  @Patch('users/:id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(id, updateUserDto);
  }

  @ApiOkResponse({description: 'Successfully delete user account'})
  @Delete('users/:id')
  async deleteUser(@Param('id') id: string) {
    return await this.usersService.remove(id);
  }
}
