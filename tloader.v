import loader

fn main() {
    mut myloader := loader.load_default_loader(shuffle: true)
    println(myloader.next()?)
}
