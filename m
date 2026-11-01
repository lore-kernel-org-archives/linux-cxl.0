Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793496865;
	b=yi4D81ky9XFPk8wJKyUKrTfpxJiGQe6U1F5ie8Vwq9OpCafLBNYLyvfQaByERjZ5GaAf
	 LG+47DqqabWei4A/qfZLfZQv4QZtNaxgC0bHIK3DsJQ0tBiA5QPrYnGWcGQU2fCAjffKt
	 ZugMzNVluHH6+W5ohlGt23Bx+c3rttGgumwHmwZolfqyX/P8mdp0Y3SIwoZXqES9qmy05
	 GZlKi4vobOea1uCxsZDuc4nQcR7W81iQp+faaIVbG5DbTTAdE1/nLuragI6FAKmILoT40
	 qgs4MUbJAM82stjf/IGtsJcTuHcB9hnhWtsImPoPwpMSx+qXE0BsrAyJh5/e8SLUIJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793496865;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=gvIJq7cqiBSNyGJy8QuDdz9gWAMdkSaGppG7j3VrUKI=;
	b=Xi3kGXShC1LLR1SCqf3FX/e6BE/SstTnngkUlTvaadIo9f8VtGsZcN1OrfI99/uco3V5
	 ae50BCVPY2TxTKwG6TEyAT9NAmfF7e0UiDSBUQDG0ZWqVtstQ+suqFbVY0U89O2ChjNME
	 uD//KGXoUaO2u49/s4I4QwZEIeLwgMql6Xv7CED1yJQw4PvOWyuB1K46/VEli1TWQjnRG
	 PdWZiIDtkTos3cDtc6c5CKvu0SM24QZxjL9/4W4hZE/5PusYPh0Xlut4JkpJcnE6vgJNR
	 sXWjK43YARWFN1ztF+QxGG4XuS5GrmjxJ/MEMzqBFhGK+x6NLr8xxQzfBKuMjEkKcUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F6606A31A
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 01:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE3F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ea7190aea1so9046035ad.1
        for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 18:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793496864; x=1794101664;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gvIJq7cqiBSNyGJy8QuDdz9gWAMdkSaGppG7j3VrUKI=;
        b=oXnhS3bhR6T8WEm6d5uYRZqowXlzlfIbx9NgXqgoIqe5r/ODk2nCkTV4Yi0iG0Mqsk
         eiCyCjENPgiqfxiI8ox6nfX8zMT6e9KBn1NCzyeNN+pzLqq1fDJzV4SE+erYWgEPHCPP
         DY5xxnEZWwRQPxYNaXLWcrUmMTBR+lksGczONJbjGrAmJzDE9XmdfmtBZB5ThqCQz+BL
         BIJAVL86OpgoaZ0s2AvHG3Go4lqjwE322M2FI2SAqduYacbr1VweMUITMurx85GYBWxp
         p8GWWjytW+sgNgvUvDuD1EC+nLDcb7Hp4tY8LJKj/C4PfK4m1R+xz6vrhIXW7JKqQC92
         ILKw==
X-Forwarded-Encrypted: i=1; AKwUvBypdnFLIBjs8BJNft7QQUKldKyaXnnTnJchFo0hdWIlA+J7S8vlPtfg3aisiHLvjwv+DONnOVX1yIY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JL+0BrPsx5L2uXHZi0dEv5l1Dh5ATbJmQIYSB//Ar/XqBk9nv
	CwahNluYLxoLgbIgxDTkMeh6Dfw7pMgw4/wU8oyN9G1UpOCEUdseYEOAmY0CxoqhX+RZ
