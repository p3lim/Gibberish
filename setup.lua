﻿local TEXTURE = [=[Interface\ChatFrame\ChatFrameBackground]=]
local BACKDROP = {bgFile = TEXTURE, edgeFile = TEXTURE, edgeSize = 1}
local FONT = [=[Interface\AddOns\Gibberish\semplice.ttf]=]

for index = 1, 5 do
	local frame = _G['ChatFrame'..index]
	frame:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	frame:SetShadowOffset(0, 0)
	frame:SetClampRectInsets(0, 0, 0, 0)

	local bg = CreateFrame('Frame', nil, frame)
	bg:SetPoint('TOPRIGHT', 2, 0)
	bg:SetPoint('BOTTOMLEFT', -2, -4)
	bg:SetBackdrop(BACKDROP)
	bg:SetBackdropColor(0, 0, 0, 0.3)
	bg:SetBackdropBorderColor(0, 0, 0)
	bg:SetFrameLevel(0)

	local editbox = _G['ChatFrame'..index..'EditBox']
	editbox:ClearAllPoints()
	editbox:SetPoint('BOTTOMRIGHT', 0, -20)
	editbox:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 0, -6)
	editbox:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	editbox:SetShadowOffset(0, 0)
	editbox:SetAltArrowKeyMode(false)

	editbox.focusLeft:SetTexture(nil)
	editbox.focusMid:SetTexture(nil)
	editbox.focusRight:SetTexture(nil)

	editbox.header:SetFont(FONT, 8, 'OUTLINEMONOCHROME')

	local bg = CreateFrame('Frame', nil, editbox)
	bg:SetPoint('TOPRIGHT', 2, 0)
	bg:SetPoint('BOTTOMLEFT', -2, -2)
	bg:SetBackdrop(BACKDROP)
	bg:SetBackdropColor(0, 0, 0, 0.3)
	bg:SetBackdropBorderColor(0, 0, 0)
	bg:SetFrameLevel(0)

	_G['ChatFrame'..index..'ButtonFrame']:Hide()
	_G['ChatFrame'..index..'EditBoxLeft']:SetTexture(nil)
	_G['ChatFrame'..index..'EditBoxMid']:SetTexture(nil)
	_G['ChatFrame'..index..'EditBoxRight']:SetTexture(nil)
end

DEFAULT_CHATFRAME_ALPHA = 0
ChatFrameMenuButton:SetAlpha(0)
ChatFrameMenuButton:EnableMouse(false)
FriendsMicroButton:Hide()

ChatTypeInfo.CHANNEL.sticky = 0
ChatTypeInfo.WHISPER.sticky = 0
ChatTypeInfo.BN_WHISPER.sticky = 0

function FloatingChatFrame_OnMouseScroll(self, direction)
	if(direction > 0) then
		if(IsShiftKeyDown()) then
			self:ScrollToTop()
		elseif(IsControlKeyDown()) then
			self:PageUp()
		else
			self:ScrollUp()
		end
	elseif(direction < 0) then
		if(IsShiftKeyDown()) then
			self:ScrollToBottom()
		elseif(IsControlKeyDown()) then
			self:PageDown()
		else
			self:ScrollDown()
		end
	end
end
