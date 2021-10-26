import { Controller, Param, Get, Query } from '@nestjs/common';
import { GameService } from './game.service';
import { GameFilter } from './GameFilter';

@Controller('game')
export class GameController {
  constructor(private service: GameService) {}

  @Get('/detail/:id')
  async getOneGame(@Param('id') id: string) {
    return this.service.getOneGame(id);
  }

  @Get('/detail/')
  async getMany(
    @Query()
    { ids, search, page }: GameFilter,
  ) {
    return this.service.getManyGame(ids?.split(','), search, page);
  }

  @Get('/detail-full/:id')
  async getFullGame(@Param('id') id: string) {
    return this.service.getOneGameFull(id);
  }

  @Get('/detail-full/')
  async getManyFull(
    @Query()
    { ids, search, page }: GameFilter,
  ) {
    return this.service.getManyGameFull(ids?.split(','), search, page);
  }
}
