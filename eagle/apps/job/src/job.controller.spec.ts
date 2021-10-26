import { Test, TestingModule } from '@nestjs/testing';
import { JobController } from './job.controller';

describe('JobController', () => {
  let jobController: JobController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [JobController],
    }).compile();

    jobController = app.get<JobController>(JobController);
  });

  describe('root', () => {
    it('should return success', () => {
      expect(jobController.getHello().status).toBe('success');
    });
  });
});
