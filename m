Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F63D9DB1
	for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487815; cv=none; b=OZSjbrLgXUH5fPQcSdnM22RO1R6957Rpx2BRKsPnDZ9xppzhzUp6o1QBjE3tWALCONSMOHTZ6wInbdrnvyWwzLD5iR7w3A20S8b5F0SsMed9Pr+8pydHJPrsalXsY3Ml+Rvc5o6f3W+hdFNGerlZerHu1MclJCrW+3LMcAWO6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487815; c=relaxed/simple;
	bh=2gbuA1AjlN179ZHb25jNrxxQxfaAVzkCubGgIeg8DsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJQ/SxWRKMRGs8YSje9kkqWrO6jlSdQGIlfcDqQX7IO6iIO/dDVLxK3AKCyv+csUfVKmMbtbDM+e9p6BE7CJ8SaAdvx/EyUmcBwTC97Irw9cDIhi9/3aWePnX/U7nzDmFo30U2D/LcpAncIfwbIlKmsP4CwX0jqJqE3owUXvVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjEgWDmg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjEgWDmg"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cc61541f8cso18829415ad.0
        for <linux-cxl@vger.kernel.org>; Fri, 31 Jul 2026 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785487812; x=1786092612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8WEQGrgrO2scS8Gd9nnQU/D+8yl6XUvFmWxuOwntXk=;
        b=DjEgWDmg1HNXGCGm+y8hORXMNoW5FHf6n79jtYO6JQVIEmekXkEMCZAiyTNTcp5Nkf
         xdzDZwrxeBalReUJqTxjH7PfUuM4lWWfh0gA+5d5KQlD7tvcHoJuymLBxhgjqPBkUMKG
         bn1vlG0FGpfFkQB2mf4Ymnii5iwToUN6S2z9sUf4rnkJQ+eX8BZChzxiGPdp8HIs+79U
         5vLUkOvN5eLZtqoBSvkRZUw99k6u4nx1QU5yK1ux/Ecai8S96WAgas/9E3un4BRi6o5n
         4H7io+7GvhMh9IQgs+vMaIiSKD72s3poC2WWXASbXkoOJV7jF0n0zg0jJy/2OXgX6vPe
         pucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487812; x=1786092612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8WEQGrgrO2scS8Gd9nnQU/D+8yl6XUvFmWxuOwntXk=;
        b=EOVL47GJrJxLK8ieVX3KkksK45j49lmGf1z3agP1FHiyLY9P1EXVyzWN9DJ6LqX1PN
         B1nJwbK+SJ/QutpiBODXue+Hw0UsY6VGjTcCvG6Ke/wyHzBcavYvdcmBqSju9GksdpjK
         eaAfkryQvd9E1yvqKHd1GWkXUOmrG4MZw0HfMQ4L/fQssgMRWcNCXHxp5nRdCelHrfgG
         eBJO9XqpdpcMksvFsP96MmW+gGHOSdMYkOvGWlZg3vKfm4worPdUdCUuO19/7oM8dwv2
         Cm+ZEpvflWmWLG2y0Chz4nQEo9MXb+zxrTeHXaCGG7v1vox/iCu/y1D1GaU/QqInwY1O
         +BIQ==
X-Gm-Message-State: AOJu0YxKTK8hw2VAN4RTjJh+RxcYqLgi7rLOQgHwjPmDNYfqMfwOFVtp
	ptw5Zjsq4pMyOoNXaU3bAjtaFHgUJQlyXOjhuuvmT+EcPrEp7jqBYL2Y39o4kQ==
X-Gm-Gg: AR+sD12AMDZ3TBbZmkzhFmB9BGoR4AjIUHvy0B13DFAfQfgVBrvBxEs9BheZ33tELKs
	gMR/HHdUkGbAlTNZnTNGRFlmu7H3y63XmX3JHeSnDLDhI3nBuap531d/V32V2NWwWtZjT8f7ep3
	8qiHmJCVsgVlzul5kFu4w7jA2rCfzI0XQoQJ32wDuDZtITayb70mJi5X4VRFGY5eJkoAtBr611b
	rIvZkxQvwAvWuCeerwGY0ZV7hgnulmBt2fwhl9cWSzWQaA6xzpEqU6Mn66G6mlBTYkQgPGJx5qb
	aEUGIbPllXFW1IqTlIovIbrXjfTGuzbF3AnPufgn4Mb0kH/icVXzWJG5+lFB7ZzFzv3tHV8/Dxe
	8ew2B7p5IYbMbuS3ViltfjunbhmoejlJyi2Go0y2OtPR5+CQ2U4BpLl+RoUoiypjAiuwuqrpSUq
	2OM/olb0k2xxbeUyCVHZuz9k35b06OxvOktpXNix+bOhl0PLh52+4hrhpiD9oaWRRU0ISAtGe3B
	F/ounh3U06xb937vzfDubzo2TFH+0L8hy9vb1QDAh3v
