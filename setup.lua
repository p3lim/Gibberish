﻿local __, Gibberish = ...

local FONT = [=[Interface\AddOns\Gibberish\semplice.ttf]=]

local function Skin(index)
	local frame = _G['ChatFrame'..index]
	frame:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	frame:SetShadowOffset(0, 0)
	frame:SetClampRectInsets(0, 0, 0, 0)
	frame:SetSpacing(1.4)

	local editbox = _G['ChatFrame'..index..'EditBox']
	editbox:ClearAllPoints()
	editbox:SetPoint('TOPRIGHT', frame, 'BOTTOMRIGHT', 0, 5)
	editbox:SetPoint('TOPLEFT', frame, 'BOTTOMLEFT', 0, 5)
	editbox:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	editbox:SetShadowOffset(0, 0)
	editbox:SetAltArrowKeyMode(false)

	editbox.focusLeft:SetTexture(nil)
	editbox.focusMid:SetTexture(nil)
	editbox.focusRight:SetTexture(nil)

	editbox.header:ClearAllPoints()
	editbox.header:SetPoint('LEFT')
	editbox.header:SetFont(FONT, 8, 'OUTLINEMONOCHROME')
	editbox.header:SetShadowOffset(0, 0)

	local orig = editbox.SetTextInsets
	editbox.SetTextInsets = function(self)
		orig(self, self.header:GetWidth(), 0, 0, 0)
	end

	_G['ChatFrame'..index..'ButtonFrame']:Hide()
	_G['ChatFrame'..index..'EditBoxLeft']:SetTexture(nil)
	_G['ChatFrame'..index..'EditBoxMid']:SetTexture(nil)
	_G['ChatFrame'..index..'EditBoxRight']:SetTexture(nil)

	_G['ChatFrame'..index..'Tab']:SetScript('OnDragStart', nil)
end

Gibberish.Skin = Skin

local Handler = CreateFrame('Frame')
Handler:RegisterEvent('PLAYER_LOGIN')
Handler:RegisterEvent('CHAT_MSG_WHISPER')
Handler:RegisterEvent('CHAT_MSG_BN_WHISPER')
Handler:SetScript('OnEvent', function(self, event)
	if(event == 'PLAYER_LOGIN') then
		for index = 1, 4 do
			Skin(index)

			_G['ChatFrame'..index..'Tab']:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		end

		DEFAULT_CHATFRAME_ALPHA = 0
		ChatFrameMenuButton:SetAlpha(0)
		ChatFrameMenuButton:EnableMouse(false)
		FriendsMicroButton:Hide()

		ChatTypeInfo.CHANNEL.sticky = 0
		ChatTypeInfo.WHISPER.sticky = 0
		ChatTypeInfo.BN_WHISPER.sticky = 0
		ChatTypeInfo.GUILD.flashTabOnGeneral = true
	else
		PlaySound('TellMessage', 'master')
	end
end)

function CombatLog_LoadUI() end

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
