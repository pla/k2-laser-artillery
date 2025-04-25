local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

function laser_artillery_turret_sheet(inputs)
  return {
    layers = {
      {
          filename = "__k2-laser-artillery__/graphics/" .. "building-hr-laser-artillery-turret-sheet.png",
          width = 440,
          height = 380,
          line_length = inputs.frame_count or 8,
          frame_count = inputs.frame_count or 1,
          axially_symmetrical = false,
          direction_count = 64,
          shift = { 0, -0.7 },
          scale = 0.5,
        
      },
      {
        flags = { "mask" },
        filename = "__k2-laser-artillery__/graphics/" .. "building-hr-laser-artillery-turret-sheet-mask.png",
        width = 440,
        height = 380,
        line_length = inputs.frame_count or 8,
        frame_count = inputs.frame_count or 1,
        axially_symmetrical = false,
        direction_count = 64,
        shift = { 0, -0.7 },
        apply_runtime_tint = true,
        scale = 0.5,

      },
      {
        filename = "__k2-laser-artillery__/graphics/" .. "building-hr-laser-artillery-turret-sheet-shadow.png",
        width = 460,
        height = 380,
        line_length = inputs.frame_count or 8,
        frame_count = inputs.frame_count or 1,
        axially_symmetrical = false,
        direction_count = 64,
        shift = { 0.9, 0.05 },
        draw_as_shadow = true,
        scale = 0.5,

      },
    },
  }
end

data:extend({
  {
    type = "electric-turret",
    name = "k2-laser-artillery-turret",
    icon = "__k2-laser-artillery__/graphics/" .. "item-laser-artillery-turret.png",
    icon_size = 64,
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "k2-laser-artillery-turret" },
    max_health = 1000,
    corpse = "turret-remnant",
    damaged_trigger_effect = hit_effects.entity(),
    resistances = {
      { type = "physical", percent = 50 },
      { type = "fire",     percent = 75 },
      { type = "impact",   percent = 75 },
    },
    collision_box = { { -1.75, -1.75 }, { 1.75, 1.75 } },
    selection_box = { { -2, -2 }, { 2, 2 } },
    graphics_set = {
      base_visualisation = {
        animation = {
          layers = {
            {
              filename = "__k2-laser-artillery__/graphics/" .. "building-hr-k2-turret-base.png",
              priority = "high",
              width = 440,
              height = 380,
              axially_symmetrical = false,
              direction_count = 1,
              frame_count = 1,
              shift = { 0, -0.8 },
              scale = 0.5,

            },
            {
              filename = "__k2-laser-artillery__/graphics/" .. "building-hr-k2-turret-base-mask.png",
              flags = { "mask", "low-object" },
              line_length = 1,
              width = 440,
              height = 380,
              axially_symmetrical = false,
              direction_count = 1,
              frame_count = 1,
              shift = { 0, -0.8 },
              apply_runtime_tint = true,
              scale = 0.5,

            },
            {
              filename = "__k2-laser-artillery__/graphics/" .. "building-hr-k2-turret-base-shadow.png",
              line_length = 1,
              width = 440,
              height = 380,
              axially_symmetrical = false,
              draw_as_shadow = true,
              direction_count = 1,
              frame_count = 1,
              shift = { 0, -0.8 },
              scale = 0.5,

            },
          },
        },
      },
    },
    vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
    energy_glow_animation = laser_turret_shooting_glow(),
    glow_light_intensity = 0.5, -- defaults to 0

    rotation_speed = 0.002,
    preparing_speed = 0.08,
    folding_speed = 0.02,
    dying_explosion = "big-explosion",
    --attacking_speed = 0.020, -- its strongly reduce rate of fire
    folded_animation = laser_artillery_turret_sheet({ direction_count = 8, line_length = 1 }),

    energy_source = {
      type = "electric",
      buffer_capacity = "100MJ",
      input_flow_limit = "150MW",
      drain = "50MW",
      usage_priority = "primary-input",
    },

    attack_parameters = {
      type = "projectile",
      cooldown = 120,
      ammo_category = "laser",
      projectile_creation_distance = 3.9,
      projectile_center = { 0, 0.2 },
      range = 11 * 32, -- artillery is 7 * 32
      min_range = 32,  -- same of artillery is 32
      ammo_type = {
        category = "laser",
        target_type = "entity",
        energy_consumption = "99.9MJ",
        action = {
          type = "direct",
          action_delivery = {
            type = "projectile",
            projectile = "laser-projectile",
            starting_speed = 5,
            direction_deviation = 0.1,
            range_deviation = 0.1,
            max_range = 11 * 32, -- artillery is 7 * 32
            source_effects = {
              type = "create-explosion",
              entity_name = "k2-laser-explosion-gunshot",
            },
          },
        },
      },
      rotate_penalty = 200,
      health_penalty = -10000,
      --warmup = 27, -- its strongly reduce rate of fire, was used to sync the sounds of turret when shot
      sound = {
        {
          filename = "__k2-laser-artillery__/sounds/" .. "laser-artillery-turret-shot.ogg",
          volume = 0.20,
        },
      },
    },
    starting_attack_sound = {
      {
        filename = "__k2-laser-artillery__/sounds/" .. "laser-artillery-turret-starting_attack_sound.ogg",
        volume = 0.20,
        audible_distance_modifier = 0.5,
        aggregation = {
          count_already_playing = true,
          max_count = 3,
        },
      },
    },

    water_reflection = {
      pictures = {
        filename = "__k2-laser-artillery__/graphics/" .. "building-turrets-reflection.png",
        priority = "extra-high",
        width = 50,
        height = 50,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false,
    },

    shoot_in_prepare_state = false,
    turret_base_has_direction = true,
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    call_for_help_radius = 110,

  },
})


-- Sound fixes if needed
if settings.startup["k2-fix-laser-artillery-turret"].value == true then
  data.raw["electric-turret"]["k2-laser-artillery-turret"].starting_attack_sound = nil
end
