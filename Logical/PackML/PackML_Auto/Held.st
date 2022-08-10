
ACTION Held: 
	
	
	
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_HELD,
		1) THEN
		
		PackML_State := 'HELD';
			
		IF cmdContinue THEN
			cmdContinue:=FALSE;
			MpRoboArm6Axis_0.Interrupt:=FALSE; 
//			Step:=ROBOTCTRL_CONTINUE;
//			Step_State := 'CONTINUE';
			MpPackMLMode_Auto.Unhold := 1;
		END_IF
	END_IF

END_ACTION
