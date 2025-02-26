if (data.raw.corpse["turret-remnant"] == nil) then
	require("prototypes/turret-remnants")
end
require("prototypes/laser-artillery-turret")
data:extend({
  {
    type = "item",
    name = "kr-laser-artillery-turret",
    icon = "__k2-laser-artillery__/graphics/" .. "building-laser-artillery-turret.png",
    icon_size = 64,
    group = "combat",
    subgroup = "gun",
    order = "b[turret]-e[artillery-turret]-a[laser-artillery-turret]",
    place_result = "kr-laser-artillery-turret",
    stack_size = 10,
  },
  {
    type = "recipe",
    name = "kr-laser-artillery-turret",
    enabled = false,
    energy_required = 20,
    ingredients = {
      {type="item", name = "artillery-turret", amount=1 },
      { type="item", name = "processing-unit",amount= 40 },
      { type="item", name = "laser-turret",amount= 25 },
      { type="item", name = "accumulator",amount= 100 },
    },
    results = {{type="item", name ="kr-laser-artillery-turret",amount=1}}
  },
  {
    type = "technology",
    name = "kr-laser-artillery-turret",
    icon = "__k2-laser-artillery__/graphics/" .. "technology-laser-artillery-turret.png",
    icon_size = 256,
    prerequisites = { "artillery" },
    effects = {
      {
        type = "unlock-recipe",
        recipe = "kr-laser-artillery-turret",
      },
    },
    order = "g-f-z",
    unit = {
      count = 2500,
      ingredients = {
        { "automation-science-pack", 1 },
        { "logistic-science-pack", 1 },
        { "military-science-pack", 1 },
        { "chemical-science-pack", 1 },
        { "production-science-pack", 1 },
        { "utility-science-pack", 1 }
      },
      time = 60,
    },
  },
  {
    type = "trivial-smoke",
    name = "kr-laser-explosion-gunshot-smoke-fast",
    animation = {
      filename = "__base__/graphics/entity/smoke-fast/smoke-fast.png",
      priority = "high",
      blend_mode = "additive-soft",
      width = 50,
      height = 50,
      frame_count = 16,
      animation_speed = 16 / 60,
      duration = 600,
      fade_in_duration = 0,
      fade_away_duration = 600,
      spread_duration = 600,
      start_scale = 0.20,
      end_scale = 1.0,
      tint = { r = 0.65, g = 0.0, b = 0.0, a = 0.9 },
    },
    duration = 60,
    fade_away_duration = 60,
  },
  {
    type = "explosion",
    name = "kr-laser-explosion-gunshot",
    flags = { "not-on-map" },
    subgroup = "explosions",
    animations = {
      {
        filename = "__k2-laser-artillery__/graphics/" .. "laser_gunshot.png",
        priority = "extra-high",
        draw_as_glow = true,
        width = 51,
        height = 57,
        frame_count = 2,
        animation_speed = 1.3,
        shift = { 0, 0 },
      },
      {
        filename = "__k2-laser-artillery__/graphics/" .. "laser_gunshot.png",
        priority = "high",
        draw_as_glow = true,
        blend_mode = "additive",
        width = 51,
        height = 57,
        frame_count = 2,
        animation_speed = 1.3,
        shift = { 0, 0 },
      },
      {
        filename = "__k2-laser-artillery__/graphics/" .. "laser_gunshot.png",
        priority = "medium",
        width = 51,
        height = 57,
        frame_count = 2,
        animation_speed = 1.3,
        shift = { 0, 0 },
      },
    },
    rotate = true,
    smoke = "kr-laser-explosion-gunshot-smoke-fast",
    smoke_count = 2,
    smoke_slow_down_factor = 0.25,
  },
  {
    type = "explosion",
    name = "kr-laser-explosion",
    icon = "__base__/graphics/item-group/effects.png",
    icon_size = 64,
    flags = { "not-on-map" },
    subgroup = "explosions",
    animations = {
      filename = "__k2-laser-artillery__/graphics/" .. "laser-explosion.png",
      -- flags = { "compressed" },
      width = 300,
      height = 300,
      frame_count = 47,
      line_length = 8,
      shift = { 0.1875, -0.75 },
      draw_as_glow = true,
      animation_speed = 0.55,
    },
    sound = {
      aggregation = {
        max_count = 2,
        remove = true,
      },
      audible_distance_modifier = 1.95,
      variations = {
        {
          filename = "__base__/sound/fight/large-explosion-1.ogg",
          volume = 0.75,
        },
        {
          filename = "__base__/sound/fight/large-explosion-2.ogg",
          volume = 0.75,
        },
      },
    },
  },
  {
    type = "projectile",
    name = "laser-projectile",
    flags = { "not-on-map" },
    --collision_box = {{-0.3, -1.1}, {0.3, 1.1}},
    acceleration = 0,
    --direction_only = true,
    --piercing_damage = 500,
    action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          {
            type = "damage",
            damage = { amount = 1000, type = "laser" },
          },
          --          {
          --            type = "damage",
          --            damage = {amount = 500 , type = "explosion"}
          --          },
          {
            type = "create-entity",
            entity_name = "kr-laser-explosion",
          },
        },
      },
    },
    final_action = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {

          {
            type = "create-entity",
            entity_name = "big-explosion",
          },
          {
            type = "show-explosion-on-chart",
            scale = 1,
          },
          {
            type = "create-entity",
            entity_name = "small-scorchmark",
            check_buildability = true,
          },
          {
            type = "nested-result",
            action = {
              type = "area",
              radius = 4,
              action_delivery = {
                type = "instant",
                target_effects = {
                  {
                    type = "damage",
                    damage = { amount = 250, type = "explosion" },
                  },
                  {
                    type = "create-entity",
                    entity_name = "explosion",
                  },
                },
              },
            },
          },
        },
      },
    },
    animation = {
      filename = "__k2-laser-artillery__/graphics/" .. "missile-laser.png",
      frame_count = 1,
      width = 6,
      height = 90,
      priority = "high",
    },
    light = { intensity = 2, size = 15, color = { r = 1, g = 0.1, b = 0.1 } },
  },
})

