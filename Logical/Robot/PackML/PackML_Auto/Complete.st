
ACTION Complete: 
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_COMPLETE,
		1) THEN
		
		PackML_State := 'COMPLETE';
		gCompliteFlag:=TRUE;
		//MpPackMLMode_Auto.Stop := 1;

		IF diReset THEN
			MpPackMLStateComplete(gPackMLCore, 1);
			MpPackMLMode_Auto.Reset := 1;
			Step := ROBOTCTRL_POWER;
			
			//			Step_State := 'POWER';
			
			END_IF;
	END_IF

END_ACTION
