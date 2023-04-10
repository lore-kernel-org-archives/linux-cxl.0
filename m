Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F339C77B6F
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Apr 2023 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDJU43 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDJU43 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Apr 2023 16:56:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F742681
        for <linux-cxl@vger.kernel.org>; Mon, 10 Apr 2023 13:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681160163; x=1712696163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tyMqj3O9qmbkVT4s7uKv+wYvkOnhYi9Pllh5Hx4bqsk=;
  b=H/eFnKtJY1YLKzB2vEsaORngCXuFo+S3j0Xb9IgA5jEfV4XXwq2J6uCy
   37SdC+CtWXqpdgcVToRIArolaouhpaU7mTEx/ChswYhg2VcRmJdkm/ENe
   dZFeHmyV2YTIfnE+Ci5fflqVPfgTyOdIYaVvCij2/KJqhRuWgug1w4fMn
   JxvT3C3bIhlyA5aWVYBQA8UVBUW0lFuAK8gw/l2pYRqlWv9iW9pf+pBc7
   bl6Hpb5kfpzxCu0Ylv8YU1apqz84cXWsutmmAb4gTul8ezfo1w9SvbqBH
   TtsxaiX0LReDbGkTS7kiBAG9nNhISCXC2TVQyQ8xHxvrEkj4xoh6u5oNz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="371295543"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="371295543"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688375781"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="688375781"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.230.103])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:55:35 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 5/6] cxl/trace: Add an HPA to cxl_poison trace events
Date:   Mon, 10 Apr 2023 13:55:24 -0700
Message-Id: <fdd22364b0e9588fd280832f20365d8846fcb989.1681159309.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681159309.git.alison.schofield@intel.com>
References: <cover.1681159309.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When a cxl_poison trace event is reported for a region, the poisoned
Device Physical Address (DPA) can be translated to a Host Physical
Address (HPA) for consumption by user space.

Translate and add the resulting HPA to the cxl_poison trace event.
Follow the device decode logic as defined in the CXL Spec 3.0 Section
8.2.4.19.13.

If no region currently maps the poison, assign ULLONG_MAX to the
cxl_poison event hpa field.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h | 11 ++++-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index 29ae7ce81dc5..d0403dc3c8ab 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -1,5 +1,99 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
+#include <cxl.h>
+#include "core.h"
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
+
+static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int gran = p->interleave_granularity;
+	int ways = p->interleave_ways;
+	u64 offset;
+
+	/* Is the hpa within this region at all */
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return false;
+	}
+
+	/* Is the hpa in an expected chunk for its pos(-ition) */
+	offset = hpa - p->res->start;
+	offset = do_div(offset, gran * ways);
+	if ((offset >= pos * gran) && (offset < (pos + 1) * gran))
+		return true;
+
+	dev_dbg(&cxlr->dev,
+		"Addr trans fail: hpa 0x%llx not in expected chunk\n", hpa);
+
+	return false;
+}
+
+static u64 cxl_dpa_to_hpa(u64 dpa,  struct cxl_region *cxlr,
+			  struct cxl_endpoint_decoder *cxled)
+{
+	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
+	struct cxl_region_params *p = &cxlr->params;
+	int pos = cxled->pos;
+	u16 eig = 0;
+	u8 eiw = 0;
+
+	ways_to_eiw(p->interleave_ways, &eiw);
+	granularity_to_eig(p->interleave_granularity, &eig);
+
+	/*
+	 * The device position in the region interleave set was removed
+	 * from the offset at HPA->DPA translation. To reconstruct the
+	 * HPA, place the 'pos' in the offset.
+	 *
+	 * The placement of 'pos' in the HPA is determined by interleave
+	 * ways and granularity and is defined in the CXL Spec 3.0 Section
+	 * 8.2.4.19.13 Implementation Note: Device Decode Logic
+	 */
+
+	/* Remove the dpa base */
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+
+	mask_upper = GENMASK_ULL(51, eig + 8);
+
+	if (eiw < 8) {
+		hpa_offset = (dpa_offset & mask_upper) << eiw;
+		hpa_offset |= pos << (eig + 8);
+	} else {
+		bits_upper = (dpa_offset & mask_upper) >> (eig + 8);
+		bits_upper = bits_upper * 3;
+		hpa_offset = ((bits_upper << (eiw - 8)) + pos) << (eig + 8);
+	}
+
+	/* The lower bits remain unchanged */
+	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
+
+	/* Apply the hpa_offset to the region base address */
+	hpa = hpa_offset + p->res->start;
+
+	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+		return ULLONG_MAX;
+
+	return hpa;
+}
+
+u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *cxlmd,
+		  u64 dpa)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled = NULL;
+
+	for (int i = 0; i <  p->nr_targets; i++) {
+		cxled = p->targets[i];
+		if (cxlmd == cxled_to_memdev(cxled))
+			break;
+	}
+	if (!cxled || cxlmd != cxled_to_memdev(cxled))
+		return ULLONG_MAX;
+
+	return cxl_dpa_to_hpa(dpa, cxlr, cxled);
+}
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 2687a2c6fbfa..65d81d27cb85 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -636,6 +636,8 @@ TRACE_EVENT(cxl_memory_module,
 #define cxl_poison_overflow(flags, time)				\
 	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
 
+u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
+
 TRACE_EVENT(cxl_poison,
 
 	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
@@ -651,6 +653,7 @@ TRACE_EVENT(cxl_poison,
 		__field(u8, trace_type)
 		__string(region, region)
 		__field(u64, overflow_t)
+		__field(u64, hpa)
 		__field(u64, dpa)
 		__field(u32, dpa_length)
 		__array(char, uuid, 16)
@@ -671,21 +674,25 @@ TRACE_EVENT(cxl_poison,
 		if (region) {
 			__assign_str(region, dev_name(&region->dev));
 			memcpy(__entry->uuid, &region->params.uuid, 16);
+			__entry->hpa = cxl_trace_hpa(region, cxlmd,
+						     __entry->dpa);
 		} else {
 			__assign_str(region, "");
 			memset(__entry->uuid, 0, 16);
+			__entry->hpa = ULLONG_MAX;
 		}
 	    ),
 
 	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s "  \
-		"region_uuid=%pU dpa=0x%llx dpa_length=0x%x source=%s "     \
-		"flags=%s overflow_time=%llu",
+		"region_uuid=%pU hpa=0x%llx dpa=0x%llx dpa_length=0x%x "    \
+		"source=%s flags=%s overflow_time=%llu",
 		__get_str(memdev),
 		__get_str(host),
 		__entry->serial,
 		show_poison_trace_type(__entry->trace_type),
 		__get_str(region),
 		__entry->uuid,
+		__entry->hpa,
 		__entry->dpa,
 		__entry->dpa_length,
 		show_poison_source(__entry->source),
-- 
2.37.3

