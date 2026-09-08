Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC983F8717
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862938; cv=none; b=pGNbsdB5wKImrCLNPgfSUw/fMvUrDamaUmzjnYGWifCE6z9XSavrVTocX03IgZXj9WzvCGUyp1qhf2yyfHJ7IxbFaFZhcgIBbIh6MhAesTyhN7wBf3aPf5YZpl151u4Z/S2yrjGHWWcRbgNHZo4Y59WbZHvjNG/F/WswvilDksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862938; c=relaxed/simple;
	bh=4OghBPXWhR905IRZifFXiD0uhz35KsSF0C+wf5jkAAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fE1BALRm8xTfbbJ+BkVkh5kicqrTWL6gKae8aOjOS7sdStr+dXvvK9tW8j6HVty20P7T/CTGao/0HvcJrO+w4zjU1hj+O2jIB4YWGfsUrp38wDLaSate6SeE4lvg+ZBO82qrjedquIZ9ZcmQ+vVCja1x+S4x/3/I5lhe6+HEbbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xon6Hohm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xon6Hohm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so3243323a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 08 Sep 2026 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862936; x=1789467736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NGTNLsjgXGidRqZrOnlHaMewke5Oj+tAxqfQ6aTtidE=;
        b=Xon6Hohmyf8s/ZqZkTNGd78AWqEQnu04C5zHC+HPHZzKkKC8t1yAkz4G54pTzKB10R
         /ryJJxQyPrzr2J61MnAC6LDRdqHsxoGdO6O9MdtrjbCsI4lIkyhjbr/UVdfKKQSk5/G3
         c2VaNPzZGu1op3dLhqPTR2hIYYoHb39vg/O7dgtvU2UrdhONzbbrmi2JIW1n4BlLKiDd
         rS7TDB4duWL7Yz0hOjla0WwE1SlesmBl9eROqik5MmjWKY4Ls7H109cvSoZSu89/3UFw
         o9XbtqPBbjqbzMEZA41domnHE6h7MmABjOPp6xRoIGEcgfLVnMfVYGn7HZ2c6fxN1jQM
         K9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862936; x=1789467736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NGTNLsjgXGidRqZrOnlHaMewke5Oj+tAxqfQ6aTtidE=;
        b=KXnWHTsDIbhP5nZ7rEU8rzxZ4OKJYKScj1Qybn8GPSWqxKPCVBrf4y2hzBnMX8qr/z
         DHRRkviXJQI37FjgSfootaidzLv/np2GPB6cFFkKOuFRIej1EeWe0W3kZHdUobP9pqKB
         mCkLz1RyrKVCiSOisyd1SUR6nlkpxwz1ryPYwuDm3xmMAQLqINpQslz6MgfFbZ3t/v+Y
         1NePjL5V09UPotahs0RmGLf/aHFnZVLkj3mQl1LozcgUzFygy2fzvqBEMKn7Vuy6Tnnj
         eccrP3hwZkGiiGH/iJJiJOU+AmFMEbLbLfg2dZm9M/lI+OJ/GCYq+WB8lXxPO1RIR4jW
         ADow==
X-Gm-Message-State: AFuF++kwj2NZiwuudKtsMCIT0KvJre8MVwEmOeT/9xv/73W0wK49bYO2
	wzzRmT/0tQICegDP+UkrCs0VY9UYE48xBr6a9vQYtwFHt2ksq9AZAc9/0zT8DQ==
X-Gm-Gg: AYBFou107JvOnklQw+pASz3F3CLbmASJIo/oOG7m3+l/V4WCRK47mQsqeBG31sbD7pW
	9Gxuu2VfHP10cI1lzxKsY1O+YHtrpzKYodQA/UbIE8ZpnHZnOvgKeyeV+CjDbgVTU5Uns4Ooy/1
	PHYsRS3ZesaAkGOyB7DT/KpO0+7HYorUdUyXfjjXdUJ1mHEfCQNvwPswbZGIc1B1BN9n/8hLouj
	rXuMD2xLHTiw4Mdz7NeLPF2aekn6nGo4w/pTEgM1S2vhMcbMVXIG+OwT2d7EOl0W0WUeI4f0W3L
	ESggyg43347iOKxNq9+bSbOQ6aU2Kt63NsBM0kyOBkY/eeqocUPno7oETjPjwQxWS6KpuSDCd9I
	96zxvFCGMl5a8S1KBjL1gBM25x7WUgolj0T5l56wFYt0yQLjq4bSAmiLgPQzPz+Kz70sLPn5bKW
	oDNbpi35sOnaUfYEhPtrUPdZfE7i+s4YdWBj/PoEAAt6jrCfGIMSX7BTjY7rdt+AIQKoXoHy1sP
	Hxm4Fvht3dTAwoLQLGau6K2rTT8UbM2hXPQY461EOMNd/H8STqbE6sgh7zR/d8yR+uaIMHC5HIt
	ZJzaZho5OCs=
