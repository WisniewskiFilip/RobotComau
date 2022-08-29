
ACTION Stopping:
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_STOPPING,
		1) THEN
		
		PackML_State := 'STOPPING';
		gCompliteFlag:=FALSE;
		//STOP EVERYTHING
		MpRoboArm6Axis_0.Stop := TRUE;
		IF NOT MpRoboArm6Axis_0.InMotion THEN
				MpRoboArm6Axis_0.Stop := FALSE;
			MpRoboArm6Axis_0.Power := FALSE; 
			emptyPos:=0;
			diStop := 0;

		
		//	IF NOT MpRoboArm6Axis_0.InMotion AND (NOT MpRoboArm6Axis_0.PowerOn) THEN

				MpPackMLStateComplete(gPackMLCore, 1);
		//	END_IF;
			
	END_IF;	

		
	
		
	END_IF

END_ACTION
