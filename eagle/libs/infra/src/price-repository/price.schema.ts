import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type PriceDocument = Price & Document;

@Schema({ timestamps: true, autoIndex: false })
export class Price {
  @Prop()
  country: string;
  @Prop()
  gameId: string;
  @Prop()
  salesStatus: string;
  @Prop({ type: {} })
  regularPrice: {
    amount: string;
    currency: string;
    rawValue: string;
    startDatetime: string;
    endDatetime: string;
  };
  @Prop({ type: {} })
  discountPrice: {
    amount: string;
    currency: string;
    rawValue: string;
    startDatetime: string;
    endDatetime: string;
  };

  createdAt: Date;
  updatedAt: Date;
}

export const PriceSchema = SchemaFactory.createForClass(Price);
