# Kumiki 規則

Kumiki を使って UI を書く・直すときに適用する。

## Modifier

Modifier は1つだけの場合も、呼び出しごとに改行する。
Modifier に渡す構造体・タプルに複数の要素がある場合は、要素ごとに改行する。

```zig
ui.column(.{
    ui.text("Hello world")
        .frame(.{
            .width = 200,
            .height = 50,
        })
        .bg(surface),
})
    .gap(12)
    .main(.start)
    .cross(.center);
```
