Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794C353A81;
	Tue, 29 Sep 2026 06:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662940; cv=none; b=Bm6dJgX360IXW7BRxrIJBtJ6PqUr0jGh1rPVc7NJiUyHVouGxK6oaABO3l9dN1Vq+15OKIbgAdeLRt9gqnx7M8m2GVo9ubhrAjwMHW01yrC/XOQ1oKlCNpuHp057SV2Djeg+a0pGPskUeB9tfmsW/KK/OXGLszuhhrmec2CfuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662940; c=relaxed/simple;
	bh=YU67BmXIf/XgsBKN7z4o7Q7GBJoZDan2zs7UfFQGz3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=DnhCUs/Eo+UnZLKtDOZkOIOS+RRaKjxwT5O7AIdQK1RUzTU767gz60nJQZ9VPDomwERQnTEAVa5V7Ib7ukX9slOPgx6CxfGDoEta+lQ8kQNrCbGwTgp5HWu3+AlIV+b02N84yA6iOEmECjW5S8pfQX13Zeff70GFz44/vHGNBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.11] ) by
 ajax-webmail-APP-17 (Coremail) ; Tue, 29 Sep 2026 14:22:10 +0800
 (GMT+08:00)
Date: Tue, 29 Sep 2026 14:22:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: "Ira Weiny" <iweiny@kernel.org>, linux-cxl@vger.kernel.org, 
	"Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"Dave Jiang" <dave.jiang@intel.com>, 
	"Alison Schofield" <alison.schofield@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Dan Williams" <djbw@kernel.org>, "Li Ming" <ming.li@zohomail.com>, 
	"Richard Cheng" <icheng@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH RESEND] cxl/mbox: validate the DCD extent list
 counts against the payload
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <aq2qtqtPN97Kffvr@4470NRD-ASU.ssi.samsung.com>
References: <20260917104656.2658591-1-huanggaobin23@semi.ac.cn>
 <aq2qtqtPN97Kffvr@4470NRD-ASU.ssi.samsung.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2c3c870c.2a1df.1a0ebd3ee88.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowACnUhESWbtqDaMSAA--.50685W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwMFDGq7TSQcvgAFsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW3Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgQW5pc2EsCgpUaGFuayB5b3UgZm9yIHRoZSBwb2ludGVyLCBhbmQgc29ycnkgZm9yIHRoZSBz
