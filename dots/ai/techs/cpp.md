# C++ 規則

C++ を書く・直すときに適用する。

## ファイルの拡張子

ヘッダファイルには `.hh` を、ソースファイルには `.cc` を使う。

## インクルードガード

名前は `_<プロジェクト名>_<パスを大文字スネークケースにしたもの>_HH` にする。
`#endif` にコメントは付けない。

```cpp
#ifndef _PROJECT_CORE_ENGINE_HH
#define _PROJECT_CORE_ENGINE_HH

#endif
```

## include の順序

上から「POSIX」「C++ 標準」「サードパーティ」「自プロジェクト」の順に並べる。
グループ間は1行空ける。
サードパーティはライブラリごとにも1行空ける。

```cpp
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>

#include <algorithm>
#include <filesystem>

#include <SDL3/SDL.h>

#include <glm/glm.hpp>

#include "core/engine.hh"
#include "app/app.hh"
```

## 命名規則

標準ライブラリと同じく snake_case にする。
`private` メンバ変数だけ先頭に `_` を付ける（`_x`, `_score`）。

## コードブロックの書き方

波括弧は開始行の末尾、閉じ括弧は開始行の桁に合わせる K&R スタイルにする。
関数・クラス・namespace・if・for・while・switch すべて同じ書き方にする。

## namespace

中身は他のブロックと同じく1段インデントする。
閉じ括弧に `// namespace test` のようなコメントは付けない。
