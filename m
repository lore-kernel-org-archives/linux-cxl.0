Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86D50EC07
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862948; cv=none; b=uDAuBEfjHWpPlV6HJEbc+efWgPO9YYE/XU0yunEHDu7Ut5LVtsfSB72/3fkKwqxFydxYpI4Rf1t+kZBGOImi10J83M18msRRGnr5iQtKj9eeJO5uZRcgAT7Q9lsweS9CP/EvT3hRWXvrcv+xJxOmEJYdv2rT0JnqTP8mCXS6jH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862948; c=relaxed/simple;
	bh=vM6XOP/2kT7XTO4pcC/jfJDZM3SYQWL1rFcFE7vbNzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcfdFVVK11JK8sf3jaNNuDEfUq1OEiNCjUOI0sWy28AzKgtB0YmDbzHwnMoBvYjQzDH9rxhkFEM4Y6G0fPUdBjfBbZtDkMYNhoJuVkx8jFB2h/oIv9xt2IogSd+O2Zp7LtqjDqphOrCd4C3HH5SxNhU5syW/YeEz4UJD3D+I7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFl2lMue; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFl2lMue"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caced6038eso40142525ad.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862946; x=1789467746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+0GrycW8zeSxhP/eUxYzvJNNrXQOWsR91Ktt2keJeM=;
        b=XFl2lMue4635mBDBVMio37V+6SyBfTjNxFTc98xsTBTCV2ExuBJveJL2Nl/q5WQdCH
         zlkHGqO5Kihyx2BY9GZi47jw47yVdjTxw0qoC44buI1sop93n18mHCd4yK+Ym9ivSLid
         bNaOmtnB4Y1rJmAJPZlSfC6bsdEbet1XW8GKBGG0+fjXDHrlh1jA8U/3MijvdjX9kmjU
         A1hdplNb0VGaN0jtw+l5HWSbjoN7BBK+hoCt+JWaHGWJeNtSo1yFpGn6Cry7Nl2gKilA
         qjRBY24cArrTBuZBASjZN3UbJTe+v2fZSKJqgAc+jxsO0IvVFCQov9BY4ew6LtazTpVm
         PhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862946; x=1789467746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+0GrycW8zeSxhP/eUxYzvJNNrXQOWsR91Ktt2keJeM=;
        b=W3ca0enHWi4qEMX5SQy/TIjP/aPgnsAf+l/ktNOm41cjqGzj2ym8wz2Ydhrj0uGg74
         esJWY2tMjKhrYghaY21Qbn4Z0MNcXfoKN78NSMlm2Bzb6KOIhkxJC4a3aD5Y3AuM/gJz
         FAOnQGRNhrWcbLT6ZrZOH9bWFjje5vK3BaasBou6t+R11J+ostXGRfE9R1vlcOjCFzFJ
         n1Lh1Ig1TpfusPYznPinCM/yoWA/Ax6lN2P4/HEMSU28jwJyrEvzCGexG/GPtjxO+ybo
         HohJaRCnoy6rNsiEIknk9T/VNxZUon8J3vpLIihws3Gndbp8dwj3cqdQ5gRQqQhuqbJI
         rgJw==
X-Gm-Message-State: AFuF++nc2ZRFC9LzhWeaFzsclMOB83A6QrzgL5i2WFzLVaFw6TfNmv/q
	7B2YnoSZ2gXh5Uo7AVZZfXHRZv1Sg5SD07H/quG40163tgmJ9oBiIimHgCINLA==
X-Gm-Gg: AYBFou2OKMlpywfO8l7OpddKUWUsPCK8O87o1UpDXiiRqCYdMYiFSGl0tcWjO10N/KS
	hflZ9lmN0KksIGMK9e1YDPYSvw5R8q0BJ//GLt5vetAg/w9hApt53Pf7xogGYKd9vd5CIXIYCY6
	sc12FeZ9kmCX/2aXAovZ8lYmGgEVucUnP7GHsPxJdNrlzxIbCfO9fk9oD8+CW+F/JCqqxi81PJh
	F7exJ1dTwCywdua9LEQ3itv107D07dUhHk50I+3rTQKKvb4QdegppolnNUkIBYaz4rD3uB9wmEq
	h6alOYqYDHBt1PAvYpXwjCB55IkhUDxt/G61XjvF2duzQHZDOzwaKTeCykH+/RkhO0s66knYc+Y
	LZKfQlyGf0rrszm3sMcs8upbcnPqNwNnbisG8H9+ZHhiDjoEW76AW3TYBe3/ictaNVwxJGdq2Ua
	YVyRrRrwsfdDrhEuq9Q5MSyyifEqGCsLiwd/Vgv+kKIZIrM6BJvq11xoQcgEq26jV3kZwzkK21k
	m9RToomb6FFfybWBXclO/IkyCV43hgRC7d5/5rvnKKs3XcXbfn8tObFl/cVTDD7GWxlCtcGPGCD
X-Received: by 2002:a17:903:1247:b0:2d8:d4d2:d137 with SMTP id d9443c01a7336-2dafb136bd7mr292747335ad.19.1788862945854;
        Tue, 08 Sep 2026 03:22:25 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:25 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com,
	jic23@kernel.org,
	dave.jiang@intel.com,
	gourry@gourry.net,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	vishal.l.verma@intel.com,
	dave@stgolabs.net,
	benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>,
	Anisa Su <anisa.su@samsung.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH v13 7/8] cxl/core: Enforce partition order/simplify partition calls
Date: Tue,  8 Sep 2026 03:15:11 -0700
Message-ID: <20260908102124.2231730-9-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908102124.2231730-2-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
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
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---
Changes:
1. cxl.h: document the DPA partition layout above enum
   cxl_partition_mode with ascii art, and cite where the order comes
   from: the static ram and pmem order is mandated by CXL r4.0
   8.2.10.9.2.1 Table 8-310, while a dynamic partition has no such
   requirement -- 8.2.10.9.9.1 Table 8-347 only requires the DC Region
   Base to be 256MB aligned -- so following pmem is a Linux choice that
   cxl_configure_dcd() enforces. Reported by Alison Schofield.

2. Commit message: explain what the partition order is, where it comes
   from, and that this patch starts enforcing it. The previous text
   named an "implied partition order" without saying what it implied.
   Reported by Alison Schofield.
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
index 4a5793fa3cbf..5297fa20c8b0 100644
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

