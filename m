Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAD7EB64DB
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jun 2023 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjFNTUB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjFNTTw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 15:19:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497C2135
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686770389; x=1718306389;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=jQg/IKNsIX3ExQXTsdU1UOMrpqCfaC2ONKPLm68j8tI=;
  b=LScQhJwDypnK43ISRE28FdmJzOaCF1lS0k0rtCAQ+4SiEpH2z90OQ9T+
   r35tYFufYdSumOMLB/oKw9f7cqBQoKRPYxMCaE/v+zpivZGw+ijw5JaMP
   K4L8WSBp/CXOhbNNi3D48lKuKKnPyKp8scVSI6yTQhUdSDS5OyEHA7AYk
   MpWrtrB5mU4ISosO5FvnxvjcE4HYvgWAvAjuqqDWc7q9y+AfTwtfItHic
   i3XCfjZZlM2rAUtV5GREafLvd+8fOvEz+oil1NYguUfP8b+zgtwZYq+Ue
   edfcb3aqGTFmy7NZ9sX7y9cnqJYijwBOjLjczZWSaZj3aB9YLCsSeFP0u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338347360"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338347360"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="886384288"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="886384288"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.116.198])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:19:46 -0700
From:   ira.weiny@intel.com
Date:   Wed, 14 Jun 2023 12:16:31 -0700
Subject: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
To:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686770367; l=28894;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=lnyIy7/2CBuaRNyRNHpGdKUJC3jhjcbKwn6Z+csYfrs=;
 b=VT6kYxcug1TOI9pztroMKPntR4gRbs+47LwMa5KZWythdmdjxzww3uCOU3KLfE4+pINgu1yQT
 /TU/FKWGmXLCC5e+fso43tW2wM47CjB8vbZZEqd/5xNLLO24kORPL6C
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Navneet Singh <navneet.singh@intel.com>

A dynamic capacity device utilizes events to signal the host about the
changes to the allocation of DC blocks. The device communicates the
state of these blocks of dynamic capacity through an extent list that
describes the starting DPA and length of all blocks the host can access.

Based on the dynamic capacity add or release event type,
dynamic memory represented by the extents are either added
or removed as devdax device.

Process the dynamic capacity add and release events.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>

---
[iweiny: Remove invalid comment]
---
 drivers/cxl/core/mbox.c   | 345 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/region.c | 214 +++++++++++++++++++++++++++-
 drivers/cxl/core/trace.h  |   3 +-
 drivers/cxl/cxl.h         |   4 +-
 drivers/cxl/cxlmem.h      |  76 ++++++++++
 drivers/cxl/pci.c         |  10 +-
 drivers/dax/bus.c         |  11 +-
 drivers/dax/bus.h         |   5 +-
 8 files changed, 652 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index c5b696737c87..db9295216de5 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -767,6 +767,14 @@ static const uuid_t log_uuid[] = {
 	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
 };
 
+/* See CXL 3.0 8.2.9.2.1.5 */
+enum dc_event {
+	ADD_CAPACITY,
+	RELEASE_CAPACITY,
+	FORCED_CAPACITY_RELEASE,
+	REGION_CONFIGURATION_UPDATED,
+};
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
@@ -852,6 +860,14 @@ static const uuid_t mem_mod_event_uuid =
 	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
 
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const uuid_t dc_event_uuid =
+	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c,
+		0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a);
+
 static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
@@ -945,6 +961,188 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	return rc;
 }
 
