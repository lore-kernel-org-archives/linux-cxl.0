Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F902BEFF1
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794171; cv=none; b=HhxcaW4NCTjUGcnOBrxvHXHSAOyr+fa6AlCEbeUAHLNx/1Py7TVnJXtxFepSLBWGI87g6rPtUmziKVtyso58kBtRpJsP0tYMlZ7c6KhbwvyNObKygf/bW6acYbx7ImcMttBMzZ89T+pBpV6CfcM50gfa/50/TZe18P9G87rtv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794171; c=relaxed/simple;
	bh=kpTdKuRNhp6WDMTUkgvRN77msNjucZq3HHnrebzNO6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS7MnjClRVdDG8fkDCYMODtRPGBeYgYxj0+euMa9a9q6eedI8nV66+187OmJ02y8qNTlSNazaNYumaoAHFWorf6HG1XKMLSMDcvbjdaavKRNXNoR6MKO6+4WdDAuxKGoziyVJxFSeilAw3v/r90NZWYzTxbPojLTE11yoCT8Eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGywamDj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGywamDj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-343f52d15efso100057a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 12:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764794168; x=1765398968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGBXI6KEou/hhBdbkRnHGzI6fRxCqsOAqw+98bbiBWA=;
        b=lGywamDj1L0f3yL1ufPHtn8lgw5ZM+ut5Gy4DrQWAwYq1ZlkPoRX9T+u9jyn52m1Er
         QNfs5WFUe4mAzXUHFoKg4BTQ0jxGbgNe6qH/O/ik9ZMhS96+VwGRoXPvsFMc3uWOJDsQ
         +y85B7NRygVOvxxNF3sJy+KJZiLpAdiOGrJkt7fmig3DMQYgfmrIBCdwYUEp4VYcKRqs
         YvPIos8KRKgd2Xf+RChv3PYYTOmC+QACoS0+5RnwRkxQHAb4/eqWhDvmixvrlkYnK0hC
         NevUEtS1oyVQI3ZQ+gYeZmRcvUwBhYu6u5STqd6u1U3n5v86AEF1zVWLVjpHuAV+W1dE
         n9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764794168; x=1765398968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGBXI6KEou/hhBdbkRnHGzI6fRxCqsOAqw+98bbiBWA=;
        b=sFiquJjmYcrEgeI04HPB4EBUegcJoDSNjTGi8u9L1/VOK/HXRTMNJSBYUsDfNQNwUx
         cCNIiaifVUS2/D2KoWkbYjoU4/6xoxGGxIo78yzGkSrBTl/eocxtf+WAijQiPu9Wa5Jk
         pyxCMmLBYO8sGR8hC+I8z/UE1T7ZvNqCBfjpbbtN+Lc54vZotr0qYIsJqc1qaj08+m6U
         JPEBk58w5xYlcJuoSQlCIwJU2WLe6zpy5YF4z1Gic8creEPpKR8C9zcEVjuAXrEoHwYK
         Cv6iaR1vUwAbxc4DjSMV7jwfU18UZEBImw34x/JhSEL6b7e1fJh3RsR/olk8PAmjhy8d
         PxYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsK/uTASal3t+Lee5ZC92LVwHDGnZ59lbvURXczwtHhmOvYb/L7ZdIfDNqIlnxHbACdguLCsxFJiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0x/fDXGFx3kSDZKasY0P8luB7fLlo2qwvefbgcHIt0G1ncfxd
	aPoK2cb6aUxvFWHAaCS7nx8M/dREnzNUmFg8To60HlafX+lVP1c6u0jO
X-Gm-Gg: ASbGnctATYHBC7UKMUVpBfP3mo7+QJQ3eadu7XJt+X0Oymm9/yYWGrlNO6VItVbzt8v
	CbneYpwiz61ZVNM84lfHNDy2fJf7ngC8N234TX1lrcWT8dnwd5PV9J5MqDJBQpAHMBf/bVIfCPq
	oazZ2/qwUpqd3Cu0elLX1L2Qb4C0Nz4LtWYI0EdHrVgtcBZRLiVep5JZASEdqCAfTOMJOTOSSdz
	gsbFzRi4O4gSNsuBpzQV9TN3DBC0kHVgpGQk1rgBkn667+j7f2DKgueOfQKZRymwqa7vuQVHEhp
	QZ1F4VMh5HOKL/WWLDCmAxSoqOXwv6KZcY4XJr9IYDmJHs40WGGYFszO0UlbXPArT/i8vL/560N
	gBKU6WMSFdwvsePt3FkSrnGyqtmpu4ocRDAEAOnBmcvRKTX/mBFH77/e/7AslLowjDAyhKJMT5D
	wNu+kGBPsl8wzXjHo8PzwMVHQK8ULgjN90
