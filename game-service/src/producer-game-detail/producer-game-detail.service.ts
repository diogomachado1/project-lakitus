import { Inject, Injectable } from '@nestjs/common';
import { NsgService } from 'src/infra/nsg/nsg.service';
import { RabbitService } from 'src/infra/rabbit/rabbit.service';
import { GameRepositoryService } from '../infra/game-repository/game-repository.service';
import { NsgGame } from './interfaces/NsgGame';

@Injectable()
export class ProducerGameDetailService {
  constructor(
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('NSG_SERVICE') private nsgServices: NsgService,
    @Inject('RABBIT_SERVICE') private rabbitService: RabbitService,
  ) {}

  async sendGamesMessage(sendAll = false) {
    const [nsgGames, savedGamesUsId] = await Promise.all([
      this.nsgServices.getGames(),
      this.gameRepository.getAllUsId(),
    ]);

    const gamesIds = sendAll
      ? this.getAllGames(nsgGames)
      : this.getNewGames(nsgGames, savedGamesUsId);

    await this.rabbitService.sendBatchToGameDetail(gamesIds);
    return gamesIds;
  }
  protected getNewGames(
    nsgGames: NsgGame[],
    savedGamesUsId: { usEshopId: string }[],
  ) {
    const usIdHashTable = this.createHatableUsIdEshop(savedGamesUsId);
    return nsgGames
      .filter((item) => !usIdHashTable.includes(item.nsuid_na.toString()))
      .map((item) => ({ usId: item.nsuid_na, euId: item.nsuid_eu }));
  }

  protected getAllGames(nsgGames: NsgGame[]) {
    return nsgGames.map((item) => ({
      usId: item.nsuid_na,
      euId: item.nsuid_eu,
    }));
  }

  protected createHatableUsIdEshop(savedGamesUsId: { usEshopId: string }[]) {
    return savedGamesUsId.map((item) => item.usEshopId.toString());
  }

  async getPriceMessages() {
    await this.rabbitService.sendMessageToPriceStart();
    return { status: 'success' };
  }

  async getPriceHistoryMessages() {
    await this.rabbitService.sendMessageToPriceHistoryStart();
    return { status: 'success' };
  }
}
