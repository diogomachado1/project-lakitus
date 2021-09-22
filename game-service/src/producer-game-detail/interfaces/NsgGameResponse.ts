import { NsgGame } from './NsgGame';

export interface NsgGameResponse {
  total: number;
  showing: number;
  rows: NsgGame[];
}
