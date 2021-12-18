import { Injectable } from '@nestjs/common';

@Injectable()
export class WishlistService {
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
  addGameToWishlist() {
    return [
      {
        _id: 'sdfsdf',
        userId: 'sdfsdf',
        gameId: 'sdfsdf',
        wantedPrice: 78.45,
      },
    ];
  }
}
