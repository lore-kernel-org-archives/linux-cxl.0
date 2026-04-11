Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A772AE78
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871633; cv=none; b=PwoQlBKzVHKLFj+sPDbpaL1U3CGOvDRDD9pwxvE64gMI3jcvjJEvaPyWVmFX28xfq4Jj6xnC4V2/NLutET3VG8ztfcUGv5m8cRuVhDlkUmZUcX01uY++mgcwRbx7BkJPVDjYKo++jiUX9ht7df92LVUBQATUygY+ne2XMuUfIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871633; c=relaxed/simple;
	bh=mpO5I5XOC6bnl5fZ28QWshLGgvKeBiK8zfZpmx+hExc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihVC0BvhSsNXXIJDnhDDo7nEoE7lyCtKtQQlHkMXwUqshBrOwxfU5KOW/TvAxUKZAdmkmmEUykorK6Ej1mg05Q5EHUOWyT8OgnsBdLBcwS2P8mMybA6g+TLIyneWCSAjd8JdZ2wIt0vBa+8cgqlswbCVKCnvTmILS2n8WVRVq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D02T432T; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D02T432T"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-794719afcd4so28273277b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871631; x=1776476431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlxmzyysGxPiGipsGpKmah2A1xaSauxCi5PeYI/buiE=;
        b=D02T432TRx+GlxKcQDhLyYZ2wei75VdjA8PYKvH4JoBuUvdpL8ilYbQMmqogbTxBBb
         DkAmHWkFZr9e2/XdSwfpHw9VgioZXYjAMCLwrCqXu0IHR0wj6FWRHjWlii50cKz7/ERq
         xTwukWaQzr2aQ+GxitUMVKKDJvg3BjMI/nbpWwPtOywYwJvJoneOs1ZQTtyJigvemYx8
         ZobxAErddsaBbLsQDU3+gLe/FgyVHAq+Djn/6JUaLB7qjvpOmOeHwUaZM2xqG/ziaIhD
         rc9oW+cBVe1f15/mzuMBXXW510GV19Pxs+7a/9Ec3wSfT0IyC0PDoi0hLd+woxYxNVcE
         2zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871631; x=1776476431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlxmzyysGxPiGipsGpKmah2A1xaSauxCi5PeYI/buiE=;
        b=qdrhIMXlfJTvh9YR76jmUh6D7wPQkOF71vVcrF06e4Q6LJnAlniiiYsnfMoF3Sy+m6
         BMh/s12JZOwrOXGS2uL80ebLrIZEgqOj0+srz1ikN+XZLW6CnJAXHxcC9dClhQ9iabgy
         g541Y3+5HV138td1eexN/YA1OIlbezRllJUc8ltzj1quYOL9STHe4dwLK3AkhdIPQGvB
         kUXF9CwDP9qE1N/tCE99ul//AhQgwfKufg0g3pFppSGhgF8zC9jR7h1zQwSBeWMTeegC
         OEMwIUztiPMcQsQWF5yFHir7Gviw73/qPHsJv8zLGkuXnEOUb3HGenGjAbzrSqjhw7SI
         ZMjg==
X-Gm-Message-State: AOJu0YzBQaNMcAfMExrirTmMlk4Kp51hCWqVDLiBd2mBdZW0og7AORy8
	LlAxqYZEO2moqKS+5q0wJUz8SZ+hEbfIUJS32uuzCNK3YFP7du3RTUgXY1GMUw==
X-Gm-Gg: AeBDieujafLf9Ah3Iza7UXH1Ip6mfPBY0Q3oLY9zlc3+JpsnKGavAf5E0mHE2vzlc7c
	PLiA4LEnFzgjApJxYsgBGROi0fjWzWYojKSne1Yag/y67JV031QpzH8QEPlINPuQA1jq8LTC8wf
	+qqYGMJ3DMpFeD0VCd12mnGptjUwYJygvRCX2MTyPCEja15m6RhATkCjzzxqLQLJ5a36brTY+5L
	j8F7mEeQP5ky2VK9b+0ZLrTuEjSHr8XhM9D9UBntoGZU9kq/rGC3wgZWYJt6EGenP+5ag5xDthK
	OU3ZrIQnG4f1fJSR4OTx1RHE6E7s1Gbq3UWj3YFfKXXGgJCiK+IxwUN5Mtk1W2EmizZ8zDuEmLd
	PDbSvn1Cz3HX4/u6MT/1tThD0+oCihW/C8tsaOFZ6wfeGz85iobR2wzPFDDXNThVP0masW9EP5H
	PfARi4KoEd4XlLMyHlVNqyX1WAgSjmWXRfysQSixcMdQ==
X-Received: by 2002:a05:690c:698b:b0:7a4:80ce:825b with SMTP id 00721157ae682-7af6feef58dmr62135047b3.24.1775871631359;
        Fri, 10 Apr 2026 18:40:31 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:31 -0700 (PDT)
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
Subject: [PATCH 03/20] cxl/cdat: Gather DSMAS data for DCD partitions
Date: Fri, 10 Apr 2026 18:22:58 -0700
Message-ID: <20260411013958.47422-4-anisa.su@samsung.com>
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

Additional DCD partition (AKA region) information is contained in the
DSMAS CDAT tables, including performance, read only, and shareable
attributes.

