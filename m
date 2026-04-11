Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205691CEADB
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871651; cv=none; b=dYraixTdVytksYeIoWl9Gglz1nx+U+3Tv8Df811FeyqaMg1xOaBixYXrttoctrcCyyQjy2ecBXr4SX1erftNUYPiVAvAphWx+tOnzuMYKbOgovxo1+ejOiB8ah8ZpWwXFWxdc//JQShlpRo3gY5rtg53EftWn2EHO6pqyLHm+eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871651; c=relaxed/simple;
	bh=ig2hfbJsdHD8YolPsPrGndqyUccMdhoNdv06p+mzo0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyfTkEC2ylmS8w28+tVtT+IsGW9vAlSw4cJSVAj7ZX/BHRmd+Wd+OgSQFLaA04ZSstn8U+3XU1ImpVgeWmcDjEBpT3Tj30OTi24YNP8u6y/Pfpn5TYHrSsU5cbOYkiYXhMjwlu34J2u+COv+cYvx5+vIrqDOpciDW/bApqLXWZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Cxe5yd; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Cxe5yd"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79d991c7b6aso26030267b3.2
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871649; x=1776476449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9TokF4tTz9nrCx+/fqhzK0am69vsncpuB4UyQpOYsw=;
        b=J3Cxe5ydzWo0lrMKwcc53RkkM1CtM6xQvkbGDr+t2ia7gq7bQQdapktd37ItjpRSau
         wfcGnMdsQKwR2LbDqGdw7zj/wNHKS2o0fTmRlJeacqSoltBIR99ZEmMoU/qB3SDgKVbk
         hDCK2V1rSKCFEQWGDe1PRnr+rr669NxTEY0vxGDKZmGappQfKkXxdsj86eF/iXkjt+z0
         bQDWVQNdgVlr22BMcnJmpntkq8k8TX4tA5jIUH4gHfK+Wv11ifT7x9y3kYygeXD5r79g
         wotGy9pZi97y8u7rLrx8B9rLFaalI0yRGqW2gYdzX0sQXpyh9lqYrZyo17IGyyki4vg3
         HBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871649; x=1776476449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9TokF4tTz9nrCx+/fqhzK0am69vsncpuB4UyQpOYsw=;
        b=dK9ieGMWRTBoYMEUMeVG6K8U9Jad70wnksJc5hwCxWfxqBBYzPuNTlYcO05ap6Zhup
         WzcUCoOl2+9fG+CcbPGrw06wYv/Rzq3z/NkRZ1tzbLVcXrQT19YWuRuc+rMiJExlhlc+
         de1H8ltXIdfcEa+hf9ga6mX87qjHrrQ/iRUqGg/+u1KR52PFfAFZPSqXgYtImfpqs5fq
         aQ67zqop504t/WFK3AzrIZWalzm805q0biZofp9mylNtQg2XMwG45Pt4JvPe1dy+eEfI
         51Uolhuo1EKisM0eKtMFtUYadewGjbejVZVMUY+KxTxTwRL5oevTWvxmzfu2dM4qIKip
         RNLw==
X-Gm-Message-State: AOJu0Yxf5b9VCpWG5WU+eRwERpRUVNRmJ169hZevCzNxZ4VVpSghkQWb
	LSLQvrJpN8DoeniAUmRX3HHakugVPAUotMwA2wFZBtzZn1D9ijJ1ii/YNhh5Ug==
X-Gm-Gg: AeBDievfiOHEgcimb7to8nzclJJHMXI54Y/2RiEAT+CWhSGPvLzLE6+mBbQo550PxPT
	+JOmyiNk3Hsh1UHu0rasWIz4UxGMTx4DHqpbFnQHXRg5FYT39iUFhcScPxBY69uYn62O83qGEKQ
	sVil1PWtJ9wPpnA3ExF5Hm6QSBd7CCdY/f2jW8ugi9um1ekVvznw2L6tdFI5Ne5SeeXFjvR2w2D
	D1u1R9nZkV6ryiZIUW8Pc3fPWqnhsD3S5X+slrAhSiNl5sX7tYxXkyF1rYEqUka1Od7Xrq4wp6E
	AV9SS6Ub9eRZu9bWNK1bZaFQtF3vKxGx4j09u9Pd9gJAfVOsERvtM3ZS4mKUbPQtptGofRGtzZC
	w5udZqSZ2hd+pneeMw1rKj16S0ZCi2t0qVo5hRh+/qTVjMLiFRa2HsWZrwt31XbRrGf2/I2Whkw
	2cJCLQ4BydOcmUJcLX7wMM2B9EyIKMQTuJ5VzVLtwKaA==
X-Received: by 2002:a05:690c:d95:b0:79b:d941:ddc0 with SMTP id 00721157ae682-7af70f92985mr60981637b3.26.1775871648563;
        Fri, 10 Apr 2026 18:40:48 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:48 -0700 (PDT)
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
	dan.j.williams@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 16/20] cxl/region: Read existing extents on region creation
Date: Fri, 10 Apr 2026 18:23:11 -0700
Message-ID: <20260411013958.47422-17-anisa.su@samsung.com>
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

Dynamic capacity device extents may be left in an accepted state on a
device due to an unexpected host crash.  In this case it is expected
that the creation of a new region on top of a DC partition can read
those extents and surface them for continued use.

Once all endpoint decoders are part of a region and the region is being
realized, a read of the 'devices extent list' can reveal these
previously accepted extents.

CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
this purpose.  The call returns all the extents for all dynamic capacity
partitions.  If the fabric manager is adding extents to any DCD
partition, the extent list for the recovered region may change.  In this
case the query must retry.  Upon retry the query could encounter extents
which were accepted on a previous list query.  Adding such extents is
ignored without error because they are entirely within a previous
accepted extent.  Instead warn on this case to allow for differentiating
bad devices from this normal condition.

