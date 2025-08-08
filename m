Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC54265CBB
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643458; cv=none; b=bcmNlNv++P60vPyNGQ2R+b8bGlWcUyukK3HAeXOgwvrVV9Gsr+xJdZqyFJHGcmKddSHql7c+dfvB8Jbhpz4HjpvKaRXcMjSnBkdH/GjL55pLNOKSb2c6K9a7m+FWqcIAVjcqjLHgOmoDMyDVS4JMmngnv5fxtB+Kk8sUd/IVaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643458; c=relaxed/simple;
	bh=UNrkFENYHmF5laM8eQwFryQtOrcUKMvNLp1YU7Jr64U=;
	h=Date:From:To:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=ox2LHEhj8fQR3HplXXJOAaOxQvtwOceiOMo1qnU/mvVN9kV0o7Db7g4CgAa1mgpeN2tQia5XRHLeGuCp+VzpNe16WUYmQaQGKYSDi8voQlhMGDnvdXN4KGML1fVgIr7F4xsU9/8euD1TmLhgJJECnY4dgJBafkNU5BmzCD3OvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBH3WD4u5VoC8n_BA--.52559S2;
	Fri, 08 Aug 2025 16:57:28 +0800 (CST)
Received: from wangyuquan1236$phytium.com.cn ( [218.76.62.144] ) by
 ajax-webmail-mail (Coremail) ; Fri, 8 Aug 2025 16:57:24 +0800 (GMT+08:00)
Date: Fri, 8 Aug 2025 16:57:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Yuquan Wang" <wangyuquan1236@phytium.com.cn>
To: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v13 1/5] hw/cxl-host: Add an index field to
 CXLFixedMemoryWindow
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250512(e7b47ee3) Copyright (c) 2002-2025 www.mailtech.cn
 mispb-8dfce572-2f24-404d-b59d-0dd2e304114c-icoremail.cn
In-Reply-To: <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-2-Jonathan.Cameron@huawei.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: M/wOdmZvb3Rlcl90eHQ9NjcyOjM4Mw==
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15325098.17ac.19888e633a1.Coremail.wangyuquan1236@phytium.com.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwAXoAf0u5VoGRcNAA--.3990W
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWiU-30DD
	AACsj
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF18ZFW5Xw45Gr4rJry3CFg_yoW8tw4xp3
	W8ta48Aw1UG3W7J3ySgw1xZryUG3yUGr47Jw1jy39FywsrJr1DXrnxKFZ7J3Wqga4jyr4D
	t3W3Z390qr1UtrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

U29ycnkgZm9yIGRpc3R1cmJpbmchIEkgdHJpZWQgdG8gdGVzdCBzZW5kIG1vcmUgdGhhbiAxMCBl
bWFpbHMgb24gbXkgc210cCBzZXJ2ZXLvvIEKCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDl
j5Hku7bkuro6IHdhbmd5dXF1YW4gPHdhbmd5dXF1YW4xMjM2QHBoeXRpdW0uY29tLmNuPgo+IOWP
kemAgeaXtumXtDoyMDI1LTA4LTA4IDE2OjI5OjU3ICjmmJ/mnJ/kupQpCj4g5pS25Lu25Lq6OiB0
YW5ndGFvMTYzNEBwaHl0aXVtLmNvbS5jbiwgcWVtdS1kZXZlbEBub25nbnUub3JnLCAiRmFuIE5p
IiA8ZmFuLm5pQHNhbXN1bmcuY29tPiwgIlBldGVyIE1heWRlbGwiIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+LCBtc3RAcmVkaGF0LmNvbQo+IOaKhOmAgTogIkpvbmF0aGFuIENhbWVyb24iIDxK
b25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+LCBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnLCBs
aW51eGFybUBodWF3ZWkuY29tLCBxZW11LWFybUBub25nbnUub3JnLCAiWXVxdWFuIFdhbmciIDx3
YW5neXVxdWFuMTIzNkBwaHl0aXVtLmNvbS5jbj4sICJJdGFydSBLaXRheWFtYSIgPGl0YXJ1Lmtp
dGF5YW1hQGxpbnV4LmRldj4sICJQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSIgPHBoaWxtZEBsaW5h
cm8ub3JnPgo+IOS4u+mimDogW1BBVENIIHYxMyAxLzVdIGh3L2N4bC1ob3N0OiBBZGQgYW4gaW5k
ZXggZmllbGQgdG8gQ1hMRml4ZWRNZW1vcnlXaW5kb3cKDQoNCuS/oeaBr+WuieWFqOWjsOaYju+8
muacrOmCruS7tuWMheWQq+S/oeaBr+W9kuWPkeS7tuS6uuaJgOWcqOe7hOe7h+aJgOaciSzlj5Hk
u7bkurrmiYDlnKjnu4Tnu4flr7nor6Xpgq7ku7bmi6XmnInmiYDmnInmnYPliKnjgILor7fmjqXm
lLbogIXms6jmhI/kv53lr4Ys5pyq57uP5Y+R5Lu25Lq65Lmm6Z2i6K645Y+vLOS4jeW+l+WQkeS7
u+S9leesrOS4ieaWuee7hOe7h+WSjOS4quS6uumAj+mcsuacrOmCruS7tuaJgOWQq+S/oeaBr+OA
gg0KSW5mb3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVk
IGluIHRoaXMgbWFpbCBpcyBzb2xlbHkgcHJvcGVydHkgb2YgdGhlIHNlbmRlcidzIG9yZ2FuaXph
dGlvbi5UaGlzIG1haWwgY29tbXVuaWNhdGlvbiBpcyBjb25maWRlbnRpYWwuUmVjaXBpZW50cyBu
YW1lZCBhYm92ZSBhcmUgb2JsaWdhdGVkIHRvIG1haW50YWluIHNlY3JlY3kgYW5kIGFyZSBub3Qg
cGVybWl0dGVkIHRvIGRpc2Nsb3NlIHRoZSBjb250ZW50cyBvZiB0aGlzIGNvbW11bmljYXRpb24g
dG8gb3RoZXJzLg==

