Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F3DC761AF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC0FCV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjC0FCV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:02:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD43A8C
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893339; x=1711429339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pAFga0FgaGT07CW90wjOARHpemkPoduhOqTy+pRCdKo=;
  b=Ih6Uw83yyeYu0GdgnVQCk90guzvmbZOX2QQB/EMVV0pwr1SYCp7uAC1f
   fGTqhqE/9LIsiHUNvaBvZF4lqm7K3wqlzhvlCqKnaeP73A9ie3KA+UBQc
   Do8eug9K2Bt0xMbHiJpPjGTjz4mzQh0EwGmg78ro74KKgdj1iSdWkG4Vk
   RnAYKSkIkWSRmHFqskLr63Zr8HnT2PUHCOQW/Tby8Ltrn1gOq/gTTfwve
   RvA2SY+wjTio+nLjwv+aMWCSfEasuU6q7F2qFiVJQJOyN8HCbzXkzjxEX
   3ajVcikkNAZ5iOBuV9KqfKRigJHEo2ahYPqkRcylMLPG5eyEJc8iwSVtn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="341753854"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="341753854"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="747856150"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="747856150"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:02:18 -0700
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
Subject: [PATCH v11 2/6] cxl/trace: Add TRACE support for CXL media-error records
Date:   Sun, 26 Mar 2023 22:02:08 -0700
Message-Id: <0232ba1799a982795b8ad8115d10b664de0cf937.1679888450.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679888450.git.alison.schofield@intel.com>
References: <cover.1679888450.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices may support the retrieval of a device poison list.
Add a new trace event that the CXL subsystem may use to log
the media-error records returned in the poison list.

Log each media-error record as a cxl_poison trace event of
type 'List'.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h  |  4 ++
 drivers/cxl/core/mbox.c  |  5 ++-
 drivers/cxl/core/trace.h | 94 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index cde475e13216..e888e293943e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -64,4 +64,8 @@ int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
 
+enum cxl_poison_trace_type {
+	CXL_POISON_TRACE_LIST,
+};
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0da0a30511f2..a8369ef56f61 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1147,7 +1147,10 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		if (rc)
 			break;
 
-		/* TODO TRACE the media error records */
+		for (int i = 0; i < le16_to_cpu(po->count); i++)
+			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
+					 po->flags, po->overflow_t,
+					 CXL_POISON_TRACE_LIST);
 
 		/* Protect against an uncleared _FLAG_MORE */
 		nr_records = nr_records + le16_to_cpu(po->count);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 9b8d3d997834..2687a2c6fbfa 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -7,10 +7,12 @@
 #define _CXL_EVENTS_H
 
 #include <linux/tracepoint.h>
+#include <linux/pci.h>
 #include <asm-generic/unaligned.h>
 
 #include <cxl.h>
 #include <cxlmem.h>
+#include "core.h"
 
 #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
 #define CXL_RAS_UC_CACHE_ADDR_PARITY	BIT(1)
@@ -600,6 +602,98 @@ TRACE_EVENT(cxl_memory_module,
 	)
 );
 
+#define show_poison_trace_type(type)		   \
+	__print_symbolic(type,			   \
+	{ CXL_POISON_TRACE_LIST,	"List"	})
+
+#define __show_poison_source(source)                          \
+	__print_symbolic(source,                              \
+		{ CXL_POISON_SOURCE_UNKNOWN,   "Unknown"  },  \
+		{ CXL_POISON_SOURCE_EXTERNAL,  "External" },  \
+		{ CXL_POISON_SOURCE_INTERNAL,  "Internal" },  \
+		{ CXL_POISON_SOURCE_INJECTED,  "Injected" },  \
+		{ CXL_POISON_SOURCE_VENDOR,    "Vendor"   })
+
+#define show_poison_source(source)			     \
+	(((source > CXL_POISON_SOURCE_INJECTED) &&	     \
+	 (source != CXL_POISON_SOURCE_VENDOR)) ? "Reserved"  \
+	 : __show_poison_source(source))
+
+#define show_poison_flags(flags)                             \
+	__print_flags(flags, "|",                            \
+		{ CXL_POISON_FLAG_MORE,      "More"     },   \
+		{ CXL_POISON_FLAG_OVERFLOW,  "Overflow"  },  \
+		{ CXL_POISON_FLAG_SCANNING,  "Scanning"  })
+
+#define __cxl_poison_addr(record)					\
+	(le64_to_cpu(record->address))
+#define cxl_poison_record_dpa(record)					\
+	(__cxl_poison_addr(record) & CXL_POISON_START_MASK)
+#define cxl_poison_record_source(record)				\
+	(__cxl_poison_addr(record)  & CXL_POISON_SOURCE_MASK)
+#define cxl_poison_record_dpa_length(record)				\
+	(le32_to_cpu(record->length) * CXL_POISON_LEN_MULT)
+#define cxl_poison_overflow(flags, time)				\
+	(flags & CXL_POISON_FLAG_OVERFLOW ? le64_to_cpu(time) : 0)
+
+TRACE_EVENT(cxl_poison,
+
+	TP_PROTO(struct cxl_memdev *cxlmd, struct cxl_region *region,
+		 const struct cxl_poison_record *record, u8 flags,
+		 __le64 overflow_t, enum cxl_poison_trace_type trace_type),
+
+	TP_ARGS(cxlmd, region, record, flags, overflow_t, trace_type),
+
+	TP_STRUCT__entry(
+		__string(memdev, dev_name(&cxlmd->dev))
+		__string(host, dev_name(cxlmd->dev.parent))
+		__field(u64, serial)
+		__field(u8, trace_type)
+		__string(region, region)
+		__field(u64, overflow_t)
+		__field(u64, dpa)
+		__field(u32, dpa_length)
+		__array(char, uuid, 16)
+		__field(u8, source)
+		__field(u8, flags)
+	    ),
+
+	TP_fast_assign(
+		__assign_str(memdev, dev_name(&cxlmd->dev));
+		__assign_str(host, dev_name(cxlmd->dev.parent));
+		__entry->serial = cxlmd->cxlds->serial;
+		__entry->overflow_t = cxl_poison_overflow(flags, overflow_t);
+		__entry->dpa = cxl_poison_record_dpa(record);
+		__entry->dpa_length = cxl_poison_record_dpa_length(record);
+		__entry->source = cxl_poison_record_source(record);
+		__entry->trace_type = trace_type;
+		__entry->flags = flags;
+		if (region) {
+			__assign_str(region, dev_name(&region->dev));
+			memcpy(__entry->uuid, &region->params.uuid, 16);
+		} else {
+			__assign_str(region, "");
+			memset(__entry->uuid, 0, 16);
+		}
+	    ),
+
+	TP_printk("memdev=%s host=%s serial=%lld trace_type=%s region=%s "  \
+		"region_uuid=%pU dpa=0x%llx dpa_length=0x%x source=%s "     \
+		"flags=%s overflow_time=%llu",
+		__get_str(memdev),
+		__get_str(host),
+		__entry->serial,
+		show_poison_trace_type(__entry->trace_type),
+		__get_str(region),
+		__entry->uuid,
+		__entry->dpa,
+		__entry->dpa_length,
+		show_poison_source(__entry->source),
+		show_poison_flags(__entry->flags),
+		__entry->overflow_t
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
-- 
2.37.3

