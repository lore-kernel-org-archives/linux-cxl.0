Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A2C77B76
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDSD0s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSD0r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB310CF
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874805; x=1713410805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0r645ngRLXhJ2JS/XgUunSp01f80mlWq/diDW0CQGWE=;
  b=j0H41cWKZeYe6PGJoD7K4QXWHf5lLHY5c0DR8PZMRd9cE5AN7qFt88Wn
   fuWjgLtV4IjjacRD/5nAnw9eULzGRfL18Jb180jk/3NFopdmGxludf3rC
   9oTr1w+TFtLcuIB/pKiPQHgFF+ylTGl7Z7s7D0jyPDh93ogUr2KidolP9
   5kAIuXTwAxTf7KzYnRrpUA+3oD7ByNdlzUPe/V5H58al+XJVeufjxi3fg
   Sy48PAJKgWFG87UOHMKaQr3meFViqll1AdQzhrvC6uJtGzcDWzZCyfbSV
   zd2protxtapVRpFpOfzG5FK14Q0FTOZV2FXl2eUbDR0LMhEImn9PwslOv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621712"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621712"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711111"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711111"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:44 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 04/10] cxl/memdev: Trace inject and clear poison as cxl_poison events
Date:   Tue, 18 Apr 2023 20:26:28 -0700
Message-Id: <e20eb7c3029137b480ece671998c183da0477e2e.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

The cxl_poison trace event allows users to view the history of poison
list reads. With the addition of inject and clear poison capabilities,
users will expect similar tracing.

Add trace types 'Inject' and 'Clear' to the cxl_poison trace_event and
trace successful operations only.

If the driver finds that the DPA being injected or cleared of poison
is mapped in a region, that region info is included in the cxl_poison
trace event. Region reconfigurations can make this extra info useless
if the debug operations are not carefully managed.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h   |  2 ++
 drivers/cxl/core/memdev.c | 15 +++++++++++++++
 drivers/cxl/core/trace.h  |  8 +++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index deb5f87d6d0a..27f0968449de 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -71,6 +71,8 @@ void cxl_mbox_init(void);
 
 enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_LIST,
+	CXL_POISON_TRACE_INJECT,
+	CXL_POISON_TRACE_CLEAR,
 };
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 23ac8d322b37..274c741ea219 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -6,6 +6,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "trace.h"
 #include "core.h"
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
@@ -232,6 +233,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_mbox_inject_poison inject;
+	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_region *cxlr;
 	int rc;
@@ -261,6 +263,12 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (cxlr)
 		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",
 			      dpa, dev_name(&cxlr->dev));
+
+	record = (struct cxl_poison_record) {
+		.address = cpu_to_le64(dpa),
+		.length = cpu_to_le32(1),
+	};
+	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
 out:
 	up_read(&cxl_dpa_rwsem);
 
@@ -272,6 +280,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_mbox_clear_poison clear;
+	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_region *cxlr;
 	int rc;
@@ -310,6 +319,12 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (cxlr)
 		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",
 			      dpa, dev_name(&cxlr->dev));
+
+	record = (struct cxl_poison_record) {
+		.address = cpu_to_le64(dpa),
+		.length = cpu_to_le32(1),
+	};
+	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
 out:
 	up_read(&cxl_dpa_rwsem);
 
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 220cc7e721b8..a0b5819bc70b 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -602,9 +602,11 @@ TRACE_EVENT(cxl_memory_module,
 	)
 );
 
-#define show_poison_trace_type(type)		   \
-	__print_symbolic(type,			   \
-	{ CXL_POISON_TRACE_LIST,	"List"	})
+#define show_poison_trace_type(type)			\
+	__print_symbolic(type,				\
+	{ CXL_POISON_TRACE_LIST,	"List"   },	\
+	{ CXL_POISON_TRACE_INJECT,	"Inject" },	\
+	{ CXL_POISON_TRACE_CLEAR,	"Clear"  })
 
 #define __show_poison_source(source)                          \
 	__print_symbolic(source,                              \
-- 
2.37.3