+static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
+				struct cxl_mbox_dc_response *res,
+				int extent_cnt, int opcode)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc, size;
+
+	size = struct_size(res, extent_list, extent_cnt);
+	res->extent_list_size = cpu_to_le32(extent_cnt);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = opcode,
+		.size_in = size,
+		.payload_in = res,
+	};
+
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+
+	return rc;
+
+}
+
+static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
+					int *n, struct range *extent)
+{
+	struct cxl_mbox_dc_response *dc_res;
+	unsigned int size;
+
+	if (!extent)
+		size = struct_size(dc_res, extent_list, 0);
+	else
+		size = struct_size(dc_res, extent_list, *n + 1);
+
+	dc_res = krealloc(*res, size, GFP_KERNEL);
+	if (!dc_res)
+		return -ENOMEM;
+
+	if (extent) {
+		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
+		memset(dc_res->extent_list[*n].reserved, 0, 8);
+		dc_res->extent_list[*n].length =
+				cpu_to_le64(range_len(extent));
+		(*n)++;
+	}
+
+	*res = dc_res;
+	return 0;
+}
+/**
+ * cxl_handle_dcd_event_records() - Read DCD event records.
+ * @mds: The memory device state
+ *
+ * Returns 0 if enumerate completed successfully.
+ *
+ * CXL devices can generate DCD events to add or remove extents in the list.
+ */
+static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
+					struct cxl_event_record_raw *rec)
+{
+	struct cxl_mbox_dc_response *dc_res = NULL;
+	struct device *dev = mds->cxlds.dev;
+	uuid_t *id = &rec->hdr.id;
+	struct dcd_event_dyn_cap *record =
+			(struct dcd_event_dyn_cap *)rec;
+	int extent_cnt = 0, rc = 0;
+	struct cxl_dc_extent_data *extent;
+	struct range alloc_range, rel_range;
+	resource_size_t dpa, size;
+
+	if (!uuid_equal(id, &dc_event_uuid))
+		return -EINVAL;
+
+	switch (record->data.event_type) {
+	case ADD_CAPACITY:
+		extent = devm_kzalloc(dev, sizeof(*extent), GFP_ATOMIC);
+		if (!extent)
+			return -ENOMEM;
+
+		extent->dpa_start = le64_to_cpu(record->data.extent.start_dpa);
+		extent->length = le64_to_cpu(record->data.extent.length);
+		memcpy(extent->tag, record->data.extent.tag,
+				sizeof(record->data.extent.tag));
+		extent->shared_extent_seq =
+			le16_to_cpu(record->data.extent.shared_extn_seq);
+		dev_dbg(dev, "Add DC extent DPA:0x%llx LEN:%llx\n",
+					extent->dpa_start, extent->length);
+		alloc_range = (struct range) {
+			.start = extent->dpa_start,
+			.end = extent->dpa_start + extent->length - 1,
+		};
+
+		rc = cxl_add_dc_extent(mds, &alloc_range);
+		if (rc < 0) {
+			dev_dbg(dev, "unconsumed DC extent DPA:0x%llx LEN:%llx\n",
+					extent->dpa_start, extent->length);
+			rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, NULL);
+			if (rc < 0) {
+				dev_err(dev, "Couldn't create extent list %d\n",
+									rc);
+				devm_kfree(dev, extent);
+				return rc;
+			}
+
+			rc = cxl_send_dc_cap_response(mds, dc_res,
+					extent_cnt, CXL_MBOX_OP_ADD_DC_RESPONSE);
+			if (rc < 0) {
+				devm_kfree(dev, extent);
+				goto out;
+			}
+
+			kfree(dc_res);
+			devm_kfree(dev, extent);
+
+			return 0;
+		}
+
+		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
+				GFP_KERNEL);
+		if (rc < 0)
+			goto out;
+
+		mds->num_dc_extents++;
+		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &alloc_range);
+		if (rc < 0) {
+			dev_err(dev, "Couldn't create extent list %d\n", rc);
+			return rc;
+		}
+
+		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
+					      CXL_MBOX_OP_ADD_DC_RESPONSE);
+		if (rc < 0)
+			goto out;
+
+		break;
+
+	case RELEASE_CAPACITY:
+		dpa = le64_to_cpu(record->data.extent.start_dpa);
+		size = le64_to_cpu(record->data.extent.length);
+		dev_dbg(dev, "Release DC extents DPA:0x%llx LEN:%llx\n",
+				dpa, size);
+		extent = xa_load(&mds->dc_extent_list, dpa);
+		if (!extent) {
+			dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
+			return -EINVAL;
+		}
+
+		rel_range = (struct range) {
+			.start = dpa,
+			.end = dpa + size - 1,
+		};
+
+		rc = cxl_release_dc_extent(mds, &rel_range);
+		if (rc < 0) {
+			dev_dbg(dev, "withhold DC extent DPA:0x%llx LEN:%llx\n",
+									dpa, size);
+			return 0;
+		}
+
+		xa_erase(&mds->dc_extent_list, dpa);
+		devm_kfree(dev, extent);
+		mds->num_dc_extents--;
+		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &rel_range);
+		if (rc < 0) {
+			dev_err(dev, "Couldn't create extent list %d\n", rc);
+			return rc;
+		}
+
+		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
+					      CXL_MBOX_OP_RELEASE_DC);
+		if (rc < 0)
+			goto out;
+
+		break;
+
+	default:
+		return -EINVAL;
+	}
+out:
+	kfree(dc_res);
+	return rc;
+}
+
 static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 				    enum cxl_event_log_type type)
 {
@@ -982,9 +1180,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		if (!nr_rec)
 			break;
 
-		for (i = 0; i < nr_rec; i++)
+		for (i = 0; i < nr_rec; i++) {
 			cxl_event_trace_record(cxlmd, type,
 					       &payload->records[i]);
+			if (type == CXL_EVENT_TYPE_DCD) {
+				rc = cxl_handle_dcd_event_records(mds,
+						&payload->records[i]);
+				if (rc)
+					dev_err_ratelimited(dev,
+						"dcd event failed: %d\n", rc);
+			}
+		}
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
@@ -1024,6 +1230,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
 		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
 	if (status & CXLDEV_EVENT_STATUS_INFO)
 		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
+	if (status & CXLDEV_EVENT_STATUS_DCD)
+		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
 
@@ -1244,6 +1452,140 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
 
+int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
+			      unsigned int *extent_gen_num)
+{
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_dc_extents *dc_extents;
+	struct cxl_mbox_get_dc_extent get_dc_extent;
+	unsigned int total_extent_cnt;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	/* Check GET_DC_EXTENT_LIST is supported by device */
+	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
+		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
+		return 0;
+	}
+
+	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
+	if (!dc_extents)
+		return -ENOMEM;
+
+	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
+		.extent_cnt = 0,
+		.start_extent_index = 0,
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+		.payload_in = &get_dc_extent,
+		.size_in = sizeof(get_dc_extent),
+		.size_out = mds->payload_size,
+		.payload_out = dc_extents,
+		.min_out = 1,
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		goto out;
+
+	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
+	*extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
+	dev_dbg(dev, "Total extent count :%d Extent list Generation Num: %d\n",
+			total_extent_cnt, *extent_gen_num);
+out:
+
+	kvfree(dc_extents);
+	if (rc < 0)
+		return rc;
+
+	return total_extent_cnt;
+
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);
+
+int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
+			   unsigned int index, unsigned int cnt)
+{
+	/* See CXL 3.0 Table 125 dynamic capacity config  Output Payload */
+	struct device *dev = mds->cxlds.dev;
+	struct cxl_mbox_dc_extents *dc_extents;
+	struct cxl_mbox_get_dc_extent get_dc_extent;
+	unsigned int extent_gen_num, available_extents, total_extent_cnt;
+	int rc;
+	struct cxl_dc_extent_data *extent;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct range alloc_range;
+
+	/* Check GET_DC_EXTENT_LIST is supported by device */
+	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
+		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
+		return 0;
+	}
+
+	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
+	if (!dc_extents)
+		return -ENOMEM;
+	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
+		.extent_cnt = cnt,
+		.start_extent_index = index,
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
+		.payload_in = &get_dc_extent,
+		.size_in = sizeof(get_dc_extent),
+		.size_out = mds->payload_size,
+		.payload_out = dc_extents,
+		.min_out = 1,
+	};
+	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	if (rc < 0)
+		goto out;
+
+	available_extents = le32_to_cpu(dc_extents->ret_extent_cnt);
+	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
+	extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
+	dev_dbg(dev, "No Total extent count :%d Extent list Generation Num:%d\n",
+			total_extent_cnt, extent_gen_num);
+
+
+	for (int i = 0; i < available_extents ; i++) {
+		extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
+		if (!extent) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		extent->dpa_start = le64_to_cpu(dc_extents->extent[i].start_dpa);
+		extent->length = le64_to_cpu(dc_extents->extent[i].length);
+		memcpy(extent->tag, dc_extents->extent[i].tag,
+					sizeof(dc_extents->extent[i].tag));
+		extent->shared_extent_seq =
+				le16_to_cpu(dc_extents->extent[i].shared_extn_seq);
+		dev_dbg(dev, "dynamic capacity extent[%d] DPA:0x%llx LEN:%llx\n",
+				i, extent->dpa_start, extent->length);
+
+		alloc_range = (struct range){
+			.start = extent->dpa_start,
+			.end = extent->dpa_start + extent->length - 1,
+		};
+
+		rc = cxl_add_dc_extent(mds, &alloc_range);
+		if (rc < 0)
+			goto out;
+		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
+				GFP_KERNEL);
+	}
+
+out:
+	kvfree(dc_extents);
+	if (rc < 0)
+		return rc;
+
+	return available_extents;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extents, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
@@ -1452,6 +1794,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
+	xa_init(&mds->dc_extent_list);
 
 	return mds;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 144232c8305e..ba45c1c3b0a9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/memregion.h>
