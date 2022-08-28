import loader

fn main() {
    // loader.hello()
    mut myloader := loader.load_default_loader(shuffle: true)
    println(myloader.next()?)
}
