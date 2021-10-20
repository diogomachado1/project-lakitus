import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { GameEU, GameJP, GameUS } from 'nintendo-switch-eshop';
import { GameHk } from '../eshop/eshop.service';
import { Game, GameDocument } from './game.schema';

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

  async findOneGame(id: string, fullDetail = false) {
    const game = await this.gameModel.findById(id).populate('prices').lean();
    return fullDetail
      ? game
      : {
          id: game._id,
          externalIds: {
            usEshopId: game.usEshopId,
            euEshopId: game.euEshopId,
            hkEshopId: game.hkEshopId,
            jpEshopId: game.jpEshopId,
          },
          title: game.usEshopDetail?.title || game.euEshopDetail?.title,
          description: game.usEshopDetail?.description || '',
          developer:
            game.usEshopDetail?.developers?.[0] ||
            game.euEshopDetail?.developer,
          publisher:
            game.usEshopDetail?.publishers?.[0] ||
            game.euEshopDetail?.publisher,
          image:
            game.euEshopDetail?.image_url ||
            game.usEshopDetail?.horizontalHeaderImage,
          releaseDate:
            game.usEshopDetail?.releaseDateDisplay ||
            game.euEshopDetail?.date_from,
          popularity: game.euEshopDetail?.popularity,
          createdAt: game.createdAt,
          updatedAt: game.updatedAt,
        };
  }

  async findGames(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
    fullDetail = false,
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

    return fullDetail
      ? games
      : games.map(
          ({
            _id,
            usEshopDetail,
            euEshopDetail,
            usEshopId,
            euEshopId,
            hkEshopId,
            jpEshopId,
            createdAt,
            updatedAt,
          }) => ({
            id: _id,
            externalIds: {
              usEshopId: usEshopId,
              euEshopId: euEshopId,
              hkEshopId: hkEshopId,
              jpEshopId: jpEshopId,
            },
            title: usEshopDetail?.title || euEshopDetail?.title,
            description: usEshopDetail?.description || '',
            developer:
              usEshopDetail?.developers?.[0] || euEshopDetail?.developer,
            publisher:
              usEshopDetail?.publishers?.[0] || euEshopDetail?.publisher,
            image:
              euEshopDetail?.image_url || usEshopDetail?.horizontalHeaderImage,
            releaseDate:
              usEshopDetail?.releaseDateDisplay || euEshopDetail?.date_from,
            popularity: euEshopDetail?.popularity,
            createdAt,
            updatedAt,
          }),
        );
  }
}