X-Google-Smtp-Source: AGHT+IEHnGRqWDw+6HurkwIBq3zU8FknBp8rzU2/svZ2wiTfc3rFz1dHXpa6dvH3CCLqkhzTwkGIrg==
X-Received: by 2002:a05:7022:f004:b0:119:e55a:9bf7 with SMTP id a92af1059eb24-11df6458278mr282918c88.19.1764794167807;
        Wed, 03 Dec 2025 12:36:07 -0800 (PST)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb04a07bsm88257115c88.7.2025.12.03.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 12:36:07 -0800 (PST)
From: anisa.su887@gmail.com
To: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Cc: nifan.cxl@gmail.com,
	dongjoo.seo1@samsung.com,
	Fan Ni <fan.ni@samsung.com>,
	Anisa Su <anisa.su@samsung.com>
Subject: [RFC PATCH 3/3] dcd: Add support for multiple DC regions
Date: Wed,  3 Dec 2025 20:29:13 +0000
Message-ID: <20251203203540.1091827-4-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251203203540.1091827-1-anisa.su887@gmail.com>
References: <20251203203540.1091827-1-anisa.su887@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

With the change, we add following support:
1. Allow creating multiple DC regions (up to 8);
2. Allow DC extents to belong to regions other than region 0;
3. Modify sysfs entries to enable the above capabilities;
4. Shareable attribute is added to dc region (partition);

This series is tested with proper NDCTL fix, see:
https://github.com/anisa-su993/anisa-ndctl/tree/multiple-dc-region-support

