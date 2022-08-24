
ACTION Stopped:
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_STOPPED,
		1) THEN
		
		PackML_State := 'STOPPED';
		MpRoboArm6Axis_0.Power := FALSE; 
		emptyPos:=0;
	
		

		
		IF diReset THEN
			Step := ROBOTCTRL_POWER;
			Step_State := 'POWER';
			MpPackMLMode_Auto.Reset := TRUE;
			diReset := FALSE;
		END_IF
		
		
		
	END_IF

END_ACTION
