import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { GameEU, GameJP, GameUS } from 'nintendo-switch-eshop';
import { GameHk } from '../eshop/eshop.service';

export type GameDocument = Game & Document;

@Schema({ timestamps: true })
export class Game {
  @Prop({ type: {} })
  usEshopDetail: GameUS;

  @Prop({ type: {} })
  euEshopDetail: GameEU & { popularity?: number };

  @Prop({ type: {} })
  jpEshopDetail: GameJP;

  @Prop({ type: {} })
  hkEshopDetail: GameHk;

  @Prop()
  usEshopId: string;

  @Prop()
  euEshopId: string;

  @Prop()
  jpEshopId: string;

  @Prop()
  hkEshopId: string;

  @Prop()
  platform: string;

  @Prop()
  active: boolean;

  prices: any[];
  createdAt: Date;
  updatedAt: Date;
}

export const GameSchema = SchemaFactory.createForClass(Game);
GameSchema.virtual('prices', {
  ref: 'Price',
  localField: '_id',
  foreignField: 'gameId',
  justOne: false,
});
