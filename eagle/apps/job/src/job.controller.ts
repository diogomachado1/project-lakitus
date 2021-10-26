import { Controller, Get } from '@nestjs/common';

@Controller()
export class JobController {
  @Get()
  getHello() {
    return { status: 'success' };
  }
}
