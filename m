Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C800C433E6
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 02:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F5464EDA
	for <linux-cxl@archiver.kernel.org>; Fri, 19 Feb 2021 02:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhBSCFU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 Feb 2021 21:05:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:50640 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhBSCFU (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 18 Feb 2021 21:05:20 -0500
IronPort-SDR: fWAbqilkfsoUfraUhML8d/YWAL8ewrSlx48U9KE6CiWtT7US6qRaZ1CzRER6XlR3bpFaDVx9u4
 21LFRdvhwH9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="162854724"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="162854724"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:55 -0800
IronPort-SDR: CACyJKUsYqJyJa2GbfO5zIR0aDiQrkQa+UTEsxeZqjhTAQGTpZ0Ynp7ck3T22GoFFIZRlDktUP
 NQ545vFokTHw==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="513509678"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:54 -0800
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     <linux-nvdimm@lists.01.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH v2 10/13] util/hexdump: Add a util helper to print a buffer in hex
Date:   Thu, 18 Feb 2021 19:03:28 -0700
Message-Id: <20210219020331.725687-11-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for tests that may need to set, retrieve, and display
opaque data, add a hexdump function in util.

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
2.29.2

