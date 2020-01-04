# 基于的Weil Pairing而来的IBE


## 1 介绍

介绍了几个基于身份的加密应用来体现IBE的作用。



## 2 定义

详细说明IBE的定义，证明IBE的CCA安全，定义了几种情况下的IBE语义安全



## 3 双线性映射和双线性DH假设

- 双线性映射下的IBE中CDH是困难的，但DDH可以解决

- 当BDH参数生成器满足BDH假设时，BDH是安全的。

## 4. IBE 方案

本节介绍使用满足BDH假设的任意BDH参数生成器G。

### 4.1 BasicIdent

通过一种基本的IBE加密方案BasicIdent，来解释IBE系统的基本思想。证明IBE的语义安全。

### 4.2 IBE的CCA 安全性

使用Fujisaki-Okamoto的技术将前一节的BasicIdent方案转换为随机预言机模型中选择密文安全IBE系统。

该系统是IND-ID-CCA 安全，称该系统为FullIdent.



Apply technique introduced by Fujisaki-Okamoto to convert BasicIdent scheme 

Fujisaki-Okamoto introduced one transformation method that can convert BasicIdent scheme into a chosen ciphertext secure IBE system in the random oracle model.  

#### 安全性

通过定理4.4来证明，定理4.4基于定理4.5与引理4.6证明



### 4.3 放宽哈希的限制

4.2中使用了哈希函数$H1:\{0,1\}^*\rightarrow\mathbb{G}^*_1$ ，实践应用中，难以对这些群创建这种哈希关系。因此在本节展示如何放宽哈希限制。这是通过哈希到集合$A\subseteq\{0,1\}^*$取代直接哈希到$\mathbb{G}^*_1$上，用一个确定性编码函数从$A$映射到$\mathbb{G}^*_1$。



## 5. 一个具体的IBE系统

用FillIdent来描述一个具体的基于Weil pairing的IBE系统

###5.1 Wail pairing 的性质

- Bilinear 双线性
- Non-degenerate 非退化性
- Computable 可计算性

### 5.2 可用的编码函数 MapToPoint

该函数函数从$A$映射到$\mathbb{G}^*_1$。

#### 具体算法

#### 引理 



### 5.3 一个具体的IBE系统

Using FullIdent’ from Section 4.3 with the BDH parameter generator G1and the admissible encoding function MapToPoint we obtain a concrete IBE system 它是一个CCA sec.的系统

并介绍了性能



##  6. 一些扩展和观察

- **Tate pairing and other curves**
- **Asymmetric pairings**
- **Distributed PKG**
- **Working in subgroups**
- **IBE implies signatures**

## 7. 履约保证EIgamal 加密

Weil pairing 可以为EIgamal加密系统添加一个全局履约保证能力



## 8. 总结

为基于身份的系统定义了选择的密文安全性，并提出了一个功能全面的IBE系统。 该系统在假定BDH（CDH问题的自然模拟）的随机预言模型中选择了密文安全性。 