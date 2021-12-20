import { Inject, Injectable } from '@nestjs/common';
import { NsgService } from '@infra/infra/nsg/nsg.service';
import { RabbitService } from '@infra/infra/rabbit/rabbit.service';
import { GameRepositoryService } from '@infra/infra/game-repository/game-repository.service';
import { NsgGame } from '@infra/infra/nsg/interfaces/NsgGame';

@Injectable()
export class ProducerGameDetailService {
  constructor(
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('NSG_SERVICE') private nsgServices: NsgService,
    @Inject('RABBIT_SERVICE') private rabbitService: RabbitService,
  ) {}

  async sendGamesMessage() {
    await this.rabbitService.sendBatchToGameDetail();
  }
  getNewGames(nsgGames: NsgGame[], savedGamesUsId: { usEshopId: string }[]) {
    const usIdHashTable = this.createHatableUsIdEshop(savedGamesUsId);
    return nsgGames
      .filter(
        (item) =>
          item.nsuid_na && !usIdHashTable.includes(item?.nsuid_na?.toString()),
      )
      .map((item) => ({ usId: item.nsuid_na, euId: item.nsuid_eu }));
  }

  getAllGames(nsgGames: NsgGame[]) {
    return nsgGames.map((item) => ({
      usId: item.nsuid_na,
      euId: item.nsuid_eu,
    }));
  }

  createHatableUsIdEshop(savedGamesUsId: { usEshopId: string }[]) {
    return savedGamesUsId.map((item) => item?.usEshopId?.toString());
  }

  async getPriceMessages() {
    await this.rabbitService.sendMessageToPriceStart();
    return { status: 'success' };
  }
}
