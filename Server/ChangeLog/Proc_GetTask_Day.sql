CREATE PROCEDURE Proc_GetTask_Day
	@DateWorking Date,
	@UserID UNIQUEIDENTIFIER
AS
BEGIN
   SELECT	T.TaskID,
			T.PBI,
			T.TaskName,
			T.EffortScore,
			T.MinusScore,
			T.FinalScore,
			T.Note,
			T.CreatedDate,
			T.ModifiedDate,
			T.UserID,
			T.Week,
			T.DateWorking 
   FROM		dbo.Task AS T 
   WHERE	T.UserID = @UserID 
			AND T.DateWorking = @DateWorking
END

GO

