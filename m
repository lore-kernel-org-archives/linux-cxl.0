Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4122311592
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789763494; cv=none; b=JbzfS0xwkZ3y8c4KBBUp5QoJLep00dKIL3KTk2dxqAzvRhX0fRRk4nSCk6PA6aSQsI4KbT18HyWSqnP7G69YRifxwbgLyLLv8nLNgihGYx/8sidd2dJ8jIRSMO7RvRQGKOH55wak33eN/HcRZxzo0bGbYqKw86RENV61Sy8iGgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789763494; c=relaxed/simple;
	bh=0urpuF69lmjANEoASIpNMaqjvaF8Zqpff1iP2PVfnUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7cyNDOW+mJggIJ7J+C8Tymy5/m2wwae1O6fX0MemCynXXVSMreTYDbwJ6qqqwmEOr9wHi7Efiol8T0vHzteIO9czIJ5GcNPx1UQr2//jgbQ1Pz0dZXHoR1bGsK1OUEM1osSz43m3PH0YwfK7sg56NP/LJVqU1/toA01WcbUi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgwACJhV; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgwACJhV"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66fb93aee5eso1293323d50.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789763492; x=1790368292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/278BRZkZUFeUdXtTpfZmLT8E8MCceT99a8hF0iosM=;
        b=MgwACJhV421K7jVutxu08UkW835ytPisw7M1ZoOfTHARIYGelKAT/6FK9qm4OUgTid
         RFbSJJNLeB754qj+dbml02wmotzmAkxk1Ob6LCBnUM9pJFIYWkY62oVfkIyQcU2An++w
         O9++DFT9Y9/2ZnFnRC1XU7sWopIPqrx72LwUK9zyBuI70Iwk2FZh6YWJFrOCgbFXVL4N
         /h4lHoSxm43yBJLC8YBs+muOOnOqwhDK30Zyf3gEoTNDN5qjnksEseEpRisij8/6jf4R
         pbkF/FqIW6hjDIeRFKda/OvQAHorckt4+Ao6mkiRUrkG/WsFZV5DFD9RhA8wC1pcnaoD
         7CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789763492; x=1790368292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0/278BRZkZUFeUdXtTpfZmLT8E8MCceT99a8hF0iosM=;
        b=ewWIuhQhavKXWzKcJkGcWK5VcTDje9elysRu4y9FCqgcDROzV7gPU5jktgJE7iTHWt
         g0QPky89V/deV5AomXyNx2QaO/6XmwIErrH94umD6NTmEkeRuEKifzsWF8oF7zq88Hnt
         hl5hsjETypFFG+cHtJ65sI6rjYk56qijCe+RBi9XGMfkYVqi0HoxE6ffOcWPUWSAUQvr
         NF7z6HcX13fz5wCalDud9uinwzfZce8S+7H7/uZCXNeuVYYPl8e7sN94ZWoKJCX2PVz7
         CZhre4L4v5QUXBIyiwgMrF30LKnx0Tn2EngI+bvQKVbNj/qg3vLO0NwESIzHA9N7ANLk
         y3qw==
X-Gm-Message-State: AFuF++mIna8kMtMEMa6hR849czZBSqK/LSXS5H5X1tSIMnJeqdicXhtJ
	VySOL7ZUr9UOB4k5r4xIJ3+L0dKHS4+Hz599W8bc5eBwuwQ/AezT3FU4kTHcjg==
X-Gm-Gg: AYBFou3ClxI0v2DJ5I3i0qei6+7eEVqZNanGuuaWtkKlIH7VpSMmRYJ6YzLwJ6ODA+4
	VChCb3vQ/xBzZduH+pFz36Yoz8O5dQID4mdJxR4f689036fBuB2qFCfA0Vkwe1NbBsCsu0Ys91p
	LQQ9fE0XfSGA+Y3UqZXY5V5RtDHpZ3tNn90d/wv7Lm9zdNHP6FFomTijbKfzwA381/E9CgQWwls
	qUeOiP+CeHZzizRVu0vaCVFYQvCxI1ZNNSw/yvjz8xNaH4Ee2+p9yxkLqzy26l8zEOPwcTBXB2h
	Yh+dk8h0aHjz8ip1EiviobWss0EJ3dqZeNrG61b/Cgi+bGukLgglcQuWymG31/TyVr5zHdpedfb
	Kt84c7SdnRR/QFHURVYZjTS60Vitt76N53i73I9CfHOLKDuxUhVQGruz4Cyb3gt8OrJpes8Lvea
	OYdtpx/v+kjVJOPlfabTOwofpPOckszcnAP8ON83dGS2iU+XTDZ09sg7mkYt/Z0qUPNG+xZkZUv
	8CDqSoMcSTnXQmWMz3M9pIj5p3U42i8p7P34vmDyaAEOqoAZ+2CbVtYHtAq
