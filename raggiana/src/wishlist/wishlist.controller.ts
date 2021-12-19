import { Body, Controller, Get, Headers, Post } from '@nestjs/common';
import { WishlistDto } from './Dto/wishlistDto';
import { WishlistService } from './wishlist.service';
@Controller('wishlist')
export class WishlistController {
  constructor(protected wishlistService: WishlistService) {}

  @Get()
  getAll() {
    return this.wishlistService.getWishlist();
  }
  @Post()
  async addGameToWishlist(@Headers() headers, @Body() body: WishlistDto) {
    const userId = headers['x-kong-jwt-claim-sub'];
    console.log(body);
    return this.wishlistService.addGameToWishlist(userId, body);
  }
}
