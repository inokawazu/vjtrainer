module loader

import os
import encoding.csv
import rand

const (
	default_tsv = os.resource_abs_path(os.join_path('assets', 'jpen_examples.tsv'))
)

pub struct Entry {
pub:
	jp string
	en string
}

struct Loader<T> {
mut:
	current int
	data    []T [required]
}

[params]
pub struct NewLoaderConfigs {
	shuffle bool
}

pub fn load_default_loader(nlc NewLoaderConfigs) Loader<Entry> {
	data := load_from_tsv(loader.default_tsv)
	return new_loader(data, nlc)
}

pub fn new_loader<T>(data []T, nlc NewLoaderConfigs) Loader<T> {
	// ldata := if nlc.shuffle {data} else {rand.shuffle_clone(data)?}
	mut ldata := data.clone()
	if nlc.shuffle {
		rand.shuffle(mut ldata) or { panic(err) }
	}
	return Loader<T>{
		data: ldata
	}
}

pub fn (mut l Loader<T>) next() ?T {
	if l.current >= l.data.len {
		return error('Reached the last entry.')
	}
	l.current += 1
	return l.data[l.current - 1]
}

pub fn (mut l Loader<T>) prev() ?T {
	if l.current <= 0 {
		return error('Reached the first entry.')
	}
	l.current -= 1
	return l.data[l.current + 1]
}

fn load_from_tsv(filename string) []Entry {
	data := os.read_file(filename) or { panic(err) }
	mut reader := csv.new_reader(data, delimiter: `\t`)
	mut entries := []Entry{}

	for {
		row := reader.read() or { break }
		entries << Entry{row[0], row[1]}
	}
	return entries
}