+#include <linux/interrupt.h>
 #include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -11,6 +12,8 @@
 #include <cxlmem.h>
 #include <cxl.h>
 #include "core.h"
+#include "../../dax/bus.h"
+#include "../../dax/dax-private.h"
 
 /**
  * DOC: cxl core region
@@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 	return 0;
 }
 
+static int cxl_region_manage_dc(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	unsigned int extent_gen_num;
+	int i, rc;
+
+	/* Designed for Non Interleaving flow with the assumption one
+	 * cxl_region will map the complete device DC region's DPA range
+	 */
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+		rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
+		if (rc < 0)
+			goto err;
+		else if (rc > 1) {
+			rc = cxl_dev_get_dc_extents(mds, rc, 0);
+			if (rc < 0)
+				goto err;
+			mds->num_dc_extents = rc;
+			mds->dc_extents_index = rc - 1;
+		}
+		mds->dc_list_gen_num = extent_gen_num;
+		dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n", rc);
+	}
+	return 0;
+err:
+	return rc;
+}
+
 static int commit_decoder(struct cxl_decoder *cxld)
 {
 	struct cxl_switch_decoder *cxlsd = NULL;
@@ -2865,11 +2900,14 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
 		return PTR_ERR(cxlr_dax);
 
 	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
-	if (!cxlr_dc) {
-		rc = -ENOMEM;
-		goto err;
-	}
+	if (!cxlr_dc)
+		return -ENOMEM;
 
+	rc = request_module("dax_cxl");
+	if (rc) {
+		dev_err(dev, "failed to load dax-ctl module\n");
+		goto load_err;
+	}
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
@@ -2891,10 +2929,24 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
 	xa_init(&cxlr_dc->dax_dev_list);
 	cxlr->cxlr_dc = cxlr_dc;
 	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
-	if (!rc)
-		return 0;
+	if (rc)
+		goto err;
+
+	if (!dev->driver) {
+		dev_err(dev, "%s Driver not attached\n", dev_name(dev));
+		rc = -ENXIO;
+		goto err;
+	}
+
+	rc = cxl_region_manage_dc(cxlr);
+	if (rc)
+		goto err;
+
+	return 0;
+
 err:
 	put_device(dev);
+load_err:
 	kfree(cxlr_dc);
 	return rc;
 }