Signed-off-by: Fan Ni <nifan.cxl@gmail.com>
Tested-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
---
 drivers/cxl/core/cdat.c   |   2 +-
 drivers/cxl/core/core.h   |   9 +-
 drivers/cxl/core/hdm.c    |  18 +++-
 drivers/cxl/core/mbox.c   |  39 +++++----
 drivers/cxl/core/memdev.c | 179 +++++++++++++++++++++++++-------------
 drivers/cxl/core/port.c   |  45 ++++++++--
 drivers/cxl/core/region.c |  54 ++++++++----
 drivers/cxl/cxl.h         |  18 +++-
 drivers/cxl/cxlmem.h      |   5 +-
 drivers/dax/cxl.c         |   4 +-
 10 files changed, 264 insertions(+), 109 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 67c6917a9add..4b05af576a4f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -278,7 +278,7 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 			};
 
 			if (range_contains(&range, &dent->dpa_range)) {
-				if (mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
+				if (is_cxl_dc_partition_mode(mode) &&
 				    dent->handle != handle)
 					dev_warn(dev,
 						"Dynamic RAM perf mismatch; %pra (%u) vs %pra (%u)\n",
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 70942c40221b..061dcf3320cd 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -34,7 +34,14 @@ int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
-extern struct device_attribute dev_attr_create_dynamic_ram_a_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_0_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_1_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_2_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_3_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_4_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_5_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_6_region;
+extern struct device_attribute dev_attr_create_dynamic_ram_7_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 6b976da4a70a..faa4656f9542 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -463,8 +463,22 @@ static const char *cxl_mode_name(enum cxl_partition_mode mode)
 		return "ram";
 	case CXL_PARTMODE_PMEM:
 		return "pmem";
-	case CXL_PARTMODE_DYNAMIC_RAM_A:
-		return "dynamic_ram_a";
+	case CXL_PARTMODE_DYNAMIC_RAM_0:
+		return "dynamic_ram_0";
+	case CXL_PARTMODE_DYNAMIC_RAM_1:
+		return "dynamic_ram_1";
+	case CXL_PARTMODE_DYNAMIC_RAM_2:
+		return "dynamic_ram_2";
+	case CXL_PARTMODE_DYNAMIC_RAM_3:
+		return "dynamic_ram_3";
+	case CXL_PARTMODE_DYNAMIC_RAM_4:
+		return "dynamic_ram_4";
+	case CXL_PARTMODE_DYNAMIC_RAM_5:
+		return "dynamic_ram_5";
+	case CXL_PARTMODE_DYNAMIC_RAM_6:
+		return "dynamic_ram_6";
+	case CXL_PARTMODE_DYNAMIC_RAM_7:
+		return "dynamic_ram_7";
 	default:
 		return "";
 	};
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a6de98eb1310..291a96757ac8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -963,7 +963,7 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
 	for (int i = 0; i < cxlds->nr_partitions; i++) {
 		struct cxl_dpa_partition *part = &cxlds->part[i];
 
-		if (part->mode != CXL_PARTMODE_DYNAMIC_RAM_A)
+		if (!is_cxl_dc_partition_mode(part->mode))
 			continue;
 
 		struct range partition_range = (struct range) {
@@ -1710,6 +1710,7 @@ static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
  *                         device.
  * @mbox: Mailbox to query
  * @dc_info: The dynamic partition information to return
+ * @num_part: The number of dynamic partitions returned
  *
  * Read Dynamic Capacity information from the device and return the partition
  * information.
@@ -1718,7 +1719,7 @@ static int cxl_get_dc_config(struct cxl_mailbox *mbox, u8 start_partition,
  *         on error only dynamic_bytes is left unchanged.
  */
 int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
-			struct cxl_dc_partition_info *dc_info)
+			struct cxl_dc_partition_info *dc_info, int *num_part)
 {
 	struct cxl_dc_partition_info partitions[CXL_MAX_DC_PARTITIONS];
 	size_t dc_resp_size = mbox->payload_size;
@@ -1763,12 +1764,15 @@ int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
 
 	} while (num_partitions < dc_resp->avail_partition_count);
 
-	/* Return 1st partition */
-	dc_info->start = partitions[0].start;
-	dc_info->size = partitions[0].size;
-	dc_info->handle = partitions[0].handle;
-	dev_dbg(dev, "Returning partition 0 %zu size %zu\n",
-		dc_info->start, dc_info->size);
+
+	*num_part = dc_resp->avail_partition_count;
+	for (int i = 0; i < dc_resp->avail_partition_count; i++) {
+		dc_info[i].start = partitions[i].start;
+		dc_info[i].size = partitions[i].size;
+		dc_info[i].handle = partitions[i].handle;
+		dev_dbg(dev, "Returning partition %d %zu size %zu\n",
+			i, dc_info[i].start, dc_info[i].size);
+	}
 
 	return 0;
 }
@@ -1955,12 +1959,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_get_dirty_count, "CXL");
 
 void cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
-	struct cxl_dc_partition_info dc_info = { 0 };
+	struct cxl_dc_partition_info dc_info[CXL_MAX_DC_PARTITIONS];
 	struct device *dev = mds->cxlds.dev;
 	size_t skip;
-	int rc;
+	int rc, num_part;
 
-	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, &dc_info);
+	rc = cxl_dev_dc_identify(&mds->cxlds.cxl_mbox, dc_info, &num_part);
 	if (rc) {
 		dev_warn(dev,
 			 "Failed to read Dynamic Capacity config: %d\n", rc);
@@ -1969,7 +1973,7 @@ void cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	}
 
 	/* Skips between pmem and the dynamic partition are not supported */
-	skip = dc_info.start - info->size;
+	skip = dc_info[0].start - info->size;
 	if (skip) {
 		dev_warn(dev,
 			 "Dynamic Capacity skip from pmem not supported: %zu\n",
@@ -1978,10 +1982,13 @@ void cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 		return;
 	}
 
-	info->size += dc_info.size;
-	dev_dbg(dev, "Adding dynamic ram partition A; %zu size %zu\n",
-		dc_info.start, dc_info.size);
-	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_A);
+	for (int i = 0; i < num_part; i++) {
+		info->size += dc_info[i].size;
+		dev_dbg(dev, "Adding dynamic ram partition %d; %zu size %zu\n",
+			i, dc_info[i].start, dc_info[i].size);
+		add_part(info, dc_info[i].start, dc_info[i].size, CXL_PARTITION_DC_MODE(0) + i);
+	}
+	mds->cxlds.nr_dc_partitions = num_part;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_configure_dcd, "CXL");
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c53b06522d6c..720780901f5a 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/string_choices.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -102,18 +103,115 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
-static ssize_t dynamic_ram_a_size_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t dynamic_ram_N_size_show(struct cxl_memdev *cxlmd, char *buf, int pos)
 {
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	unsigned long long len = cxl_part_size(cxlds, CXL_PARTMODE_DYNAMIC_RAM_A);
+	unsigned long long len = cxl_part_size(cxlds, CXL_PARTITION_DC_MODE(0) + pos);
 
 	return sysfs_emit(buf, "%#llx\n", len);
 }
 
