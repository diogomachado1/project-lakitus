import { Controller, Get } from '@nestjs/common';

@Controller()
export class ApiController {
  @Get()
  getHello() {
    return { status: 'success' };
  }
}
