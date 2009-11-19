--[[
	The client doesn't allow using DetectWowMouse() constantly,
	and it is locked while the PopupDialog is shown.
	We have to do this in a timed script for it to work.
--]]

local timer = 0
local dummy = CreateFrame('Frame')
dummy:Hide()
dummy:SetScript('OnUpdate', function(self, elapsed)
	if(timer > 0.2) then
		DetectWowMouse()
		self:Hide()
		timer = 0
	else
		timer = timer + elapsed
	end
end)

StaticPopupDialogs.WOW_MOUSE_NOT_FOUND = {
	text = WOW_MOUSE_NOT_FOUND,
	button1 = 'Retry',
	button2 = 'Ignore',
	OnAccept = function(self)
		dummy:Show()
	end,
	OnCancel = function(self)
		SetCVar('enableWoWMouse', '0')
		if(InterfaceOptionsFrame:IsShown()) then
			InterfaceOptionsMousePanelWoWMouse:Click()
		end
	end,
	timeout = 0,
	whileDead = 1,
	showAlert = 1,
	hideOnEscape = 1
}
