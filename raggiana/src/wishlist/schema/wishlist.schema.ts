import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type WishlistDocument = Wishlist & Document;

@Schema()
export class Wishlist {
  @Prop({ required: true })
  gameId: string;

  @Prop({ required: true })
  userId: string;

  @Prop({ required: true })
  wishedPrice: number;

  @Prop({ required: true })
  currency: string;
}

export const WishlistSchema = SchemaFactory.createForClass(Wishlist);
