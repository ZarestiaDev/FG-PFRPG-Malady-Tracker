-- 
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	update()
end

--	This function takes the Save DC related information and combines them into a single string that can be displayed once the window is locked.
local function generateOnsetString()
	local sOnset = ''
	
	if onset_unit.getValue() ~= '' then sOnset = onset_interval.getValue() end
	if onset_unit.getValue() ~= '' then sOnset = sOnset .. ' ' .. onset_unit.getValue() else sOnset = '' end
	
	return sOnset
end

--	This function takes the Save DC related information and combines them into a single string that can be displayed once the window is locked.
local function generateDurationString()
	local sDur = ''
	
	if duration_unit.getValue() ~= '' then sDur = duration_interval.getValue() end
	if duration_unit.getValue() ~= '' then sDur = sDur .. ' ' .. duration_unit.getValue() else sDur = '' end
	
	return sDur
end

--	This function takes the Save DC related information and combines them into a single string that can be displayed once the window is locked.
local function generateFrequencyString()
	local sFreq = ''
	
	if freq_unit.getValue() ~= '' then sFreq = freq_interval.getValue() end
	if freq_unit.getValue() ~= '' then sFreq = sFreq .. freq_unit.getValue() else sFreq = '' end
	
	return sFreq
end

--	This function takes the Save DC related information and combines them into a single string that can be displayed once the window is locked.
function generateSaveString()
	local sSave = ''
	
	local nSaveDc = savedc.getValue()
	local sSaveType = savetype.getValue()
	if nSaveDc ~= 0 then sSave = 'DC ' .. nSaveDc end
	if sSaveType ~= '' then sSave = sSave .. ' ' .. sSaveType end
	
	local sFreq = generateFrequencyString()
	if sSave == '' then sSave = sFreq elseif sFreq ~= '' then sSave = sSave .. '    ' .. sFreq end
	
	local sDur = generateDurationString()
	if sSave == '' then sSave = sDur elseif duration_interval.getValue() > 0 then sSave = sSave .. ' for ' .. sDur end

	local sOnset = generateOnsetString()
	if sSave ~= '' and onset_interval.getValue() > 0 then sSave = sSave .. ' after ' .. sOnset end

	if sSave == '' then sSave = 'none' end
	
	save_string.setValue(sSave)
end

--	This function sets the visibility and editability of various fields on the malady sheet when it is unlocked.
local function ifLocked(sType)
	local sSubtype = ''
	if subtype.getValue() and subtype.getValue() ~= '' then
		sSubtype = ' (' .. subtype.getValue() .. ')'
	end
	type_biglabel.setValue('[' .. type.getValue() .. sSubtype .. ']')

	generateSaveString()

	save_string.setVisible(true)
	savetype.setVisible(false)
	savedc_label.setVisible(false)
	savedc.setVisible(false)
	saveroll.setVisible(true)

	if sType ~= 'disease' then
		duration_label.setVisible(false)
		duration_interval.setVisible(false)
		duration_unit.setVisible(false)
		if poison_effect_primary.getValue() == '' then
			poison_effect_primary.setVisible(true)
			poison_effect_primary_label.setVisible(true)
		end
		if poison_effect_secondary.getValue() == '' then
			poison_effect_secondary.setVisible(true)
			poison_effect_secondary_label.setVisible(true)
		end
	else
		duration_label.setVisible(false)
		duration_interval.setVisible(false)
		duration_unit.setVisible(false)
		disease_effect.setVisible(true)
		raisesave.setVisible(false)
		increaseduration.setVisible(false)
		poison_effect_primary.setVisible(false)
		poison_effect_primary_label.setVisible(false)
		poison_effect_secondary.setVisible(false)
		poison_effect_secondary_label.setVisible(false)
	end
	if sType == 'poison' then
		disease_effect.setVisible(false)
		if save_string.getValue() and save_string.getValue() ~= 'none' then raisesave.setVisible(true) end
		if not save_string.getValue() or save_string.getValue() == 'none' then raisesave.setVisible(false) end
		if duration_interval.getValue() and duration_interval.getValue() > 0 then increaseduration.setVisible(true) end
		if not duration_interval.getValue() or duration_interval.getValue() <= 0 then increaseduration.setVisible(false) end
	end
	
	if disease_effect.getValue() == '\n<p></p>' and poison_effect_primary.getValue() == '' and poison_effect_primary.getValue() == '' then
		section_effect_label.setVisible(false)
	end
	if description.getValue() == '\n<p></p>' then section_description_label.setVisible(false) end

	onset_label.setVisible(false)
	onset_unit.setVisible(false)
	onset_interval.setVisible(false)

	button_settime.setVisible(false)

	freq_label.setVisible(false)
	freq_unit.setVisible(false)
	freq_interval.setVisible(false)

	type_biglabel.setVisible(true)
	type.setVisible(false)
	type_label.setVisible(false)
	subtype.setVisible(false)
	subtype_label.setVisible(false)
	
	if savesreq.getValue() ~= 0 then
		savecount_seperator.setVisible(true)
		isconsecutive.setVisible(true)
	else
		savecount_seperator.setVisible(false)
		isconsecutive.setVisible(false)
	end
end

--	This function sets the visibility and editability of various fields on the malady sheet when it is locked.
local function ifUnlocked(sType)
	save_string.setVisible(false)
	savetype.setVisible(true)
	savedc_label.setVisible(true)
	savedc.setVisible(true)
	saveroll.setVisible(false)

	raisesave.setVisible(false)
	increaseduration.setVisible(false)

	if sType ~= 'disease' then
		duration_label.setVisible(true)
		duration_interval.setVisible(true)
		duration_unit.setVisible(true)
		poison_effect_primary.setVisible(true)
		poison_effect_primary_label.setVisible(true)
		poison_effect_secondary.setVisible(true)
		poison_effect_secondary_label.setVisible(true)
	else
		duration_label.setVisible(true)
		duration_interval.setVisible(true)
		duration_unit.setVisible(true)
		disease_effect.setVisible(true)
		poison_effect_primary.setVisible(false)
		poison_effect_primary_label.setVisible(false)
		poison_effect_secondary.setVisible(false)
		poison_effect_secondary_label.setVisible(false)
	end
	if sType == 'poison' then disease_effect.setVisible(false) end
	if sType ~= 'poison' then disease_effect.setVisible(true) end

	section_effect_label.setVisible(true)
	section_description_label.setVisible(true)

	onset_label.setVisible(true)
	onset_unit.setVisible(true)
	onset_interval.setVisible(true)

	button_settime.setVisible(true)

	freq_label.setVisible(true)
	freq_unit.setVisible(true)
	freq_interval.setVisible(true)

	type_biglabel.setVisible(false)
	type.setVisible(true)
	type_label.setVisible(true)
	subtype.setVisible(true)
	subtype_label.setVisible(true)
	
	savecount_seperator.setVisible(true)
	isconsecutive.setVisible(true)
end

function update()
	local bReadOnly = WindowManager.getReadOnlyState(getDatabaseNode())
	local sType = string.lower(type.getValue())
	if bReadOnly then ifLocked(sType) else ifUnlocked(sType) end

	savesreq.update(bReadOnly, bForceHide, 'cure_label')
	savecount_consec.update(false, bForceHide, 'cure_label', savesreq)
	if sType ~= 'poison' then disease_effect.update(bReadOnly) end
	if sType ~= 'disease' then poison_effect_primary.update(bReadOnly) end
	if sType ~= 'disease' then poison_effect_secondary.update(bReadOnly) end
	description.update(bReadOnly)
end