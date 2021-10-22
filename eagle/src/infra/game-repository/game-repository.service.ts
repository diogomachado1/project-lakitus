import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Document, LeanDocument, Model } from 'mongoose';
import { GameEU, GameJP, GameUS } from 'nintendo-switch-eshop';
import { GameHk } from '../eshop/eshop.service';
import { Game, GameDocument } from './game.schema';
import { SimpleDetail } from './SimpleDetail';

@Injectable()
export class GameRepositoryService {
  constructor(@InjectModel(Game.name) private gameModel: Model<GameDocument>) {}

  async saveGameDetail({
    euEshopDetail,
    usEshopDetail,
    jpEshopDetail,
    hkEshopDetail,
    usEshopId,
    euEshopId,
    jpEshopId,
    hkEshopId,
  }: {
    euEshopDetail?: GameEU;
    usEshopDetail?: GameUS;
    jpEshopDetail?: GameJP;
    hkEshopDetail?: GameHk;
    usEshopId: string;
    euEshopId?: string;
    jpEshopId?: string;
    hkEshopId?: string;
  }) {
    await this.gameModel.findOneAndUpdate(
      { usEshopId: usEshopId },
      {
        euEshopDetail,
        usEshopDetail,
        hkEshopDetail,
        jpEshopDetail,
        euEshopId,
        usEshopId,
        jpEshopId,
        hkEshopId,
      },
      { upsert: true },
    );
  }

  async getAllUsId() {
    return this.gameModel.find({}, 'usEshopId').lean();
  }

  async getAllEshopIds() {
    return this.gameModel
      .find({}, ['usEshopId', 'euEshopId', 'hkEshopId', 'jpEshopId', '_id'])
      .lean();
  }

  async getAllIds() {
    return this.gameModel.find({}, ['_id']).lean();
  }

  async findOneGame(id: string) {
    return this.gameModel.findById(id).populate('prices').lean();
  }

  async findOneGameSimple(id: string) {
    const game = await this.findOneGame(id);
    return this.trasformData(game);
  }

  trasformData(
    value: LeanDocument<
      Game &
        Document<any, any, any> & {
          _id: any;
        }
    >,
  ) {
    const gameDetail = {
      id: value._id,
      externalIds: {
        usEshopId: value.usEshopId,
        euEshopId: value.euEshopId,
        hkEshopId: value.hkEshopId,
        jpEshopId: value.jpEshopId,
      },
      title: value.usEshopDetail?.title || value.euEshopDetail?.title,
      description: value.usEshopDetail?.description || '',
      developer:
        value.usEshopDetail?.developers?.[0] || value.euEshopDetail?.developer,
      publisher:
        value.usEshopDetail?.publishers?.[0] || value.euEshopDetail?.publisher,
      image:
        value.euEshopDetail?.image_url ||
        value.usEshopDetail?.horizontalHeaderImage,
      releaseDate:
        value.usEshopDetail?.releaseDateDisplay ||
        value.euEshopDetail?.date_from,
      popularity: value.euEshopDetail?.popularity,
      createdAt: value.createdAt,
      updatedAt: value.updatedAt,
    } as unknown as SimpleDetail;
    if (value.prices) gameDetail.prices = value.prices;
    return gameDetail;
  }

  async findGamesSimpleDetail(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
  ) {
    const games = await this.findGames({ ids, search }, page);

    return games.map(this.trasformData);
  }

  async findGames(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
  ) {
    const searchRegex = new RegExp(search, 'i');
    const filter =
      search || ids
        ? search
          ? {
              $or: [
                { 'euEshopDetail.title': searchRegex },
                { 'usEshopDetail.title': searchRegex },
              ],
            }
          : { _id: { $in: ids } }
        : {};
    const games = await this.gameModel
      .find(
        filter,
        '_id usEshopDetail euEshopDetail usEshopId euEshopId hkEshopId jpEshopId createdAt updatedAt',
      )
      .limit(20)
      .skip(20 * (page - 1))
      .lean();

    return games;
  }
}
