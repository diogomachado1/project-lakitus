import { Controller, Param, Get, Query } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { GameService } from './game.service';

@Controller('game/detail')
export class GameController {
  constructor(private service: GameService) {}
  @Get('/:id')
  async getOneGame(@Param('id') id: string) {
    return this.service.getOneGame(id);
  }

  @Get('/')
  async getMany(
    @Query()
    { ids, search, page }: { ids: string; search: string; page: number },
  ) {
    return this.service.getManyGame(ids?.split(','), search, page);
  }

  @MessagePattern('game-detail')
  async getDetail(message: { usId: string; euId: string }) {
    await this.service.getAndSaveGameData(message.usId, message.euId);
  }
}
