Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991ADC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 21:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhK2V6B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:58:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:47142 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232552AbhK2V4A (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Nov 2021 16:56:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="222968504"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="222968504"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458596091"
Received: from ajsteine-mobl13.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.141.244])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 13:47:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4/9] cxl/pci: Implement Interface Ready Timeout
Date:   Mon, 29 Nov 2021 13:47:16 -0800
Message-Id: <20211129214721.1668325-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129214721.1668325-1-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The original driver implementation used the doorbell timeout for the
Mailbox Interface Ready bit to piggy back off of, since the latter
doesn't have a defined timeout. This functionality, introduced in commit
8adaf747c9f0 ("cxl/mem: Find device capabilities"), can now be improved
since a timeout has been defined with an ECN to the 2.0 spec.

While devices implemented prior to the ECN could have an arbitrarily
long wait and still be within spec, the max ECN value (256s) is chosen
as the default for all devices. All vendors in the consortium agreed to
this amount and so it is reasonable to assume no devices made will
exceed this amount.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since v1:
- Use 60 seconds for timeout instead of 256 (Dan)
---
 drivers/cxl/pci.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6c8d09fb3a17..b28c220d48ea 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -298,6 +299,38 @@ static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *c
 static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 {
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
+	unsigned long timeout;
+	u64 md_status;
+	int rc;
+
+	/*
+	 * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
+	 * dictate how long to wait for the mailbox to become ready. The new
+	 * field allows the device to tell software the amount of time to wait
+	 * before mailbox ready. This field allows for up to 255 seconds. 255
+	 * seconds is unreasonable long, and longer than other default timeouts
+	 * in the OS. Use the more sane, 60 seconds instead.
+	 *
+	 * 100ms is chosen as the specified pause as it is the value used in the
+	 * CXL Type 3 Memory Device Software Guide.
+	 */
+	timeout = jiffies + 60 * HZ;
+
+	rc = check_device_status(cxlds);
+	if (rc)
+		return rc;
+
+	do {
+		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		if (md_status & CXLMDEV_MBOX_IF_READY)
+			break;
+		if (msleep_interruptible(100))
+			break;
+	} while (!time_after(jiffies, timeout));
+
+	/* It's assumed that once the interface is ready, it will remain ready. */
+	if (!(md_status & CXLMDEV_MBOX_IF_READY))
+		return -EIO;
 
 	cxlds->mbox_send = cxl_pci_mbox_send;
 	cxlds->payload_size =
-- 
2.34.1

