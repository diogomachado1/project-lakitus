import { Controller, Param, Get, Query } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { GameService } from './game.service';
import { GameFilter } from './GameFilter';

@Controller('game')
export class GameController {
  constructor(private service: GameService) {}
  @Get('/detail/:id')
  async getOneGame(@Param('id') id: string) {
    return this.service.getOneGame(id, false);
  }

  @Get('/detail/')
  async getMany(
    @Query()
    { ids, search, page }: GameFilter,
  ) {
    return this.service.getManyGame(ids?.split(','), search, page, false);
  }
  @Get('/detail-full/:id')
  async getFullGame(@Param('id') id: string) {
    return this.service.getOneGame(id, true);
  }

  @Get('/detail-full/')
  async getManyFull(
    @Query()
    { ids, search, page }: GameFilter,
  ) {
    return this.service.getManyGame(ids?.split(','), search, page, true);
  }

  @MessagePattern('game-detail')
  async getDetail(message: { usId: string; euId: string }) {
    await this.service.getAndSaveGameData(message.usId, message.euId);
  }
}
