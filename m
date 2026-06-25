Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26273D8907
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386892; cv=none; b=afaSK9GkgZ1ekxxkONxCrfgXgLQrqiasycQs7jv6VtqGjEdlIrBO8pgIVaEC/OcOBrC65Rz91d9+NnmFp1PrUuJyutMr6RAn+nVwqo8F5fC7Mw+3Y+bLV1B8OZz9b38mdW2mKW0EtyOnIN9OphSS0frfFkOroCC657kxZfnyrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386892; c=relaxed/simple;
	bh=OteijnKs0num+zDRh9t2C544jz22W8cp2mrKG4MKkHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nllf1/E2VVaBFj1zIqiLqKYz4C22d1C6kdAa16zsfJw1tdUszT5fQqO+O/1xBynuKaTjo9mLf9d5BUJVqe4swZB5i6CN3cvbj/9SctXSSWdJmjoU1u7K2ttHCpFLXuC2bGs3/4dIAMoGXlwxbStEPk3b8B2sOk/WdXJLPEPM9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qn7Dt6EO; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qn7Dt6EO"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30b9e755555so4750617eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jun 2026 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782386890; x=1782991690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQEDHJUViVdb9753oFFV6MIPPi66FApbDzURQmPDm4o=;
        b=qn7Dt6EOSyd23nTaI3pH4uZzbyXngDPJ9frPCAIuownQOn28fQ9/XXVmdGWyptmsDl
         1j9DzkKS0ZEbOgXUnfq+YpOzZWa1c8kgxE8BioNK/q+bFgvwZw1sIFBR1hBECOzGDYoP
         fiO8NRWtpNz1TqDMpqtwQMjAhg4zj/m2O+tfgyuGR/G8/aYz/7H6SKefjmBhALvRJcgW
         LC5s3uCRYwhuloRIb40wcX8LkuMr/QTO/VO8d7PWvUXy/8Z/VfSYzFv840MrP9T0Hm4k
         qQmohBDeMl04ZP6b7Gk42avK2aiN1gDsXGXR7Arc5QZsGCEmvMwF8lbFuPdkI3eLhQZN
         W8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782386890; x=1782991690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQEDHJUViVdb9753oFFV6MIPPi66FApbDzURQmPDm4o=;
        b=euPspFZhJC2MrQsYiIKMMgFi0F20PaCvP7Q8R4At0jZqb5KLnLCEdV0WPUIvspfeQQ
         pX4I6FUakrhVUA6VNz716kbqmRhemsFoC5KAjPwzAmtZlyCvA8V6kirzlHsj6yNCZeA/
         eRWxiwPOgmgYmgHL+ZsTuvA45pSKTe1mA2o0fLBqVbpmsOKJpRAT8nKzUPdokujnRFak
         cDcyI7qqz24hH4sLfVOrqdhT2V777lI9jNkOx31AjaUJosJjanzOewUd0B6XdE++exnK
         P9QL23zAkiJFuB6/SMPL6r8RgFA+pgJ2JvgDhIq0MWBfIR3c2BkmJgTwTZS84hSoeL2h
         U7ag==
X-Gm-Message-State: AOJu0Yy5i1lhcwWI4ImvoC/f50EsiRypXETnWofDDqAYePsW+8a5AHj5
	BPYsOWqnzCYksGKz9fneZwO1gcVwrcLxOGnFi0UOFGNWJsxm3NEKubKFHN3CPA==
X-Gm-Gg: AfdE7cnXlwBGLP1ic32c9sqsL6c2uZQliSn5I2UVZFTxTMtlJxmvah91X5nsu9zC/Qx
	GSYoL1Ew2EefhcwfMcFBG37/D51v0HYz50Mu7o5vYwBZy550NQQCC5eiYLu3GZA9AAfpM2wJciT
	fjpIiTP7FtjsP5D5JCdiVAzIRsatW2r0ZFq9Bsw+wvDq4rP/OI3j3ikmiH1ysa/KIVBgmeAKDBo
	zMlk22voRGxYWaHbUZNHrcnARbb+xDJZR0jF3XNdIL28dzqbUYNwlJu7gG8HDYwU7IwcVGvZ4uz
	2g+CcC5pNMtetlZwDJ0DEKgtKwRgDGeqO097VHrW2guVZC+XgCqUv3tXozaEew2qhExVz5fLNwd
	jRni2cfNFOM2WqYpSz35rXJ78DWWxrTLlQ6cDe46sGAv7umHhkrPDqGnlfFTUg4M7SxCLuwRSvJ
	uBTaHip7o4MUIHgzEtUfbPbpvOwIIjCTWvGvsoPLjUoAOFdKCjtC8MTPbm/3v1sa0tmXkE
X-Received: by 2002:a05:7300:e828:b0:307:91f5:9377 with SMTP id 5a478bee46e88-30c84bdd86emr2253369eec.9.1782386889800;
        Thu, 25 Jun 2026 04:28:09 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab08c2sm8744614eec.29.2026.06.25.04.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:28:09 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@Groves.net>,
	Gregory Price <gourry@gourry.net>,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v11 04/31] cxl/core: Enforce partition order/simplify partition calls
Date: Thu, 25 Jun 2026 04:04:41 -0700
Message-ID: <20260625112638.550691-5-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625112638.550691-1-anisa.su@samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
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

---
Changes:

1. Use info->part[i] for verifying partitions are in expected order,
   not cxlds->part[i]. cxlds->part[] is populated in the loop following
   this check.
---
 drivers/cxl/core/hdm.c    | 11 ++++++++++-
 drivers/cxl/core/memdev.c | 32 +++++++++-----------------------
 drivers/cxl/cxlmem.h      |  9 +++------
 drivers/cxl/mem.c         |  2 +-
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7f63b86887f4..54b6848928a9 100644
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
+		if (info->part[i].mode < info->part[i-1].mode) {
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
index b29fb16725b4..afc195d8c090 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -388,14 +388,11 @@ struct cxl_security_state {
 
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

