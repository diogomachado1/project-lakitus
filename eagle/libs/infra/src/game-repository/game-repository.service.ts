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

  async saveAllGameDetail(
    games: {
      euEshopDetail?: GameEU;
      usEshopDetail?: GameUS;
      jpEshopDetail?: GameJP;
      hkEshopDetail?: GameHk;
      usEshopId?: string;
      euEshopId?: string;
      jpEshopId?: string;
      hkEshopId?: string;
      active: boolean;
      platform: string;
    }[],
  ) {
    await this.gameModel.insertMany(games);
  }

  async updateGame(gameId: string, game: Partial<Game>) {
    await this.gameModel.findByIdAndUpdate(gameId, game);
  }

  async getAllUsId() {
    return this.gameModel.find({}, 'usEshopId').lean();
  }

  async getGamesTitle() {
    return (
      await this.gameModel
        .find({}, 'usEshopDetail.title euEshopDetail.title _id')
        .lean()
    ).map((item) => ({
      _id: item._id,
      title: item.usEshopDetail?.title || item.euEshopDetail?.title,
    }));
  }

  async getTotalGames() {
    return this.gameModel.count();
  }

  async getGamesPagination(page = 1) {
    const skip = (page - 1) * 500;
    return this.gameModel.find().limit(500).skip(skip);
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
        value.euEshopDetail?.image_url_sq_s ||
        value.usEshopDetail?.horizontalHeaderImage,
      horizontalImage:
        value.usEshopDetail?.horizontalHeaderImage ||
        value.euEshopDetail?.image_url_h2x1_s,
      releaseDate:
        value.usEshopDetail?.releaseDateDisplay ||
        value.euEshopDetail?.date_from,
      popularity: value.euEshopDetail?.popularity,
      bestPrice: value.bestPrice,
      genres: value.usEshopDetail?.genres,
      metacritics: value.metacritics,
      createdAt: value.createdAt,
      updatedAt: value.updatedAt,
    } as unknown as SimpleDetail;
    if (value.prices) gameDetail.prices = value.prices;
    return gameDetail;
  }

  async findByExternalId<T>(id: string) {
    return this.gameModel
      .find(
        {
          [id]: { $exists: true, $ne: null },
        },
        id,
      )
      .lean<T[]>();
  }

  async findGamesSimpleDetail(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
    sort: string = undefined,
    asc: string = undefined,
    filter: {
      genres?: string[];
    } = {},
  ) {
    const games = await this.findGames(
      { ids, search },
      page,
      false,
      sort,
      asc,
      filter,
    );

    return games.map(this.trasformData);
  }

  async findGames(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
    allFields = false,
    sort: string = undefined,
    asc: string = undefined,
    filtersToAdds: {
      genres?: string[];
    } = {},
  ) {
    const games = await this.makeQuery(
      { ids, search },
      page,
      allFields,
      sort,
      asc,
      filtersToAdds,
    );

    return games;
  }

  async findGamesCount(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
    allFields = false,
    sort: string = undefined,
    asc: string = undefined,
    filtersToAdds: {
      genres?: string[];
    } = {},
  ) {
    const games = await this.makeQuery(
      { ids, search },
      page,
      allFields,
      sort,
      asc,
      filtersToAdds,
    )
      .limit(undefined)
      .count();

    return games;
  }

  makeQuery(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
    allFields = false,
    sort: string = undefined,
    asc: string = undefined,
    filtersToAdds: {
      genres?: string[];
    } = {},
  ) {
    const sortsFields = {
      bestDiscount: 'bestPrice.discountedValue',
      release: 'usEshopDetail.releaseDateDisplay',
      title: 'usEshopDetail.title',
      metacritics: 'metacritics.score',
    };
    const filter = {};
    if (sort) filter['usEshopDetail'] = { $exists: true };
    if (sort === 'release') {
      filter['usEshopDetail.releaseDateDisplay'] = new RegExp(
        /\d{4}-[01]\d-[0-3]\dT[0-2]\d:[0-5]\d:[0-5]\d\.\d+([+-][0-2]\d:[0-5]\d|Z)/,
      );
      filter['usEshopDetail.availability'] = 'Available now';
    }
    if (filtersToAdds.genres)
      filter['usEshopDetail.genres'] = filtersToAdds.genres;

    const searchRegex = new RegExp(search, 'i');
    const filters =
      search || ids
        ? search
          ? {
              $or: [
                { 'euEshopDetail.title': searchRegex },
                { 'usEshopDetail.title': searchRegex },
              ],
            }
          : { _id: { $in: ids } }
        : { ...filter };
    const query = this.gameModel
      .find(
        filters,
        allFields
          ? undefined
          : '_id usEshopDetail euEshopDetail usEshopId euEshopId hkEshopId bestPrice metacritics jpEshopId createdAt updatedAt',
      )
      .limit(20)
      .skip(20 * (page - 1))
      .lean();
    if (sort) {
      query.sort({
        [sortsFields[sort]]: asc?.toLowerCase() === 'desc' ? 'desc' : 'asc',
      });
    }
    return query;
  }
}