@@ -3076,6 +3128,156 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
 
+static int match_ep_decoder_by_range(struct device *dev, void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct range *dpa_range = data;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	if (!cxled->cxld.region)
+		return 0;
+
+	if (cxled->dpa_res->start <= dpa_range->start &&
+				cxled->dpa_res->end >= dpa_range->end)
+		return 1;
+
+	return 0;
+}
+
+int cxl_release_dc_extent(struct cxl_memdev_state *mds,
+			  struct range *rel_range)
+{
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dc_region *cxlr_dc;
+	struct dax_region *dax_region;
+	resource_size_t dpa_offset;
+	struct cxl_region *cxlr;
+	struct range hpa_range;
+	struct dev_dax *dev_dax;
+	resource_size_t hpa;
+	struct device *dev;
+	int ranges, rc = 0;
+
+	/*
+	 * Find the cxl endpoind decoder with which has the extent dpa range and
+	 * get the cxl_region, dax_region refrences.
+	 */
+	dev = device_find_child(&cxlmd->endpoint->dev, rel_range,
+				match_ep_decoder_by_range);
+	if (!dev) {
+		dev_err(mds->cxlds.dev, "%pr not mapped\n", rel_range);
+		return PTR_ERR(dev);
+	}
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	hpa_range = cxled->cxld.hpa_range;
+	cxlr = cxled->cxld.region;
+	cxlr_dc = cxlr->cxlr_dc;
+
+	/* DPA to HPA translation */
+	if (cxled->cxld.interleave_ways == 1) {
+		dpa_offset = rel_range->start - cxled->dpa_res->start;
+		hpa = hpa_range.start + dpa_offset;
+	} else {
+		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
+		return -EINVAL;
+	}
+
+	dev_dax = xa_load(&cxlr_dc->dax_dev_list, hpa);
+	if (!dev_dax)
+		return -EINVAL;
+
+	dax_region = dev_dax->region;
+	ranges = dev_dax->nr_range;
+
+	while (ranges) {
+		int i = ranges - 1;
+		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
+
+		devm_release_action(dax_region->dev, unregister_dax_mapping,
+								&mapping->dev);
+		ranges--;
+	}
+
+	dev_dbg(mds->cxlds.dev, "removing devdax device:%s\n",
+						dev_name(&dev_dax->dev));
+	devm_release_action(dax_region->dev, unregister_dev_dax,
+							&dev_dax->dev);
+	xa_erase(&cxlr_dc->dax_dev_list, hpa);
+
+	return rc;
+}
+
+int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range)
+{
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dax_region *cxlr_dax;
+	struct cxl_dc_region *cxlr_dc;
+	struct dax_region *dax_region;
+	resource_size_t dpa_offset;
+	struct dev_dax_data data;
+	struct dev_dax *dev_dax;
+	struct cxl_region *cxlr;
+	struct range hpa_range;
+	resource_size_t hpa;
+	struct device *dev;
+	int rc;
+
+	/*
+	 * Find the cxl endpoind decoder with which has the extent dpa range and
+	 * get the cxl_region, dax_region refrences.
+	 */
+	dev = device_find_child(&cxlmd->endpoint->dev, alloc_range,
+				match_ep_decoder_by_range);
+	if (!dev) {
+		dev_err(mds->cxlds.dev, "%pr not mapped\n",	alloc_range);
+		return PTR_ERR(dev);
+	}
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	hpa_range = cxled->cxld.hpa_range;
+	cxlr = cxled->cxld.region;
+	cxlr_dc = cxlr->cxlr_dc;
+	cxlr_dax = cxlr_dc->cxlr_dax;
+	dax_region = dev_get_drvdata(&cxlr_dax->dev);
+
+	/* DPA to HPA translation */
+	if (cxled->cxld.interleave_ways == 1) {
+		dpa_offset = alloc_range->start - cxled->dpa_res->start;
+		hpa = hpa_range.start + dpa_offset;
+	} else {
+		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
+		return -EINVAL;
+	}
+
+	data = (struct dev_dax_data) {
+		.dax_region = dax_region,
+		.id = -1,
+		.size = 0,
+	};
+
+	dev_dax = devm_create_dev_dax(&data);
+	if (IS_ERR(dev_dax))
+		return PTR_ERR(dev_dax);
+
+	if (IS_ALIGNED(range_len(alloc_range), max_t(unsigned long,
+				dev_dax->align, memremap_compat_align()))) {
+		rc = alloc_dev_dax_range(dev_dax, hpa,
+					range_len(alloc_range));
+		if (rc)
+			return rc;
+	}
+
+	rc = xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
+
+	return rc;
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a0b5819bc70b..e11651255780 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -122,7 +122,8 @@ TRACE_EVENT(cxl_aer_correctable_error,
 		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
 		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
 		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
-		{ CXL_EVENT_TYPE_FATAL, "Fatal" })
+		{ CXL_EVENT_TYPE_FATAL, "Fatal" },		\
+		{ CXL_EVENT_TYPE_DCD, "DCD" })
 
 TRACE_EVENT(cxl_overflow,
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7ac1237938b7..60c436b7ebb1 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -163,11 +163,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
 #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
 #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
+#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
 
 #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
 				 CXLDEV_EVENT_STATUS_WARN |	\
 				 CXLDEV_EVENT_STATUS_FAIL |	\
-				 CXLDEV_EVENT_STATUS_FATAL)
+				 CXLDEV_EVENT_STATUS_FATAL|	\
+				 CXLDEV_EVENT_STATUS_DCD)
 
 /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
 #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 9c0b2fa72bdd..0440b5c04ef6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/xarray.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -226,6 +227,7 @@ struct cxl_event_interrupt_policy {
 	u8 warn_settings;
 	u8 failure_settings;
 	u8 fatal_settings;
