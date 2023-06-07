local _, core = ...; -- Namespace
local AceGUI = LibStub("AceGUI-3.0")
FineTune = LibStub("AceAddon-3.0"):NewAddon("FineTune", "AceConsole-3.0", "AceEvent-3.0")

core.frames = {
    extraAbilityContainer = _G["ExtraAbilityContainer"],
    targetFrame = _G["TargetFrame"],
    talkingHeadFrame = _G["TalkingHeadFrame"],
    partyFrame = _G["PartyFrame"],
    combatRaidFrameContainer = _G["CompactRaidFrameContainer"],
    debuffFrame = _G["DebuffFrame"],
    possessActionBar = _G["PossessActionBar"],
    playerFrame = _G["PlayerFrame"],
    chatFrame1 = _G["ChatFrame1"],
    mainMenuBarVehicleLeaveButton = _G["MainMenuBarVehicleLeaveButton"],
    playerCastingBarFrame = _G["PlayerCastingBarFrame"],
    stanceBar = _G["StanceBar"],
    petActionBar = _G["PetActionBar"],
    mainMenuBar = _G["MainMenuBar"],
    multiBarBottomLeft = _G["MultiBarBottomLeft"],
    multiBar7 = _G["MultiBar7"],
    multiBar6 = _G["MultiBar6"],
    multiBar5 = _G["MultiBar5"],
    multiBarBottomRight = _G["MultiBarBottomRight"],
    multiBarRight = _G["MultiBarRight"],
    multiBarLeft = _G["MultiBarLeft"],
    mainStatusTrackingBarContainer = _G["MainStatusTrackingBarContainer"],
    secondaryStatusTrackingBarContainer = _G["SecondaryStatusTrackingBarContainer"],
    petFrame = _G["PetFrame"],
    objectiveTrackerFrame = _G["ObjectiveTrackerFrame"],
    buffFrame = _G["BuffFrame"],
    minimapCluster = _G["MinimapCluster"],
    bossTargetFrameContainer = _G["BossTargetFrameContainer"],
    durabilityFrame = _G["DurabilityFrame"],
    arenaEnemyFramesContainer = _G["ArenaEnemyFramesContainer"],
    gameTolltipDefaultContainer = _G["GameTooltipDefaultContainer"],
    bagsBar = _G["BagsBar"],
    microMenuContainer = _G["MicroMenuContainer"],
    lootFrame = _G["LootFrame"],
}

local container = CreateFrame("Frame", "container", UIParent);
container:HookScript("OnUpdate", function() FineTune:OnUpdateHandler() end)

local settingDialog = _G["EditModeSystemSettingsDialog"];
local coordText = settingDialog:CreateFontString(nil, "OVERLAY", "GameFontNormal")
coordText:SetPoint("BOTTOM", settingDialog, "BOTTOM", 0, 125);
local leftArrowButton = CreateFrame("Button", "leftArrorButton", settingDialog, "UIPanelButtonTemplate")
leftArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
leftArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", -40, 50);
leftArrowButton:SetSize(30, 30)

local rightArrowButton = CreateFrame("Button", "rightArrorButton", settingDialog, "UIPanelButtonTemplate")
rightArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
rightArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", 40, 50);
rightArrowButton:SetSize(30, 30)

local upArrowButton = CreateFrame("Button", "upArrorButton", settingDialog, "UIPanelButtonTemplate")
upArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
upArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", 0, 80);
upArrowButton:SetSize(30, 30)
upArrowButton:GetNormalTexture():SetRotation(math.rad(-90))

local downArrowButton = CreateFrame("Button", "downArrorButton", settingDialog, "UIPanelButtonTemplate")
downArrowButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
downArrowButton:SetPoint("BOTTOM", settingDialog, "BOTTOM", 0, 20);
downArrowButton:SetSize(30, 30)
downArrowButton:GetNormalTexture():SetRotation(math.rad(-90))

function FineTune:SetUpArrowFunctions(frame)
    leftArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "left") end)
    rightArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "right") end)
    upArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "up") end)
    downArrowButton:SetScript("OnClick", function() FineTune:Move(frame, "down") end)
end

function FineTune:OnUpdateHandler()
    for name, frame in pairs(core.frames) do
        local movable = frame:IsMovable();
        if movable then
            local left = frame:GetLeft();
            local bottom = frame:GetBottom();
            local leftFormatted = string.format("%.1f", left);
            local bottomFormatted = string.format("%.1f", bottom);
            coordText:SetText("X: " .. leftFormatted .. " Y: " .. bottomFormatted)
            FineTune:SetUpArrowFunctions(frame);
        end
    end
end

function FineTune:Move(frame, direction)
    if frame then
        local currentPoints = { frame:GetPoint() }
        if direction == "left" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4] - 1, currentPoints[5])
        elseif direction == "right" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4] + 1, currentPoints[5])
        elseif direction == "up" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4], currentPoints[5] + 1)
        elseif direction == "down" then
            frame:SetPoint(currentPoints[1], currentPoints[2], currentPoints[3], currentPoints[4], currentPoints[5] - 1)
        end
    end
end