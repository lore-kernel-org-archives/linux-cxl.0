Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D4385503
	for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779529424; cv=none; b=rUT3w2KLRKe0QlRX1HgO8j5GUuCam/HxdB7wFh2FnFm4mhqcZ19A7QSDdSFJi235KMu/HaAQdPT56Qu19D888RrsBSY/BLRNpisRtFCAZzLgsmBQ9/LPpImNtHFW4uLPmG6172KtNOlUx5gUzWgYZVbqVq+wQ9RIyuiPwYIxBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779529424; c=relaxed/simple;
	bh=kE5rNago1b+pyJpsmlKzqPBUNfF637c14Fgd6EpHYHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD7dIRJeeoCmdk0WFy2QW9RkGrn7B8q8ZCV1sxZCXxUA45SNUZ6vZ+ooz4uo4otmjI5H6/rK4whyjV8cPz0wpxR/U9us1NbOH66VnXU3U6ra68HPOORPIUinMn2P5JzoN/zuXu048N+hqqBvoldo2JiVDXmLqlJsmCranpFho44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekoqdcg3; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekoqdcg3"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f30a4601bbso8246698eec.1
        for <linux-cxl@vger.kernel.org>; Sat, 23 May 2026 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779529422; x=1780134222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWos/AalbO5utJ9gJ5N4ZBriXQ8AKrI8xdpp7eapkB0=;
        b=ekoqdcg3qFcQv2k7VH66HoMr3dcs6Y5swBaHGaCM6e0+8Qyh1YbBBnJGBxvCTjOGVF
         Two0s7NpnbRAAgj5PvhB4s5MmIMDq3ZFVUAmXtxk0knfi4o/Cv0vt7vfljm2xpdCjAqU
         VDDytjlTP9PfQrs8cCz1aEA7ZDuutfrOoAVpPcJMVDCOuzxW6E2teB6/25j+iV6dmOmT
         n2Xzxpf0i3RYl/KruYoPMSde59TT7Ir1Yw1uFcv9xZYwWLF5LFuWJmAXWxgNlT26wITj
         TTLW4NQHWsg/Zo6+tTnF624epcCfixXx5/HIHOo7dVlNA91pvyDlsBWgr3OYRrIVsgVK
         Y4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779529422; x=1780134222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OWos/AalbO5utJ9gJ5N4ZBriXQ8AKrI8xdpp7eapkB0=;
        b=FOIQs930zA4ssnNBX8j5djZBkExydSkkW1owy+BADOOjB86ekeiMkOvzW2F/ubEAWJ
         n33M7cpVXAsYkkzipxslk09hRfOm44CKwri7yhXA+cDMCaqXBNcxM89s+0tQjNwz7X5A
         2XjCKbJKd9oXd1OeYiy7R2INthnikU5vloKnenjt6cHBhHiz83fW8Jov/S89P/ZoGg1N
         h5WVzbCnZ5M8C1xMGPsUsDcKFJD5AdbExLMCkHmLhnghh2YlrPkfkt8bcydX11AqcpCc
         fVscF43XRTuZ0KOFS6szarg7MPWLMiEl9g1o2QQDv1Wj7X8dkRuszVLeFxkSoq7O1igF
         v7hQ==
X-Gm-Message-State: AOJu0YwD9fDQbuHlzwHMIuoW9she5iS+cRk4TlLzJyfzkreAiMtH6dM2
	lx+vr7aldP0E9tQtclo0585p5jRGTo49uwDv15nR2Fn5y80pR0qJMcOltY/8UQ==
X-Gm-Gg: Acq92OGypZTTIZHEq9hX3x7veJWvCn3h8e+xTiLinZLG13DALtHCkbEQnXol8dtmdaG
	FV41uiCfbDtKDR7lQjxzZax6aELPrmdwsI1/K5PbtaXfCE4Er4sCGcaJcjMP7PLKSIRYgAvPHRq
	qzmkn5ezNSJ0n9ckYMshCkyqpj+7B7b7tRpT5Jj1WfBH91/ZYLTos8I9O1tvic/wc69ngkQ5jjk
	lrJJk3fuAOkNE5Rb1JQ9zK0SZn952xCHSyraUJ61FrTxnbDRxcG9jiaXmACNFCtEOzDsujYxkXC
	MpLCkq0RM0VWOvDS4uzR7pzajKr7sYrV0xAsPzpHHtfGQqPUaoQcf8PzCR65bFK8iRfG8wAEqCZ
	jDDlMpJvj1Ly6pT7j8ev7pjJYU3+JxuQY4zNbw4V3i4WohsNPuCdrEMXkjiK7K3IfFQ00wcL+Mo
	icb8L12ydnkZYiMsjoFa1S7Dk7Yib5BZRrkBd/DA30uMDbXNIg65oJF0r1r2dc+pHEmhGYSEnh7
	wfeSPU=
X-Received: by 2002:a05:701b:290a:b0:12d:de3e:be88 with SMTP id a92af1059eb24-1365fc6d91cmr1288421c88.36.1779529422248;
        Sat, 23 May 2026 02:43:42 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366a40305csm2376358c88.7.2026.05.23.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 02:43:41 -0700 (PDT)
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
Subject: [PATCH v10 03/31] cxl/cdat: Gather DSMAS data for DCD partitions
Date: Sat, 23 May 2026 02:42:57 -0700
Message-ID: <f7800561164a891513a20381378f2ff052d29288.1779528761.git.anisa.su@samsung.com>
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

Additional DCD partition (AKA region) information is contained in the
DSMAS CDAT tables, including performance, read only, and shareable
attributes.

Match DCD partitions with DSMAS tables and store the meta data.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa: rebase]
[jonathan: core/mbox.c: error if there are non-zero reserved bits in DSMAD
handle in cxl_dc_check]
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
index 87386488ad10..cee936fb3d03 100644
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
@@ -818,6 +819,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 struct cxl_dc_partition_info {
 	size_t start;
 	size_t size;
+	u8 handle;
 };
 
 int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index bb1df0cef863..51685a01d19c 100644
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
 
 #define CXL_NR_PARTITIONS_MAX 3
-- 
2.43.0