Match DCD partitions with DSMAS tables and store the meta data.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
---
 drivers/cxl/core/cdat.c | 11 +++++++++++
 drivers/cxl/core/mbox.c |  7 +++++++
 drivers/cxl/cxlmem.h    |  2 ++
 include/cxl/cxl.h       |  4 ++++
 4 files changed, 24 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 5c9f07262513..c5f3d2ebea55 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -17,6 +17,7 @@ struct dsmas_entry {
 	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int entries;
 	int qos_class;
+	bool shareable;
 };
 
 static u32 cdat_normalize(u16 entry, u64 base, u8 type)
@@ -74,6 +75,7 @@ static int cdat_dsmas_handler(union acpi_subtable_headers *header, void *arg,
 		return -ENOMEM;
 
 	dent->handle = dsmas->dsmad_handle;
+	dent->shareable = dsmas->flags & ACPI_CDAT_DSMAS_SHAREABLE;
 	dent->dpa_range.start = le64_to_cpu((__force __le64)dsmas->dpa_base_address);
 	dent->dpa_range.end = le64_to_cpu((__force __le64)dsmas->dpa_base_address) +
 			      le64_to_cpu((__force __le64)dsmas->dpa_length) - 1;
@@ -244,6 +246,7 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
 		dpa_perf->coord[i] = dent->coord[i];
 		dpa_perf->cdat_coord[i] = dent->cdat_coord[i];
 	}
+	dpa_perf->shareable = dent->shareable;
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->qos_class = dent->qos_class;
 	dev_dbg(dev,
@@ -266,13 +269,21 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 		bool found = false;
 
 		for (int i = 0; i < cxlds->nr_partitions; i++) {
+			enum cxl_partition_mode mode = cxlds->part[i].mode;
 			struct resource *res = &cxlds->part[i].res;
+			u8 handle = cxlds->part[i].handle;
 			struct range range = {
 				.start = res->start,
 				.end = res->end,
 			};
 
 			if (range_contains(&range, &dent->dpa_range)) {
+				if (mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
+				    dent->handle != handle)
+					dev_warn(dev,
+						"Dynamic RAM perf mismatch; %pra (%u) vs %pra (%u)\n",
+						&range, handle, &dent->dpa_range, dent->handle);
+
 				update_perf_entry(dev, dent,
 						  &cxlds->part[i].perf);
 				found = true;
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 71b29cd6abfe..f9a5e21f5d09 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1356,10 +1356,16 @@ static int cxl_dc_check(struct device *dev, struct cxl_dc_partition_info *part_a
 {
 	size_t blk_size = le64_to_cpu(dev_part->block_size);
 	size_t len = le64_to_cpu(dev_part->length);
+	u32 handle = le32_to_cpu(dev_part->dsmad_handle);
 
 	part_array[index].start = le64_to_cpu(dev_part->base);
 	part_array[index].size = le64_to_cpu(dev_part->decode_length);
 	part_array[index].size *= CXL_CAPACITY_MULTIPLIER;
+	if (handle & ~0xFF) {
+		dev_warn(dev, "DSMAD handle 0x%x has non-zero reserved bits\n", handle);
+		return -EINVAL;
+	}
+	part_array[index].handle = handle;
 
 	/* Check partitions are in increasing DPA order */
 	if (index > 0) {
@@ -1494,6 +1500,7 @@ int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
 	/* Return 1st partition */
 	dc_info->start = partitions[0].start;
 	dc_info->size = partitions[0].size;
+	dc_info->handle = partitions[0].handle;
 	dev_dbg(dev, "Returning partition 0 %zu size %zu\n",
 		dc_info->start, dc_info->size);
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2fef6bb373b9..314d37ca9bdb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -118,6 +118,7 @@ struct cxl_dpa_info {
 	struct cxl_dpa_part_info {
 		struct range range;
 		enum cxl_partition_mode mode;
+		u8 handle;
 	} part[CXL_NR_PARTITIONS_MAX];
 	int nr_partitions;
 };
@@ -816,6 +817,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 struct cxl_dc_partition_info {
 	size_t start;
 	size_t size;
+	u8 handle;
 };
 
 int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 0d3f144016f2..91964272f392 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -122,12 +122,14 @@ struct cxl_register_map {
  * @coord: QoS performance data (i.e. latency, bandwidth)
  * @cdat_coord: raw QoS performance data from CDAT
  * @qos_class: QoS Class cookies
+ * @shareable: Is the range sharable
  */
 struct cxl_dpa_perf {
 	struct range dpa_range;
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	struct access_coordinate cdat_coord[ACCESS_COORDINATE_MAX];
 	int qos_class;
+	bool shareable;
 };
 
 enum cxl_partition_mode {
@@ -141,11 +143,13 @@ enum cxl_partition_mode {
  * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
  * @perf: performance attributes of the partition from CDAT
  * @mode: operation mode for the DPA capacity, e.g. ram, pmem, dynamic...
+ * @handle: DSMAS handle intended to represent this partition
  */
 struct cxl_dpa_partition {
 	struct resource res;
 	struct cxl_dpa_perf perf;
 	enum cxl_partition_mode mode;
+	u8 handle;
 };
 
 #define CXL_NR_PARTITIONS_MAX 2
-- 
2.43.0

