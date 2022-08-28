import loader

fn main() {
    mut myloader := loader.load_default_loader(shuffle: true)
    
    for _ in 0..10 {
        println(myloader.next()?)
    }
}
