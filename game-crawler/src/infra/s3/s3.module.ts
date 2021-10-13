import { Module } from '@nestjs/common';
import { S3Service } from './s3.service';

@Module({
  providers: [{ useClass: S3Service, provide: 'S3_SERVICE' }],
  exports: ['S3_SERVICE'],
})
export class S3Module {}