Latch any errors to be bubbled up to ensure notification to the user
even if individual errors are rate limited or otherwise ignored.

The scan for existing extents races with the dax_cxl driver.  This is
synchronized through the region device lock.  Extents which are found
after the driver has loaded will surface through the normal notification
path while extents seen prior to the driver are read during driver load.

Based on an original patch by Navneet Singh.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[anisa]: enforce same tagged add rules for processing existing extents

Instead of onlining and notifying the dax layer as we go, process the
entire list, creating a single region extent from it, then
online/notify.
---
 drivers/cxl/core/core.h |   1 +
 drivers/cxl/core/mbox.c | 116 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  21 ++++++++
 3 files changed, 138 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cb3f46a1152a..24121734b2d5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -28,6 +28,7 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
 	return container_of(cxlds, struct cxl_memdev_state, cxlds);
 }
 
+int cxl_process_extent_list(struct cxl_endpoint_decoder *cxled);
 int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
 
 #ifdef CONFIG_CXL_REGION
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c256081d2c65..9ef38a81933d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1916,6 +1916,122 @@ int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
 
+/* Return -EAGAIN if the extent list changes while reading */
+static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
+{
+	u32 current_index, total_read, total_expected, initial_gen_num;
+	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
+	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_cmd mbox_cmd;
+	u32 max_extent_count;
+	int latched_rc = 0;
+	bool first = true;
+
+	struct cxl_mbox_get_extent_out *extents __free(kvfree) =
+				kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!extents)
+		return -ENOMEM;
+
+	total_read = 0;
+	current_index = 0;
+	total_expected = 0;
+	max_extent_count = (cxl_mbox->payload_size - sizeof(*extents)) /
+				sizeof(struct cxl_extent);
+	do {
+		u32 nr_returned, current_total, current_gen_num;
+		struct cxl_mbox_get_extent_in get_extent;
+		int rc;
+
+		get_extent = (struct cxl_mbox_get_extent_in) {
+			.extent_cnt = cpu_to_le32(max(max_extent_count,
+						  total_expected - current_index)),
+			.start_extent_index = cpu_to_le32(current_index),
+		};
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+			.payload_in = &get_extent,
+			.size_in = sizeof(get_extent),
+			.size_out = cxl_mbox->payload_size,
+			.payload_out = extents,
+			.min_out = 1,
+		};
+
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		/* Save initial data */
+		if (first) {
+			total_expected = le32_to_cpu(extents->total_extent_count);
+			initial_gen_num = le32_to_cpu(extents->generation_num);
+			first = false;
+		}
+
+		nr_returned = le32_to_cpu(extents->returned_extent_count);
+		total_read += nr_returned;
+		current_total = le32_to_cpu(extents->total_extent_count);
+		current_gen_num = le32_to_cpu(extents->generation_num);
+
+		dev_dbg(dev, "Got extent list %d-%d of %d generation Num:%d\n",
+			current_index, total_read - 1, current_total, current_gen_num);
+
+		if (current_gen_num != initial_gen_num || total_expected != current_total) {
+			dev_warn(dev, "Extent list change detected; gen %u != %u : cnt %u != %u\n",
+				 current_gen_num, initial_gen_num,
+				 total_expected, current_total);
+			return -EAGAIN;
+		}
+
+		for (int i = 0; i < nr_returned ; i++) {
+			struct cxl_extent *extent = &extents->extent[i];
+
+			dev_dbg(dev, "Processing extent %d/%d\n",
+				current_index + i, total_expected);
+
+			rc = add_to_pending_list(&mds->add_ctx.pending_extents,
+						 extent);
+			if (rc) {
+				latched_rc = rc;
+			}
+		}
+
+		current_index += nr_returned;
+	} while (total_expected > total_read);
+
+	if (!latched_rc && !list_empty(&mds->add_ctx.pending_extents)) {
+		latched_rc = cxl_add_pending(mds);
+	}
+	clear_pending_extents(mds);
+
+	return latched_rc;
+}
+
+#define CXL_READ_EXTENT_LIST_RETRY 10
+
+/**
+ * cxl_process_extent_list() - Read existing extents
+ * @cxled: Endpoint decoder which is part of a region
+ *
+ * Issue the Get Dynamic Capacity Extent List command to the device
+ * and add existing extents if found.
+ *
+ * A retry of 10 is somewhat arbitrary, however, extent changes should be
+ * relatively rare while bringing up a region.  So 10 should be plenty.
+ */
+int cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
+{
+	int retry = CXL_READ_EXTENT_LIST_RETRY;
+	int rc;
+
+	do {
+		rc = __cxl_process_extent_list(cxled);
+	} while (rc == -EAGAIN && retry--);
+
+	return rc;
+}
+
 static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
 {
 	int i = info->nr_partitions;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 6da958352afd..3346da309be3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -532,6 +532,27 @@ struct cxl_mbox_dc_response {
 	} __packed extent_list[] __counted_by(extent_list_size);
 } __packed;
 
+/*
+ * Get Dynamic Capacity Extent List; Input Payload
+ * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
+ */
+struct cxl_mbox_get_extent_in {
+	__le32 extent_cnt;
+	__le32 start_extent_index;
+} __packed;
+
+/*
+ * Get Dynamic Capacity Extent List; Output Payload
+ * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
+ */
+struct cxl_mbox_get_extent_out {
+	__le32 returned_extent_count;
+	__le32 total_extent_count;
+	__le32 generation_num;
+	u8 rsvd[4];
+	struct cxl_extent extent[];
+} __packed;
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];
-- 
2.43.0

