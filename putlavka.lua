require 'lib.moonloader'
local samp = require 'lib.samp.events'

local active = false

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampAddChatMessage("{C285FF}[PutLavka]{FFFFFF} ��������  |  ���������: {C285FF}/pl{FFFFFF}  |  �����: {FFD700}legacy.", -1)

    sampRegisterChatCommand('pl', function()
        active = not active
        local status = active and "{00FF00}�������" or "{FF0000}��������"
        sampAddChatMessage(string.format("{C285FF}[PutLavka]{FFFFFF} ������: %s", status), -1)
    end)

    while true do
        wait(1000)
        if active then
            sampAddChatMessage("���� ����� ��� �����", -1)
            sampSendChat("/lavka")
        end
    end
end

function samp.onServerMessage(_, text)
    if text:find('�� ������� ��������� ����� ��� �������/������� ������!') then
        sampAddChatMessage("{7B3F99}[PutLavka] {5A2D80}����� �����������", -1)
        active = false
    elseif text:find('%[������%] {FFFFFF}�� �����!') then
        return false
    elseif text:find('%[������%] {ffffff}� ��� ��� ����������� �����!') then
        sampAddChatMessage("{C285FF}[PutLavka] {FFFFFF}� ��� ��� ����������� �����,��������� ���������.", -1)
        active = false
    end
end
