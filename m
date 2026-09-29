Received: from cstnet.cn (smtp87.cstnet.cn [159.226.251.87])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA2345CDA;
	Tue, 29 Sep 2026 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662542; cv=none; b=mcUC9R8ulZN+3jZI08u+9wXFs9RvMP/YWY40LcUWZ0ynULqjcW0uciQWNF62ZqkgAhqqE74bprcU+jlmbewPIL30ZgMRNtd687K/kLQhBSPlPz4Cs1vGpbR7kbIPWkJr1XlFSRzgti1jxgLVMCyDyfjWv2T2JRPPUxkMgg3/UUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662542; c=relaxed/simple;
	bh=Z2+H9o/My65At5c+ZTlwoYFtlygGFbGf6bDMNB9Nw+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NRXSAJzbT0IrCBHnHqd5A+F4pb1RsIkzNcC1qODEXcGrzxR/2H4oaBuI7V3B4DX1kPQPsiujZTYAguPoMQoHvU7l/1mFUpVel9WS/fmmsibTRutg0J5zRGeB4oph+4+sKhKra0SJuXx6hK8rf4sjJyPPVBHpHgGZ4nYmPF942F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.11] ) by
 ajax-webmail-APP-17 (Coremail) ; Tue, 29 Sep 2026 14:15:31 +0800
 (GMT+08:00)
Date: Tue, 29 Sep 2026 14:15:31 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, "Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"Dave Jiang" <dave.jiang@intel.com>, 
	"Alison Schofield" <alison.schofield@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Dan Williams" <djbw@kernel.org>, "Li Ming" <ming.li@zohomail.com>, 
	linux-kernel@vger.kernel.org, "Anisa Su" <anisa.su887@gmail.com>
