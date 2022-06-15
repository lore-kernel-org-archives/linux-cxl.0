Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A86C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Jun 2022 00:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiFOAK6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiFOAKw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Jun 2022 20:10:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4632C31356;
        Tue, 14 Jun 2022 17:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655251851; x=1686787851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nu1sRFuhuPRHQby7CWmOe+Fl1IDvKYrgdKkIDvgU/T8=;
  b=E3FBejEgmc5S/58yxsJqgesXqZwfXyEAkCdYppz8ef7xeg4C5IZDfzx7
   I2XOyJ57XLJTUuKWzfGq050BMgy1spfbqwWYgLYKBw4XT87eoT+rl1TZR
   6xpUyOu5eQfQCLVBS1tVxwFYDEBbVzSWSZeyVdhYcKd1F14ZNTaTsQp1H
   H6kgevPfYEc0p+zbdS9LlsIRSL+Lo1bIvhdWd9BtWb9uxRtfxmpVZk/QS
   G3SuC6IBPks1qC0ojGcYJ1ebPkXp4seHiyGKtD59+NidmBMZ4FCKTivTJ
   dwlSwB/0AyuU3EqqtYK6H55y6UaZxGzLQc3yhzRzB67kmmh37a0YpZANV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278825448"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278825448"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640662873"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:49 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] trace, cxl: Introduce a TRACE_EVENT for CXL Poison Records
Date:   Tue, 14 Jun 2022 17:10:26 -0700
Message-Id: <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Add a trace event for CXL Poison List Media Error Records that
includes the starting DPA of the poison, the length, and the
the source of the poison.

This trace event will be used by the CXL_MEM driver to log the
Media Errors returned by the GET_POISON_LIST Mailbox command.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 include/trace/events/cxl.h | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 include/trace/events/cxl.h

diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
new file mode 100644
index 000000000000..17e707c3817e
--- /dev/null
+++ b/include/trace/events/cxl.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cxl
+
+#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
+#define _CXL_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_UNKNOWN);
+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INTERNAL);
+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_EXTERNAL);
+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INJECTED);
+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_VENDOR);
+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INVALID);
+
+#define show_poison_source(source)					\
+	__print_symbolic(source,					\
+			{CXL_POISON_SOURCE_UNKNOWN,  "UNKNOWN"},	\
+			{CXL_POISON_SOURCE_EXTERNAL, "EXTERNAL"},	\
+			{CXL_POISON_SOURCE_INTERNAL, "INTERNAL"},	\
+			{CXL_POISON_SOURCE_INJECTED, "INJECTED"},	\
+			{CXL_POISON_SOURCE_VENDOR,   "VENDOR"},		\
+			{CXL_POISON_SOURCE_INVALID,  "INVALID"})
+
+TRACE_EVENT(cxl_poison_list,
+
+	    TP_PROTO(struct device *dev,
+		     int source,
+		     unsigned long start,
+		     unsigned int length),
+
+	    TP_ARGS(dev, source, start, length),
+
+	    TP_STRUCT__entry(
+		__string(name, dev_name(dev))
+		__field(int, source)
+		__field(u64, start)
+		__field(u32, length)
+	    ),
+
+	    TP_fast_assign(
+		__assign_str(name, dev_name(dev));
+		__entry->source = source;
+		__entry->start = start;
+		__entry->length = length;
+	    ),
+
+	    TP_printk("dev %s source %s start %llu length %u",
+		__get_str(name),
+		show_poison_source(__entry->source),
+		__entry->start,
+		__entry->length)
+);
+#endif /* _CXL_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE cxl
+#include <trace/define_trace.h>
-- 
2.31.1

