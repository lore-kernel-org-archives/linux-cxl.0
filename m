Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E053ABD8F
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673066; cv=none; b=SbhMAQwpz0YEnLSbQeZ/rY/aSeZRcgT86mq+QNkPwB7aMr2peGgoTLpVAg0maN63m2ETLdBWmMMAOOftJnM6yiVx6JVWBTCrXZAcDLMgZQT3pduxWggyo7NCvkr1ts1DzwAGzMsWztOUbOk4a+eA+k4cX1V0342Hrp9C7amjoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673066; c=relaxed/simple;
	bh=O85p7dQKkoCkjAQRK1NTGmBvnoYH4SGayD20o4UpkIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9Z58UF/Q45oKGaGzKdqjsYYCKRla574l1/QvRHuQJiNmXl04xPrL+dV/QTpseqKMQprO3cAikHiDu0di3DK3dRuD0vuG5b4D72FNzuc8Xm9DDfhJtp7gX4ix4pYiWOhHNUy8OjJo/uqahC2O22Dm8HlSySPDIw4B+wEFF0L31A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkfNbGMM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkfNbGMM"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398a5aad413so367427a91.3
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791673057; x=1792277857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppxBfGCc+Is1s0EIeQ9jLa31H147Yqy45OpXxBr6feE=;
        b=DkfNbGMM0Um+ryIl650YALqyMCXVPUYc7QZJ+pWbmG79R7jwjxBgL/rWTV3aTtXWRU
         8h7WMUydV/28CFQRIrRX7OjrLr8rT52z/bM/e5RVLfR6Qhv/7mVHl8DUNLXbqEAIT1Ik
         VZjue10DNAtFBmTAqSstRCeO8aXnEgF0rpHExZ5aMIl355FR0N+FwK8nvkyh67Gy+YVy
         vf7Gv5owDDLevPJydQ44GvWXa+PQFsq4jjBVK+TWiHNFdbQG3uzs5+uTyPu3KwtLTB/m
         2/qCDPtT4CA6/32IaLh1PXKDO7PiwVtdRSh1rG990qZ6cileNooR8QljyJN1FurZ+yo9
         0aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791673057; x=1792277857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppxBfGCc+Is1s0EIeQ9jLa31H147Yqy45OpXxBr6feE=;
        b=sraIQCmDuMj8hd3mvCGlgHizAijirYHc1Uu271B0vBg0Wsk6wScEqgEGxbLdhInCmp
         9OUn/+eiMC4od+S4OgxYfGHaUXXiJoeXEjWSUs1hGLoUqwbrMhMzFvz+ZdmbGGQnFYpr
         sNMWRSTPyvx3ZF0jcvaHYsnx9i8vAfFPFNGhocJvXi8voq5Fayxw0YxF6eRgF6HIKxHR
         GJzZ5+g5DdtTBx+mW40jwexTdVCUN7F1WataYpj/HrpFkIHF4I6VYyPdh0bc+ZpZZG4J
         1J9DxxFReEsJ2gGRKlDeHPpl/o+8oU8BkeDpL3ItvyWIiHaeHeDhXTU7AdyAKYW0WIIo
         qEwg==
X-Gm-Message-State: AFq9FYIoowLkzwHBMah7rUzI9ZNLZuRFg4o1aUfA0O48X6Kr2Bsx6uQF
	ZU2F5vX6UAaXQPpGr7OwNara79WQ08ov9dgXGDY2qlOS4vy0PiCauUG/Rj6t1Q==
X-Gm-Gg: AYBFou0jwy/v01tjbxx3mLwJnMeZ+ygPNmLDhqJOeZNBwLtj/yE48rK8dhP6r+fJxsH
	yopLN9H+qPIV8/smftR2AupJeJosvJm95YT4wwsS7dIAUf+Z/SP6gj540jipTHrsw0iQhGoXGKR
	i4E25c4UjKiC8EUzmcoov1vcKbXbvLFsCQNTVsCWO0LGREm+Z1/Nas5uSl++AHPtBAesETHkk0H
	4AU6cGrBdIQ/JhDXD0TUcdW8oypgh0k1W9w+Q2re4eDfBl1IA5xVTuh4chqHrbrjOfI/TC5KVZ/
	KfqpoXRc0x/eaIkz1VijtHzGWpzXVNnWsd/QW1icoz3OAV/rj30h9vR1E4JxrZCh5DAVLkA9o+j
	5/2U+MPn9xmRzmGSjPtZZ37U/e/TYttJzusxgB2o3kTkY8QlYuITq7c9rRcie/MFrKS0T/JJ+5C
	+hRn3C1BQlNVP9ql1wrcTAn3O4e/FyMYy1gg6nIhzOAeBuf4EPZ7mSGmWC0DX/hpFPjjK6XjSGs
	Hn+QjkdXXnyT7WZv3fsfSidO5lS