-static struct device_attribute dev_attr_dynamic_ram_a_size =
-	__ATTR(size, 0444, dynamic_ram_a_size_show, NULL);
+static ssize_t dynamic_ram_N_shareable_show(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	enum cxl_partition_mode mode = CXL_PARTITION_DC_MODE(0) + pos;
+	bool val = cxlmd->cxlds->part[mode].perf.shareable;
+
+	return sysfs_emit(buf, "%s\n", str_true_false(val));
+}
+
+static struct cxl_dpa_perf *part_perf(struct cxl_dev_state *cxlds,
+				      enum cxl_partition_mode mode)
+{
+	for (int i = 0; i < cxlds->nr_partitions; i++)
+		if (cxlds->part[i].mode == mode)
+			return &cxlds->part[i].perf;
+	return NULL;
+}
+
+static ssize_t dynamic_ram_N_qos_class_show(struct cxl_memdev *cxlmd,
+					    char *buf, int pos)
+{
+	enum cxl_partition_mode mode = CXL_PARTITION_DC_MODE(0) + pos;
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	return sysfs_emit(buf, "%d\n", part_perf(cxlds, mode)->qos_class);
+}
+
+#define CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(n)					\
+static ssize_t dynamic_ram_##n##_size_show(struct device *dev,			\
+					   struct device_attribute *attr,	\
+					   char *buf)				\
+{										\
+	return dynamic_ram_N_size_show(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dynamic_ram_##n##_size = {				\
+	.attr = { .name = "size",  .mode = 0444 },				\
+	.show = dynamic_ram_##n##_size_show,					\
+};										\
+static ssize_t dynamic_ram_##n##_shareable_show(struct device *dev,		\
+						struct device_attribute *attr,	\
+						char *buf)			\
+{										\
+	return dynamic_ram_N_shareable_show(to_cxl_memdev(dev), buf, (n));	\
+}										\
+struct device_attribute dynamic_ram_##n##_shareable = {				\
+	.attr = { .name = "shareable",  .mode = 0444 },				\
+	.show = dynamic_ram_##n##_shareable_show,				\
+};										\
+static ssize_t dynamic_ram_##n##_qos_class_show(struct device *dev,		\
+						struct device_attribute *attr,	\
+						char *buf)			\
+{										\
+	return dynamic_ram_N_qos_class_show(to_cxl_memdev(dev), buf, (n));	\
+}										\
+struct device_attribute dynamic_ram_##n##_qos_class = {				\
+	.attr = { .name = "qos_class",  .mode = 0444 },				\
+	.show = dynamic_ram_##n##_qos_class_show,				\
+};										\
+static struct attribute *cxl_memdev_dynamic_ram_##n##_attributes[] = {		\
+	&dynamic_ram_##n##_size.attr,						\
+	&dynamic_ram_##n##_shareable.attr,					\
+	&dynamic_ram_##n##_qos_class.attr,					\
+	NULL,									\
+};										\
+static umode_t cxl_memdev_dynamic_ram_##n##_attr_visible(struct kobject *kobj,	\
+							 struct attribute *a,	\
+							 int pos)		\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
+										\
+	if (!mds)								\
+		return 0;							\
+										\
+	return a->mode;								\
+}										\
+static umode_t cxl_memdev_dynamic_ram_##n##_group_visible(struct kobject *kobj)	\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
+										\
+	if (!mds || n >= mds->cxlds.nr_dc_partitions)					\
+		return 0;							\
+										\
+	return true;								\
+}										\
+DEFINE_SYSFS_GROUP_VISIBLE(cxl_memdev_dynamic_ram_##n);                        \
+static struct attribute_group cxl_memdev_dynamic_ram_##n##_attribute_group = { \
+       .name = "dynamic_ram_"#n,                                               \
+       .attrs = cxl_memdev_dynamic_ram_##n##_attributes,                       \
+       .is_visible = SYSFS_GROUP_VISIBLE(cxl_memdev_dynamic_ram_##n),          \
+}
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(0);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(1);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(2);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(3);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(4);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(5);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(6);
+CXL_MEMDEV_DYNAMIC_RAM_ATTR_GROUP(7);
 
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -399,15 +497,6 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
-static struct cxl_dpa_perf *part_perf(struct cxl_dev_state *cxlds,
-				      enum cxl_partition_mode mode)
-{
-	for (int i = 0; i < cxlds->nr_partitions; i++)
-		if (cxlds->part[i].mode == mode)
-			return &cxlds->part[i].perf;
-	return NULL;
-}
-
 static ssize_t pmem_qos_class_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -426,25 +515,6 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
 	NULL,
 };
 