+	u8 dyncap_settings;
 } __packed;
 
 /**
@@ -296,6 +298,13 @@ enum cxl_devtype {
 #define CXL_MAX_DC_REGION 8
 #define CXL_DC_REGION_SRTLEN 8
 
+struct cxl_dc_extent_data {
+	u64 dpa_start;
+	u64 length;
+	u8 tag[16];
+	u16 shared_extent_seq;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -406,6 +415,11 @@ struct cxl_memdev_state {
 		u8 flags;
 	} dc_region[CXL_MAX_DC_REGION];
 
+	u32 dc_list_gen_num;
+	u32 dc_extents_index;
+	struct xarray dc_extent_list;
+	u32 num_dc_extents;
+
 	size_t dc_event_log_size;
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
@@ -470,6 +484,17 @@ enum cxl_opcode {
 	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
 
+
+struct cxl_mbox_dc_response {
+	__le32 extent_list_size;
+	u8 reserved[4];
+	struct updated_extent_list {
+		__le64 dpa_start;
+		__le64 length;
+		u8 reserved[8];
+	} __packed extent_list[];
+} __packed;
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];
@@ -555,6 +580,7 @@ enum cxl_event_log_type {
 	CXL_EVENT_TYPE_WARN,
 	CXL_EVENT_TYPE_FAIL,
 	CXL_EVENT_TYPE_FATAL,
+	CXL_EVENT_TYPE_DCD,
 	CXL_EVENT_TYPE_MAX
 };
 
@@ -639,6 +665,35 @@ struct cxl_event_mem_module {
 	u8 reserved[0x3d];
 } __packed;
 
+/*
+ * Dynamic Capacity Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.5; Table 8-47
+ */
+
+#define CXL_EVENT_DC_TAG_SIZE	0x10
+struct cxl_dc_extent {
+	__le64 start_dpa;
+	__le64 length;
+	u8 tag[CXL_EVENT_DC_TAG_SIZE];
+	__le16 shared_extn_seq;
+	u8 reserved[6];
+} __packed;
+
+struct dcd_record_data {
+	u8 event_type;
+	u8 reserved;
+	__le16 host_id;
+	u8 region_index;
+	u8 reserved1[3];
+	struct cxl_dc_extent extent;
+	u8 reserved2[32];
+} __packed;
+
+struct dcd_event_dyn_cap {
+	struct cxl_event_record_hdr hdr;
+	struct dcd_record_data data;
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;
@@ -684,6 +739,19 @@ struct cxl_mbox_dynamic_capacity {
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 #define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
 
+struct cxl_mbox_get_dc_extent {
+	__le32 extent_cnt;
+	__le32 start_extent_index;
+} __packed;
+
+struct cxl_mbox_dc_extents {
+	__le32 ret_extent_cnt;
+	__le32 total_extent_cnt;
+	__le32 extent_list_num;
+	u8 rsvd[4];
+	struct cxl_dc_extent extent[];
+}  __packed;
+
 /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
 struct cxl_mbox_set_timestamp_in {
 	__le64 timestamp;
@@ -826,6 +894,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+/* FIXME why not have these be static in mbox.c? */
+int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range);
+int cxl_release_dc_extent(struct cxl_memdev_state *mds, struct range *rel_range);
+int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
+			      unsigned int *extent_gen_num);
+int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds, unsigned int cnt,
+			   unsigned int index);
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ac1a41bc083d..558ffbcb9b34 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -522,8 +522,8 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 		return irq;
 
 	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