X-Gm-Gg: AYBFou3hJ6Xow3sGoBhTx6NcrG/jHMnusMBPthZZGhthk2YXboiI+ZdpGIHSlzgeoYj
	lhx45ryLawQMmwD4kai7jYUt50UHvxPKQS9pDKZGbZSvEuwFwzB7ChK4Y2l9WvLeGAsKp+vk1AI
	0Tgc6p+hesz35Z5EhjaE2NDWz90HMsWg3NATTbRs+bVUn9mBDwMraaO4f8hPqz/Lzn0KzovxM/C
	jC8+AbzASxXNY8Q27da8HE+sTCO3NIXYuuCmD3ecaUk1w94Wf//vRfKAL8OywJ5UQTEOK2osaZm
	MakwGpm0lvNKmvpRblQzHtdTmTxRXspj/t2ZfBIvasbU0XJgOE4K0bXW9T5YwnUyllBBHg5Yfhd
	xY88wgrtxNLuFSQarJ2Ce4AMr4SwlExfOLimkh2gtcRxCuctMuqA5+/8M+ozcKQ4PZBFusnvx8D
	eyuIK7olu3P2Oxn0mlBbaqBcC0os+duSZUw+3JOZG0j6uilillQ3yAL3JYInIa1VQlO0cUKvDGr
	nDf0Ix+7pw2hj8sCuJJDobCfOihlLaHdrFSihTV2Ak6/R7GKl9sczEVMac1PwROhqO2kHPfTUkZ
	NFrIPwJOS6TojbUxQTBzvNabP1Qp9emvycb51GsBXgyJ9BOLLmoHcrwPl6Qf2/ZJXCVhWoF6EEi
	94hUF3+vItcIiYn4LD+G0OERMJRs56u3RcZEc5Gw=
X-Received: by 2002:a17:90b:528d:b0:3ab:f38:2b3c with SMTP id 98e67ed59e1d1-3ae897baff7mr4750080a91.28.1793496864135;
        Sat, 31 Oct 2026 18:34:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm8727943a91.17.2026.10.31.18.34.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Oct 2026 18:34:23 -0700 (PDT)
From: Jongwon Lee <ai@linux.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>
Cc: Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] cxl/edac: Fix event record lookups for memory repair
Date: Sun, 01 Nov 2026 10:34:18 +0900
Message-ID: <20261101013418.87326-1-ai@linux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Patch 2 is the DPA flag masking fix from v2. Sashiko's review of v2
pointed out that the repair path reads cached DRAM event records with
no lock that keeps the event path from freeing them [1]. That race was
already there in cxl_find_rec_dram() and cxl_mem_perform_sparing(); v2
added one more read of a record, in the General Media lookup.

Patch 1 fixes the race for the DRAM lookup and the sparing path. Patch 2
does its General Media lookup under the same lock.

I used xa_lock() instead of RCU freeing. The cached records are copies
of the spec-defined event structures, so kfree_rcu() would need a
wrapper struct with an rcu_head, and the lookups only compare a few
fields. Taking device_lock() in the repair path, as the event path does,
looked like it could deadlock against unbind, where the EDAC sysfs
files are removed with device_lock() held.

Changes in v3:
- New patch 1 for the record lifetime race (Sashiko)
- Patch 2: General Media lookup under the xarray lock, returns bool

Changes in v2:
- Moved the Claude Code note below the --- (Dave Jiang)

v2: https://lore.kernel.org/r/20261031161121.15948-1-ai@linux.com
v1: https://lore.kernel.org/r/20261030072721.31970-1-ai@linux.com

Testing, QEMU master (b574eaf) with a CXL type 3 device, region
committed, KASAN and PROVE_LOCKING on:

- Same test as v1/v2: DRAM events injected at 0x1001, 0x2000 and
  0x3002, then a repair requested through mem_repair0..4 for six DPAs.
  Results match v2 for all five repair types.
- Race test: the host injects DRAM events every 20 ms (the same DPA
  again and again, so xa_store() replaces and frees records, plus enough
  distinct DPAs to hit the 200-record overflow path) while the guest
  requests repairs in a loop on all five mem_repair devices, 300 s.
  A test-only mdelay(20) after xa_load() widens the window.
  Unpatched: KASAN slab-use-after-free in cxl_find_rec_dram(), called
  from cxl_do_mem_sparing(). v3, delay inside the locked section: 3780
  repair requests, no KASAN, lockdep or WARN output.
  Without the delay neither kernel reported anything in 600 s.

This series was developed with Claude Code.

[1] https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org

Jongwon Lee (2):
  cxl/edac: Read cached DRAM event records under the xarray lock
  cxl/edac: Mask DPA flags in the event record cache key

 drivers/cxl/core/edac.c | 112 ++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 39 deletions(-)


base-commit: cf15f9f2361dd4002203716b7b878393c0eee4bf
-- 
2.55.0

