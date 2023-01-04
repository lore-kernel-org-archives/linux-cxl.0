Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9214C46467
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Jan 2023 21:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjADVEJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbjADVEI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Jan 2023 16:04:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39B1A223
        for <linux-cxl@vger.kernel.org>; Wed,  4 Jan 2023 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672866247; x=1704402247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rja9+I8lpRCqKl2YvoXfltJBfHQAzxC/iz1pMhV+SCE=;
  b=gU8JA/TCoTn4lLeKY+kpRCFoPh3WRu2r/kfWQnXmZFDeLPrq0hHfMs8/
   DLJxRW2eFCoyxYEud0c104sTovFWJUJkeXGBRvjECquRQVaozVdtzTe+z
   6EU/K5zYVIVWRARxVE9aWHMlIuu+gk9W/i0Y7guJE6EjbyhYFtw0r6Xhq
   ZSXnTeL6JZwAiahwlSUcteiib7qaeSz5KOlg7S5QbVf7U2nMHUA+wO9vZ
   rJiU0fc25t1IsodszEK9lFdrYnTiyyzXI4ryYJDhrpdP07x407L9QsIei
   KGeMlEOFFzHW4Z64Plbk9JbipTToP9kZMob16tQOTScJaQqPflbdWPUZ7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301734103"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="301734103"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 13:04:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779336036"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="779336036"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.42.169])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 13:04:06 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/trace: Add an HPA to cxl_poison trace events
Date:   Wed,  4 Jan 2023 13:04:01 -0800
Message-Id: <20230104210401.195808-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When a cxl_poison trace event is reported by region, the poisoned
Device Physical Address (DPA) can be translated to a Host Physical
Address (HPA) for consumption by user space.

Translate and add the resulting HPA to the cxl_poison trace event.
Follow the device decode logic as defined in the CXL Spec 3.0 Section
8.2.4.19.13.

When the poison request is by memdev, no HPA translation is performed
and ULLONG_MAX is assigned to the cxl_poison hpa trace field.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Built on cxl/preview plus Patchset: CXL Poison List Retrieval & Tracing [1]

Changes in v0:
Unusual to have changes in a v0, but since this is based off a prior
patchset [2] that Jonathan had reviewed, carrying the pertinent changelog
here:
- Use ULLONG_MAX as err return in translation (Jonathan)
- HPA 0 is valid address, use ULLONG_MAX for invalid return (Jonathan)
- Replace a slow chunk-checking do-while loop with suggested calc. (Jonathan)
- Update the calcs to directly follow the CXL spec. (Jonathan)

[1] https://lore.kernel.org/linux-cxl/cover.1671135967.git.alison.schofield@intel.com/
[2] https://lore.kernel.org/linux-cxl/cover.1669153711.git.alison.schofield@intel.com/

 drivers/cxl/core/trace.c | 94 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.h |  9 +++-
 2 files changed, 102 insertions(+), 1 deletion(-)

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
index c7958311ce5f..521b80f92e96 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -136,6 +136,8 @@ TRACE_EVENT(cxl_aer_correctable_error,
 #define cxl_poison_overflow(flags, time)				\
 	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
 
+u64 cxl_trace_hpa(struct cxl_region *cxlr, struct cxl_memdev *memdev, u64 dpa);
+
 TRACE_EVENT(cxl_poison,
 
 	    TP_PROTO(struct cxl_memdev *memdev, const struct pci_dev *pcidev,
@@ -150,6 +152,7 @@ TRACE_EVENT(cxl_poison,
 		__string(pcidev, dev_name(&pcidev->dev))
 		__string(region, region)
 		__field(u64, overflow_t)
+		__field(u64, hpa)
 		__field(u64, dpa)
 		__field(u32, length)
 		__array(char, uuid, 16)
@@ -168,17 +171,21 @@ TRACE_EVENT(cxl_poison,
 		if (region) {
 			__assign_str(region, dev_name(&region->dev));
 			memcpy(__entry->uuid, &region->params.uuid, 16);
+			__entry->hpa = cxl_trace_hpa(region, memdev,
+						     __entry->dpa);
 		} else {
 			__assign_str(region, "");
 			memset(__entry->uuid, 0, 16);
+			__entry->hpa = ULLONG_MAX;
 		}
 	    ),
 
-	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
+	    TP_printk("memdev=%s pcidev=%s region=%s region_uuid=%pU hpa=0x%llx dpa=0x%llx length=0x%x source=%s flags=%s overflow_time=%llu",
 		__get_str(memdev),
 		__get_str(pcidev),
 		__get_str(region),
 		__entry->uuid,
+		__entry->hpa,
 		__entry->dpa,
 		__entry->length,
 		show_poison_source(__entry->source),

base-commit: 9b5f77efb0dc71d95403b528756e39b6cae0b948
prerequisite-patch-id: 9b1057bd203e74ccce389c8b564bcb587bdf96c2
prerequisite-patch-id: 9575915f2ee75f6d3121dd0deff2e8e83fc9d65e
prerequisite-patch-id: d1fff988bf70bbe437d448e32ffb582aedbce8fe
prerequisite-patch-id: c7e7a448e543dbee69a3d7133f5074be12556abf
prerequisite-patch-id: bb4baf87391645e151dc7c0becf11b8795f9f969
prerequisite-patch-id: 6b0bb1d874e57e0007705b21460972723fd9be90
prerequisite-patch-id: aa4578d50c0a406d3e87045eeb5b3b51ca2c5e83
-- 
2.37.3

