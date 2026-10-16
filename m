Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757A599A29;
	Fri, 16 Oct 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792173199; cv=none; b=nIBjD6oCdm+w4O/gl/SG7C4w7pass0AZbrf2HN2GLvX01l01RN6bTPki1JZ2GQj3iKCb45cqiFeh9vhZYPNw3FTp4xy1HXsM9Oci0CCelQYgqmiLlUDdFtirJK0+XCkWwVfTSzQqyM0eZ3ECMh3jewVGjG+9AQFPUQxmH03k0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792173199; c=relaxed/simple;
	bh=KLkHDBzSoSd4iet4hNavvV7b78nG4EKMaJpIVOPYYsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=O5ylIzgY/saUcATcTXzXxWz64BWJJ9mGlDXsJkh+eFwRxtgt21Y2Za+b4AEWrku7k71sMKg1FldImotJ2DbW8zsXtJFPfb2rtHpc0Y0+zE880nPur+BHkJUkrYtT2rLr9Y1VDI8Aa6AtE5TnxozSArJ6R7jI9W7ZegXiTd/iHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn; spf=pass smtp.mailfrom=semi.ac.cn; arc=none smtp.client-ip=159.226.251.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semi.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semi.ac.cn
Received: from huanggaobin23$semi.ac.cn ( [159.226.228.11] ) by
 ajax-webmail-APP-10 (Coremail) ; Sat, 17 Oct 2026 01:52:52 +0800
 (GMT+08:00)
Date: Sat, 17 Oct 2026 01:52:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: =?UTF-8?B?6buE6auY5b2s?= <huanggaobin23@semi.ac.cn>
To: "Alison Schofield" <alison.schofield@intel.com>
Cc: "Dave Jiang" <dave.jiang@intel.com>, "Richard Cheng" <icheng@nvidia.com>, 
	linux-cxl@vger.kernel.org, "Davidlohr Bueso" <dave@stgolabs.net>, 
	"Jonathan Cameron" <jic23@kernel.org>, 
	"Vishal Verma" <vishal.l.verma@intel.com>, 
	"Dan Williams" <djbw@kernel.org>, "Ira Weiny" <iweiny@kernel.org>, 
	"Li Ming" <ming.li@zohomail.com>, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] cxl/mbox: Add the CXL 4.0 command return codes
 001Fh and 0020h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.1-cmXT5 build
 20240627(e6c6db66) Copyright (c) 2002-2026 www.mailtech.cn cnic.cn
In-Reply-To: <atEP3yvpvEK3O3VX@aschofie-mobl2.lan>
References: <20261015055048.1765042-1-huanggaobin23@semi.ac.cn>
 <atCLjvE5xJp9jo6L@MWDK4CY14F>
 <31c53d8e.42202.1a13eba4ae8.Coremail.huanggaobin23@semi.ac.cn>
 <ec305690-a036-406e-8185-d93632a5dcb7@intel.com>
 <atEP3yvpvEK3O3VX@aschofie-mobl2.lan>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1eaf388a.46026.1a145d867f9.Coremail.huanggaobin23@semi.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:tACowABXXax0ZNJqMbUTAA--.31862W
X-CM-SenderInfo: xkxd0wxjdruxrqstq2xhplhtffof0/1tbiBgMCDGrRZumQ2AACs1
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

SGkgQWxpc29uLAoKTm8gbmVlZCB0byBhcG9sb2dpemUgLS0gYm90aCBlbnRyaWVzIGRvIGV4aXN0
IGluIHRoZSBzcGVjaWZpY2F0aW9uLCBhbmQgaXQKdG9vayB0aGUgcmV2aWV3IHRvIHNlZSB0aGF0
IG5vdGhpbmcgaW4gdGhlIGRyaXZlciBjYW4gcHJvZHVjZSB0aGVtIHlldC4KCkFncmVlZCwgYW5k
IHRoYW5rcyBEYXZlOiB0aGUgcGF0Y2ggaXMgZHJvcHBlZCwgcGxlYXNlIGRvbid0IHBpY2sgaXQg
dXAuICBUaGUKZW50cmllcyBjYW4gY29tZSBiYWNrIHdpdGggdGhlIGNvZGUgdGhhdCBjYW4gcHJv
ZHVjZSB0aGVtIC0tIGNodW5rZWQKbWFpbnRlbmFuY2UgaW5wdXQgdHJhbnNmZXIsIG9yIFJlcXVl
c3QgQWJvcnQgQmFja2dyb3VuZCBPcGVyYXRpb24gc3VwcG9ydC4KClRoZSBvdXQtb2YtYm91bmRz
IHJlYWQgaXMgZml4ZWQgb24gaXRzIG93biBieSAzLzQsIHNvIGEgZGV2aWNlIHRoYXQgcmVwb3J0
cyBhCmNvZGUgdGhlIHRhYmxlIGRvZXMgbm90IGRlc2NyaWJlIGlzIGhhbmRsZWQgZWl0aGVyIHdh
eS4KClRoYW5rcyB0byB5b3UgYW5kIFJpY2hhcmQgZm9yIHRoZSByZXZpZXcuCgpHYW9iaW4=
