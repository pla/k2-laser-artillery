local graphics_path = "__k2-laser-artillery__/" .. "graphics/remnants/"

data:extend({
  {
    type = "corpse",
    name = "turret-remnant",
    localised_name = { "entity-name.turret-remnant" },
    icon = "__k2-laser-artillery__/" .. "graphics/item-laser-artillery-turret.png",
    icon_size = 64,
    flags = { "placeable-neutral", "building-direction-8-way", "not-on-map" },
    selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
    tile_width = 9,
    tile_height = 9,
    selectable_in_game = false,
    subgroup = "remnants",
    order = "z[remnants]-a[generic]-b[medium]",
    time_before_removed = 60 * 60 * 20, -- 20 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet(1, {
      filename = graphics_path .. "turret-remnant.png",
      line_length = 1,
      width = 186,
      height = 126,
      frame_count = 1,
      direction_count = 1,
      hr_version = {
        filename = graphics_path .. "hr-turret-remnant.png",
        line_length = 1,
        width = 373,
        height = 253,
        frame_count = 1,
        direction_count = 1,
        scale = 0.5,
      },
    }),
  },
})
