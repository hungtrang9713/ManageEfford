import { ActionState } from "../enums/action-state";

export class Task {
    TaskID?: string;
    PBI?: string;
    TaskName: string;
    MinusScore: number;
    EffortScore: number;
    FinalScore: number;
    Note?: string;
    CreatedDate?: Date;
    ModifiedDate?: Date;
    UserID: string;
    Week: number;
    DateWorking: Date;
    ActionState: number;

    constructor(UserID, Week, DateData) {
        this.TaskName = ``;
        this.EffortScore = 0;
        this.MinusScore = 0;
        this.FinalScore = 0;
        this.UserID = UserID;
        this.Week = Week;
        this.DateWorking = DateData;
        this.Note = ``;
        this.PBI = ``;
        this.ActionState = ActionState.Add;
    }
}