Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF8C77B6C
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjC0FD1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC0FDY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBC04234
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893403; x=1711429403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eOa6PTzsbbOOifFcLKiYSro65LcaKPOf+snM3L6es78=;
  b=YaVeQ59nmDb7L+d1nOSDDyEVAw22lCrVQM1Q6ZSgCm/aHrZcr+R2/NWi
   94r2qfOuWJUCOnLhZo93Q566n8ogUVJZYBjVwqln+uF9RofRz9mDPvP3k
   426uUKfN6o/uFrs2vy/HgrtdDxC7VG3vYhEphYKny81mX2Lcva7vO40ZJ
   liCJ6dyGq8MnmPIOmg2vCFv3J0jzIEkrxzCGDd7FNBZpQW3gX4fdWfulJ
   2ZX26PnhsJlTH/LBv8eLn7gOwQw3GuJyLzJcb56WtWU7OIsQEGZmZXlf1
   axwDkPHgSgXrsEzz/GSgg3xqxhBE0XHVa0ITkJe+apHf6L4Bq/nQCVC20
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920188"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492260"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492260"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:22 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 04/12] cxl/memdev: Trace inject and clear poison as cxl_poison events
Date:   Sun, 26 Mar 2023 22:03:10 -0700
Message-Id: <9074fc4d2ac3fb1aa1c4db7ea55fba85c4f3864a.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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
---
 drivers/cxl/core/core.h   |  2 ++
 drivers/cxl/core/memdev.c | 16 ++++++++++++++++
 drivers/cxl/core/trace.h  |  8 +++++---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 57bd22e01a0b..5b673eca8f12 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -71,6 +71,8 @@ void cxl_mbox_init(void);
 
 enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_LIST,
+	CXL_POISON_TRACE_INJECT,
+	CXL_POISON_TRACE_CLEAR,
 };
 
 struct cxl_trigger_poison_context {
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a83619c31f61..71ebe3795616 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -6,6 +6,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "trace.h"
 #include "core.h"
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
@@ -285,6 +286,7 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mbox_inject_poison inject;
+	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_region *cxlr;
 	int rc;
@@ -313,6 +315,13 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
 	if (cxlr)
 		dev_warn_once(dev, "poison inject dpa:0x%llx region: %s\n",
 			      dpa, dev_name(&cxlr->dev));
+
+	record = (struct cxl_poison_record) {
+		.address = cpu_to_le64(dpa),
+		.length = cpu_to_le32(1),
+	};
+	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
+
 out:
 	up_read(&cxl_dpa_rwsem);
 
@@ -324,6 +333,7 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_mbox_clear_poison clear;
+	struct cxl_poison_record record;
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_region *cxlr;
 	int rc;
@@ -363,6 +373,12 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
 	if (cxlr)
 		dev_warn_once(dev, "poison clear dpa:0x%llx region: %s\n",
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
index 65d81d27cb85..5e5e29995d3e 100644
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

