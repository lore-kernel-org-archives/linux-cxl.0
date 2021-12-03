Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71014C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Dec 2021 19:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382806AbhLCTc1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:32:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:24105 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382867AbhLCTc0 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Dec 2021 14:32:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="297841054"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="297841054"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:29:02 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="501304739"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:29:01 -0800
Subject: [PATCH 1/2] cxl/pci: Implement Interface Ready Timeout
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, ben.widawsky@intel.com,
        Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com
Date:   Fri, 03 Dec 2021 11:29:01 -0800
Message-ID: <163855974164.1338601.11643774914793606293.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The original driver implementation used the doorbell timeout for the
Mailbox Interface Ready bit to piggy back off of, since the latter does
not have a defined timeout. This functionality, introduced in commit
8adaf747c9f0 ("cxl/mem: Find device capabilities"), needs improvement as
the recent "Add Mailbox Ready Time" ECN timeout indicates that the
mailbox ready time can be significantly longer that 2 seconds.

While the specification limits the maximum timeout to 256s, the cxl_pci
driver gives up on the mailbox after 60s. This value corresponds with
important timeout values already present in the kernel. A module
parameter is provided as an emergency override.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: add modparam, drop check_device_status()]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8dc91fd3396a..519795432708 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/moduleparam.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -35,6 +37,19 @@
 /* CXL 2.0 - 8.2.8.4 */
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
+/*
+ * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
+ * dictate how long to wait for the mailbox to become ready. The new
+ * field allows the device to tell software the amount of time to wait
+ * before mailbox ready. This field allows for up to 255 seconds. 255
+ * seconds is unreasonable long, and longer than other default timeouts
+ * in the OS. Use the more sane, 60 seconds instead.
+ */
+static unsigned short mbox_ready_timeout = 60;
+module_param(mbox_ready_timeout, ushort, 0600);
+MODULE_PARM_DESC(mbox_ready_timeout,
+		 "seconds to wait for mailbox ready status");
+
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
 	const unsigned long start = jiffies;
@@ -281,6 +296,25 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
 static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 {
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
+	unsigned long timeout;
+	u64 md_status;
+
+	timeout = jiffies + mbox_ready_timeout * HZ;
+	do {
+		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		if (md_status & CXLMDEV_MBOX_IF_READY)
+			break;
+		if (msleep_interruptible(100))
+			break;
+	} while (!time_after(jiffies, timeout));
+
+	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
+		dev_err(cxlds->dev,
+			"timeout awaiting mailbox ready, device state:%s%s\n",
+			md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
+			md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
+		return -EIO;
+        }
 
 	cxlds->mbox_send = cxl_pci_mbox_send;
 	cxlds->payload_size =