-static ssize_t dynamic_ram_a_qos_class_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-
-	return sysfs_emit(buf, "%d\n",
-			  part_perf(cxlds, CXL_PARTMODE_DYNAMIC_RAM_A)->qos_class);
-}
-
-static struct device_attribute dev_attr_dynamic_ram_a_qos_class =
-	__ATTR(qos_class, 0444, dynamic_ram_a_qos_class_show, NULL);
-
-static struct attribute *cxl_memdev_dynamic_ram_a_attributes[] = {
-	&dev_attr_dynamic_ram_a_size.attr,
-	&dev_attr_dynamic_ram_a_qos_class.attr,
-	NULL,
-};
-
 static ssize_t ram_qos_class_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -521,29 +591,6 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.is_visible = cxl_pmem_visible,
 };
 
-static umode_t cxl_dynamic_ram_a_visible(struct kobject *kobj, struct attribute *a, int n)
-{
-	struct device *dev = kobj_to_dev(kobj);
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_A);
-
-	if (a == &dev_attr_dynamic_ram_a_qos_class.attr &&
-	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
-		return 0;
-
-	if (a == &dev_attr_dynamic_ram_a_size.attr &&
-	    (!cxl_part_size(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_A)))
-		return 0;
-
-	return a->mode;
-}
-
-static struct attribute_group cxl_memdev_dynamic_ram_a_attribute_group = {
-	.name = "dynamic_ram_a",
-	.attrs = cxl_memdev_dynamic_ram_a_attributes,
-	.is_visible = cxl_dynamic_ram_a_visible,
-};
-
 static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 					   struct attribute *a, int n)
 {
@@ -572,7 +619,14 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
-	&cxl_memdev_dynamic_ram_a_attribute_group,
+	&cxl_memdev_dynamic_ram_0_attribute_group,
+	&cxl_memdev_dynamic_ram_1_attribute_group,
+	&cxl_memdev_dynamic_ram_2_attribute_group,
+	&cxl_memdev_dynamic_ram_3_attribute_group,
+	&cxl_memdev_dynamic_ram_4_attribute_group,
+	&cxl_memdev_dynamic_ram_5_attribute_group,
+	&cxl_memdev_dynamic_ram_6_attribute_group,
+	&cxl_memdev_dynamic_ram_7_attribute_group,
 	&cxl_memdev_security_attribute_group,
 	NULL,
 };
@@ -581,7 +635,14 @@ void cxl_memdev_update_perf(struct cxl_memdev *cxlmd)
 {
 	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_ram_attribute_group);
 	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_pmem_attribute_group);
-	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_a_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_0_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_1_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_2_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_3_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_4_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_5_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_6_attribute_group);
+	sysfs_update_group(&cxlmd->dev.kobj, &cxl_memdev_dynamic_ram_7_attribute_group);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_perf, "CXL");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3f94dbf63ba9..68b88159e525 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -119,7 +119,14 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
-CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_a, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_0, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_1, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_2, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_3, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_4, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_5, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_6, CXL_DECODER_F_RAM);
+CXL_DECODER_FLAG_ATTR(cap_dynamic_ram_7, CXL_DECODER_F_RAM);
 CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
 CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
@@ -214,8 +221,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 		mode = CXL_PARTMODE_PMEM;
 	else if (sysfs_streq(buf, "ram"))
 		mode = CXL_PARTMODE_RAM;