X-Received: by 2002:a17:903:1786:b0:2cf:70d2:da7c with SMTP id d9443c01a7336-2d047d7921fmr9860715ad.12.1785487811786;
        Fri, 31 Jul 2026 01:50:11 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5abaesm2708425ad.27.2026.07.31.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 01:50:11 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v12 8/8] cxl/core: Enforce partition order/simplify partition calls
Date: Fri, 31 Jul 2026 01:48:13 -0700
Message-ID: <20260731084901.1512819-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731084901.1512819-1-anisa.su@samsung.com>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Device partitions have an implied order which is made more complex by
the addition of a dynamic partition

Remove the ram special case information calls in favor of generic calls
with a check ahead of time to ensure the preservation of the implied
partition order.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c    | 11 ++++++++++-
 drivers/cxl/core/memdev.c | 32 +++++++++-----------------------
 drivers/cxl/cxlmem.h      |  9 +++------
 drivers/cxl/mem.c         |  2 +-
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7f63b86887f4..d87dfbcac6a5 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -457,6 +457,7 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 {
 	struct device *dev = cxlds->dev;
+	int i;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
 
@@ -469,9 +470,17 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 		return 0;
 	}
 
+	/* Verify partitions are in expected order. */
+	for (i = 1; i < info->nr_partitions; i++) {
+		if (info->part[i].mode < info->part[i - 1].mode) {
+			dev_err(dev, "Partition order mismatch\n");
+			return -EINVAL;
+		}
+	}
+
 	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
 
-	for (int i = 0; i < info->nr_partitions; i++) {
+	for (i = 0; i < info->nr_partitions; i++) {
 		const struct cxl_dpa_part_info *part = &info->part[i];
 		int rc;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1565a5cf0f32..136443bffcb8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -77,20 +77,12 @@ static ssize_t label_storage_size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(label_storage_size);
 
-static resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
-{
-	/* Static RAM is only expected at partition 0. */
-	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
-		return 0;
-	return resource_size(&cxlds->part[0].res);
-}
-
 static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	unsigned long long len = cxl_ram_size(cxlds);
+	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_RAM);
 
 	return sysfs_emit(buf, "%#llx\n", len);
 }
@@ -103,7 +95,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	unsigned long long len = cxl_pmem_size(cxlds);
+	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_PMEM);
 
 	return sysfs_emit(buf, "%#llx\n", len);
 }
@@ -426,10 +418,11 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
-static struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
+static struct cxl_dpa_perf *part_perf(struct cxl_dev_state *cxlds,
+				      enum cxl_partition_mode mode)
 {
 	for (int i = 0; i < cxlds->nr_partitions; i++)
-		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
+		if (cxlds->part[i].mode == mode)
 			return &cxlds->part[i].perf;
 	return NULL;
 }
@@ -440,7 +433,7 @@ static ssize_t pmem_qos_class_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
+	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_PMEM)->qos_class);
 }
 
 static struct device_attribute dev_attr_pmem_qos_class =
@@ -452,20 +445,13 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
 	NULL,
 };
 
-static struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
-{
-	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
-		return NULL;
-	return &cxlds->part[0].perf;
-}
-
 static ssize_t ram_qos_class_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	return sysfs_emit(buf, "%d\n", to_ram_perf(cxlds)->qos_class);
+	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_RAM)->qos_class);
 }
 
 static struct device_attribute dev_attr_ram_qos_class =
@@ -501,7 +487,7 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
+	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_RAM);
 
 	if (a == &dev_attr_ram_qos_class.attr &&
 	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
@@ -520,7 +506,7 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
+	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_PMEM);
 
 	if (a == &dev_attr_pmem_qos_class.attr &&
 	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 666e01326dae..77f6417a1de7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -412,14 +412,11 @@ struct cxl_security_state {
 
 #define CXL_MAX_DC_PARTITIONS 8
 
-static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
+static inline resource_size_t cxl_part_size(struct cxl_dev_state *cxlds,
+					    enum cxl_partition_mode mode)
 {
-	/*
-	 * Static PMEM may be at partition index 0 when there is no static RAM
-	 * capacity.
-	 */
 	for (int i = 0; i < cxlds->nr_partitions; i++)
-		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
+		if (cxlds->part[i].mode == mode)
 			return resource_size(&cxlds->part[i].res);
 	return 0;
 }
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..9c4ef401cbad 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -139,7 +139,7 @@ static int cxl_mem_probe(struct device *dev)
 		return -ENXIO;
 	}
 
-	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
+	if (cxl_part_size(cxlds, CXL_PARTMODE_PMEM) && IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = devm_cxl_add_nvdimm(dev, parent_port, cxlmd);
 		if (rc) {
 			if (rc == -ENODEV)
-- 
2.43.0