X-Received: by 2002:a05:690e:810:20b0:671:1d59:2998 with SMTP id 956f58d0204a3-6717fcbc3b7mr899543d50.33.1789763491808;
        Fri, 18 Sep 2026 13:31:31 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64b74sm427240d50.1.2026.09.18.13.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:31:31 -0700 (PDT)
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
Subject: [PATCH v14 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Date: Fri, 18 Sep 2026 13:30:12 -0700
Message-ID: <20260918203049.7273-4-anisa.su@samsung.com>
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

Additional DCD partition (AKA region) information is contained in the
DSMAS CDAT tables, including performance and shareable attributes.

Match DCD partitions with DSMAS tables and store the meta data.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

---
Changes:
1. cdat.c: record the DSMAS shareable flag independently of QTG
   discovery. cxl_port_perf_data_calculate() returns -ENOENT when FW
   recommends no QTG for any entry, which skipped the assignment even
   though the CDAT parsed successfully and the DSMAS flag was valid.
   Richard
---
 drivers/cxl/core/cdat.c   | 49 +++++++++++++++++++++++++++++----------
 drivers/cxl/core/hdm.c    |  1 +
 drivers/cxl/core/mbox.c   |  9 +++++++
 drivers/cxl/core/memdev.c | 17 ++++++++------
 drivers/cxl/cxlmem.h      |  2 ++
 include/cxl/cxl.h         |  4 ++++
 6 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..6e7950f12134 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -17,6 +17,7 @@ struct dsmas_entry {
 	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int entries;
 	int qos_class;
+	bool shareable;
 };
 
 static u32 cdat_normalize(u16 entry, u64 base, u8 type)
@@ -74,6 +75,8 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 		return -ENOMEM;
 
 	dent->handle = dsmas->dsmad_handle;
+	/* Shareable is CDAT 1.03 and later, DSMAS Flags bit 3 */
+	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
 	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
 	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
 			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
@@ -255,8 +258,13 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
 }
 
-static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
-				     struct xarray *dsmas_xa)
+/*
+ * The DSMAS shareable flag is a property of the CDAT entry and is recorded
+ * even if FW returns no QTG recommendations for any entry; only update perf
+ * if those recommendations exist, indicated by @set_perf
+ */
+static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
+				   struct xarray *dsmas_xa, bool set_perf)
 {
 	struct device *dev = cxlds->dev;
 	struct dsmas_entry *dent;
@@ -266,18 +274,34 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 		bool found = false;
 
 		for (int i = 0; i < cxlds->nr_partitions; i++) {
-			struct resource *res = &cxlds->part[i].res;
+			struct cxl_dpa_partition *part = &cxlds->part[i];
 			struct range range = {
-				.start = res->start,
-				.end = res->end,
+				.start = part->res.start,
+				.end = part->res.end,
 			};
 
-			if (range_contains(&range, &dent->dpa_range)) {
-				update_perf_entry(dev, dent,
-						  &cxlds->part[i].perf);
-				found = true;
+			if (!range_contains(&range, &dent->dpa_range))
+				continue;
+
+			found = true;
+			/*
+			 * part->handle is from Get DC Config, dent->handle
+			 * from the CDAT DSMAS entry.
+			 */
+			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1 &&
+			    dent->handle != part->handle) {
+				dev_warn(dev,
+					 "DSMAD handle mismatch: %pra has %u, DSMAS %pra has %u\n",
+					 &range, part->handle,
+					 &dent->dpa_range, dent->handle);
 				break;
 			}
+
+			if (set_perf)
+				update_perf_entry(dev, dent, &part->perf);
+			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
+				part->shareable = dent->shareable;
+			break;
 		}
 
 		if (!found)
@@ -419,12 +443,13 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 	}
 
 	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
