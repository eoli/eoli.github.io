---
layout: post
---
本文探讨如何在Python中调用DLL。我们首先创建一个DLL，然后再用Python进行调用。

<br>
## 1.创建DLL

本次使用C写DLL库，开发环境为Dev-C++ 5.11。

<br>

### 新建DLL项目

在Dev-C++中新建项目,选择DLL,语言选择C项目。

之所以选择C语言，是因为C语言导出的函数名称不会被额外处理，而C++导出的函数名称会被加上一些符号。当然C++也是可以导出不被额外处理的函数名的，不过需要一点点配置。

![image-20200331140111314](/assets/image-20200331140111314.png)

现在点击确定就会生成项目，里面有dll.h和dllmain.c两个文件。

**dll.h**

这里定义了DLLIMPORT，以及导出函数原型。其实可以不用定义导出函数原型，只是以后没人知道怎么使用这些函数。

{%code%}
c
#ifndef _DLL_H_
#define _DLL_H_

#if BUILDING_DLL
#define DLLIMPORT __declspec(dllexport)
#else
#define DLLIMPORT __declspec(dllimport)
#endif

DLLIMPORT void HelloWorld();
DLLIMPORT int add(int, int);

#endif
{%endcode%}



**dllmain.c**

这份源码有三个部分，**HelloWorld**和**add**是我们导出的函数，供用户使用，**DllMain**由系统自动调用。注意，add是我自己添加的。

```c
/* Replace "dll.h" with the name of your header */
#include "dll.h"
#include <windows.h>

DLLIMPORT void HelloWorld()
{
	MessageBox(0,"Hello World from DLL!\n","Hi",MB_ICONINFORMATION);
}

DLLIMPORT int add(int a, int b)
{
	return a+b;
}


BOOL WINAPI DllMain(HINSTANCE hinstDLL,DWORD fdwReason,LPVOID lpvReserved)
{
	switch(fdwReason)
	{
		case DLL_PROCESS_ATTACH:
		{
			break;
		}
		case DLL_PROCESS_DETACH:
		{
			break;
		}
		case DLL_THREAD_ATTACH:
		{
			break;
		}
		case DLL_THREAD_DETACH:
		{
			break;
		}
	}
	
	/* Return TRUE on success, FALSE on failure */
	return TRUE;
}
```

<br>

### 编译

顶部菜单选择`运行/编译`后得到DLL， 我们需要的就是图中的mydll.dll。注意的是，我们编译出的DLL是64位的。

![image-20200331141047704](/assets/image-20200331141047704.png)

可以使用dll查看器打开mydll.dll文件看看我们导出的函数

<img src="/assets/image-20200331141354227.png" alt="image-20200331141354227" style="zoom: 67%;" />

<br>

## 2.在Python中使用DLL
我们使用Python提供的ctypes包完成这个任务。

将dll放到能被操作系统搜寻的目录里，然后启动64位的Python，因为我们的DLL是64位的。

<br>

### 导入DLL

```
> from ctypes import *
> c = CDLL("mydll.dll")
```

现在已经成功的导入了DLL到Python里。

<br>

### 使用DLL

- **使用HelloWorld函数**

```
> c.HelloWorld()
```

执行结果如下

![image-20200331141436496](/assets/image-20200331141436496.png)

- **使用add函数**

和使用HelloWorld不同的是，我们需要传入两个参数

```
> c.add(1, 2)
3
```

或者

```
> c.add(c_int(1), c_int(2))
3
```

c_int会将Python的数据类型转换到C的数据类型。在这个例子中，不使用c_int也是可以的。

除了c_int，ctypes中还有其它很多转换函数。关于ctypes的更多用法，你可以参考官方文档。

<br>

## 参考

- [ctypes - A foreign function library for Python](https://docs.python.org/3/library/ctypes.htm)
- [Python下使用ctypes调用DLL的方法简单总结](http://www.5bug.wang/post/74.html)
- [默认的 DLL 搜索路径优先级](https://mazhuang.org/2014/07/13/dllsearch/)