bG93IHJlcGx5IC0tIEkgaGFkIG5vdCBmb3VuZAp5b3VyIHNlcmllcy4gIFNpbmNlIHlvdSBoYXZl
IHRoZSBmaXggaW4geW91ciB0cmVlLCBJIGFtIHdpdGhkcmF3aW5nIHRoaXMgcGF0Y2gKcmF0aGVy
IHRoYW4gY2FycnlpbmcgYSBzZWNvbmQgY29weSBvZiBpdCwgYW5kIEkgd2lsbCBub3QgcmVwb3N0
IGl0LgoKPiBTYXNoaWtvIHJlcG9ydGVkIHRoZSBzYW1lIGlzc3VlIG9uIHRoZSBwcmV2aW91cyBy
ZXZpc2lvbiAuLi4gYW5kIEkgaGF2ZQo+IGFscmVhZHkgcGF0Y2hlZCBpdCBpbiBteSB3b3JraW5n
IHRyZWUuCgpJZiBpdCBpcyB1c2VmdWwsIHdlIGhhdmUgYSByZXByb2R1Y3Rpb24gZnJvbSBhIFFF
TVUgVHlwZS0zIGRldmljZSB0aGF0IGxpZXMgaW4KdGhlIEdldCBEQyBFeHRlbnQgTGlzdCByZXNw
b25zZSwgd2l0aCB0aGUgYm91bmRhcnkgbWVhc3VyZWQgcmF0aGVyIHRoYW4KaW5mZXJyZWQuICBU
aGUgcmVzcG9uc2UgaGVhZGVyIGlzIDE2IGJ5dGVzIGFuZCBhbiBleHRlbnQgaXMgNDAsIHNvIGEg
MjA0OCBieXRlCm1haWxib3ggYnVmZmVyIGhvbGRzIDUwOiByZXR1cm5lZF9leHRlbnRfY291bnQg
PSA1MCBzdGF5cyBpbnNpZGUgaXQsIDUxIGlzIHRoZQpmaXJzdCB0aGF0IHJlYWRzIHBhc3QgdGhl
IGVuZCAoS0FTQU4gaW4gY3hsX3ZhbGlkYXRlX2V4dGVudCwgUmVhZCBvZiBzaXplIDIsCmV4dGVu
dC0+c2hhcmVkX2V4dG5fc2VxKSwgYW5kIDQwOTYgZmFpbHMgdGhlIHNhbWUgd2F5LiAgQSBkZXZp
Y2UgcmVwb3J0aW5nCnRvdGFsX2V4dGVudF9jb3VudCA9IDEwMDAwMCB3aXRoIHJldHVybmVkX2V4
dGVudF9jb3VudCA9IDAgaW5zdGVhZCBzcGlucyByZWdpb24KYnJpbmctdXAgdW50aWwgdGhlIGd1
ZXN0IHN0b3BzIGFuc3dlcmluZyBjb25zb2xlIGNvbW1hbmRzIC0tIHRoYXQgb25lIGlzIG5vdApj
b3ZlcmVkIGJ5IGEgY291bnQgY2hlY2ssIGJlY2F1c2UgemVybyBleHRlbnRzIGZpdCBhbnkgcGF5
bG9hZC4KCk91ciB2ZXJzaW9uIGVuZGVkIHVwIGRvaW5nIHdoYXQgSSB0aGluayB5b3VycyBkb2Vz
OiByZWplY3QgYSBjb3VudCB0aGF0IGRvZXMKbm90IGZpdCB0aGUgcGF5bG9hZCB3aXRoIC1FSU8s
IGFuZCBmYWlsIHdpdGggLUVJTyB3aGVuIGEgcmVzcG9uc2UgbWFrZXMgbm8KcHJvZ3Jlc3MuICBZ
b3VycyBzdXBlcnNlZGVzIGl0LiAgSGFwcHkgdG8gc2VuZCB0aGUgc3dlZXAgYXMgdGVzdCBjYXNl
cywgb3IgdG8KcnVuIGl0IGFnYWluc3QgeW91ciBzZXJpZXMgb25jZSBpdCBpcyBwb3N0ZWQuCgo+
IElmIHRoZSBvcmlnaW5hbCBzZW5kIGZhaWxlZCBhbmQgZGlkIG5vdCBtYWtlIGl0IHRvIHRoZSBt
YWlsaW5nIGxpc3QsIHRoZXJlJ3MKPiBubyBuZWVkIHRvIHByZWZpeCB0aGlzIHBhdGNoIHdpdGgg
UkVTRU5ELgoKTm90ZWQsIHRoYW5rIHlvdS4gIFRoZSBsaXN0IGRpZCByZWNlaXZlIHRoZSBmaXJz
dCBwb3N0aW5nOyB3aGF0IGJvdW5jZWQgd2FzIGEKbWFpbnRhaW5lciBhZGRyZXNzIGluIHRoZSBD
YyBsaXN0LCBzbyB0aGUgUkVTRU5EIHByZWZpeCB3YXMgbWlzbGVhZGluZy4gIFRoZXJlCmlzIG5v
dGhpbmcgdG8gcmUtcG9zdCBub3cgaW4gYW55IGNhc2UuCgo+IEkgcGxhbiB0byBwb3N0IHRoZSBu
ZXh0IHJldmlzaW9uIGFmdGVyIHRoZSBEQ0QgUHJlcCBTZXJpZXMgaXMgY29tcGxldGU6Cj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY3hsLzIwMjYwOTE4MjAzMDQ5LjcyNzMtMS1hbmlz
YS5zdUBzYW1zdW5nLmNvbS9ULyN0Cj4gWW91IGFyZSB3ZWxjb21lIHRvIHJldmlldyBib3RoLgoK
SSB3aWxsIGZvbGxvdyBib3RoLiAgSm9uYXRoYW4ncyBwb2ludCBlYXJsaWVyIGluIHRoaXMgdGhy
ZWFkIHdhcyByaWdodCBhcyB3ZWxsOgphIHNuaXBwZXQgaW4gdGhlIHNlcmllcyB0aHJlYWQgd291
bGQgaGF2ZSBiZWVuIGEgYmV0dGVyIHNoYXBlIHRoYW4gYSBzdGFuZGFsb25lCnBhdGNoLgoKT25l
IG1vcmUgdGhpbmcsIHNpbmNlIHdlIHdlcmUgdGVzdGluZyB0aGUgb2xkZXIgYGRjZC12Ni0yMDI1
LTA0LTEzYCBicmFuY2g6IGEKZGV2aWNlIHRoYXQgcmV0dXJucyBvbmUgcGFydGl0aW9uIGFuZCB0
aGVuIHplcm8gd2hpbGUgc3RpbGwgY2xhaW1pbmcgbW9yZQphdmFpbGFibGUgbWFrZXMgYGN4bF9k
ZXZfZGNfaWRlbnRpZnkoKWAgbG9vcCB3aXRob3V0IHByb2dyZXNzICg3LjQgbWlsbGlvbgpxdWVy
aWVzIG9uIG91ciBRRU1VIGRldmljZSwgYW5kIHRoZSBndWVzdCBuZXZlciByZWFjaGVzIGEgc2hl
bGwpLiAgdjExIGFscmVhZHkKZ3VhcmRzIHRoYXQgd2l0aCB0aGUgYHJjID09IDBgIGNoZWNrLCBz
byB0aGVyZSBpcyBub3RoaW5nIHRvIHJlcG9ydCAtLSBqdXN0CmNvbmZpcm1pbmcgdGhhdCB0aGUg
Y2FzZSB3ZSBjYW4gcmVwcm9kdWNlIGlzIGNvdmVyZWQsIGFuZCB0aGF0IHRoZSB6ZXJvLXByb2dy
ZXNzCnNoYXBlIGlzIHJlYWNoYWJsZSByYXRoZXIgdGhhbiB0aGVvcmV0aWNhbC4KCj4gLi4uIG1v
bnRobHkgbWVldGluZyBhdCAxMUFNIFBTVCBldmVyeSAzcmQgVHVlc2RheSBvZiB0aGUgbW9udGgu
ICBTbyB0aGUgbmV4dAo+IG9uZSBpcyBUdWVzZGF5IE9jdG9iZXIgMjAgMTFBTSBQU1QuICBJZiB5
b3Ugd291bGQgbGlrZSB0byBhdHRlbmQsIEkgY2FuCj4gZm9yd2FyZCB0aGUgaW52aXRlIHRvIHlv
dS4KClRoYW5rIHlvdSBmb3IgdGhlIG9mZmVyIC0tIEkgd2lsbCBwYXNzIG9uIHRoZSBpbnZpdGUg
Zm9yIG5vdywgYnV0IEkgd2lsbCBrZWVwCmZvbGxvd2luZyB0aGUgcHVibGlzaGVkIG5vdGVzICho
dHRwczovL3BtZW0uaW8vbmRjdGwvY29sbGFiLykuICBJZiBzb21ldGhpbmcgb24KdGhlIGNhbGwg
bmVlZHMgdGhlIGF1dGhvciBvZiB0aGlzIHNlcmllcywgSSBhbSBoYXBweSB0byBqb2luIGZvciB0
aGF0LgoKR2FvYmluCg==
