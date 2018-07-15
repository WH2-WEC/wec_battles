load_script_libraries();

output_uicomponent_on_click();

bm = battle_manager:new(empire_battle:new());
local gc = generated_cutscene:new(true);
cam = bm:camera();
	
local pos_out = "";
local targ_out = "";


gb = generated_battle:new(
	false,                                      		-- screen starts black
	true,                                      		-- prevent deployment for player
	false,                                      		    -- prevent deployment for ai
	function() end_deployment_phase() end,          	-- intro cutscene function
	false                                      			-- debug mode
);

intro_cinematic_file = "script/battle/quest_battles/_cutscene/scenes/wolfplate_s01.CindyScene";
bm:cindy_preload(intro_cinematic_file);

wh2_main_sfx_01 = new_sfx("Play_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_01");
wh2_main_sfx_02 = new_sfx("Play_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_02");
wh2_main_sfx_03 = new_sfx("Play_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_03");
wh2_main_sfx_04 = new_sfx("Play_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_04");

fade_on_intro_cutscene_end = true;

function end_deployment_phase()
	bm:out("\tend_deployment_phase() called");
	
	cam:fade(true, 0);
		
	-- declare cutscene
	local cutscene_intro = cutscene:new(
		"cutscene_intro", 			-- unique string name for cutscene
		ga_player_01.sunits,			-- unitcontroller over player's army
		30000, 				-- duration of cutscene in ms
		function() intro_cutscene_end() end		-- what to call when cutscene is finished
	);


	
	local player_units_hidden = true;

	
	-- set up subtitles
	local subtitles = cutscene_intro:subtitles();
	subtitles:set_alignment("bottom_centre");
	subtitles:clear();
	
	cutscene_intro:set_is_ambush();
	
	-- skip callback
	cutscene_intro:set_skippable(
		true, 
		function()
			bm:stop_cindy_playback(true);
			
			if player_units_hidden then
				ga_player_01:set_enabled(true)
			end;
		end
	);



cutscene_intro:set_debug(true);
cutscene_intro:enable_debug_timestamps(false);



	-- set up actions on cutscene
	--cutscene_intro:action(function() cam:fade(false, 1) end, 100);	

	--cutscene_intro:action(function() cam:move_to(v(307.712, 725.585, 141.159), v(217.846, 699.303, 183.810), 0, true, 0) end, 0);

	cutscene_intro:action(function() bm:cindy_playback("script/battle/quest_battles/_cutscene/scenes/wolfplate_s01.CindyScene", true, true) end, 0);	
	
	cutscene_intro:action(
		function()
			player_units_hidden = false;
			ga_player_01:set_enabled(true) 
		end, 
		200
	);
	
	-- Voiceover and Subtitles --
	
	cutscene_intro:action(function() cutscene_intro:play_sound(wh2_main_sfx_01) end, 3000);	
	cutscene_intro:action(function() cutscene_intro:show_custom_cutscene_subtitle("scripted_subtitles_localised_text_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_01", "subtitle_with_frame", 1) end, 3500);	
	cutscene_intro:action(function() cutscene_intro:hide_custom_cutscene_subtitles() end, 5000);
	
	cutscene_intro:action(function() cutscene_intro:play_sound(wh2_main_sfx_02) end, 5500);	
	cutscene_intro:action(function() cutscene_intro:show_custom_cutscene_subtitle("scripted_subtitles_localised_text_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_02", "subtitle_with_frame", 5) end, 6000);	
	cutscene_intro:action(function() cutscene_intro:hide_custom_cutscene_subtitles() end, 11500);
	
	cutscene_intro:action(function() cutscene_intro:play_sound(wh2_main_sfx_03) end, 12000);	
	cutscene_intro:action(function() cutscene_intro:show_custom_cutscene_subtitle("scripted_subtitles_localised_text_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_03", "subtitle_with_frame", 9.5) end, 12500);	
	cutscene_intro:action(function() cutscene_intro:hide_custom_cutscene_subtitles() end, 22500);
	
	cutscene_intro:action(function() cutscene_intro:play_sound(wh2_main_sfx_04) end, 23000);
	cutscene_intro:action(function() cutscene_intro:show_custom_cutscene_subtitle("scripted_subtitles_localised_text_wh2_main_qb_skv_skrolk_the_liber_bubonicus_stage_3_mortuary_of_tzulaqua_pt_04", "subtitle_with_frame", 4) end, 23500);	
	cutscene_intro:action(function() cutscene_intro:hide_custom_cutscene_subtitles() end, 29500);
	
	cutscene_intro:start();
