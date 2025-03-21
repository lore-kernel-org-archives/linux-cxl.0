Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7522D4EB
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580457; cv=none; b=uKIYEHFCY4ymkAkn8l2akpfNBLxJeo7h7Ya4WbyWjWuFEpPIZjY9OfBmnyOzc0kVL6T1xIhSuiMdrWciSJV36+NnOmrbPLbQF6se9FjFpeeQvBsnEUHTbQa4WPil00SWE1xEqGT0uOsKERvnJNHu8jkWNxm78hQLL6CQkFUhDGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580457; c=relaxed/simple;
	bh=47Y8hQip99iCf7c6Dmi/CZyHe8FpzUoY9ZGUEv+WWks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8+mD5T1AdPAAtQMpp7ibi9CZpDTmaidrJFcFn1BMf6mTYryHuahNYqo7NadJBjFr/KCIIT50GVtmJd7koZAOocxF7BzWEmoZczyMr86nb3TRw2sTwaB/XeuCo/AxSA4AcJ/f/5Q0trpwBBK6Bjzu8+TgcYuoPKZkc/vBW55iuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Lcm9xCdZ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Lcm9xCdZ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500cf80so182387485a.1
        for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742580454; x=1743185254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLZ7c8PVq08fNJyONQLIT/0eP11NvUsx2TyTerL7XHc=;
        b=Lcm9xCdZx3SU4zIQeK0307UQBIHvzFmf/PvKMcOr1rwqqwY7dxAsvEhHXgMB8oLDbi
         W8He2l8z0QUaqpWNKzk4Xzwm4stCtCpfgrNuexEcfdvAPY5Zs0DWHdUW3zaKBjhvF2k4
         BomHBcCf8EvIwSW8xDthRPI2H/VSnP6h2xgfBYAlsWKDR9N2pM2Qpfrc9USAE/LXmHT6
         enTLFUcC1Z/8FULl3V+X0w636KSuphDbWiukF3qchEsquaaHFX6NYP4N1WjmRrzFlBAz
         Ov63OOb6a1sPOUiSNlrY/Bx5dvgIgpKwlSc9Fy9NaKsKSYXRqZa+6sRUorYaKxufK1FA
         WESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742580454; x=1743185254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLZ7c8PVq08fNJyONQLIT/0eP11NvUsx2TyTerL7XHc=;
        b=KWWd7a2e3etT1y0vetP/pFfaHS+KDijC1PR0UCV70dI6RRfJt3dk6EhLuADcpNHLxL
         5uYpNIbV3qDD8vi20Z6Qqp35R4rDMMLCZbDK2iLCL5zC0kcPeCTcXjcpW/rmyfBEEF5a
         XrBX6FUNVwwoBHFaZGghBSSVWnnY/FCJrVMNtnRqEeZazzFGEBrHXWC7Bxoq0C0jOnGY
         bPoPaJfxUco7nXrfjHX5GTdLltQRkyQcAkR5Zp20WyK4pL9pRzkf7B/Fj+MjYu8j3nhb
         vS7fPR20RSnmQOtddwfXB/+h47o4ClPg3LD7Ejs/xm3plkp7HUC7pS/A9jwPLTZjBD1p
         KcWw==
X-Gm-Message-State: AOJu0Ywkch5FQx3Pjb5Lm0rRLnQo03xqcwTaE5SXLKOPkAPbodLdwsoF
	x1izGxw110UDKGmQy5ufrsGNci9YdLM+DQa/zY2dmdRSHGwsC1P5FWvfWiRvRDaus0JixsnMITJ
	f
