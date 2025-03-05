Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB920ADDC
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171382; cv=none; b=s4oft6wmfuduB97LCpG3D89OlDxGe+JB/2STErqdecRK/miOZKHu2OIQU0ivoEIZ8B/4UEe41tU/kGJ2SuwPJ5PGWhtaOoFd3KI5RLuznx+O0jlwdhWmBXx/M46PbLrf6/y1bul4z0ManWSJrP9VjE5pJ783B2nJ/ImaA960QjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171382; c=relaxed/simple;
	bh=xpLJvzbVj19xk6Ix4oz/UU2+vpsLmOzc8c3hL2NknDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DmAO39Y680477wy/H3CEqlkp9k2V0dP8aQVLgSdGeFf8KXfy/C2Hc5sCB246TcfIxsYyZx2ZoB00aoZ1xsYPN79tdO3gpKrfqcCmF7KqOGZo0TJ7tJAr9FaKjLYvkaFEdkHr9k/Pu86x6P2hADqWeQHGyqC3Uam7pLiyXZdi1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDn7Az_KMhn9bSNBg--.23228S2;
	Wed, 05 Mar 2025 18:35:43 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Wed, 5 Mar 2025 18:35:40 +0800 (GMT+08:00)
Date: Wed, 5 Mar 2025 18:35:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] docs/cxl: Add serial number for persistent-memdev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT6 build
 20240812(cfb32469) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <20250305141359.00001288@huawei.com>
References: <20250217112039.138650-1-wangyuquan1236@phytium.com.cn>
 <20250220161213.000049a9@huawei.com>
 <20250221065509-mutt-send-email-mst@kernel.org>
 <17b91a9f.2847.1955fd23d78.Coremail.wangyuquan1236@phytium.com.cn>
 <20250305141359.00001288@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: BXBrtmZvb3Rlcl90eHQ9MTczMTozODM=
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4752672.2b5f.19565e01b65.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwBna4f8KMhn3Oo6AA--.5354W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAAAWfHXBcGa
	wAAsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr4xAr4kGrW3AFy8JF1DWrg_yoWrtrW5p3
	W8Ja48Aw1UKa17G3yS9w18ZryUG3yUGr47Xw10y39FywnrJrn0qrnIgFZ7J3Wjgay5tr4D
	t3W7X390qr1UtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Cj4gCj4gT24gVHVlLCA0IE1hciAyMDI1IDE0OjIyOjQ4ICswODAwCj4gWXVxdWFuIFdhbmcgPHdh
bmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPiB3cm90ZToKPiAKPiA+ID4gCj4gPiA+IE9uIFRo
dSwgRmViIDIwLCAyMDI1IGF0IDA0OjEyOjEzUE0gKzAwMDAsIEpvbmF0aGFuIENhbWVyb24gd3Jv
dGU6ICAKPiA+ID4gPiBPbiBNb24sIDE3IEZlYiAyMDI1IDE5OjIwOjM5ICswODAwCj4gPiA+ID4g
WXVxdWFuIFdhbmcgPHdhbmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPiB3cm90ZToKPiA+ID4g
PiAgIAo+ID4gPiA+ID4gQWRkIHNlcmlhbCBudW1iZXIgcGFyYW1ldGVyIGluIHRoZSBjeGwgcGVy
c2lzdGVudCBleGFtcGxlcy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVx
dWFuIFdhbmcgPHdhbmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPiAgCj4gPiA+ID4gTG9va3Mg
Z29vZC4gIEkndmUgcXVldWVkIGl0IHVwIG9uIG15IGdpdGxhYiBzdGFnaW5nIHRyZWUsIGJ1dAo+
ID4gPiA+IE1pY2hhZWwgaWYgeW91IHdhbnQgdG8gcGljayB0aGlzIG9uZSBkaXJlY3RseSB0aGF0
J3MgZmluZSBhcyB3ZWxsLiAgCj4gPiA+IAo+ID4gPiBTZWUgbm8gcmVhc29uIHRvLCBJIHdhcyBu
b3QgZXZlbiBDQydkLiAgCj4gPiAKPiA+IEhpLCBNaWNoYWVsCj4gPiAKPiA+IEknbSBzb3JyeSwg
dGhpcyBpcyBteSBmYXVsdC4gSSB1c2VkICJnZXRfbWFpbnRhaW5lci5wbCIgdG8gY2hlY2sgdGhp
cwo+ID4gcGF0Y2gncyBtYWludGFpbmVycyBidXQgaXQgc2hvd3MgIk5vIG1haW50YWluZXJzIGZv
dW5kLCBwcmludGluZyByZWNlbnQKPiA+IGNvbnRyaWJ1dG9ycyIuIAo+ID4gCj4gSSB1c3VhbGx5
IHN0YWdlIHVwIG11bHRpcGxlIHNlcmllcyB0b2dldGhlciBhbmQgc2VuZCBvbiB0byBNaWNoYWVs
Lgo+IFNvIGl0IHdhcyBiZSBiZWluZyBsYXp5IGZvciBhIG1pbm9yIGNoYW5nZSByYXRoZXIgdGhh
biBhbnl0aGluZyBtdWNoCj4gdGhhdCB5b3UgZGlkIHdyb25nLgo+IAo+IElmIEkgZ2V0IHRpbWUg
SSdsbCBwb3N0IGEgc2VyaWVzIHdpdGggdGhpcyBhIGZldyBvdGhlciBwYXRjaGVzCj4gbGF0ZXIg
dG9kYXkuICAKPiAKPiBKb25hdGhhbgo+IApUaGFuayB5b3UhCgpCVFcsIEkgZm91bmQgYSBjb3Ju
ZXIgY2FzZSBpbiBDWEwgbnVtYSBub2RlIGNyZWF0aW9uLgoKQ29uZGl0aW9uOiAKMSkgQSBVTUEv
TlVNQSBzeXN0ZW0gd2l0aG91dCBTUkFULCBidXQgd2l0aCBDRURULkNGTVdTCjLvvIlFbmFibGUg
Q09ORklHX0FDUElfTlVNQQoKUmVzdWx0czoKMSkgYWNwaV9udW1hX2luaXQ6IHRoZSBmYWtlX3B4
bSB3aWxsIGJlIDAgYW5kIHNlbmQgdG8gYWNwaV9wYXJzZV9jZm13cygpCjLvvIlJZiBkeW5hbWlj
YWxseSBjcmVhdGUgY3hsIHJhbSByZWdpb24sIHRoZSBjeGwgbWVtb3J5IHdvdWxkIGJlIGFzc2ln
bmVkCnRvIG5vZGUwIHJhdGhlciB0aGFuIGEgbmV3IG5vZGUKCkNvbmZ1c2lvbnM6CjEpIElzIGEg
bnVtYSBzeXN0ZW0gYSByZXF1aXJlbWVudCBmb3IgQ1hMIG1lbW9yeSB1c2FnZT8KMikgU2hvdWxk
IHdlIGZvcmJpZCB0aGlzIHNpdHVhdGlvbiBieSBhZGRpbmcgZmFrZV9weG0gY2hlY2sgYW5kIHJl
dHVybmluZwplcnJvciBpbiBhY3BpX251bWFfaW5pdCgpPyAKM++8iU9yIHdlIGNhbiBhZGQgc29t
ZSBrZXJuZWwgY29kZSB0byBhbGxvdyBjcmVhdGUgdGhlc2UgZmFrZSBub2RlcyBvbiBhCnN5c3Rl
bSB3aXRob3V0IFNSQVQ/CgpZdXF1YW4KCgoKDQoNCuS/oeaBr+WuieWFqOWjsOaYju+8muacrOmC
ruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6uuaJgOWcqOe7hOe7h+aJgOaciSzlj5Hku7bkurrm
iYDlnKjnu4Tnu4flr7nor6Xpgq7ku7bmi6XmnInmiYDmnInmnYPliKnjgILor7fmjqXmlLbogIXm
s6jmhI/kv53lr4Ys5pyq57uP5Y+R5Lu25Lq65Lmm6Z2i6K645Y+vLOS4jeW+l+WQkeS7u+S9lees
rOS4ieaWuee7hOe7h+WSjOS4quS6uumAj+mcsuacrOmCruS7tuaJgOWQq+S/oeaBr+OAgg0KSW5m
b3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRo
aXMgbWFpbCBpcyBzb2xlbHkgcHJvcGVydHkgb2YgdGhlIHNlbmRlcidzIG9yZ2FuaXphdGlvbi5U
aGlzIG1haWwgY29tbXVuaWNhdGlvbiBpcyBjb25maWRlbnRpYWwuUmVjaXBpZW50cyBuYW1lZCBh
Ym92ZSBhcmUgb2JsaWdhdGVkIHRvIG1haW50YWluIHNlY3JlY3kgYW5kIGFyZSBub3QgcGVybWl0
dGVkIHRvIGRpc2Nsb3NlIHRoZSBjb250ZW50cyBvZiB0aGlzIGNvbW11bmljYXRpb24gdG8gb3Ro
ZXJzLg==

