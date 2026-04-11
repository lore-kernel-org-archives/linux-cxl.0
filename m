Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C97255F52
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871635; cv=none; b=iyDhW50CN6QlUqYrgzm7GGNtlDyOmkQsxsLmeaY3rJRP/kK61/gqQsm1sndkiVe2D7hGbrEG5f4/evDwkm6/GI55nN8GqN6LVzmsuzY6x/VOm1mTUsJzeWoag80s5k+xsUfYGh4y/8dM8bqj497DVYFJ0SEFjZXZiKguJ6LUoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871635; c=relaxed/simple;
	bh=DOka2cdwA6oiyIX1rOThEcasAtyiBfM7eR4a04GcIbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHaZaQJ9FpkF7oSFxBZ8qLpGCyIRgQSXLGxmai3orpwRrjXhZ65paDa/x/LvxEi5QqKIPNy7bjtmZMLvMCRTXIX3wdhA4FTERBXzwntBT2e/Zhybqrvde3+USDFLKCJUcrfI7tUuvn8jhMPSaSFF58ar0yDA5su79g773/DBItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIcCaVr3; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIcCaVr3"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6507a9303fbso2844540d50.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871633; x=1776476433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+cCT37X4GaH8FrvlWpMRZq+NtSZl+LWd3Hrkr0lBKo=;
        b=SIcCaVr3kZQjTLbFWgrBIlRefaOyf/9RYojfAMcm1bGkU8aRCsJkKtyphVYd6F6Xtp
         EufdaSV9adwvfRa32nycxgEG2IUA8nnF3M/l1dx0HTUMnsIWIpa/vnfm6iwV9Y/6d9Zq
         b63IOIdLLuHf2DxcC8qSubCX0T4Om6achFG06ZpwZovIlxkz41emSNw/VJWlZ3OMtDMC
         TPaaOG7cYaS++QUQS9oxorPxGR91BJjkiQ/7ACpC/ikhS0rKPJ4hCfGU7WYrn6DnGu05
         Gw7T+9xMun7KGWXIGdWTbCtvm0VX7MNnlwK2bCu3lsbWzl1bb5Fmj31om7oEWN5Uswez
         6enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871633; x=1776476433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U+cCT37X4GaH8FrvlWpMRZq+NtSZl+LWd3Hrkr0lBKo=;
        b=h+4U4odOSrVuFu6G5dUJbAHvH3e1Y6AMtB2TNvGY1fjVo67+e9xPxJZi4mthnzuTHX
         Gpb4NvaPqlSkUBMj0PX05WbShJwDfE5V6XpvlZdAqrqYEAHJQ7SV3wm5lNegqgehv9B1
         8IfQvADvM0hhdSWV54a67Yz3qRGOE0uNIUgZDV8ycEYqWCDctwlx99AP0F/umbGBtWPf
         AaEe+c8g6TA6SKyYlpx372690qrt1m2QPZh6SeYGunFD1OyAWz0D1pQhCV6/fYbIm2U/
         EWwG6YZ8BQ+Wlwma27sL+fPGqRDRocWQuDi/4jalyd7CQ+V9qXCVfsEFOBdjBfXeAJkG
         cryg==
X-Gm-Message-State: AOJu0YyGkBcxQtFagMq2kgVZHCDJvlEvLqrfDP0T+PREwVjNJedlkOh8
	m+rT951AE86wKyHckcmS57p24bDKeMjoPDJLYNYtGzbcVentEldHA2NzdoXP6Q==
