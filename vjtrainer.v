module main

import os
import ui
import loader

// constants values that do not change
const (
    awidth  = 800
    aheight = 800
    atitle  = "V Japanese Trainer"
    afpath  = os.resource_abs_path(os.join_path('assets', 'fonts', "SourceHanSerif-Regular.otf")) 
    // abg_color  = gx.white
    // abox_color = gx.light_gray
    // atxt_color = gx.black
		font_size  = 32
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
    loader loader.Loader<loader.Entry> = loader.load_default_loader(shuffle: true)
}


fn main() {

    mut app := &App{}

    println("Japanese Text is $app.jp_text and English Text is $app.en_text")
    println("The font path is $afpath")
    os.setenv("VUI_FONT", afpath, true)

    app.window = ui.window(
        width: awidth, height: aheight,
        title: atitle,
        on_init: app.on_init,
        on_key_down: app.on_key_down
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
            text_size: font_size
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
            text_size: font_size
        ),
        ui.row(
            spacing: 5
            children: [
            ui.button(
                id: "en_reveal_button"
                text: "英訳現す"
                on_click: app.en_reveal_btn
                text_size: 1.0 / 20
                radius: .25
                hoverable: true
            ),
            ui.button(
                id: "next_button"
                text: "次ぎ"
                on_click: app.next_entry_btn
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
    // app.en_hide()
    app.next_entry()
}

fn (app &App) en_reveal_btn (btn &ui.Button) {
    app.en_reveal()
}

fn (app &App) en_reveal () {
    mut en_tb := app.window.textbox("en_text")
    if en_tb.text != empty_string { return }

    println("Revealed the English Text.")
    en_tb.set_text(app.en_text_cache)
}

fn (mut app App) en_hide () {
    mut en_tb := app.window.textbox("en_text")

    if en_tb.text == empty_string { return }

    println("Hid the English Text.")

    app.en_text_cache = app.en_text
    en_tb.set_text(empty_string)
}

fn (mut app App) next_entry_btn(nt &ui.Button) { app.next_entry() }

fn (mut app App) next_entry() {
    entry := app.loader.next() or {
        println(err)
        return 
    }
    // println(entry)

    mut jp_tb := app.window.textbox("jp_text")
    jp_tb.set_text(entry.jp)
    
    app.en_hide()
    app.en_text_cache = entry.en
}

fn (mut app App) prev_entry() {
    entry := app.loader.prev() or {
        println(err)
        return 
    }
    // println(entry)

    mut jp_tb := app.window.textbox("jp_text")
    jp_tb.set_text(entry.jp)
    
    app.en_hide()
    app.en_text_cache = entry.en
}

fn (mut app App) on_key_down(window &ui.Window, e ui.KeyEvent) {
    if e.action == 0 {
        match e.key {
            .right {app.next_entry()}
            .left {app.prev_entry()}
            .up {app.en_reveal()}
            .down {app.en_hide()}
            else {}
        }
    }
}
