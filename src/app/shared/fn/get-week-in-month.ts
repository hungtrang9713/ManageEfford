export function getWeekOfMonth(d: Date): number {
  const date = d.getDate();
  const day = d.getDay();
  const weekOfMonth = Math.ceil((date - 1 - day) / 7);
  return weekOfMonth;
}