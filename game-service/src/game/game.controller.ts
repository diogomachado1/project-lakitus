import { Controller, Param, Get, Query } from '@nestjs/common';
import { GameService } from './game.service';

@Controller('games')
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
}
