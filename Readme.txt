用 TEdgeBrowser 做一个富文本编辑器。

Delphi 10.4 社区版测试通过。

Rich text editor by using TEdgeBrowser and JavaScript.

以前我做的基于 TWebBrowser 的富文本编辑器，是基于 MS 的接口调用操作 DOM 来实现的。

现在的 Edge 或者其它浏览器，没有接口。只能通过 JavaScript 来操作。

参考：
https://developer.mozilla.org/zh-CN/docs/Web/API/Document/execCommand
---------------------

采用 JavaScript 语句里面的 document.execCommand() 函数，可以修改选中的字符串，无需去判断那些字符串是被选中的。

如果要内嵌代码段，从显示的角度来说，可能需要加入一些 CSS；如果 CSS 不多，可以直接写入初始化的页面里面，加载初始化页面。指定 CSS 就可以了。
引入 https://highlightjs.org/  这里下载的语法高亮 CSS 和 JS，可以实现代码块。进一步的测试需要注意，插入代码块时，最好在代码块底下插入多一行，否则无法继续在底下写非代码块的内容。

--------------------------

关于使用到的 JS 和 CSS：

1. 因为要用到一些外部的 JS 和 CSS，因此，这里使用了一个 Index.html，预先写好了 HTML 框架代码，包括对 JS 和 CSS 的引用。
2. 如果对 JS 和 CSS 的引用，采用本地文件的相对路径，编辑后的内容，如果保存为一个 HTML 文件，然后用浏览器打开这个 HTML 文件，可能看不到正确的格式。原因是这个 HTML 文件里面引用的一些 JS 和 CSS 是以本地文件的相对路径的方式引用的。把这个 HTML 文件所在的文件夹里面如果有对应的 JS 和 CSS，用浏览器打开就能看到正确的格式。
3. 最终，为了保证任何内容加载后都能够正确显示，对 JS 和 CSS 的引用，采用了对本地网络访问的绝对路径，同时本程序内置了一个 Web Server 用来处理对 JS 和 CSS 文件的请求（采用 WebBroker 框架）。这样即便你的电脑不能上网，也能正确编辑和浏览编辑内容。
4. 当然，你也可以把 JS 和 CSS 放到一个公开的 WEB SERVER 上面，修改 index.html 里面对 JS 和 CSS 的引用部分。

-----------------------------
界面按钮采用了 JEDI 的 JVCL，参考：https://wiki.delphi-jedi.org/wiki/Main_Page