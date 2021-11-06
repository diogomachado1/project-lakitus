import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { SonicService } from './sonic.service';

@Module({
  imports: [ConfigModule.forRoot()],
  providers: [{ useClass: SonicService, provide: 'SONIC_SERVICE' }],
  exports: ['SONIC_SERVICE'],
})
export class SonicModule {}
