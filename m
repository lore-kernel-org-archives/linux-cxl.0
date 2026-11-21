Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258641;
	b=OavbpaUc1hKVdQyddGEWdsreJi2VjuOJ3SYyEdOOhGfErzofriQCXWQhuQ6IHdHnPARn
	 zJd7P6obZPdtHeSzeWpWKRvktO7c7ay5IrfITi1n4UcZR7pezBUbzZEDelU958A7hntG1
	 EbDL9ZuAhCW0WpXmTqNvyI/qubyzMzVKi1rMZqn8xk0lva3Ks5rIz1aPPhfyMLYQwccFf
	 POGHyLxY5I9VygPpfxJE/rxekkUOMItIbGksCdbMOKYaeDctuwyzRYELEzRgmuQNrRJWM
	 oZS/Jj3+5GUpG4iQGMQiOcB6Mk1bKIEaruhg8K1muW8XKXDG0n/EgcHXCLaxJ0LmgtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1m48DwzUGi6gFDDhXUxXisAF/EvcOOcumTNdjVePDOI=;
	b=sZEsTFHykKn7UK4wlgwtg+sdZq8yWSVgWZWtREAhUHIdBlcSchcEwgpgOLCEmhMLbVS/
	 +uhPAKiTdAsaDxrgrSXib55C9dvQfOOdeLSuutxbhkXT9YS473G7N+AuF2XZCZzZz7uL1
	 hW+A+FfRZNbTG5HhIVOn+HNP4GAi9NxQuWDsugxxl9KcoA22A0uyax758d73/YHRZ+sFX
	 0zurkss+vyGj6pOuP/LU60Yxibsncxp00pPKXdKVqqOn9efQvObWWA4bcdsQDEWjrjlYR
	 m6lIbojiUqDYl8k9jxRasODqFPlVQrzIiGk54psCWdX3K24gmP46OwptC5Hh2FTEO3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7mvumBZ;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BB606A325
	for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 10:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D64BB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F7mvumBZ
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd69954c755so1322312a12.3
        for <linux-cxl@vger.kernel.org>; Sat, 21 Nov 2026 02:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795258640; x=1795863440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1m48DwzUGi6gFDDhXUxXisAF/EvcOOcumTNdjVePDOI=;
        b=F7mvumBZSNwUedRX/cSE3MAY0k3rNpC7uDfmktW6cnOKvRDx4tyOqsu2K+I4l7l3T8
         3aLhuFewdglnMdpfLouXvldpnLhlvesV0G0vpHu1pC39SIWYn+oDXsGZW190OsixRSiI
         AGnagRozSnXHHL8NmYZOFhoZauduuxONZs2GJ/9XDck7Ex9DPNBI5Zy6sR0HeKxNI2Bg
         IpxKUT1OiQuFIamfv7PcsQz0/xYydfgBDy72p6aubxM17XB03tqvjmR2GFxL7HPG8pHd
         iuPVijjBShiSsjqlU+eJLkv7B+2sUqEzhzKfPxBruIEZDf9tBBMgJ6gJZB+EBsGIErzd
         ktdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795258640; x=1795863440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1m48DwzUGi6gFDDhXUxXisAF/EvcOOcumTNdjVePDOI=;
        b=2gfX1OtMiTNJUcx0L6i57P6CIpo8w3Ut8i8oCNvbyh+6Z/1tKqeFex+HVBToRP6cxN
         2T5sxncGXfZEOS8meC7HlZvLFEfr3GcHOXAvYFBnFZosu1PpBS7LrDyesfwTNBrNTf03
         3OblNOU5CvkcgstLvQQlpCh8DFIWC+y6uvVn+ApFCowPMhiADlbVs3J6d6fitfK2c6Fc
         6jzgctHWO7AqPgLgcyu2qSnMcadhOcnuag/yBeizho7lW0DEZk1dg3ZBx+nSH2oyxQwe
         fjuH670aspR/g00uCB2VcCB4SBesmOJWiHR1/mJi01ose3Q4EE2uxIiJLsQqXvza12do
         yiVw==
X-Gm-Message-State: APuU4Z/Sfl5x2xL6tLuU+6vsN5kQ1tWacEXRdi8W79rx9myPAFNGaW0Z
	gT2p5jmI7d+C1UZ+nbMBOLydhIUvwpfzr/rTeTHO5V0JJROfGtw+7/pHoAgdxYfd
