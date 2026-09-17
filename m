Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23C44C8C67;
	Thu, 17 Sep 2026 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643391; cv=none; b=PfWRR/nnp63LwOcP8htdL60UnIvKBjj5b/tZIg/BAxLakgY7XKVe+dh6ExccsN98Ckw+fyVQ9nZjrhwBKpA5Nla72aE7lBKojI6HqBXcjSaMqb0wZkXj3dQIXlEXG//p4QL9SmSZC0fjAGxhwGykZOalI6syjHUwHGjyJyVIPDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643391; c=relaxed/simple;
	bh=327SPcYjWii4RRsEyQGkqdq0IrD5sfZ9eKq5B85W+iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=f7MY/AZrFfq1lk5L2OQfXF1esE3q2fUDQQ3RJG25cmGOUKgOcXo74ceWvRPKXjiUxOebiLqTUjKVfMZwJ9+4vGBvF2odkypnmiGKUD85dMLMyteBW8D3m/MTaE7CJyqA5XMO24RQePOt+akvxcdRWGi8Av2/mm6p8Yt38KhzPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.11] ) by
 ajax-webmail-APP-17 (Coremail) ; Thu, 17 Sep 2026 19:01:32 +0800
 (GMT+08:00)
Date: Thu, 17 Sep 2026 19:01:32 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, "Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, 
	"Dave Jiang" <dave.jiang@intel.com>, 
	"Alison Schofield" <alison.schofield@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Ira Weiny" <ira.weiny@intel.com>, 
	"Dan Williams" <dan.j.williams@intel.com>, 
	linux-kernel@vger.kernel.org, anisa.su887@gmail.com
Subject: Re: Re: [PATCH 1/2] cxl/mbox: clamp the event record count to the
 received payload
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <20260916013623.66609e47@jic23-hlaptop>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
 <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
 <20260916013623.66609e47@jic23-hlaptop>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <26753bf2.e6c7.1a0af07658e.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowABHMRCMyKtqdyIPAA--.51255W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiDAENDGqrrJpb+QAAsZ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gSWYgSSBmb2xsb3cgdGhlIGFib3ZlIGNvcnJlY3RseSB0aGlzIGhhcmRlbmluZyBhZ2FpbnN0