X-Received: by 2002:a05:6a21:b84:b0:3d2:89db:1688 with SMTP id adf61e73a8af0-3da39eacdedmr43615900637.2.1788862935496;
        Tue, 08 Sep 2026 03:22:15 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3396e7e477csm3435658eec.29.2026.09.08.03.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:22:14 -0700 (PDT)
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
	Heesoo Kim <habil.kim@samsung.com>
Subject: [RESEND PATCH v13 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Date: Tue,  8 Sep 2026 03:15:07 -0700
Message-ID: <20260908102124.2231730-5-anisa.su@samsung.com>
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

Additional DCD partition (AKA region) information is contained in the
DSMAS CDAT tables, including performance and shareable attributes.

Match DCD partitions with DSMAS tables and store the meta data.

Signed-off-by: Ira Weiny <iweiny@kernel.org>
Co-developed-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Tested-by: Junhee Park <jh9934.park@samsung.com>
Tested-by: Heesoo Kim <habil.kim@samsung.com>

---
Changes:
1. cdat.c: set found=true as soon as a partition contains the range, and
   break out of the search on a DSMAD handle mismatch. Partitions are
   disjoint, so the continue could never match another one; the search
   always ran out and the entry was reported twice, once as a mismatch
   and again as "no partition for dsmas dpa" even though a partition did
   cover it.

2. cdat.c: only assign shareable for the dynamic ram 1 partition. It
   was set for every partition the DSMAS range fell into, while the
   handle check above it is DC only. The field describes a DC partition,
   so ram and pmem have no use for it.

3. Commit message: drop the claim that the read only attribute is
   gathered. Only the shareable flag is. Nothing in this series or the
   follow-on DCD work consumes a read only flag, so storing it would be
   dead state. Implementing read-only (reject writes to RO partitions)
   applies to any DSMAS described range, non-specific to dynamic capacity and
   belongs to separate patch.
---
 drivers/cxl/core/cdat.c   | 32 +++++++++++++++++++++++++-------
 drivers/cxl/core/hdm.c    |  1 +
 drivers/cxl/core/mbox.c   |  9 +++++++++
 drivers/cxl/core/memdev.c | 17 ++++++++++-------
 drivers/cxl/cxlmem.h      |  2 ++
 include/cxl/cxl.h         |  4 ++++
 6 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..05058d4520f2 100644
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
@@ -266,18 +269,33 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
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
+			update_perf_entry(dev, dent, &part->perf);
+			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM_1)
+				part->shareable = dent->shareable;
+			break;
 		}
 
 		if (!found)
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
index a484e23b2b3a..efc3bf3563a5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1365,6 +1365,7 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
 {
 	u64 blk_size = le64_to_cpu(dev_part->block_size);
 	u64 len = le64_to_cpu(dev_part->length);
+	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
 
 	/*
 	 * Not an error; leave the entry empty. A partially zeroed partition
@@ -1376,9 +1377,17 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part,
 		return 0;
 	}
 
+	/* The CDAT DSMAD handle this refers to is 8 bits */
+	if (handle & ~0xFF) {
+		dev_warn(dev, "DSMAD handle 0x%x exceeds the 8 bit CDAT DSMAD handle\n",
+			 handle);
+		return -EINVAL;
+	}
+
 	*part = (struct cxl_dc_partition_info) {
 		.start = le64_to_cpu(dev_part->base),
 		.size = le64_to_cpu(dev_part->decode_length) * CXL_CAPACITY_MULTIPLIER,
+		.handle = handle,
 	};
 
 	/*
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index fdd6b395dcdf..4a5793fa3cbf 100644
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
@@ -674,7 +676,8 @@ int cxl_configure_dcd(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 	info->size += dc_info.size;
 	dev_dbg(dev, "Adding dynamic ram partition 1; %#llx size %#llx\n",
 		dc_info.start, dc_info.size);
-	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1);
+	add_part(info, dc_info.start, dc_info.size, CXL_PARTMODE_DYNAMIC_RAM_1,
+		 dc_info.handle);
 
 	return 0;
 }
@@ -693,7 +696,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity)
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

