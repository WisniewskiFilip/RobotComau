
ACTION Completing: 
	IF MpPackMLStateIsActive(gPackMLCore,
		mpPACKML_STATE_COMPLETING,
		1) THEN
			PackML_State := 'COMPLETING';
		emptyPos:=0;
			MpPackMLStateComplete(gPackMLCore, 1);
		
		
	END_IF

END_ACTION