X-Gm-Gg: AeBDievml2BBeYlWkz898fLHrzP6zQ/GMHk047sXRw7BSFr0Tp/T7RWHtNZfDSD+mVn
	62mpsNTvrtOm2oxZZ+EFn0HkLYBaNYvHEx603cEkTCE7YUIuAkGtpLpakpsHx3L4tiFyKUtFWq2
	d1jvTi8zPPeWsSXeuRqKvzpkVEQMbUFUVy+GlLaE0ruQ3vudI/lwnIdEm/5e+GjV3b5afx/o2VB
	xluJY0Ma23/zeOca52TpIcCEzeRqKZKE5oEAGmqFWvK44UxQRc7FYgkedXWx3WBr0rT9Ft4r3c0
	sl9DFI5FF7R6oYuefWGvQ/nWHNlRyLE9JrCqiOzrPtkynEkhEDq1BfL/ATiH/MUqrInfeWwt+DG
	90z/mByDnVpE8pW+kE1wdmwSYvQswySv6lCLH7nF18+aWwR0oJGFKdlLuIURH6256KzYq2EZCom
	hqAVeQyAEOtWYa5IETBMs7EwiDoZjt+jeulAbwiTs3Ig==
X-Received: by 2002:a05:690c:397:b0:79a:2f38:9a8c with SMTP id 00721157ae682-7af6f9096d8mr54354557b3.15.1775871632613;
        Fri, 10 Apr 2026 18:40:32 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:32 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 04/20] cxl/core: Enforce partition order/simplify partition calls
Date: Fri, 10 Apr 2026 18:22:59 -0700
Message-ID: <20260411013958.47422-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ira Weiny <ira.weiny@intel.com>

Device partitions have an implied order which is made more complex by
the addition of a dynamic partition.

Remove the ram special case information calls in favor of generic calls
with a check ahead of time to ensure the preservation of the implied
partition order.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes::
[anisa: rebase]
---
 drivers/cxl/core/hdm.c    | 11 ++++++++++-
 drivers/cxl/core/memdev.c | 32 +++++++++-----------------------
 drivers/cxl/cxlmem.h      |  9 +++------
 drivers/cxl/mem.c         |  2 +-
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28974adaab75..7a5812971f8f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -464,6 +464,7 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
 int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 {
 	struct device *dev = cxlds->dev;
+	int i;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
 
@@ -476,9 +477,17 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 		return 0;
 	}
 
+	/* Verify partitions are in expected order. */
+	for (i = 1; i < info->nr_partitions; i++) {
+		if (cxlds->part[i].mode < cxlds->part[i-1].mode) {
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
index 80e65690eb77..71602820f896 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -75,20 +75,12 @@ static ssize_t label_storage_size_show(struct device *dev,
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
@@ -101,7 +93,7 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	unsigned long long len = cxl_pmem_size(cxlds);
+	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_PMEM);
 
 	return sysfs_emit(buf, "%#llx\n", len);
 }
@@ -424,10 +416,11 @@ static struct attribute *cxl_memdev_attributes[] = {
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
@@ -438,7 +431,7 @@ static ssize_t pmem_qos_class_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	return sysfs_emit(buf, "%d\n", to_pmem_perf(cxlds)->qos_class);
+	return sysfs_emit(buf, "%d\n", part_perf(cxlds, CXL_PARTMODE_PMEM)->qos_class);
 }
 
 static struct device_attribute dev_attr_pmem_qos_class =
@@ -450,20 +443,13 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
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
@@ -499,7 +485,7 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dpa_perf *perf = to_ram_perf(cxlmd->cxlds);
+	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_RAM);
 
 	if (a == &dev_attr_ram_qos_class.attr &&
 	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
@@ -518,7 +504,7 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dpa_perf *perf = to_pmem_perf(cxlmd->cxlds);
+	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_PMEM);
 
 	if (a == &dev_attr_pmem_qos_class.attr &&
 	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 314d37ca9bdb..a933b6f5454f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -381,14 +381,11 @@ struct cxl_security_state {
 	struct kernfs_node *sanitize_node;
 };
 
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
index fcffe24dcb42..f19e08279ec7 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -114,7 +114,7 @@ static int cxl_mem_probe(struct device *dev)
 		return -ENXIO;
 	}
 
-	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
+	if (cxl_part_size(cxlds, CXL_PARTMODE_PMEM) && IS_ENABLED(CONFIG_CXL_PMEM)) {
 		rc = devm_cxl_add_nvdimm(dev, parent_port, cxlmd);
 		if (rc) {
 			if (rc == -ENODEV)
-- 
2.43.0

