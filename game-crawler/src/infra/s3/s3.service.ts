import { Injectable } from '@nestjs/common';
import { S3 } from 'aws-sdk';
import { format, parseISO } from 'date-fns';

@Injectable()
export class S3Service {
  s3 = new S3({ region: process.env.AWS_REGION });

  protected async getFileS3(key: string) {
    try {
      const data = await this.s3
        .getObject({
          Bucket: process.env.AWS_S3_BUCKET,
          Key: key,
        })
        .promise();
      return JSON.parse(data.Body.toString()) as any[];
    } catch (error) {
      return [];
    }
  }

  protected async saveFileS3(data: any, key: string) {
    await this.s3
      .putObject({
        Bucket: process.env.AWS_S3_BUCKET,
        Key: key,
        Body: JSON.stringify(data),
        ACL: 'public-read',
        ContentType: 'application/json',
      })
      .promise();
  }

  async append(dataToAppend: any, key: string) {
    const fileData = await this.getFileS3(key);
    if (
      fileData.length &&
      format(dataToAppend.date, 'yyyy-MM-dd') ===
        format(parseISO(fileData[fileData.length - 1].date), 'yyyy-MM-dd')
    ) {
      fileData[fileData.length - 1] = dataToAppend;
    } else {
      fileData.push(dataToAppend);
    }

    await this.saveFileS3(fileData, key);
  }
}
