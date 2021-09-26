import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { Price, PriceSchema } from '../price-repository/price.schema';
import { GameEU } from './interface/GameEU';
import { GameHk } from './interface/GameHK';
import { GameJP } from './interface/GameJP';
import { GameUS } from './interface/GameUS';

export type GameDocument = Game & Document;

@Schema({ timestamps: true })
export class Game {
  @Prop({ type: {} })
  usEshopDetail: GameUS;

  @Prop({ type: {} })
  euEshopDetail: GameEU;

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
}

export const GameSchema = SchemaFactory.createForClass(Game);
GameSchema.virtual('prices', {
  ref: 'Price',
  localField: '_id',
  foreignField: 'gameId',
  justOne: false,
});
