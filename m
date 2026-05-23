Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FA386C31
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529426; cv=none; b=AykHkYgz3izQhyqL2ugsOFmhMM+j9Js0+VdfDZAJ3etSYvfSbDKbRSqTbdB1GMfMJxrIA92JMyI3HjZM4W0TrSSSm9utJCYoiCFyXZrtwQ0LX6QGocPnswykuds7utKQ+Ii/E3vNcA2XIY9v1xOOoBhyIGqcNQ37lHcAaRac1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529426; c=relaxed/simple;
	bh=mimTWYFTaHY+FLSmEscwRLS2qecNH3JETIBfD4afc9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+n1thxybUoj6K7tM6+WB/ubs727ag89Rw8ostEKq4HyHMPnLQShM6hrLh2meg7J7X0Q84zRURUq603MwRr8Cg/zkjVpDTr+qve3nzSVmgJRYOBoP/GWDtWH+hsmA2DYJ+9QUjING+XZZiIQnv1du6YBo1OO19Y+YLwIW47IzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyLJGjlN; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyLJGjlN"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-135e7f4a295so2841067c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529424; x=1780134224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snhhVzpNXLnSXNel0j3XIF8QPv37i0IqA2Elwz6NcMg=;
        b=JyLJGjlN9X1A6O8HY253x6SRS7KuoeOyc/Hj7DrMbsHappKVNozN4SyMKsYfCEUXuu
         /GXO67ZFG/HphCHoxfl0itJ2O5TEdt722iw8V9/GRt3IXywMDUjW0P1IqfLkXRZYPlnd
         uo9TVdyaoRCLxVBNLjW0N38uBsldANdCP6UlXIo0HOH/Gx6e8IwppfkoZVWtaM0YK1Yv
         9gR5dIEnAvMNCLs5LMcPDYXuZPywMQKzikH8AU2LkXB8pZgqqEmyL8SUCqzRp2ZzkMSw
         xJMbR/CwPIiyptlb9VN9UrGZK+smI28Y1Iat7jvbBCjEeYfJ0iF1V83Y+v9i2dqUKjun
         SeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529424; x=1780134224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snhhVzpNXLnSXNel0j3XIF8QPv37i0IqA2Elwz6NcMg=;
        b=TBEk0b5Kesz4wPMxaLsGoskDAk7ViURzamW6qmbbsiDrUK6kyzv7XeYISEFJ88z5mK
         4iaJ99cqSvDp+zzLEkTgpQfdBijRq38tYgq5+lOCA7GUks8xRNx79J2fPDY0CfqHBrsx
         tPMt6mRx9lNSWwizCkEHFuVUpnlJVpULYlRXcotTOMSVkhVMcPuaZ6YJNF2CxUnz167H
         sndP7e8R/WTPvzdKlxz4N+i+zXfmRdhcHfHCZnMcZjDeZZQNlwGOnvSuS0qy2QW6tK6v
         WjtjCrxdedqFAxxM2MdjjXIkebOiDs6QknrERuNSwJihStFjXMav721oYeGhsd75J2H9
         McsA==
X-Gm-Message-State: AOJu0Yw3VXYvbmP4KEM9CLmz9xCtzGOmdWDlEuXEkdv9aSVppomqm2JP
	b5x0PhQXRyqmiOgqAy76b+CWvEeXSgUq3NVOsCxO2fwbiBmNPv5aqWWHGx+zMA==
X-Gm-Gg: Acq92OFBo7vlMkyjmNgA5vRmpqV0iXuwrCYyoKSg3QNh4egkaQYrfoAbBGx+ctyMUjM
	RVcPgLQqSqx0uelI08Wup9FpN470AkAzkbSAygR46NPzZv7xni7JsuOzSPfIL89uDGyCnKVwyap
	7QBfqvsfoHEioMJxurIAiZl2lDN/8Xkq22FtpFge6BJIOcyzxuTnNPtAJvPgTwj0KTjKNzbwxAw
	Lq1SjZB6mMhL1ENTkAxHc1qnitBWAelilGcVrQcS7WecuqTWuW+zgC37C75oMXLZGESwnqta9sX
	RIdj2iJi/vOnRtwSvPW72M3AmrtmGCJ2IPUg7dHRh1ILgB6Z4ciXzMocedyXn/GVSZUd+PlSDPl
	FAWVKKkZVg/SiHUeZfTgn9kK64gXbULqC32RXx4ZP9rUCzrEp9P4Q0H8RDhByBJWlumVm0csbL+
	zkAIcOz2veRwLGrC8robXQaadshiBqfUqAJGo2+S8oHkcb1iI8UF4gT+6C+t59N1HYqBI9a2cpu
	fNToYM=
X-Received: by 2002:a05:7022:609c:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-13633eb60b4mr3619709c88.16.1779529424123;
        Sat, 23 May 2026 02:43:44 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:43 -0700 (PDT)
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
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v10 04/31] cxl/core: Enforce partition order/simplify partition calls
Date: Sat, 23 May 2026 02:42:58 -0700
Message-ID: <22ae445b8a99d26299520e2429c5bf4e64b0d9e6.1779528761.git.anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779528761.git.anisa.su@samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
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
[davidlohr: core/hdm.c: return -EINVAL instead of 0 in cxl_dpa_setup
if partitions are out of order]
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
index cee936fb3d03..10175ca3b7ee 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -383,14 +383,11 @@ struct cxl_security_state {
 
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

