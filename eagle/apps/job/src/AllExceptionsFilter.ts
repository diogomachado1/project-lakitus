import { ExceptionFilter, Catch } from '@nestjs/common';
import { RpcException } from '@nestjs/microservices';

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: RpcException) {
    throw exception;
  }
}
