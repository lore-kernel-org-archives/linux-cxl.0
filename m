Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABB46EC79
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763507; cv=none; b=WVF9HFimyEHLJ9yfzF6Yi86VcVunpSfCZJ+dlSEYKeDxqmjTqVzO5DpQlvepQ6xSqXBAI/Gd+1j73JTiyHFXQOpAN9Z0scJlTHGdr6I7NLoKw/k/lHlAT+xykqbPyc0fuH9e+j2szRhXcmnxOi+uEZBCQ89mwYEHZd/VdRIdDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763507; c=relaxed/simple;
	bh=XdueDwYDcU599VgjC/rtycrxkks3mj2wbEfxpVuUVcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRyXUBrHpjj7VOZxd3/R3Qe9Lkbrvlyl2HdDJ8TNrYKsezpSc1UrNAW37ASqIIAjqwY4/gPva5mbiN/P5kPOspflpgb9rwwTPVG3SDlcND7VGgAKm0QBcuXt3jJL3D69i77h70L7H4OcbKTYsOaxxsA9BXuaRH4z3ZzibYmFuNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blR2gkbJ; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blR2gkbJ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso1142487d50.3
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763502; x=1790368302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xux6lizz/uoOxtP3BKbcr+QEtJmQmatXa85EK8Ifbb0=;
        b=blR2gkbJ3EdX0cv+sYe7iGPkBiVtd1UvDsv1HV6+E76nesADBWYMJFp3+dcdowrFOg
         8tnrHxXAHIok7Q8Yp42IrPqY2n+QagbIe5lv3AzbtNm0JIgm46DguRoFGe1TNolmGgDd
         QZwVzm5HbqiJZBZgODrBNoSc5fTQfO5/riuxzN8c2W10TEpUd14Zkp0w1JB0cYaxI3Ec
         v5FX2zHh5pZRJUnVW9jitlT8cJfBC4aqfYBu1ulWtXhnhDnMJ+DkLjek9BTT0nGoo68c
         Db6jcX+gYr3etyRc4XTXOdSrnml0CnJxiG7cPEjbCa9NbEhIoZSaZbMM+RJdgEztvQxl
         jjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763502; x=1790368302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xux6lizz/uoOxtP3BKbcr+QEtJmQmatXa85EK8Ifbb0=;
        b=OdaUsJI3lTxIGdj4aoTGrjX0UTdXZ8IVlb/pUijy6Mgu22Yr6s9AfAgCg2OQnvw9M9
         0dQCuY+vh+GEk/GkZ4tYc6c9dlaUKn9T5nq0T2mGKzxf99cyhQhFD1bt1rZetguFMtzZ
         NU/DdyXXiGVi9/Iry787Oi3c/Z59bZMnw+Kqp/XztvWOP+sPUedvjSEWp5Hpz2AmBfHa
         wItbw7IVENL/x1UbOJJc7CbJKlmnTGvsWSFNBjt8ikzP/RmvGlytxhcJJom/LBij3rz9
         SaxwA8qn2Yt3WZca86gVnzVq6t/m+TmxfFai3P43g6BhduyqTaX7LCXRjhrbqzHZHveh
         4pfA==
X-Gm-Message-State: AFuF++nO9wKyeJVhrERRcsQ7k3HzYmcr+fqHZoPl2xS09A+ddezEZQGb
	BqAeFDO1fHLv+7lAGxUjFI/Q4TtEwkrE8IwnckUfA+PPrnn/6dpfrg19f/UYJw==
X-Gm-Gg: AYBFou0qfhh3XViI1E/To0Pdr+MOyJX78s+4X6jx/EP2/2gcHW988Q8rL8Ar6cF4Vp7
	rNvKyBnjuHceLgxKb5xun6vwyhUKFTLvxqRcAZg0zqGHTR9Z34xZhFRiLAigrm1Cw37XfJpoPhK
	Ysj3u8Pi2b4K1lb0LMvXh45h845cg1enWYWtrr5Hr1P2zWWcRubEXR/UhojsSNyCbe58zywY+V7
	oxTsz6M1ZDuoO5kB/lhLs12fhuLkkxuLgDDdJIMqoom4U0Lpv13mK08F9NLCiKGeDVGjeoZbLx5
	+VIdT4ogMJOLvsJqbiNuLHNFYwnMW+H8Ef5tYxDp/HJUEd4kF1Q3lIpPQ+Ojg0RwpGGrU7ivXq8
	cEqZc8d43iSakmiKeD9YhIqabVUbkEE/dKN6b3P5gyirO/VRKne7GZjTVQMMdyTqsH5OAOFAqFL
	DHx36WDDzazaVl5R699LehYAnXpWPC/fJvBEDGRT9Xus8wKteH5TtiTg/gsiBcJLu6+58PfBrsW
	S5lyl0LeGNJAbpCwTLyuAcMC3MELCw6MzFtT4GEDlnfnABVGMQ=
X-Received: by 2002:a05:690e:e82:b0:671:38c0:d2bb with SMTP id 956f58d0204a3-6717fc67453mr1196445d50.13.1789763501820;
        Fri, 18 Sep 2026 13:31:41 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:41 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: [PATCH v14 7/8] cxl/core: Enforce partition order/simplify partition calls
Date: Fri, 18 Sep 2026 13:30:16 -0700
Message-ID: <20260918203049.7273-8-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918203049.7273-1-anisa.su@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
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
 drivers/cxl/cxlmem.h      |  9 +++------
 drivers/cxl/mem.c         |  2 +-
 include/cxl/cxl.h         | 20 ++++++++++++++++++++
 5 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7f63b86887f4..18e9dfa115fb 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -469,6 +469,16 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
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
index 8883c8850759..88339e393054 100644
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
index 9106affd7c81..35268d1c387c 100644
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 43edcde5bce3..b6895302a6ee 100644
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

