module main

// import gg
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
}

// fn main() {

//     mut context := gg.new_context(
//         bg_color: abg_color
//         width: awidth
//         height: aheight
//         window_title: atitle
//         frame_fn: frame
//         resizable: false
//         font_path: afpath
//         event_fn: on_event
//     )
//     context.run()
// }

// fn frame(mut ctx gg.Context) {
//     ctx.begin()
//     ws := gg.window_size()
//     ww, wh := f32(ws.width), f32(ws.height)

//     height_div := wh/16
// 		draw_text_box(mut ctx, ww/10, height_div,   8*ww/10, 3*height_div, "今日は This is some text! サヨナラ1")
// 		draw_text_box(mut ctx, ww/10, 5*height_div, 8*ww/10, 3*height_div, "今日は This is some text! サヨナラ2")
//     draw_text_box(mut ctx, ww/10, 9*height_div, 8*ww/10, 3*height_div, "今日は This is some text! サヨナラ3. This one is particularly long too!")
//     draw_audio_play_button(mut ctx, ww/10, 13*height_div, 2*height_div) 

//     ctx.end()
// }

// fn draw_text_box(mut ctx gg.Context, x f32, y f32, w f32, h f32, text string) {
// 		// font_size := 16
//     ctx.draw_rect_filled(x, y, w, h, abox_color)
//     ctx.draw_text(int(x), int(y), text + " " + ctx.text_width(text).str(), color: atxt_color, size: font_size)
// }

// fn draw_audio_play_button(mut ctx gg.Context, x f32, y f32, s f32) {
//     ctx.draw_square_filled(x, y, s, abox_color)
//     ctx.draw_triangle_filled(x + s/10, y + s/10, x + s*9/10, y + s/2, x + s/10, y + s*9/10, gx.red)
// }

// fn on_event(e &gg.Event, mut ctx gg.Context) {
//     match e.typ {
//         .resized {
//             // println(gg.window_size())
//         }
//         else {}
//     }
// }
