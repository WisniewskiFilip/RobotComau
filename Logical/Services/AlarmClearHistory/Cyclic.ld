PROGRAM _CYCLIC
<?xml version="1.0"?>
<?AutomationStudio FileVersion="4.9"?>
<!-- Automation Studio Generated XML Section -->
<networks maxcolumn="0">
	<network label="" comment="" row="2" column="0" commented="0">
		<row>
			<contact type="open" name="ClearHistory"/>
			<function position="top" type="MpAlarmXClearHistory"><input name="EN" ENO="true"/><output name="ENO" ENO="true"/></function>
			<empty/>
		</row>
		<row>
			<analog type="input" name="gAlarmXHistory"/>
			<function position="bottom" type="MpAlarmXClearHistory"><input name="MpLink"/><output name="4"/></function>
			<analog type="output" name="ClearHistoryOutput"/>
		</row>
	</network>
</networks>
END_PROGRAM