X-Gm-Gg: ASbGncsGegQber6GKzVonKBGvEhzXm8x8GK21g8/Bf/IxuL3TYPMdai9sKxMAfkngZ7
	QRcIDZTHGXSLzht9yGmlEAKg9l7cW/QlClaFuoAuBfRPO/D+Zf5WdRYOsd9p/FdXwULh5+KghJr
	5EhkdX92RnYSEOWKzuhjUCNKuWAO73k2bEScR8EbnZa4zyWpMNdZrSjfxnQJf0RfLDnRsZQJg1v
	FgC4O6THM7scIGc5+y4epA3GMdSC3f10YMSoY8pdaYPf5anPeV32wcn05l1pnmhqo0Q8NiU+XB5
	D7YJUkftHMGb8j3AFi7dpDCrNlKrEBIGNDrqkjGS/sfNyTs4hEoBR2bnppTWbcmJznIX8Qwo2D9
	fk6Jk3Qx2SzFFAhHl3IK1bAzPyz8aAUOr
X-Google-Smtp-Source: AGHT+IFUnfQhtjCQYv7DzHsq6hKskzByzvAs8wuY7quw/aYR00Op6Rp9Y4a5IxpqPKPkNuMTQdbM5g==
X-Received: by 2002:a05:620a:269a:b0:7c5:3ca5:58fe with SMTP id af79cd13be357-7c5ba15a54emr539420085a.22.1742580454012;
        Fri, 21 Mar 2025 11:07:34 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b2bb6sm158643885a.11.2025.03.21.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:07:33 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com
Subject: [PATCH] DAX: warn when kmem regions are truncated for memory block alignment.
Date: Fri, 21 Mar 2025 14:07:31 -0400
Message-ID: <20250321180731.568460-1-gourry@gourry.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device capacity intended for use as system ram should be aligned to the
architecture-defined memory block size or that capacity will be silently
truncated and capacity stranded.

As hotplug dax memory becomes more prevelant, the memory block size
alignment becomes more important for platform and device vendors to
pay attention to - so this truncation should not be silent.

This issue is particularly relevant for CXL Dynamic Capacity devices,
whose capacity may arrive in spec-aligned but block-misaligned chunks.

Example:
 [...] kmem dax0.0: dax region truncated 2684354560 bytes - alignment
 [...] kmem dax1.0: dax region truncated 1610612736 bytes - alignment

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e97d47f42ee2..15b6807b703d 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -28,7 +28,8 @@ static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
 static bool any_hotremove_failed;
 
-static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
+static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r,
+			  unsigned long *truncated)
 {
 	struct dev_dax_range *dax_range = &dev_dax->ranges[i];
 	struct range *range = &dax_range->range;
@@ -41,6 +42,9 @@ static int dax_kmem_range(struct dev_dax *dev_dax, int i, struct range *r)
 		r->end = range->end;
 		return -ENOSPC;
 	}
+
+	if (truncated && (r->start != range->start || r->end != range->end))
+		*truncated = (r->start - range->start) + (range->end - r->end);
 	return 0;
 }
 
@@ -75,6 +79,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	mhp_t mhp_flags;
 	int numa_node;
 	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
+	unsigned long ttl_trunc = 0;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -97,7 +102,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
+		rc = dax_kmem_range(dev_dax, i, &range, NULL);
 		if (rc) {
 			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
 					i, range.start, range.end);
@@ -130,8 +135,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct resource *res;
 		struct range range;
+		unsigned long truncated = 0;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
+		rc = dax_kmem_range(dev_dax, i, &range, &truncated);
 		if (rc)
 			continue;
 
@@ -180,8 +186,12 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 				continue;
 			goto err_request_mem;
 		}
+
+		ttl_trunc += truncated;
 		mapped++;
 	}
+	if (ttl_trunc)
+		dev_warn(dev, "dax region truncated %ld bytes - alignment\n", ttl_trunc);
 
 	dev_set_drvdata(dev, data);
 
@@ -216,7 +226,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		struct range range;
 		int rc;
 
-		rc = dax_kmem_range(dev_dax, i, &range);
+		rc = dax_kmem_range(dev_dax, i, &range, NULL);
 		if (rc)
 			continue;
 
-- 
2.48.1

