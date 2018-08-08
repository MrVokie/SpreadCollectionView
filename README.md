# SpreadCollectionView

折叠展开/内容左右滑动的CollectionView【Objective-C Language】

>基于[原本](https://github.com/XZwalk/SpreadCollectionView)的改版CollectionView。迎合项目需求，增加了左右滑动选择的效果。

效果图：

![效果](https://github.com/MrVokie/SpreadCollectionView/blob/master/show.gif)

控件结构关系简介：

最外层的大分类是CollectionView，点击某项展开当前Section下的Footer，并将一个新的小分类CollectionView_New放在Footer上，在小分类Collection_New上放置tableview展示小分类的项目。