import { Controller, Param, Get, Query, Response } from '@nestjs/common';
import { Response as Res } from 'express';
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
    { ids, search, page, sort, asc, genres }: GameFilter,
    @Response() res: Res,
  ) {
    const { pages, data } = await this.service.getManyGame(
      ids?.split(','),
      search,
      page,
      sort,
      asc,
      {
        genres: genres?.split(','),
      },
    );

    res.set('pages-total', pages.toString()).json(data);
  }

  @Get('/detail-full/:id')
  async getFullGame(@Param('id') id: string) {
    return this.service.getOneGameFull(id);
  }

  @Get('/detail-full/')
  async getManyFull(
    @Query()
    { ids, search, page, sort, asc, genres }: GameFilter,
  ) {
    return this.service.getManyGameFull(
      ids?.split(','),
      search,
      page,
      sort,
      asc,
      { genres: genres?.split(',') },
    );
  }

  @Get('search')
  async gameSearch(
    @Query()
    { q, page, full = false }: { q?: string; page: number; full: boolean },
  ) {
    return await this.service.search(q, page, full);
  }
}