-	if (rc) {
+	if (rc)
 		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
+
+	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
+	if (rc)
 		return;
-	}
 
-	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
 	cxl_qos_class_verify(cxlmd);
 	cxl_memdev_update_perf(cxlmd);
 }
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0ef076c08ed2..7f63b86887f4 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -477,6 +477,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 
 		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
 		cxlds->part[i].mode = part->mode;
+		cxlds->part[i].handle = part->handle;
 
 		/* Require ordered + contiguous partitions */
 		if (i) {
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c96c16cc08e1..d84a90320081 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1366,6 +1366,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
 	u64 decode_len = le64_to_cpu(dev_part->decode_length);
 	u64 blk_size = le64_to_cpu(dev_part->block_size);
 	u64 len = le64_to_cpu(dev_part->length);
+	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
 	u64 size;
 
 	/*
@@ -1378,6 +1379,13 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
 		return 0;
 	}
 
+	/* The CDAT DSMAD handle this refers to is 8 bits */
+	if (handle & ~0xFF) {
+		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
+			 handle);
+		return -EINVAL;
+	}
+
 	/*
 	 * Decode length is a count of 256M units, so a device reporting 2^36
 	 * or more wraps.
@@ -1391,6 +1399,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
 	*part = (struct cxl_dc_partition_info) {
 		.start = le64_to_cpu(dev_part->base),
 		.size = size,
+		.handle = handle,
 	};
 
 	/*
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 15df8db314d9..8883c8850759 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -594,7 +594,8 @@ bool is_cxl_memdev(const struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
 
-static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
+static void add_part(struct cxl_dpa_info *info, u64 start, u64 size,
+		     enum cxl_partition_mode mode, u8 handle)
 {
 	int i = info->nr_partitions;
 
@@ -606,6 +607,7 @@ static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_pa
 		.end = start + size - 1,
 	};
 	info->part[i].mode = mode;
+	info->part[i].handle = handle;
 	info->nr_partitions++;
 }
 
@@ -623,9 +625,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM);
+		add_part(info, 0, mds->volatile_only_bytes, CXL_PARTMODE_RAM, 0);
 		add_part(info, mds->volatile_only_bytes,
-			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM);
+			 mds->persistent_only_bytes, CXL_PARTMODE_PMEM, 0);
 		return 0;
 	}
 
@@ -635,9 +637,9 @@ int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 		return rc;
 	}
 
-	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM);
+	add_part(info, 0, mds->active_volatile_bytes, CXL_PARTMODE_RAM, 0);
 	add_part(info, mds->active_volatile_bytes, mds->active_persistent_bytes,
-		 CXL_PARTMODE_PMEM);
+		 CXL_PARTMODE_PMEM, 0);
 
 	return 0;
 }
@@ -685,7 +687,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size = total;
 	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
 		dc_info.start, dc_info.size);
-	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
+	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
+		 dc_info.handle);
 
 	return 0;
 }
@@ -704,7 +707,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
 		.size = capacity,
 	};
 
-	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM);
+	add_part(&range_info, 0, capacity, CXL_PARTMODE_RAM, 0);
 	return cxl_dpa_setup(cxlds, &range_info);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_capacity, "CXL");
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 4fac65dbb808..9fd5af2e41d4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -140,6 +140,7 @@ struct cxl_dpa_info {
 	struct cxl_dpa_part_info {
 		struct range range;
 		enum cxl_partition_mode mode;
+		u8 handle;
 	} part[CXL_NR_PARTITIONS_MAX];
 	int nr_partitions;
 };
@@ -851,6 +852,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 struct cxl_dc_partition_info {
 	u64 start;
 	u64 size;
+	u8 handle;
 };
 
 int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 4ef9511fbbdd..43edcde5bce3 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -141,11 +141,15 @@ enum cxl_partition_mode {
  * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
  * @perf: performance attributes of the partition from CDAT
  * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
+ * @handle: DSMAS handle that represents this partition
+ * @shareable: Is the partition shareable (from its CDAT DSMAS entry)
  */
 struct cxl_dpa_partition {
 	struct resource res;
 	struct cxl_dpa_perf perf;
 	enum cxl_partition_mode mode;
+	u8 handle;
+	bool shareable;
 };
 
 #define CXL_NR_PARTITIONS_MAX 3
-- 
2.43.0

