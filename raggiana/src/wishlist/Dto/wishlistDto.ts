import { IsNotEmpty } from 'class-validator';

export class WishlistDto {
  @IsNotEmpty()
  gameId: string;

  @IsNotEmpty()
  wishedPrice: number;

  @IsNotEmpty()
  currency: string;
}
