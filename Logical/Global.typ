
TYPE
	CameraStruct : 	STRUCT 
		ExposureTime : UDINT := 30000;
		Focus : UINT := 30000;
		NumSearch : USINT;
		Enable : BOOL;
		diTrigger : BOOL;
		ImageAcq : BOOL;
		PixelCntSquareArray : ARRAY[0..13]OF UDINT;
		Ready : BOOL;
		FlashColor : USINT;
		ModelNumArray : ARRAY[0..13]OF USINT;
		FlashSegment : USINT;
		prevImgProcessingActive : BOOL;
		ImgProcessingActive : BOOL;
	END_STRUCT;
	PixelCounterLimits : 	STRUCT 
		WrenchLimit : UDINT;
		WasherBoltLimit : UDINT;
		ScrewLimit : UDINT;
		HolderLimit : UDINT;
	END_STRUCT;
	gSafeType : 	STRUCT 
		diEStop : BOOL;
		diEStopPanel : BOOL;
		diGuardDoor1 : BOOL;
		diGuardDoor2 : BOOL;
		EStop : BOOL;
		EStopPanel : BOOL;
		GuardingDoor : BOOL;
		SafeChannelOK1 : BOOL;
		SafeChannelOK2 : BOOL;
		doAcoposEnable1 : BOOL;
		doAcoposEnable2 : BOOL;
		CommunicationError : BOOL;
		ComErrorAck : BOOL;
	END_STRUCT;
END_TYPE
