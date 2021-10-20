import { Controller, Param, Get, Query } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { GameService } from './game.service';
import { GameFilter } from './GameFilter';

@Controller('game/detail')
export class GameController {
  constructor(private service: GameService) {}
  @Get('/:id')
  async getOneGame(
    @Param('id') id: string,
    @Query()
    { fullDetail }: { fullDetail: boolean },
  ) {
    return this.service.getOneGame(id, fullDetail);
  }

  @Get('/')
  async getMany(
    @Query()
    { ids, search, page, fullDetail }: GameFilter,
  ) {
    return this.service.getManyGame(ids?.split(','), search, page, fullDetail);
  }

  @MessagePattern('game-detail')
  async getDetail(message: { usId: string; euId: string }) {
    await this.service.getAndSaveGameData(message.usId, message.euId);
  }
}
