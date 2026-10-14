Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5594FD798;
	Wed, 14 Oct 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989681; cv=none; b=d7j6PQINw38ZqzCFdVqJsjWG3QNy+90zyLt0NUG3tbTG5pATzWszTqJCNokp9Y+uwemTuazlThiqVGT3Z5AwNOE6dRppM/v2f/DpjDA8V2Mzs4rIaKgYhczqbkrcb09+Gi73aoOb0wokyaKyBwlbpQzu4ZJqW/ff5QijZF8LjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989681; c=relaxed/simple;
	bh=3JfaNEVGkBns1VAswZju3md8BsKJx/Eb8XEER1odfs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=eCp8reZmXINM2nrQ9gj/V7LDYB8SBK3iO2tA7TwVVYKtQGizID8i5/2cto1Wka9VeywfHW64CWcTU4bqkhoi5/HIE1KaSUbggxtpgkSYcHq0YTG1tyWnWpWcy2q4yJiBInE8eQzWuTwIeC4VheqEVhrkslXFsRXPGE86P/J8iRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.16] ) by
 ajax-webmail-APP-10 (Coremail) ; Wed, 14 Oct 2026 22:48:51 +0800
 (GMT+08:00)
Date: Wed, 14 Oct 2026 22:48:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, "Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"Dave Jiang" <dave.jiang@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Dan Williams" <djbw@kernel.org>, "Ira Weiny" <iweiny@kernel.org>, 
	"Li Ming" <ming.li@zohomail.com>, 
	"Richard Cheng" <icheng@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] cxl/mbox: bound the device-supplied command return
 code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <as7cid_6QQS5gBI-@aschofie-mobl2.lan>
References: <20260929060747.3550005-1-huanggaobin23@semi.ac.cn>
 <as7cid_6QQS5gBI-@aschofie-mobl2.lan>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49ee762d.402bc.1a13ae337d6.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowAAnLaxTls9q8yYTAA--.30477W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwcADGrOyBb0pAACsk
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgQWxpc29uLAoKVGhhbmsgeW91IGZvciBwaWNraW5nIGl0IHVwLCBhbmQgZm9yIHRoZSBjb3Jy
ZWN0aW9ucy4KCj4gKFNhc2hpa28gaXMgcmlnaHQgaGVyZS4gUEFERFIgYW5kIFBPSVNPTkxNVCBk
b24ndCBtYXAgdG8gLUVOWElPLCBzbyB0aGUKPiBjb21tZW50IGFuZCBjaGFuZ2Vsb2cgY2xhaW0g
aXNuJ3QgYWNjdXJhdGUuIC1FTlhJTyBpcyBzdGlsbCB0aGUgcmlnaHQKPiBmYWxsYmFjayBmb3Ig
YW4gdW5rbm93biBjb2RlLikKCllvdSBhcmUgYm90aCByaWdodDogdGhlIGNsYWltIHNob3VsZCBi
ZSB0aGF0IGFuIHVua25vd24gY29kZSBpcyBzdGlsbCBhIGZhaWx1cmUKYW5kIHRoYXQgLUVOWElP
IGtlZXBzIGl0IGluIHRoZSB1c3VhbCBkZXZpY2UtZXJyb3IgY2xhc3MgLS0gbm90IHRoYXQgZXZl
cnkKbm9uLXN1Y2Nlc3MgZW50cnkgbWFwcyB0byAtRU5YSU8uICBQbGVhc2UgdXNlIHRoYXQgd29y
ZGluZyBpbiB0aGUgdmVyc2lvbiB5b3UKY2Fycnk7IEkgd2lsbCBub3QgcmVwb3N0IHRoZSBwYXRj
aCBvbiBpdHMgb3duLgoKPiBJJ20gdGFraW5nIHRoaXMgaW50byBhIHNlcmllcyB0aGF0IGFkZHMg
Q1hMIEtVbml0IHRlc3RzLCBpbmNsdWRpbmcgYQo+IHJlZ3Jlc3Npb24gdGVzdCBmb3IgdGhpcyB0
YWJsZS4gWW91J2xsIGdldCBDQydkIHdoZW4gaXQgcG9zdHMgYW5kIEknbGwgbmVlZAo+IHlvdSBB
Q0sgaXQgc2luY2UgaXQgaGFzIHlvdXIgb3JpZ2luYWwgYXV0aG9yc2hpcCB3aXRoIGNoYW5nZXMg
ZnJvbSBtZSBhZGRlZC4KClVuZGVyc3Rvb2QgLS0gSSB3aWxsIEFDSyBhcyBzb29uIGFzIGl0IHBv
c3RzLgoKPiBJdCBsb29rcyBsaWtlIHRoZSByZXR1cm4gY29kZSB5b3Ugc2F3IGlzIHZhbGlkIGZv
ciBDWEwgNC4wIGFuZCBqdXN0IG5vdCBhZGRlZAo+IHRvIENYTCBkcml2ZXIgeWV0LiAuLi4gQ1hM
IDQuMCwgVGFibGUgOC0yMDggLi4uIDAwMUZoIGFuZCAwMDIwaAo+IEkgZG9uJ3QgdGhpbmsgYW55
b25lIGVsc2UgaGFzIHNlbnQgYSBwYXRjaCBmb3IgdGhhdCB5ZXQsIHNvIHlvdSBjYW4gaWYgeW91
Cj4gbGlrZS4KClR3byB0aGluZ3MgdGhlcmUsIGFuZCBJIHdvdWxkIHJhdGhlciBub3QgY29sbGlk
ZSB3aXRoIHlvdXIgc2VyaWVzOgoKLSBUaGUgS0FTQU4gcmVwcm9kdWN0aW9uIHVzZWQgMHgxZiwg
d2hpY2ggc3RvcHMgYmVpbmcgb3V0IG9mIHJhbmdlIG9uY2UgMDAxRmggaXMKICBpbiB0aGUgdGFi
bGUuICBPdXQgb2YgcmFuZ2UgaXMgYW55IGNvZGUgcGFzdCB0aGUgZW5kIG9mIHRoZSB0YWJsZSwg
c28gd2l0aAogIDAwMUZoIGFuZCAwMDIwaCBhZGRlZCBpdCBpcyAwMDIxaCB1cHdhcmRzIC0tIHRo
ZSBib3VuZCBpdHNlbGYgaXMgdW5jaGFuZ2VkLgotIEFkZGluZyB0aGUgdHdvIGVudHJpZXMgaXMg
YSBzZXBhcmF0ZSBjaGFuZ2UgZnJvbSB0aGUgYm91bmQuICBEbyB5b3Ugd2FudCBpdCBpbgogIHlv
dXIgc2VyaWVzIG5leHQgdG8gdGhlIEtVbml0IHRlc3QsIHNvIHRoZSBib3VuZGFyeSBhbmQgdGhl
IHRlc3QgbW92ZQogIHRvZ2V0aGVyLCBvciBhcyBhIHN0YW5kYWxvbmUgcGF0Y2ggZnJvbSBtZSBh
ZnRlciB5b3Vycz8gIEVpdGhlciBpcyBmaW5lLiAgSWYKICB5b3Ugd291bGQgcmF0aGVyIGhhdmUg
aXQgZnJvbSBtZSwgSSB3aWxsIHRha2UgdGhlIG5hbWVzIGFuZCBlcnJubyBtYXBwaW5ncwogIGZy
b20gVGFibGUgOC0yMDggYW5kIHNlbmQgaXQgc2VwYXJhdGVseS4KClRoYW5rcywKR2FvYmlu
