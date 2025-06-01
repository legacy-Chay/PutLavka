require 'lib.moonloader'
local samp = require 'lib.samp.events'

local active = false

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end

    sampAddChatMessage("{C285FF}[PutLavka]{FFFFFF} загружен  |  Активация: {C285FF}/pl{FFFFFF}  |  Автор: {FFD700}legacy.", -1)

    sampRegisterChatCommand('pl', function()
        active = not active
        local status = active and "{00FF00}Включен" or "{FF0000}Выключен"
        sampAddChatMessage(string.format("{C285FF}[PutLavka]{FFFFFF} Статус: %s", status), -1)
    end)

    while true do
        wait(1000)
        if active then
            sampAddChatMessage("Ищем место для лавки", -1)
            sampSendChat("/lavka")
        end
    end
end

function samp.onServerMessage(_, text)
    if text:find('Вы успешно выставили лавку для продажи/покупки товара!') then
        sampAddChatMessage("{C285FF}[PutLavka] {FFFFFF}Лавка установлена", -1)
        active = false
    elseif text:find('%[Ошибка%] {FFFFFF}Не флуди!') then
        return false
    elseif text:find('%[Ошибка%] {ffffff}У Вас уже установлена лавка!') then
        sampAddChatMessage("{C285FF}[PutLavka] {FFFFFF}У вас уже установлена лавка,установка отключёна.", -1)
        active = false
    end
end
