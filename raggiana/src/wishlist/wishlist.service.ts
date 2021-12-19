import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import axios from 'axios';
import { Wishlist, WishlistDocument } from './schema/wishlist.schema';

@Injectable()
export class WishlistService {
  constructor(
    @InjectModel(Wishlist.name) private wishlistModel: Model<WishlistDocument>,
  ) {}

  getWishlist() {
    return [
      {
        _id: 'sdfsdf',
        userId: 'sdfsdf',
        gameId: 'sdfsdf',
        wantedPrice: 78.45,
      },
    ];
  }
  async addGameToWishlist(userId, { gameId, wishedPrice, currency }) {
    if (!userId) {
      throw new HttpException('User id is required', HttpStatus.BAD_REQUEST);
    }
    const response = await axios.get(
      `http://eagle-api:3000/game/detail/${gameId}`,
      { validateStatus: (status) => status <= 500 },
    );

    if (response.status !== 200)
      throw new HttpException('Game not found!', HttpStatus.NOT_FOUND);

    const gameAlreadyAdded = await this.wishlistModel.findOne({
      userId,
      gameId,
    });

    if (gameAlreadyAdded)
      throw new HttpException('Game already added', HttpStatus.BAD_REQUEST);

    await this.wishlistModel.create({
      userId,
      gameId: gameId,
      wishedPrice: wishedPrice,
      currency,
    });

    return;
  }
}
