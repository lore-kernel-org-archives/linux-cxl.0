Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC70318EF9
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380772; cv=none; b=uypRLOOnGCIPSodT0kays1/u8Lpacb5XPd8GxJk4Q62aMF5MZmV+p4llbvxNj6szhCv6kkzL1q/0PWvqOKkL3ltm7g6W8KSWpJ02TrMasHAHXVaaMApE7jTLl8aurJBMJKPzHJ3wxOy2LRdGBJflpcVzFg+dDl+1e7L9MK5RrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380772; c=relaxed/simple;
	bh=IRkGW/+6U9xZlWhzp6teA03oy5t+nqHjZEeiuztKzEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYl+DAXyrTO6xe74A61owjHGZ02Z9H9iApodYhrBver1W8mihnOsbYV2ZqIUHRzHrelz2GM08QlzpPbmkajqaFmi0KdW2I463IEj3uGQnyqlZqve/coJBq+WCx/AbIJEjcXDW3qZeimQ0Wcydm8Dq83muoObvaWSlz9DKtuNIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=s9E9NNP7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="s9E9NNP7"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014e8b1615so1308341cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380764; x=1768985564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkgGAvtlp4w6GbvGEuWsv0IzEAPVl0Fov3QmaIKpKpw=;
        b=s9E9NNP7Ycan0Xem8faGK8tcnL0Ikl8JBadKBouEvjvh+jpI4YHE0y51EA/Z4ll/ys
         QQzxhqTj+q/aQf1UtL2bz6HQGR2YkvGj5axxjx4cNjkF4jyOkl4y6xitChcvoaMNYQWf
         dRNCx3+VL1lBeSEJq/pJK+xFpN85ZrmYqV/eOS9/9xLkJGjHOw+Z0munF7qbBqgW545M
         pFuf5FcXkhlFNPQg5fVXINWQ/rM2vnI0/mHexVl2R4HFIpV0OnYbedt2r00BpVONGS8Y
         /D1KBwQFbbAObqpdCky32G8KNnsPCbQERV9bWkqFtgihbOVXVThJv5C9DuVgRAM4p6Wi
         M+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380764; x=1768985564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AkgGAvtlp4w6GbvGEuWsv0IzEAPVl0Fov3QmaIKpKpw=;
        b=LKC0n8v6brznvKrBOKmHOTiZXVks9Y+6tfJyUs94SAFqSpdeWn/LAe4c+IiMxMkX/C
         F74K2PE7L93nlO5/X0oINAHDSUsSxa0hBuKgvKHMO14PMemZItdU4XSGx8s3PdmRUXZ9
         /5DHgr5rRJJ/O5nbttqzRdJRAxPt0Bitt+XrVDb9sIPEk0ILrVoI49xPTkmysdAvCdL8
         xCsJVnaU4vm5N7dlmLVe43P3CfSaDVDnPjKxkcApdeFQhexk3xZJtmrsiXzo7bIWkioS
         Yp/qkGL63vFSde+LCanF2cbDpss3ne8Zb874C5ZiRtHyR+yiYmcP/Bo7bTKG74e8Fyoa
         jNxw==
X-Gm-Message-State: AOJu0YykTSE9cgbNk7yAmlWCb8uEN0QJBtsHDvI4M/zrfunYXj1gDUI1
	2PrFpRjOCtBbK4tRqJCQspYjVS1O5u4hbm1vX4ca4tg5qLgerq5G9YR7Z7yD93ykSVI=
X-Gm-Gg: AY/fxX6RTn+Mtp/jBxOSIIhUwTao8Oz/yWvqbHKHGcoOa0548DmunuHvhfSiAW1vRSN
	7eMmk8LvWsQS+Vaj94bLRYys4mao+bmI5zv2zVyLAzB27qOLTwGr2dRROHsL6/82CCKcv8Hi42n
	8ELPdkm1PpNQX0bTbbp/WZp3I8aASAShox9NLEu6xLr2/g1zMqKD6n8tcaUaiNBfyLUNsmWQtqC
	U0Gv9SYqZzUVrHoUqvBBYddPMSNmy0SDldPlG6YVZVBsTW3mHECw4O8dwZxU5JoyaCvnWICzABR
	/kvf+ZkrVZnLG1g6yNs40y9U2deNWUikHYX2nKQHujhZ0HGCP43EoRbhv9O32YyevJSubdTE7kY
	k8gfOw7syS4nLGvqZMBXi7FDoDog/usbiwH/l8tTsF4+V6rmvcj3QHuDN8hX44/N/VH5R2HqKiz
	sb9L9NFG5Ol2v0WUPa3bIQ204lEaM5uZUV2I5TjsK66M1K2xlzrhCvb1UWVBkB2O9rmyNqf3XO1
	Ww=