-					 IRQF_SHARED | IRQF_ONESHOT, NULL,
-					 dev_id);
+					IRQF_SHARED | IRQF_ONESHOT, NULL,
+					dev_id);
 }
 
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
@@ -555,6 +555,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 		.warn_settings = CXL_INT_MSI_MSIX,
 		.failure_settings = CXL_INT_MSI_MSIX,
 		.fatal_settings = CXL_INT_MSI_MSIX,
+		.dyncap_settings = CXL_INT_MSI_MSIX,
 	};
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -608,6 +609,11 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
 		return rc;
 	}
 
+	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings);
+	if (rc) {
+		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
+		return rc;
+	}
 	return 0;
 }
 
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 227800053309..b2b27033f589 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -434,7 +434,7 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)
 		trim_dev_dax_range(dev_dax);
 }
 
-static void unregister_dev_dax(void *dev)
+void unregister_dev_dax(void *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
@@ -445,6 +445,7 @@ static void unregister_dev_dax(void *dev)
 	free_dev_dax_ranges(dev_dax);
 	put_device(dev);
 }
+EXPORT_SYMBOL_GPL(unregister_dev_dax);
 
 /* a return value >= 0 indicates this invocation invalidated the id */
 static int __free_dev_dax_id(struct dev_dax *dev_dax)
