import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { ElasticService } from './elastic.service';

@Module({
  imports: [ConfigModule.forRoot()],
  providers: [{ useClass: ElasticService, provide: 'ELASTIC_SERVICE' }],
  exports: ['ELASTIC_SERVICE'],
})
export class ElasticModule {}