X-Received: by 2002:a17:90b:568f:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-3ab3a7474d4mr5321563a91.19.1791673057510;
        Sat, 10 Oct 2026 15:57:37 -0700 (PDT)
Received: from cxlqual.. ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e07329sm2603662a12.5.2026.10.10.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:57:36 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v16 7/8] cxl/core: Enforce partition order/simplify partition calls
Date: Sun, 11 Oct 2026 07:54:58 +0900
Message-ID: <20261010225852.10727-8-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010225852.10727-1-anisa.su@samsung.com>
References: <20261010225852.10727-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <iweiny@kernel.org>

Device partitions share one flat DPA space in a fixed order: static
volatile capacity at DPA 0, static persistent capacity immediately above
it, and dynamic capacity above all static capacity.  The static pair is
mandated by CXL r4.0 8.2.10.9.2.1 "Get Partition Info", Table 8-310: the
device "shall provide this volatile capacity starting at DPA 0" and
"shall provide this persistent capacity starting at the DPA immediately
following the volatile capacity".  Dynamic capacity has no such rule.
Table 8-347 only requires the region base to be 256M aligned, so placing
it directly above static capacity is a Linux requirement,
enforced by cxl_configure_dcd().

    DPA 0                                                     end
    +---------------+---------------+---------------------------+
    |      ram      |     pmem      |       dynamic_ram_1       |
    +---------------+---------------+---------------------------+
    part[0]         part[1]         part[2]

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c    | 10 ++++++++++
 drivers/cxl/core/memdev.c | 32 +++++++++-----------------------
 drivers/cxl/cxlmem.h      | 12 ------------
 drivers/cxl/mem.c         |  2 +-
 include/cxl/cxl.h         | 20 ++++++++++++++++++++
 5 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 379540246333..ec5742debb52 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -470,6 +470,16 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 		return 0;
 	}
 
+	/* Verify partitions are in expected order. */
+	for (int i = 1; i < info->nr_partitions; i++) {
+		if (info->part[i].mode < info->part[i - 1].mode) {
+			dev_err(dev, "Partition order mismatch: %d (%s) follows %d (%s)\n",
+				i, cxl_mode_name(info->part[i].mode),
+				i - 1, cxl_mode_name(info->part[i - 1].mode));
+			return -EINVAL;
+		}
+	}
+
 	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
 
 	for (int i = 0; i < info->nr_partitions; i++) {
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 71493231f5e5..787988e92965 100644
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
index bac7e1ac715f..35268d1c387c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -412,18 +412,6 @@ struct cxl_security_state {
 
 #define CXL_MAX_DC_PARTITIONS 8
 
-static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
-{
-	/*
-	 * Static PMEM may be at partition index 0 when there is no static RAM
-	 * capacity.
-	 */
-	for (int i = 0; i < cxlds->nr_partitions; i++)
-		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
-			return resource_size(&cxlds->part[i].res);
-	return 0;
-}
-
 static inline resource_size_t cxl_part_size(struct cxl_dev_state *cxlds,
 					    enum cxl_partition_mode mode)
 {
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 728decda57fd..1c04a7823f64 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -130,6 +130,26 @@ struct cxl_dpa_perf {
 	int qos_class;
 };
 
+/*
+ * Partitions share one flat DPA space in a fixed order:
+ *
+ *   DPA 0                                                     end
+ *   +---------------+---------------+---------------------------+
+ *   |      ram      |     pmem      |       dynamic_ram_1       |
+ *   +---------------+---------------+---------------------------+
+ *     part[0]         part[1]         part[2]
+ *
+ * The static ram and pmem partition order is mandated by CXL r4.0
+ * 8.2.10.9.2.1 "Get Partition Info" (opcode 4100h), Table 8-310: volatile
+ * capacity starts at DPA 0 and persistent capacity starts at the DPA
+ * immediately following it.  A dynamic partition has no such
+ * requirement -- 8.2.10.9.9.1 "Get Dynamic Capacity Configuration"
+ * (opcode 4800h), Table 8-347, only requires the DC Region Base to be
+ * 256MB aligned -- but Linux follows that precedent and requires it to
+ * start at the DPA immediately following static capacity: after pmem,
+ * after ram on a device with no pmem, or at DPA 0 on a device with no
+ * static capacity at all.  cxl_configure_dcd() enforces it.
+ */
 enum cxl_partition_mode {
 	CXL_PARTMODE_RAM,
 	CXL_PARTMODE_PMEM,
-- 
2.43.0

