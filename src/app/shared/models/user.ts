export class User {
    UserID: string;
    UserName: string;
    FullName: string;
    IsLead: boolean;
    PassWord: string;
    LeadID: string;
    state: number;
    constructor(state){
        this.state = state;
    }
}