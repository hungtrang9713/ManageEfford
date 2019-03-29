import { WorkingState } from "../enums/work-status";

export function convertWorkStatusToString(workStatus: WorkingState) {
  if (workStatus === WorkingState.AllDay) {
    return 'Nghỉ cả ngày';
  }
  if (workStatus === WorkingState.Morning) {
    return 'Nghỉ Sáng';
  }
  if (workStatus === WorkingState.Afternoon) {
    return 'Nghỉ Chiều';
  }
  if (workStatus === WorkingState.NotWorking) {
    return 'Chưa chắc chắn';
  }
  if (workStatus === WorkingState.NoRegister) {
    return 'Chưa đăng kí';
  }
  return "";
}