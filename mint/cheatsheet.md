# vim cheet sheet

## denite 操作 
| コマンド | 説明                                                 |
|----------|------------------------------------------------------|
| sl       | 現在開いているファイルのディレクトリのファイル一覧   |
| sd       | 開いているディレクトリのファイル一覧                 |
| sb       | バッファ一覧                                         |
| ss       | カレントディレクトリのファイルの中身を検索           |
| sf       | 現在開いているファイルのディレクトリ以下の中身を検索 |
| sr       | レジスタ一覧                                         |
| sm       | 最近使用したファイル一覧                             |
| s/       | ファイル内検索                                       |
| s*       | カーソルのある単語を全て検索                         |


## タブ操作 
| コマンド | 説明               |
|----------|--------------------|
| gt       | 次のダブに切り替え |
| gT       | 前のダブに切り替え |


## NREDTree
### ファイル操作系
| コマンド | 説明             |
|----------|------------------|
| o(Enter) | ファイルを開く   |
| t        | タブを開く       |
| i        | 水平分割して開く |
| s        | 垂直分割して開く |


### ディレクトリ操作系

| コマンド | 説明                           |
|----------|--------------------------------|
| O        | 再帰的にディレクトを開く       |
| X        | 再帰的に子ディレクトリを閉じる |
| I        | 隠しファイルを表示             |

### ファイルシステム系

| コマンド | 説明                                       |
|----------|--------------------------------------------|
| C        | ツリーのルートを選択したディレクトリに変更 |
| u        | ツリーのルートを上の階層にする             |
| r        | 選択したディレクトリをリフレッシュ         |

## Table mode
   <leader> = \\
 - <leader> tm  
   Table Modeになる
 - <leader> tt  
   csv形式で書いていたものを表にする 

