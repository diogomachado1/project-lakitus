import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type PriceHistoryDocument = PriceHistory & Document;

@Schema({ autoIndex: false })
export class PriceHistory {
  @Prop()
  newPrice: number | null;
  @Prop()
  oldPrice: number | null;
  @Prop()
  date: Date;
  @Prop()
  gameId: string;
  @Prop()
  country: string;
}

export const PriceHistorySchema = SchemaFactory.createForClass(PriceHistory);
