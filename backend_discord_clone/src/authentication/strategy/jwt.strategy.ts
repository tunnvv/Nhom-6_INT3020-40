import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { UsersService } from 'src/users/users.service';

@Injectable()
export class JwtStratege extends PassportStrategy(Strategy, 'jwt') {
  constructor(private userService: UsersService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      // secretOrKey: process.env.JWT_SECRET || process.env.JWT_KEY,
      secretOrKey: '12345678',
    });
  }

  async validate(payload: any): Promise<string> {
    return payload.sub;
  }
}