end;




function createButton()
	out("VANDY: Add button function triggered!");
	local buttonPanel = find_uicomponent(core:get_ui_root(), "layout", "battle_orders", "battle_orders_pane")

	if not not buttonPanel then
		out("VANDY: buttonPanel found!"); 
		--local ButtonSubpanel = find_uicomponent(core:get_ui_root(), "layout", "hud_center_docker", "hud_center", "small_bar", "button_group_army");
		--if not not ButtonSubpanel then
			--out("VANDY: portholePanel ButtonSubpanel found!");
			local buttonPanelHalt = find_uicomponent(buttonPanel, "orders_parent", "button_guard")
			local buttonPanelDebug = Button.new("buttonPanelDebug", buttonPanel, "SQUARE", "ui/skins/default/icon_camera_settings.png")

			out("VANDY: Beginning of the actual add button function");
				buttonPanelDebug:Resize(buttonPanelHalt:Bounds());

			local uuWidth, uuHeight = buttonPanelHalt:Bounds();
			local uuXPos, uuYPos = buttonPanelHalt:Position();
			local gap = 5;

			--buttonPanelDebug:PositionRelativeTo(buttonPanelHalt, gap + uuWidth, 0);

			buttonPanelDebug:MoveTo(1053, 1019)

			--UnitUpgradeButton:PositionRelativeTo(ButtonRenown, 50, 0);
			buttonPanelDebug:RegisterForClick(
				function(context)
					core:trigger_event("DebugButtonPressed")
				end
			);

			buttonPanelDebug:SetState("active");

			local uic = find_uicomponent(buttonPanel, "buttonPanelDebug");
			if not not uic then
				out("VANDY: Attempting to make a tooltip, plz work");
				core:cache_and_set_tooltip_for_component_state(uic, "active", "ui_text_replacements_localised_text_end_turn_button_disabled_for_advice");
			end;
			--function core_object:cache_and_set_tooltip_for_component_state(uic, state, new_tooltip)
			--			local uic_end_turn_button = find_uicomponent(core:get_ui_root(), "faction_buttons_docker", "button_end_turn");
			--if uic_end_turn_button then
			--	core:cache_and_set_tooltip_for_component_state(uic_end_turn_button, "inactive", "ui_text_replacements_localised_text_end_turn_button_disabled_for_advice");
			--end;
			--UnitUpgradeButton:InterfaceFunction("SetTooltip", "THISISVANDYTESTING");
			--UnitUpgradeButton:SetTooltipText("this is a fucking test", true);
			buttonPanelDebug:SetVisible(true);
			out("VANDY: Completion of the actual add button function");
		--end
	end

	core:add_listener(
        "debugFrame",
        "DebugButtonPressed",
        true,
        function()
            local existingFrame = Util.getComponentWithName("DebugFrame");
			if not existingFrame then

				local frame = Util.createComponent("DebugFrame", core:get_ui_root(), "ui/battle ui/mp_team_list");
				local name = "DebugFrame"
				--[[Util.delete(UIComponent(frame:Find("tx_unit-type")))
				Util.delete(UIComponent(frame:Find("button_description_toggle")))
				Util.delete(UIComponent(frame:Find("dy_food")))
				Util.delete(UIComponent(frame:Find("health_parent")))
				Util.delete(UIComponent(frame:Find("dy_men")))
				Util.delete(UIComponent(frame:Find("upkeep_cost")))
				Util.delete(UIComponent(frame:Find("bret_peasant_icon")))]]
				--Util.delete(UIComponent(frame:Find("stat_1")))



				--[[local title = find_uicomponent(frame, "top_section", "custom_name_display")
				local parchment = UIComponent(frame:Find("parchment"));
				title:SetStateText("Battle Script Debugger!");
				local description = find_uicomponent(frame, "top_section", "short_description")
				description:SetStateText(pos_out .."\n".. targ_out);

			

				local self = {};
				--# assume self: FRAME
				self.uic = frame --:const
				self.name = name --:const
				self.title = title --:const
				self.content = parchment --:const
				self.components = {} --: vector<CA_UIC | COMPONENT_TYPE | CONTAINER>
				self.closeButton = nil --: BUTTON
				
				Util.registerComponent(name, self)
				--return self;

				local imagePath = "ui/skins/warhammer2/icon_cross.png";

				local closeButton = Button.new("DebugFrameCloseButton", frame, "CIRCULAR", imagePath);

				self.closeButton = closeButton;
				--v function(self: FRAME, component: CA_UIC | COMPONENT_TYPE | CONTAINER)
				frame:AddComponent(closeButton);

				local width, height = frame:Dimensions();
				local buttonWidth, buttonHeight = closeButton.uic:Dimensions();
				Components.positionRelativeTo(closeButton.uic, self.uic, width/2 - buttonWidth/2, height - buttonHeight/2);



				closeButton:RegisterForClick(
				function(context)
					core:trigger_event("DebugCloseButtonPressed")
				end
				);

			else
				--# assume existingFrame: BUTTON
				existingFrame:SetVisible(true)]]
			end

		end,
        true
	);
	core:add_listener(
		"debugFrameClose",
		"DebugCloseButtonPressed",
		true,
		function()
			local frame = Util.getComponentWithName("DebugFrame")
			if not not frame then

				frame:delete()
				frame:unregisterComponent()
			end
		end,
		true
	);