IGEgYnVnZ3kgZGV2aWNlPwo+IElmIHRoYXQncyB0aGUgY2FzZSBkcm9wIHRoZSBmaXhlcyB0YWcu
ICBJJ20gaGFwcHkgdG8gc2VlIHRoaXMgc29ydAo+IG9mIGNoYW5nZSBnbyBhcyBsb25nIGFzIHdl
IG1ha2UgaXQgY2xlYXIgd2hhdCBpdCBpcy4KCllvdSBoYXZlIGZvbGxvd2VkIGl0IGNvcnJlY3Rs
eTogdGhpcyBpcyBoYXJkZW5pbmcgYWdhaW5zdCBhIGRldmljZSB0aGF0IGRvZXMKbm90IGhvbm91
ciB0aGUgcHJvdG9jb2wsIG5vdCBhIGZpeCBmb3IgYSByZWdyZXNzaW9uLiAgQW4gaG9uZXN0IGRl
dmljZSBuZXZlcgpyZXBvcnRzIG1vcmUgcmVjb3JkcyB0aGFuIGl0IHJldHVybmVkLgoKSGF2aW5n
IGdvbmUgbG9va2luZywgSSBhbSBkcm9wcGluZyB0aGlzIHBhdGNoIHJhdGhlciB0aGFuIHBvc3Rp
bmcgaXQgYWdhaW4uCkFuaXNhIFN1IGZpeGVkIHRoZSBzYW1lIGJ1ZyBpbiB0aGUgc2FtZSBmdW5j
dGlvbiBvbiAyMDI2LTA4LTMxOgoKICBbUEFUQ0ggdjIgMi80XSBjeGwvZXZlbnRzOiBWYWxpZGF0
ZSB0aGUgcmVjb3JkIGNvdW50IHJlcG9ydGVkIGJ5IHRoZSBkZXZpY2UKICBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1jeGwvMjAyNjA5MDEwMDI5MTIuOTU4LTMtYW5pc2Euc3VAc2Ftc3Vu
Zy5jb20vCgpTYW1lIGV4cHJlc3Npb24gZm9yIHRoZSBib3VuZCAoc3RydWN0X3NpemUoKSBhZ2Fp
bnN0IG1ib3hfY21kLnNpemVfb3V0KSwgc2FtZQpGaXhlczogY29tbWl0ICg2ZWJlMjhmOWVjNzIp
LCBhbmQgaGVycyBpcyB0aGUgYmV0dGVyIG9mIHRoZSB0d286IGl0IGZhaWxzIHRoZQpjb21tYW5k
IGluc3RlYWQgb2YgY2xhbXBpbmcsIHdoaWNoIGFsc28gYm91bmRzIHRoZSBwZXItbG9nIGxvb3Au
ICBDbGFtcGluZwpsZWF2ZXMgbnJfcmVjIG5vbi16ZXJvLCBzbyBgfSB3aGlsZSAobnJfcmVjKTtg
IGtlZXBzIGlzc3VpbmcgR2V0IGFuZCBDbGVhcgpFdmVudCBSZWNvcmRzIHRvIGEgZGV2aWNlIHRo
YXQgbmV2ZXIgY2xlYXJzIHRoZW0gLS0gYSBoYW5nLCB3aGljaCBpcyB3b3JzZSB0aGFuCnRoZSBy
ZWFkIGJlaW5nIGZpeGVkLiAgSGVycyBhbHNvIGNvbWVzIHdpdGggYSBwYXNzIGJvdW5kIGZvciB0
aGF0IGxvb3AsIHdoaWNoCnRoaXMgb25lIGRpZCBub3QuICBTbyB0aGlzIGlzIGEgZHVwbGljYXRl
IGFuZCBJIHdpdGhkcmF3IGl0LgoKU29ycnkgZm9yIHRoZSBub2lzZS4KCj4gRmVlbHMgYSBiaXQg
bGlrZSB0aGVyZSBzaG91bGQgYmUgYSBmdW5jdGlvbiB0byByZXZlcnNlIHN0cnVjdF9zaXplKCkg
YnV0IHNhZGx5IG5vdC4KPiBXZSBkbyBoYXZlIHN0cnVjdF9vZmZzZXQoKSBob3dldmVyIHNvIGdp
dmVuIHdlIGFyZSB1c2luZyB0aGlzIGFjY2VzcyBpbnRvCj4gcGF5bG9hZHMsIEkgdGhpbmsgd2Ug
Y2FuIHdyaXRlIHRoaXMgYXM6Cj4KPiAJCW1heF9yZWMgPSAobWJveF9jbWQuc2l6ZV9vdXQgLSBz
dHJ1Y3Rfb2Zmc2V0KHBheWxvYWQsIHJlY29yZHMpIC8KPiAJCQkgICBzaXplb2YoKnBheWxvYWQt
PnJlY29yZHMpOwoKVGhhbmsgeW91IC0tIGl0IGlzIGFwcGxpZWQgdG8gdGhlIEdldCBTdXBwb3J0
ZWQgTG9ncyBwYXRjaCwgd2hpY2ggaXMgbm90IHBhcnQKb2YgaGVyIHNlcmllcyBhbmQgY29udGlu
dWVzIGFzCgogIFtQQVRDSCB2Ml0gY3hsL21ib3g6IGJvdW5kIHRoZSBHZXQgU3VwcG9ydGVkIExv
Z3MgZW50cnkgY291bnQgYnkgdGhlIHBheWxvYWQKICBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNjA5MTcxMDQ2MDMuMjY1ODUyOS0xLWh1YW5nZ2FvYmluMjNAc2VtaS5hYy5jbi8KCk9u
ZSByZWFkaW5nIG5vdGUgaW4gY2FzZSBpdCB3YXMgYSBza2V0Y2ggcmF0aGVyIHRoYW4gYSBwYXN0
ZTogYXMgd3JpdHRlbiB0aGUKcGFyZW50aGVzaXMgY2xvc2VzIGFmdGVyIHNpemVvZigqcGF5bG9h
ZC0+cmVjb3JkcyksIHNvIHRoZSBkaXZpc2lvbiB3b3VsZCBiaW5kCnRvIHN0cnVjdF9vZmZzZXQo
KSBhbG9uZSwgYW5kIHRoZSBwYXJlbiBvcGVuZWQgYmVmb3JlIG1ib3hfY21kLnNpemVfb3V0IGlz
Cm5ldmVyIGNsb3NlZC4gIEkgZ3JvdXBlZCB0aGUgc3VidHJhY3Rpb24uICBObyBuZXcgaW5jbHVk
ZSBpcyBuZWVkZWQ6CnN0cnVjdF9zaXplKCkgYSBmZXcgbGluZXMgYWJvdmUgY29tZXMgZnJvbSB0
aGUgc2FtZSBsaW51eC9vdmVyZmxvdy5oLgoKR2FvYmluCg==
