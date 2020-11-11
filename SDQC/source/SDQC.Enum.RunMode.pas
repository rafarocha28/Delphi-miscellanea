unit SDQC.Enum.RunMode;

interface

type
  TRunMode = (rmNormal, rmSpecial);

const
  RunModeList: array[TRunMode] of string = (
    'Normal',
    'Special');

  SPECIAL_MODE_PARAM = 'special';

implementation

end.
