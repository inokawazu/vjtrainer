module main

import gg
import gx

const (
    awidth  = 600
    aheight = 400
    atitle  = "V Japanese Trainer"
)

fn main() {
    mut context := gg.new_context(
        bg_color: gx.white
        width: awidth
        height: aheight
        window_title: atitle
        frame_fn: frame
        resizable: false
    )
    context.run()
}

fn frame(mut ctx gg.Context) {
    ctx.begin()
    ctx.end()
}
