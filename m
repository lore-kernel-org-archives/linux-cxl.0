Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616B348898
	for <linux-cxl@vger.kernel.org>; Fri, 16 Oct 2026 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129764; cv=none; b=NX/XHnSP7JFCgc2bbvJqqRWPpCKseAPcwudiERl3/6YgbzBV/GLmtvou9l9Pdi7cVIun7paJgeuL8TPOAHmUmeb2P0r3RzfYtjrc62kDSVp0pXSmaurSHeroi5ei9RTp8l7ChbO+kOBeNwhFpeAEeNzWSf053x6x1rJQi+6gbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129764; c=relaxed/simple;
	bh=rCTBXZWsA+DFjYHLb8u5Oa7Bvqyi+ouM5tudHnnjwtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=foeUxTF/u/z1Nrq8YtaaeAYpJkhvMuzp1y+lPpXiqIIXkxNaaCtHpUGc2NAJOE/N0RhJp/GGaUjauE+WREm2dn8JejQneyQot0G+HBwt2/8nbD6cbMva7X899H5eEtd8RgdM64f1hXQGMViSOlnFcYz6bwUrQ+XPlwzBkn40p2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NiVFX5sU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NiVFX5sU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e86dce4510so31179075ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 15 Oct 2026 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792129763; x=1792734563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z5sNEdkVrvo7sH9ZJvBOJJZb8XmvxfiMz5rU6UHY+Ek=;
        b=NiVFX5sU/FTAufM7yu/cYPhfcmFBhvQIq3q+hfe/u3+1AsfrR7qHZ3KcjUeieayd0e
         LcLKnJsH/tA0v//RMDjyuiGrG0KtgMx4lh94F9IPAH97vc+Qn5IrKcSLZifNRWJW87B9
         On48vYRJYmAgKQFHwvKI5e7YDUUDNXOo2Br9hSJcIMIkCnpBI5hqkS0BZJOuHqBBBd40
         XhNIkdbO4qzdzz54okUrTgiktdkNwHDLbacXi0b1Pic9iP6sj1CPXo/5W/8Nglp1taBV
         AjQhU/0uD0LdYhZpPFSs20IWikAeHoaJmmYoU4eiXb3fYlJzXfZzhXyV6xVO0aIwlMo+
         oF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792129763; x=1792734563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z5sNEdkVrvo7sH9ZJvBOJJZb8XmvxfiMz5rU6UHY+Ek=;
        b=r5zbAeGjCoIMOn6kBCTWWVfDCwga6FWPimQONcew7ETWK5an37YbYHRuPjLykuGNxW
         O2L8M8kIbu4U9fN5wk+vDepS77aDHtJWf89LLb0HXqfX1h90E9Y+V2jLda46kiUoFDea
         vb+5ErTqmS7SFxVbYo9Kkl5QR/pqLFEhvTEnnFNjKG8BRJJlY4HSNSumIqsMoXJ4xeGk
         41VqmSvotZPGPESzsCneytMagL6T7UOIN0BBT4gUwFGKgn+pnMuhoDUlMjFc0XCd2I87
         i39SNSAze776UCxAkcPOaMBPdRDwPipb3AJ0flDf4jLy2039Vc3mDl9TZvbwxeI2d1Fg
         B88Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTnyms7oVXPcNLxkn6+llxiOdduPeb1q9oAP7r/4RlP9WgP3DgSaJevqxWd4rkuFu4mZpR3B+izMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJmNun2eGHyHR4WjW/Xt5RoRpMAIIt0IsBAWlgiMYq4nDHTvAR
	Z6k86p4C7PRQuZ97vwO/vlvkjKcMvmwgrSZwLJ2GprRYB62iKIRaXMGk9F3hhpwHvUs=
X-Gm-Gg: AYBFou3MHACEwl5NFVWBXKAboH+S2eNdiOPiKoInQ0j54rZUDfzCHUh/sWwC1nCn6A4
	3MFCwl+u4CCjhLGfiX6cvmHCctsIsjvamtFWY/7/u8mJvoLiNDO0qhgiOOClzqV/Ig+99ijUWfV
	32ZxH9rTYN8HLJJ8B/LRGTopsUephYIpOKqR7IPijBCb7D/W1QMM82sxCAMe3VMzPLzH18aWwga
	BGG9VvA1MHGWttwjtAI1odaU9TfzLMqct+Jv2+gDsHP2zq8kBhFK2q8k4hX/DYXg1GX4EnVdUch
	RN33UFONrNlrGrA6IsCn33YZm7EotPLiuPyf9Us3SG5bR/E4q+7sqQWJ00EC3sOGhdqMThb8YSN
	QfKNYzNxqVa3dWNQBxFTQ7mZ5zYuQ4BhlBcX6ge/PrV5i8H69lRTyqBfHX42KdUSHE/DyBCLHyf
	vJwnymiO9jA1a0f3m0+41ji8Jy8X+b5Xrq8EcIQfbBJEjTvm9uQCO1LRCWyqcApJyF5DGKUVWjF
	cIuuN3t2UvNM25OFoU=
X-Received: by 2002:a17:903:1b4f:b0:2e9:7ff5:544c with SMTP id d9443c01a7336-2e97ff55897mr13235965ad.25.1792129762374;
        Thu, 15 Oct 2026 22:49:22 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d7csm4697445ad.15.2026.10.15.22.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 22:49:21 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Muchun Song <muchun.song@linux.dev>,
	stable@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] dax/pmem: fix unaligned compound devmap initialization
Date: Fri, 16 Oct 2026 13:49:14 +0800
Message-ID: <20261016054914.2601510-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static pmem Device DAX namespaces reserve space for namespace metadata
before the user-visible data range, and may also include padding needed
to satisfy the Device DAX alignment. __dax_pmem_probe() adjusts the
dax_region range to start at the data range, but the dev_pagemap range
still starts at the beginning of the namespace.

That is not valid for compound devmap mappings whose memmap is stored in
system RAM. Compound page initialization requires the start PFN to be
naturally aligned to the compound page size, because the head and tail
struct pages are initialized according to that geometry. If the pgmap
starts before the aligned data range, memmap_init_zone_device() can build
compound page metadata from an unaligned PFN.

The resulting struct page layout is inconsistent with the Device DAX
mapping. A later mmap fault can then resolve the user-visible PFN through
invalid compound page metadata and hit a kernel panic while inserting the
DAX folio.

Fix this by advancing the pgmap start to the aligned Device DAX data
range for non-altmap compound mappings. Leave base-page namespaces
unchanged, and leave the altmap path unchanged because
memmap_init_zone_device() already skips the altmap reservation itself.

Fixes: 14606001efb4 ("device-dax: compound devmap support")
Cc: <stable@vger.kernel.org>
Reported-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Closes: https://lore.kernel.org/r/wlrkqqvg.ritesh.list@gmail.com
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/dax/pmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..d3a9b85107b0 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -51,6 +51,13 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 	/* adjust the dax_region range to the start of data */
 	range = pgmap.range;
 	range.start += offset;
+	/*
+	 * When the memmap is stored in RAM, exclude metadata and alignment
+	 * padding from compound page initialization.  Otherwise, the pgmap
+	 * may start before the naturally aligned Device DAX data range.
+	 */
+	if (!pgmap_altmap(&pgmap) && le32_to_cpu(pfn_sb->align) > PAGE_SIZE)
+		pgmap.range.start = range.start;
 	dax_region = alloc_dax_region(dev, region_id, &range,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
 			IORESOURCE_DAX_STATIC);

base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
-- 
2.54.0

