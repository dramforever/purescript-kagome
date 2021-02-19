function generateConversions(start) {
    const known = new Map();

    for (let ctor of start) {
        const names = [];
        while (ctor.name !== undefined && ctor.name !== "") {
            names.push(ctor.name);
            ctor = ctor.__proto__;
        }

        for (let i = 0; i < names.length - 1; i ++) {
            known.set(names[i], names[i + 1]);
        }
    }

    const text = [];

    // DO NOT reindent these template strings

    text.push('-- Generated code below --');

    for (const [sub, base] of known) {
        text.push(`instance instanceIs${sub} :: Is ${sub}.${sub} ${sub}.${sub} where
    toBase = identity
    fromBase = Just
else instance instanceIs${sub}${base} :: Is base ${base}.${base} => Is base ${sub}.${sub} where
    toBase = toBase <<< ${sub}.to${base}
    fromBase = ${sub}.from${base} <=< fromBase`);
    }

    for (const base of new Set(known.values())) {
        if (known.has(base)) continue;

        text.push(`instance instanceIs${base} :: Is ${base}.${base} ${base}.${base} where
    toBase = identity
    fromBase = Just`);
    }

    for (const base of new Set(known.values())) {
        text.push(`to${base} :: forall sub. Is ${base}.${base} sub => sub -> ${base}.${base}
to${base} = toBase`);

        text.push(`from${base} :: forall sub. Is ${base}.${base} sub => ${base}.${base} -> Maybe sub
from${base} = fromBase`)
    }

    return text;
}

console.log(generateConversions([Document, HTMLElement, Text, HTMLDocument, HTMLButtonElement, HTMLInputElement]).join('\n\n'));
