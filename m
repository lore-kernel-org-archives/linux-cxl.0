Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA96385D75;
	Thu, 15 Oct 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053777; cv=none; b=E11IAirGxggTYlJ0Saltwpq5FE73GHDy3eMvlJRYC19AQC3YPdjcm9ip7M0uKzHioOUE4SZ3ZJNjtUB+JJeoJTH8FNbT/XNbDlLYcnMlS/MStnTrgAWM+g6097ZAMqvd/Q9BBan4fezwM6/ECYgc0On1YlXpv+Skc15ySL+H0ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053777; c=relaxed/simple;
	bh=YVvOWWnNTA4Fg6YvjJo0nlknvomj9wPVnCAdZfvzNgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bf2S6MWKb5F24oVNFk294I2JrF/ewUqQW60M1L5mCBl02Z99ilbahkqaFNBNtPzmi3DbbAMUbrz25qJJCxr8zFUcHn5jfAPidE0joyWuxu12lp/qLfh5ISlRuDkbeOKK+yfIXPzWLYfdVvyObQ76PM0EH3rCOOSi80XMjq4SHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.16] ) by
 ajax-webmail-APP-10 (Coremail) ; Thu, 15 Oct 2026 16:42:38 +0800
 (GMT+08:00)
Date: Thu, 15 Oct 2026 16:42:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, "Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"Dave Jiang" <dave.jiang@intel.com>, 
	"Alison Schofield" <alison.schofield@intel.com>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Dan Williams" <djbw@kernel.org>, "Ira Weiny" <iweiny@kernel.org>, 
	"Li Ming" <ming.li@zohomail.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes
 001Fh and 0020h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <atCLjvE5xJp9jo6L@MWDK4CY14F>
References: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
 <atCLjvE5xJp9jo6L@MWDK4CY14F>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <31c53d8e.42202.1a13eba4ae8.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowAAnLaz+kdBqFFYTAA--.31554W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBwUBDGrQUWHtLgABsH
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgUmljaGFyZCwKCj4gRG8gd2UgaGF2ZSB1c2VycyBmb3IgdGhlbSA/IG9yIHBvdGVudGlhbCB1
c2VycyA/CgpJIGNoZWNrZWQgdGhlIHJlbGF0ZWQgY29kZSwgYW5kIHRoZSBob25lc3QgYW5zd2Vy
IGlzIG5vIGZvciBib3RoIHRvZGF5LgoKMDAxRmggaXMgdGhlIGNvZGUgUGVyZm9ybSBNYWludGVu
YW5jZSAob3Bjb2RlIDA2MDBoKSByZXR1cm5zIHdoZW4gdGhlIGlucHV0CnBhcmFtZXRlcnMgYXJl
IHRyYW5zZmVycmVkIGluIHBhcnRzIGFuZCB0aGUgcGFydHMgYXJyaXZlIG91dCBvZiBvcmRlciAt
LQpBY3Rpb24gPSBJbml0aWF0ZSBUcmFuc2ZlciwgQ29udGludWUgVHJhbnNmZXIsIEVuZCBUcmFu
c2ZlciAoQ1hMIHI0LjAsCjguMi4xMC43KS4gIExpbnV4IGRvZXMgaXNzdWUgUGVyZm9ybSBNYWlu
dGVuYW5jZTogUFBSIGFuZCB0aGUgc3BhcmluZwpvcGVyYXRpb25zIGluIGVkYWMuYyBib3RoIGdv
IHRocm91Z2ggY3hsX3BlcmZvcm1fbWFpbnRlbmFuY2UoKS4gIFRoYXQgaGVscGVyCmFsd2F5cyB0
cmFuc2ZlcnMgdGhlIHBhcmFtZXRlcnMgaW4gYSBzaW5nbGUgY29tbWFuZCB0aG91Z2ggLS0gaXQg
cmV0dXJucwotRU5PTUVNIHdoZW4gdGhleSBkbyBub3QgZml0IGluIHRoZSBtYWlsYm94IHBheWxv
YWQgaW5zdGVhZCBvZiBjaHVua2luZyAtLQpzbyB0aGUgb3JkZXJpbmcgY29uZGl0aW9uIGNhbm5v
dCBhcmlzZSBmcm9tIHRoZSBkcml2ZXIuICBUaGUgbXVsdGktY2h1bmsKZmxvdyBpbiB0aGUgc3Bl
Y2lmaWNhdGlvbiBpcyBkZXNjcmliZWQgZm9yIHRoZSBCdWlsdC1JbiBTZWxmLVRlc3QgdGVzdApw
YXJhbWV0ZXJzLCBhbmQgdGhlcmUgaXMgbm8gQklTVCBzdXBwb3J0IGluIHRoZSBkcml2ZXIuCgow
MDIwaCBpcyBvbmx5IHRoZSByZXR1cm4gY29kZSBvZiBSZXF1ZXN0IEFib3J0IEJhY2tncm91bmQg
T3BlcmF0aW9uIChvcGNvZGUKMDAwNWgpLiAgTGludXggZG9lcyBub3QgaXNzdWUgdGhhdCBjb21t
YW5kIGVpdGhlci4KClNvIG5laXRoZXIgY29kZSBoYXMgYSBwcm9kdWNlciBpbiB0aGUgZHJpdmVy
IHRvZGF5LiAgQm90aCBhcmUgZGVmaW5lZCBpbiB0aGUKY29tbWFuZCByZXR1cm4gY29kZSB0YWJs
ZSAoQ1hMIHI0LjAgVGFibGUgOC0yMDgpIHRoYXQgQ01EX0NNRF9SQ19UQUJMRQp0cmFuc2NyaWJl
cywgYW5kIGNhcnJ5aW5nIHRoZW0gY29zdHMgdHdvIGxpbmVzIGFuZCBubyBiZWhhdmlvciBjaGFu
Z2U6IGEKZGV2aWNlIHRoYXQgcmVwb3J0cyBlaXRoZXIgYWxyZWFkeSBjb21lcyBiYWNrIGFzIC1F
TlhJTyB0aHJvdWdoIHRoZQp1bmtub3duLWNvZGUgcGF0aCwgc28gd2hhdCB0aGUgZW50cmllcyBi
dXkgaXMgYSBuYW1lIGluc3RlYWQgb2YgInVua25vd24KcmV0dXJuIGNvZGUiLgoKSWYgdGhlIHBv
aW50IGlzIHRoYXQgYSBkZWZpbml0aW9uIHNob3VsZCBhcnJpdmUgd2l0aCB0aGUgY29kZSB0aGF0
IGNhbgpwcm9kdWNlIGl0LCB0aGF0IGlzIGEgZmFpciBwb3NpdGlvbiB0b28uICBJIGNhbiB3aXRo
ZHJhdyB0aGlzIHBhdGNoIGFuZApyZXNlbmQgaXQgdG9nZXRoZXIgd2l0aCBjaHVua2VkIG1haW50
ZW5hbmNlIHRyYW5zZmVyIHN1cHBvcnQsIG9yIHdpdGggYWJvcnQKc3VwcG9ydCwgd2hpY2hldmVy
IGlzIGltcGxlbWVudGVkIGZpcnN0LiAKClRoYW5rcywKR2FvYmlu
