export interface GameJP extends Record<string, string | number | undefined> {
  InitialCode: string;
  LinkURL: string;
  LinkTarget: string;
  ScreenshotImgFlg: number;
  ScreenshotImgURL: string;
  ThumbVariation: string;
  ComingThumb: 'yes' | string;
  TitleName: string;
  TitleNameRuby: string;
  SoftType: string;
  D: number;
  SalesDate: string;
  MakerName: string;
  Hard: string;
  Memo: string;
  PlatformID: string;
  Price: string;
  MakerKana: string;
}