X-Gm-Gg: AZFdTZfYLBkKraII/rDMTvbneIoNCe5jnypvRV6YfYUzPSz+cfzWKEljeOg8W8/76BT
	pMT3HeapuDINdOEwmWHT6LiYiVoEiZBNW6LVFWJtx8MISit2IeSBFdkSiJisrGeZr0tdaeKOnTa
	uEe01Idlj50wCnf4KsrrVYxuQUTAsS3HT1fdjkOLQYq5G8e3oENtgtQkBSgHV2W3PKxwmUrybNC
	29JLv0IxfVja2lW45Pu6NapzjojG7PTzyhVpxOwAlFcw7dx5S2TZ0VzqJIXXEYZZi7a954fs7/I
	0BKxg+MVSHQ5pvi9t1j4kjvu9bJG85W0Nt4dtuXWjf0shsDn9JVT3vMLQUPmyfb4kZ3z6c/JZIA
	RDrePbusty7tcw6CiKS6V6tFO5Er/KIN0PhJm91UdSZKpHHTaRkJZLaky3OaGAo50lR+v6woP5x
	WiN7wvxyZ3tp4PI47SRyrizWMkVHhf7B8MNcQVEn9tEi4/P3E+JUuq4uPvwlx/MzJAAeMtXnwfi
	1aEvKMn5oui/sRFRTmi7D9lhA3zHYM73XeZSriM8HjFleWpFjsLIFN8NH0EkakFXAa4irOXRACT
	oVYkGe14qGySAltECSIrdz2L6hjbYnE2dQNkw0nHkMgeER0WURsb7s01JN4onVcq
X-Received: by 2002:a17:90a:d2cf:b0:3b0:9781:ee8b with SMTP id 98e67ed59e1d1-3b41c9e46b9mr5178411a91.26.1795258640080;
        Sat, 21 Nov 2026 02:57:20 -0800 (PST)
Received: from localhost.localdomain ([121.134.184.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b21e19fsm1494739a91.0.2026.11.21.02.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:57:19 -0800 (PST)
From: Unsung Lee <unsung0317@gmail.com>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH] cxl/region: Fail region creation for a root decoder without a CXL window
Date: Sat, 21 Nov 2026 19:57:14 +0900
Message-Id: <20261121105714.1542859-1-unsung0317@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add_cxl_resources() expands a CXL window over a conflicting resource
and then removes any following window that the expanded one contains,
or trims the start of one that it partly overlaps. pair_cxl_resource()
only sets cxlrd->res when a window still contains the whole HPA range
of the root decoder, so the root decoder of a removed or trimmed window
stays registered with cxlrd->res == NULL.

Region code uses cxlrd->res without a check. Writing a region size
under such a decoder passes NULL to alloc_free_mem_region() and oopses
with resource_lock held for write, which then stalls every other
resource tree user:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:get_free_mem_region+0xfa/0x360
   alloc_free_mem_region+0x1e/0x30
   size_store+0x1d5/0x300 [cxl_core]
   kernfs_fop_write_iter+0x13f/0x1e0

Auto-assembly of a committed region under such a decoder would do the
same in __construct_region() and cxl_extended_linear_cache_resize().

Both the sysfs and the auto-assembly paths create the region with
__create_region(), so reject a root decoder without a window there,
next to the existing check for a dead root decoder.

This was hit with cxl_test in a QEMU guest whose 64-bit PCI window
overlaps the cxl_test mock windows: CXL Window 0 is expanded over
PCI Bus 0000:00 and swallows Window 1 and 2.

The problem was found, reproduced and the fix tested with an LLM coding
assistant driving the QEMU and cxl_test runs.

Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
Signed-off-by: Unsung Lee <unsung0317@gmail.com>
---
Notes:

- How this patch was made: an LLM coding assistant found the problem
  while running cxl_test in QEMU, analysed it, drafted the fix and this
  changelog, and drove the reproduction and test runs below. I reviewed
  the analysis and the fix against the code.
- Reproduced on v7.3.1, v7.4-rc3 and cxl/next (32af781935). With the
  fix on cxl/next, all four root decoders without a window fail
  create_pmem_region/create_ram_region with -ENXIO and the guest
  stays up; the ndctl v85 cxl suite gives the same results as
  without the fix, except cxl-poison.sh, which now fails instead of
  oopsing the kernel.
- Only the alloc_hpa() path was reproduced. The auto-assembly path and
  the case in the add_cxl_resources() comment (System RAM spanning two
  windows, the second window trimmed) are from reading the code.
- With the trimmed window, its decoder now gets -ENXIO instead of
  using the remaining tail of the window for dynamic regions, as that
  comment suggests. That matches what pair_cxl_resource() already does
  (no window, no cxlrd->res); making the tail usable would need the
  decoder range to follow the trimmed window and is left alone here.
- An alternative is to warn in pair_cxl_resource() or not to register
  such a root decoder at all. Rejecting in __create_region() is the
  smallest change that covers every user of cxlrd->res.

 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6da..a2cd18571 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2792,7 +2792,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 {
 	int rc;
 
-	if (cxlrd->dead)
+	if (cxlrd->dead || !cxlrd->res)
 		return ERR_PTR(-ENXIO);
 
 	switch (mode) {
-- 
2.43.0