Subject: Re: Re: [PATCH v2] cxl/mbox: bound the Get Supported Logs entry
 count by the payload
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <arDU-kTVCa4z8C8l@MWDK4CY14F>
References: <20260917104603.2658529-1-huanggaobin23@semi.ac.cn>
 <arDU-kTVCa4z8C8l@MWDK4CY14F>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7fe55f2c.2a158.1a0ebcdda1a.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:qgCowAA3IhGDV7tqW6ISAA--.28423W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwMFDGq7TSQcvgADsU
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWDJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgUmljaGFyZCwKClRoYW5rIHlvdSwgYW5kIHNvcnJ5IGZvciB0aGUgc2xvdyB0dXJuLWFyb3Vu
ZCAtLSBib3RoIHN1Z2dlc3Rpb25zIGFyZSBpbiB2MywKYW5kIHRoZSBzcGVjIHBvaW50ZXIgc2V0
dGxlcyB0aGUgY2xhbXBpbmctdmVyc3VzLXJlamVjdGluZyBxdWVzdGlvbiByYXRoZXIKdGhhbiBq
dXN0IG1ha2luZyByZWplY3Rpbmcgc2FmZXIuCgo+IEkgd291bGQgc3VnZ2VzdCB0byBrZWVwIHRo
ZSBzaWduYXR1cmUgYW5kIGRvIHRoZSBjaGVjayBoZXJlIGluc3RlYWQuCj4gY3hsX2dldF9nc2wo
KSBpc3N1ZXMgdGhlIGNvbW1hbmQsIG93bnMgdGhlIGJ1ZmZlciBhbmQgYWxyZWFkeSBoYXMgdGhl
Cj4ga3ZmcmVlKCkvRVJSX1BUUiBlcnJvciBwYXRoLiBUaGVuIHRoZSBjYWxsZXIgZG9lc24ndCBu
ZWVkIHRvIGtub3cgdGhlIGhlYWRlcgo+IHNpemUgb3IgdGhlIGVudHJ5IHNpemUsIGFuZCBnc2wt
PmVudHJpZXMgY2FuIGJlIHRydXN0ZWQgYnkgd2hvZXZlciB1c2VzIHRoZQo+IHN0cnVjdC4KCkFn
cmVlZCwgYW5kIHRoYXQgaXMgd2hlcmUgdjMgcHV0cyBpdC4gIGN4bF9lbnVtZXJhdGVfY21kcygp
IGlzIG5vdyB1bmNoYW5nZWQKZnJvbSBtYWlubGluZToKCgltYm94X2NtZCA9IChzdHJ1Y3QgY3hs
X21ib3hfY21kKSB7CgkJLm9wY29kZSA9IENYTF9NQk9YX09QX0dFVF9TVVBQT1JURURfTE9HUywK
CQkuc2l6ZV9vdXQgPSBjeGxfbWJveC0+cGF5bG9hZF9zaXplLAoJCS5wYXlsb2FkX291dCA9IHJl
dCwKCQkvKiBBdCBsZWFzdCB0aGUgaGVhZGVyIG11c3QgYmUgdmFsaWQgKi8KCQkubWluX291dCA9
IHN0cnVjdF9zaXplKHJldCwgZW50cnksIDApLAoJfTsKCXJjID0gY3hsX2ludGVybmFsX3NlbmRf
Y21kKGN4bF9tYm94LCAmbWJveF9jbWQpOwoJaWYgKHJjIDwgMCkgewoJCWt2ZnJlZShyZXQpOwoJ
CXJldHVybiBFUlJfUFRSKHJjKTsKCX0KCgltYXhfZW50cmllcyA9IChtYm94X2NtZC5zaXplX291
dCAtIHN0cnVjdF9zaXplKHJldCwgZW50cnksIDApKSAvCgkJICAgICAgc2l6ZW9mKHJldC0+ZW50
cnlbMF0pOwoJaWYgKGxlMTZfdG9fY3B1KHJldC0+ZW50cmllcykgPiBtYXhfZW50cmllcykgewoJ
CWRldl9lcnIobWRzLT5jeGxkcy5kZXYsCgkJCSJHU0w6IGRldmljZSBjbGFpbWVkICV1IGVudHJp
ZXMgYnV0IHRoZSBwYXlsb2FkIGhvbGRzICV6dVxuIiwKCQkJbGUxNl90b19jcHUocmV0LT5lbnRy
aWVzKSwgbWF4X2VudHJpZXMpOwoJCWt2ZnJlZShyZXQpOwoJCXJldHVybiBFUlJfUFRSKC1FSU8p
OwoJfQoKPiAubWluX291dCA9IDIgaXMgdGhlIG9ubHkgbWluX291dCBpbiB0aGUgdHJlZSB0aGF0
J3Mgbm90IGEgZnVsbCBoZWFkZXIuCj4gUmFpc2luZyBpdCB0byBzdHJ1Y3Rfc2l6ZShyZXQsIGVu
dHJ5LCAwKSBsZXRzIGN4bF9pbnRlcm5hbF9zZW5kX2NtZCgpIHJlamVjdAo+IHRoZSBzaG9ydCBy
ZXNwb25zZSB3aXRoIC1FSU8sIHNvIHRoZSAidG9vIHNob3J0IGZvciB0aGUgaGVhZGVyIiBwYXJ0
IGNhbgo+IGdvIGF3YXkuCgpUYWtlbi4gIFRoZSBzdWJ0cmFjdGlvbiBjYW5ub3QgdW5kZXJmbG93
IG9uY2UgbWluX291dCBndWFyYW50ZWVzIHRoZSBoZWFkZXIsCnNvIHRoZSBndWFyZCBhcm91bmQg
aXQgaXMgZ29uZSB0b28sIGFuZCBpdCBtYXRjaGVzIHRoZSB0d28gdXNlcnMgYWxyZWFkeSBpbgp0
aGlzIGZpbGUgKHN0cnVjdF9zaXplKHBheWxvYWQsIHJlY29yZHMsIDApIGFuZCBzdHJ1Y3Rfc2l6
ZShwbywgcmVjb3JkLCAwKSkuCgo+IFRoZSBvbmx5IGt2ZnJlZSgpIGlzIGF0ICJvdXQiIHNlY3Rp
b24sIGRpcmVjdGx5IHJldHVybiBoZXJlIHdvdWxkIGxlYWsKPiBnc2wuCgpUaGF0IHdhcyBtaW5l
LCBpbiB2Mi4gIE1vdmluZyB0aGUgY2hlY2sgaW50byBjeGxfZ2V0X2dzbCgpIHJlbW92ZXMgdGhl
IHBhdGgKaW5zdGVhZCBvZiByZXBhaXJpbmcgaXQuICBzYXNoaWtvIHJlcG9ydGVkIHRoZSBzYW1l
IGxlYWsgb24gdjIuCgo+IEFncmVlIHdpdGggQWxpc29uIGFuZCBKb25hdGhhbiwgZG9uJ3QgY2xh
bXAgaGVyZS4KPiBDWEwgcjQuMCBTZWN0aW9uIDguMi4xMC41LjEgR2V0IFN1cHBvcnRlZCBMb2dz
LCBUYWJsZSA4LTI0OSAuLi4gZGVmaW5lcwo+ICJOdW1iZXIgb2YgU3VwcG9ydGVkIExvZ3MgRW50
cmllcyIgYXMgInRoZSBudW1iZXIgb2YgU3VwcG9ydGVkIExvZyBFbnRyaWVzCj4gcmV0dXJuZWQg
aW4gdGhlIG91dHB1dCBwYXlsb2FkIi4KPiBJdCdzIG5vdCB0b3RhbCwgc28gYSBjb3VudGVyIGxh
cmdlciB0aGFuIHdoYXQgYXJyaXZlZCBpcyBhIG1hbGZvcm1lZAo+IHJlc3BvbnNlLCBub3QgYSBw
YXJ0aWFsIGxpc3QuCgpUaGFuayB5b3UgZm9yIHRoZSBjaXRhdGlvbi4gIEl0IGlzIGluIHRoZSBj
b21taXQgbWVzc2FnZSBub3csIGJlY2F1c2UgaXQgaXMKd2hhdCBtYWtlcyByZWplY3RpbmcgdGhl
IHJpZ2h0IGFuc3dlciByYXRoZXIgdGhhbiBtZXJlbHkgdGhlIHNhZmVyIG9uZS4KCj4gQWJvdXQg
LUVJTyB2LnMuIC1FTlhJTywgSSB3b3VsZCBnbyB3aXRoIC1FSU8uCgotRUlPIGl0IGlzLCBhbmQg
aXQgaXMgbm93IGxpdGVyYWxseSBjeGxfaW50ZXJuYWxfc2VuZF9jbWQoKSdzIHBheWxvYWQgc2l6
ZQptaXNtYXRjaCBlcnJvciByYXRoZXIgdGhhbiBhIGNob2ljZSBtYWRlIGhlcmUuCgp2MzoKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwOTI5MDYwNjEwLjM1NDk3MTgtMS1odWFuZ2dh
b2JpbjIzQHNlbWkuYWMuY24vCgpHYW9iaW4=
