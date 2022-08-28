module main

// import gg
import gx
import os
import ui

// constants values that do not change
const (
    awidth  = 800
    aheight = 800
    atitle  = "V Japanese Trainer"
    afpath  = os.resource_abs_path(os.join_path('assets', 'fonts', "SourceHanSerif-Regular.otf")) 
    abg_color  = gx.white
    abox_color = gx.light_gray
    atxt_color = gx.black
		font_size  = 16
    empty_string = "Hidden"
)

[heap]
struct App {
mut:
    window &ui.Window = unsafe { 0 }
    jp_text string
    en_text_cache string
    en_text string
    tb_width int = 9*awidth/10
}


fn main() {
    mut app := &App{jp_text: "こんにちは with English 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ。 今日はいいだ.", en_text: "Hello there"}

    println("Japanese Text is $app.jp_text and English Text is $app.en_text")
    println("The font path is $afpath")
    os.setenv("VUI_FONT", afpath, true)

    app.window = ui.window(
        width: aheight, height: aheight,
        title: atitle,
        on_init: app.on_init,
    )
    
    app.window.children << ui.column(
        widths: f64(app.tb_width),
        alignment: .center,
        spacing: 10
        children: [
        ui.textbox(
            id: "jp_text"
            height: aheight/8
            is_wordwrap: true
            is_multiline: true
            text: &app.jp_text
            is_sync: true
            read_only: true
            fitted_height: false
        ),
        ui.textbox(
            id: "en_text"
            height: aheight/8
            is_wordwrap: true
            is_multiline: true
            text: &app.en_text
            is_sync: true
            read_only: true
            fitted_height: false
        ),
        ui.row(
            spacing: 5
            children: [
            ui.button(
                id: "en_reveal_button"
                text: "英訳現す"
                on_click: app.en_reveal
                text_size: 1.0 / 20
                radius: .25
                hoverable: true
            ),
            ui.button(
                id: "next_button"
                text: "次ぎ"
                on_click: app.next_entry
                text_size: 1.0 / 20
                radius: .25
                hoverable: true
            ),
            ]
        )
        ]
    )
    
    ui.run(app.window)

    println("Finished Running!")
}

fn (mut app App) on_init(window &ui.Window) {
    app.en_hide()
}

fn (app &App) en_reveal (btn &ui.Button) {
    println("Revealed the English Text.")
    mut en_tb := app.window.textbox("en_text")
    en_tb.set_text(app.en_text_cache)
}

fn (mut app App) en_hide () {
    println("Hid the English Text.")
    mut en_tb := app.window.textbox("en_text")

    app.en_text_cache = app.en_text
    en_tb.set_text(empty_string)
}

fn (mut app App) next_entry(nt &ui.Button) {
    app.en_hide()
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