end

function intro_cutscene_end()
	local sm = gb.sm
	sm:trigger_message("01_intro_cutscene_end")
	--Util.init()
	createButton()
	bm:repeat_callback(
		function() CameraOut() end,
		100,
		"CameraOut"
		);
end;


function CameraOut()
	bm:cache_camera();
	local pos = bm:get_cached_camera_pos()
	local targ = bm:get_cached_camera_targ()
	
	local pos_y = pos:get_y();
	local pos_x = pos:get_x();
	local pos_z = pos:get_z();
	
	local targ_y = targ:get_y();
	local targ_x = targ:get_x();
	local targ_z = targ:get_z();
	


	pos_out = "POS: ("..tostring(pos_x).."\n"..tostring(pos_y).."\n"..tostring(pos_z)..")"
	targ_out = "TARG: ("..tostring(targ_x).."\n"..tostring(targ_y).."\n"..tostring(targ_z)..")"
    local existingFrame = Util.getComponentWithName("DebugFrame");
	if not not existingFrame then
		local description = find_uicomponent(core:get_ui_root(), "DebugFrame", "top_section", "short_description")
		description:SetStateText(pos_out .."\n".. targ_out);
	end


end;





---------------------------
----HARD SCRIPT VERSION----
---------------------------
gb:set_objective_on_message("deployment_started", "wh_main_qb_objective_attack_defeat_army_ambush");


-------ARMY SETUP-------
ga_player_01 = gb:get_army(gb:get_player_alliance_num(), "player");
ga_bst1 = gb:get_army(gb:get_non_player_alliance_num(), "bst1");
ga_bst2 = gb:get_army(gb:get_non_player_alliance_num(), "bst2");
ga_bst3 = gb:get_army(gb:get_non_player_alliance_num(), "bst3");
ga_emp1 = gb:get_army(gb:get_player_alliance_num(), "emp1");


-------OBJECTIVES-------
--gb:queue_help_on_message("battle_started", "wh_dlc03_qb_bst_khazrak_one_eye_scourge_stage_4_hint_objective");


-------ORDERS-------

ga_bst1:attack_on_message("01_intro_cutscene_end");

ga_bst1:message_on_casualties("summon_reinforcements", 0.4);

ga_bst3:reinforce_on_message("summon_reinforcements");
ga_bst3:attack_on_message("summon_reinforcements");
ga_emp1:reinforce_on_message("testing");
ga_emp1:attack_on_message("testing");
ga_bst2:reinforce_on_message("summon_reinforcements");
ga_bst2:attack_on_message("summon_reinforcemnts");

ga_player_01:message_on_casualties("testing", 0.01);
