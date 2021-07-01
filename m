Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27023C11F72
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1449161411
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jul 2021 20:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhGAUMy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jul 2021 16:12:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:63968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233909AbhGAUMy (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Jul 2021 16:12:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="208653232"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="208653232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:20 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="409271363"
Received: from anandvig-mobl.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.38.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 13:10:19 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v3 11/21] util/hexdump: Add a util helper to print a buffer in hex
Date:   Thu,  1 Jul 2021 14:09:55 -0600
Message-Id: <20210701201005.3065299-12-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210701201005.3065299-1-vishal.l.verma@intel.com>
References: <20210701201005.3065299-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for tests that may need to set, retrieve, and display
opaque data, add a hexdump function in util/

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 util/hexdump.h |  8 ++++++++
 util/hexdump.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 util/hexdump.h
 create mode 100644 util/hexdump.c

diff --git a/util/hexdump.h b/util/hexdump.h
new file mode 100644
index 0000000..d322b6a
--- /dev/null
+++ b/util/hexdump.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation. All rights reserved. */
+#ifndef _UTIL_HEXDUMP_H_
+#define _UTIL_HEXDUMP_H_
+
+void hex_dump_buf(unsigned char *buf, int size);
+
+#endif /* _UTIL_HEXDUMP_H_*/
diff --git a/util/hexdump.c b/util/hexdump.c
new file mode 100644
index 0000000..1ab0118
--- /dev/null
+++ b/util/hexdump.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2015-2021 Intel Corporation. All rights reserved. */
+#include <stdio.h>
+#include <util/hexdump.h>
+
+static void print_separator(int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		fprintf(stderr, "-");
+	fprintf(stderr, "\n");
+}
+
+void hex_dump_buf(unsigned char *buf, int size)
+{
+	int i;
+	const int grp = 4;  /* Number of bytes in a group */
+	const int wid = 16; /* Bytes per line. Should be a multiple of grp */
+	char ascii[wid + 1];
+
+	/* Generate header */
+	print_separator((wid * 4) + (wid / grp) + 12);
+
+	fprintf(stderr, "Offset    ");
+	for (i = 0; i < wid; i++) {
+		if (i % grp == 0) fprintf(stderr, " ");
+		fprintf(stderr, "%02x ", i);
+	}
+	fprintf(stderr, "  Ascii\n");
+
+	print_separator((wid * 4) + (wid / grp) + 12);
+
+	/* Generate hex dump */
+	for (i = 0; i < size; i++) {
+		if (i % wid == 0) fprintf(stderr, "%08x  ", i);
+		ascii[i % wid] =
+		    ((buf[i] >= ' ') && (buf[i] <= '~')) ? buf[i] : '.';
+		if (i % grp == 0) fprintf(stderr, " ");
+		fprintf(stderr, "%02x ", buf[i]);
+		if ((i == size - 1) && (size % wid != 0)) {
+			int j;
+			int done = size % wid;
+			int grps_done = (done / grp) + ((done % grp) ? 1 : 0);
+			int spaces = wid / grp - grps_done + ((wid - done) * 3);
+
+			for (j = 0; j < spaces; j++) fprintf(stderr, " ");
+		}
+		if ((i % wid == wid - 1) || (i == size - 1))
+			fprintf(stderr, "  %.*s\n", (i % wid) + 1, ascii);
+	}
+	print_separator((wid * 4) + (wid / grp) + 12);
+}
-- 
2.31.1