@@ -641,7 +642,7 @@ static void dax_mapping_release(struct device *dev)
 	kfree(mapping);
 }
 
-static void unregister_dax_mapping(void *data)
+void unregister_dax_mapping(void *data)
 {
 	struct device *dev = data;
 	struct dax_mapping *mapping = to_dax_mapping(dev);
@@ -658,7 +659,7 @@ static void unregister_dax_mapping(void *data)
 	device_del(dev);
 	put_device(dev);
 }
-
+EXPORT_SYMBOL_GPL(unregister_dax_mapping);
 static struct dev_dax_range *get_dax_range(struct device *dev)
 {
 	struct dax_mapping *mapping = to_dax_mapping(dev);
@@ -793,7 +794,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
-static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
+int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		resource_size_t size)
 {
 	struct dax_region *dax_region = dev_dax->region;
@@ -853,6 +854,8 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(alloc_dev_dax_range);
+
 
 static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
 {
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 8cd79ab34292..aa8418c7aead 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -47,8 +47,11 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
 	__dax_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
 void dax_driver_unregister(struct dax_device_driver *dax_drv);
 void kill_dev_dax(struct dev_dax *dev_dax);
+void unregister_dev_dax(void *dev);
+void unregister_dax_mapping(void *data);
 bool static_dev_dax(struct dev_dax *dev_dax);
-
+int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
+					resource_size_t size);
 /*
  * While run_dax() is potentially a generic operation that could be
  * defined in include/linux/dax.h we don't want to grow any users

-- 
2.40.0

