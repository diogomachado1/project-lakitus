import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
import { GameUS } from 'nintendo-switch-eshop';

export type GameDocument = Game & Document;

@Schema({ timestamps: true })
export class Game {
  @Prop({ type: {} })
  usEshopDetail: GameUS;

  @Prop()
  usEshopId: string;
}

export const GameSchema = SchemaFactory.createForClass(Game);