-	else if (sysfs_streq(buf, "dynamic_ram_a"))
-		mode = CXL_PARTMODE_DYNAMIC_RAM_A;
+	else if (sysfs_streq(buf, "dynamic_ram_0"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_0;
+	else if (sysfs_streq(buf, "dynamic_ram_1"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_1;
+	else if (sysfs_streq(buf, "dynamic_ram_2"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_2;
+	else if (sysfs_streq(buf, "dynamic_ram_3"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_3;
+	else if (sysfs_streq(buf, "dynamic_ram_4"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_4;
+	else if (sysfs_streq(buf, "dynamic_ram_5"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_5;
+	else if (sysfs_streq(buf, "dynamic_ram_6"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_6;
+	else if (sysfs_streq(buf, "dynamic_ram_7"))
+		mode = CXL_PARTMODE_DYNAMIC_RAM_7;
 	else
 		return -EINVAL;
 
@@ -321,14 +342,28 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
 static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_pmem.attr,
 	&dev_attr_cap_ram.attr,
-	&dev_attr_cap_dynamic_ram_a.attr,
+	&dev_attr_cap_dynamic_ram_0.attr,
+	&dev_attr_cap_dynamic_ram_1.attr,
+	&dev_attr_cap_dynamic_ram_2.attr,
+	&dev_attr_cap_dynamic_ram_3.attr,
+	&dev_attr_cap_dynamic_ram_4.attr,
+	&dev_attr_cap_dynamic_ram_5.attr,
+	&dev_attr_cap_dynamic_ram_6.attr,
+	&dev_attr_cap_dynamic_ram_7.attr,
 	&dev_attr_cap_type2.attr,
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
 	&dev_attr_qos_class.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
-	SET_CXL_REGION_ATTR(create_dynamic_ram_a_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_0_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_1_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_2_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_3_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_4_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_5_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_6_region)
+	SET_CXL_REGION_ATTR(create_dynamic_ram_7_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index da3ea3cf8585..1a53c74b814c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -499,7 +499,7 @@ static ssize_t interleave_ways_store(struct device *dev,
 	if (rc)
 		return rc;
 
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A && val != 1) {
+	if (is_cxl_dc_partition_mode(cxlr->mode) && val != 1) {
 		dev_err(dev, "Interleaving and DCD not supported\n");
 		return -EINVAL;
 	}
@@ -2255,7 +2255,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
 		}
 
 		cxled = to_cxl_endpoint_decoder(dev);
-		if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
+		if (is_cxl_dc_partition_mode(cxlr->mode) &&
 		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
 			dev_dbg(dev, "DCD unsupported\n");
 			rc = -EINVAL;
@@ -2606,7 +2606,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 	switch (mode) {
 	case CXL_PARTMODE_RAM:
 	case CXL_PARTMODE_PMEM:
-	case CXL_PARTMODE_DYNAMIC_RAM_A:
+	case CXL_PARTMODE_DYNAMIC_RAM_0...CXL_PARTMODE_DYNAMIC_RAM_7:
 		break;
 	default:
 		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
@@ -2659,20 +2659,36 @@ static ssize_t create_ram_region_store(struct device *dev,
 }
 DEVICE_ATTR_RW(create_ram_region);
 
-static ssize_t create_dynamic_ram_a_region_show(struct device *dev,
-						struct device_attribute *attr,
-						char *buf)
-{
-	return __create_region_show(to_cxl_root_decoder(dev), buf);
-}
-
-static ssize_t create_dynamic_ram_a_region_store(struct device *dev,
-						 struct device_attribute *attr,
-						 const char *buf, size_t len)
-{
-	return create_region_store(dev, buf, len, CXL_PARTMODE_DYNAMIC_RAM_A);
-}
-DEVICE_ATTR_RW(create_dynamic_ram_a_region);
+#define CREATE_DYNAMIC_RAM_N_REGION(n)						\
+static ssize_t create_dynamic_ram_##n##_region_show(struct device *dev,		\
+						struct device_attribute *attr,	\
+						char *buf)			\
+{										\
+	return __create_region_show(to_cxl_root_decoder(dev), buf);		\
+}										\
+static ssize_t create_dynamic_ram_##n##_region_store(struct device *dev,		\
+						 struct device_attribute *attr, \
+						 const char *buf, size_t len)	\
+{										\
+	enum cxl_partition_mode mode = CXL_PARTITION_DC_MODE(0) + (n);		\
+	return create_region_store(dev, buf, len, mode);			\
+}
+CREATE_DYNAMIC_RAM_N_REGION(0);
+CREATE_DYNAMIC_RAM_N_REGION(1);
+CREATE_DYNAMIC_RAM_N_REGION(2);
+CREATE_DYNAMIC_RAM_N_REGION(3);
+CREATE_DYNAMIC_RAM_N_REGION(4);
+CREATE_DYNAMIC_RAM_N_REGION(5);
+CREATE_DYNAMIC_RAM_N_REGION(6);
+CREATE_DYNAMIC_RAM_N_REGION(7);
+DEVICE_ATTR_RW(create_dynamic_ram_0_region);
+DEVICE_ATTR_RW(create_dynamic_ram_1_region);
+DEVICE_ATTR_RW(create_dynamic_ram_2_region);
+DEVICE_ATTR_RW(create_dynamic_ram_3_region);
+DEVICE_ATTR_RW(create_dynamic_ram_4_region);
+DEVICE_ATTR_RW(create_dynamic_ram_5_region);
+DEVICE_ATTR_RW(create_dynamic_ram_6_region);
+DEVICE_ATTR_RW(create_dynamic_ram_7_region);
 
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -3266,7 +3282,7 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	struct device *dev;
 	int rc;
 
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
+	if (is_cxl_dc_partition_mode(cxlr->mode) &&
 	    cxlr->params.interleave_ways != 1) {
 		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
 		return -EINVAL;
@@ -3667,7 +3683,7 @@ static int cxl_region_probe(struct device *dev)
 
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_PARTMODE_RAM:
-	case CXL_PARTMODE_DYNAMIC_RAM_A:
+	case CXL_PARTMODE_DYNAMIC_RAM_0...CXL_PARTMODE_DYNAMIC_RAM_7:
 		rc = devm_cxl_region_edac_register(cxlr);
 		if (rc)
 			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3e400dd4f08b..80fb8d09172c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -503,12 +503,26 @@ struct cxl_region_params {
 	resource_size_t cache_size;
 };
 
+#define CXL_PARTITION_DC_MODE(n) CXL_PARTMODE_DYNAMIC_RAM_##n
 /* Modes should be in the implied DPA order */
 enum cxl_partition_mode {
 	CXL_PARTMODE_RAM,
 	CXL_PARTMODE_PMEM,
-	CXL_PARTMODE_DYNAMIC_RAM_A,
-};
+	CXL_PARTITION_DC_MODE(0),
+	CXL_PARTITION_DC_MODE(1),
+	CXL_PARTITION_DC_MODE(2),
+	CXL_PARTITION_DC_MODE(3),
+	CXL_PARTITION_DC_MODE(4),
+	CXL_PARTITION_DC_MODE(5),
+	CXL_PARTITION_DC_MODE(6),
+	CXL_PARTITION_DC_MODE(7),
+	CXL_PARTITION_MODE_MAX,
+};
+
+static inline bool is_cxl_dc_partition_mode(enum cxl_partition_mode mode)
+{
+	return mode >= CXL_PARTITION_DC_MODE(0) && mode < CXL_PARTITION_MODE_MAX;
+}
 
 /*
  * Indicate whether this region has been assembled by autodetection or
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2bad68f13e21..e28cd6827c7d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -106,7 +106,7 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
-#define CXL_NR_PARTITIONS_MAX 3
+#define CXL_NR_PARTITIONS_MAX 10
 
 struct cxl_dpa_info {
 	u64 size;
@@ -456,6 +456,7 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
 	unsigned int nr_partitions;
+	unsigned int nr_dc_partitions;
 	u64 serial;
 	enum cxl_devtype type;
 	struct cxl_mailbox cxl_mbox;
@@ -954,7 +955,7 @@ struct cxl_dc_partition_info {
 };
 
 int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
-			struct cxl_dc_partition_info *dc_info);
+			struct cxl_dc_partition_info *dc_info, int *num_part);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
 int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 15fc2de63185..fa6ada01b681 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -57,7 +57,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
 	flags = IORESOURCE_DAX_KMEM;
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
+	if (is_cxl_dc_partition_mode(cxlr->mode))
 		flags |= IORESOURCE_DAX_SPARSE_CAP;
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
@@ -65,7 +65,7 @@ static int cxl_dax_region_probe(struct device *dev)
 	if (!dax_region)
 		return -ENOMEM;
 
-	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A) {
+	if (is_cxl_dc_partition_mode(cxlr->mode)) {
 		rc = cxlr_add_existing_extents(cxlr);
 		/* If adding existing extents fails, continue with only an error
 		 * message ?? */
-- 
2.51.0

