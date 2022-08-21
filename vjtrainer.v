module main

import gg
import gx
import os

const (
    awidth  = 600
    aheight = 400
    atitle  = "V Japanese Trainer"
    afpath  = os.resource_abs_path(os.join_path('assets', 'fonts', 'Noto Sans Mono CJK JP Regular.otf')) 
    abg_color  = gx.white
    abox_color = gx.light_gray
    atxt_color = gx.black
		font_size  = 16
)

fn main() {

    mut context := gg.new_context(
        bg_color: abg_color
        width: awidth
        height: aheight
        window_title: atitle
        frame_fn: frame
        resizable: false
        font_path: afpath
        event_fn: on_event
    )
    context.run()
}

fn frame(mut ctx gg.Context) {
    ctx.begin()
    ws := gg.window_size()
    ww, wh := f32(ws.width), f32(ws.height)
    // ctx.draw_text(0, 0, "今日は This is some text!", color: gx.dark_green, bold: true, size: 32)
		draw_text_box(mut ctx, ww/10, wh/10, 8*ww/10, 4*wh/10, "今日は This is some text! サヨナラ")
    // ctx.draw_rect_filled(8/10*awidth, 1/10*aheight, 8/10*awidth, 4/10*aheight, gx.green)
    // ctx.draw_rect_filled(100, 100, 100, 100, gx.green)
    ctx.end()
}

fn draw_text_box(mut ctx gg.Context, x f32, y f32, w f32, h f32, text string) {
		// font_size := 16
    ctx.draw_rect_filled(x, y, w, h, abox_color)
    ctx.draw_text(int(x), int(y), text, color: atxt_color, size: font_size)
}

fn on_event(e &gg.Event, mut ctx gg.Context) {
    match e.typ {
        .resized {
            // println(gg.window_size())
        }
        else {}
    }
}
