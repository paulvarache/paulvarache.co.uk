const { readFileSync, createWriteStream, existsSync, mkdirSync } = require('fs');
const { Readable } = require('stream');
const marked = require('marked');
const inliner = require('html-inline');
const htmlMinifyStream = require('html-minify-stream');

function createStreamFromString(contents) {
    const input = new Readable();
    input._read = () => {};
    input.push(contents);
    input.push(null);
    return input;
}

if (!existsSync('dist')) {
    mkdirSync('dist', 0744);
}

const src = readFileSync('index.html', 'utf-8');
const mdSrc = readFileSync('src.md', 'utf-8');

const generated = marked(mdSrc);
const final = src.replace('<div id="md-content"></div>', generated);

const inline = inliner({});

const output = createWriteStream('dist/index.html');
const input = createStreamFromString(final);
input.pipe(inline).pipe(htmlMinifyStream({
    collapseWhitespace: true,
    removeOptionalTags: true,
    minifyCSS: true,
})).pipe(output);