X-Received: by 2002:ac8:7dc1:0:b0:4ee:ccd:7215 with SMTP id d75a77b69052e-501481206a5mr26400211cf.0.1768380764400;
        Wed, 14 Jan 2026 00:52:44 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:44 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH 6/8] dax/kmem: add online/offline helper functions
Date: Wed, 14 Jan 2026 03:51:58 -0500
Message-ID: <20260114085201.3222597-7-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114085201.3222597-1-gourry@gourry.net>
References: <20260114085201.3222597-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper functions for onlining and offlining memory ranges:

  - dax_kmem_do_online(): online memory with specified type (MMOP_ONLINE
    or MMOP_ONLINE_MOVABLE) using online_memory_range()
  - dax_kmem_do_offline(): offline memory using offline_memory()

These helpers use the memory hotplug APIs from the memory_hotplug
refactoring and will be used by the upcoming sysfs interface to allow
userspace control over memory state transitions.

No functional change as these helpers are not called yet.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 103 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 5225f2bf0b2a..30429f2d5a67 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -190,6 +190,109 @@ static int dax_kmem_do_hotremove(struct dev_dax *dev_dax,
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+/**
+ * dax_kmem_do_online - online memory blocks for dax kmem device
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ * @online_type: MMOP_ONLINE or MMOP_ONLINE_MOVABLE
+ *
+ * Onlines all ranges in the dev_dax region with the specified online type.
+ * On partial failure, previously onlined ranges are rolled back to offline.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int dax_kmem_do_online(struct dev_dax *dev_dax,
+			      struct dax_kmem_data *data, int online_type)
+{
+	int i, j, rc;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		if (!data->res[i])
+			continue;
+
+		rc = online_memory_range(range.start, range_len(&range),
+					 online_type);
+		if (rc)
+			goto rollback;
+	}
+
+	return 0;
+
+rollback:
+	/* Rollback previously onlined ranges */
+	for (j = 0; j < i; j++) {
+		struct range range;
+
+		if (dax_kmem_range(dev_dax, j, &range))
+			continue;
+
+		if (!data->res[j])
+			continue;
+
+		/* Best effort rollback - ignore failures */
+		offline_memory(range.start, range_len(&range));
+	}
+	return rc;
+}
+
+/**
+ * dax_kmem_do_offline - offline memory blocks for dax kmem device
+ * @dev_dax: the dev_dax instance
+ * @data: the dax_kmem_data structure with resource tracking
+ *
+ * Offlines all ranges in the dev_dax region.
+ * On partial failure, previously offlined ranges are rolled back to online.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int dax_kmem_do_offline(struct dev_dax *dev_dax,
+			       struct dax_kmem_data *data)
+{
+	int i, j, rc;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct range range;
+
+		rc = dax_kmem_range(dev_dax, i, &range);
+		if (rc)
+			continue;
+
+		if (!data->res[i])
+			continue;
+
+		rc = offline_memory(range.start, range_len(&range));
+		if (rc)
+			goto rollback;
+	}
+
+	return 0;
+
+rollback:
+	/*
+	 * Rollback previously offlined ranges. Use MMOP_ONLINE as a safe
+	 * default - the original online type is not tracked per-range.
+	 */
+	for (j = 0; j < i; j++) {
+		struct range range;
+
+		if (dax_kmem_range(dev_dax, j, &range))
+			continue;
+
+		if (!data->res[j])
+			continue;
+
+		/* Best effort rollback - ignore failures */
+		online_memory_range(range.start, range_len(&range), MMOP_ONLINE);
+	}
+	return rc;
+}
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
-- 
2.52.0

