Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E398AC6FD18
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDRRjU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRRjT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:39:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5A04691
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681839558; x=1713375558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EYi+dzPXuYboA0IBJjfPo5GsdXqo7N2YOGPTOGLL8c0=;
  b=MvK/lL2mu0NcVNMHpTJxMjElBbNEYGt8aqWMPXrVBhDs+n0J80w0AP6M
   6whprpxJawK0i5aCQhC9kw3/oM/w7OROM6vRH5qbUcIV7Dr8IlwRYBfJT
   D+jPJ5UfKuMPyJPm6MbMOl+UOVUxRDPK0Nxo9hQlswiAhltQB3noPlRJf
   02S9KtNl6/yKeiDoaeGmCUidbAu4w7gSY42srjUd7G1qa6NRaKEYCpEfh
   /qwZybVo706IqADRYK5KjCZ9+Bx87iclsYAW/gWI3nrafdcEjrPg0aO+l
   QKC9ri7aHnrjEtDbWjUXpuPNmHdL96zsWT/mnD+qElEAHEwtlnXcsUvmt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410470718"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410470718"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="865505425"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="865505425"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 10:39:16 -0700
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
Subject: [PATCH v13 4/9] cxl/mbox: Add GET_POISON_LIST mailbox command
Date:   Tue, 18 Apr 2023 10:39:04 -0700
Message-Id: <a1f332e817834ef8e89c0ff32e760308fb903346.1681838291.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681838291.git.alison.schofield@intel.com>
References: <cover.1681838291.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices maintain a list of locations that are poisoned or result
in poison if the addresses are accessed by the host.

Per the spec, (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
list as a set of Media Error Records that include the source of the
error, the starting device physical address, and length. The length is
the number of adjacent DPAs in the record and is in units of 64 bytes.

Retrieve the poison list.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 55 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 46 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 17737386283a..05ff50ee8489 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,7 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1038,6 +1039,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
 	struct cxl_mbox_identify id;
 	struct cxl_mbox_cmd mbox_cmd;
+	u32 val;
 	int rc;
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -1061,6 +1063,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
+	if (test_bit(CXL_POISON_ENABLED_LIST, cxlds->poison.enabled_cmds)) {
+		val = get_unaligned_le24(id.poison_list_max_mer);
+		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
@@ -1151,6 +1158,54 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
 
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_poison_out *po;
+	struct cxl_mbox_poison_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	int nr_records = 0;
+	int rc;
+
+	rc = mutex_lock_interruptible(&cxlds->poison.lock);
+	if (rc)
+		return rc;
+
+	po = cxlds->poison.list_out;
+	pi.offset = cpu_to_le64(offset);
+	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_POISON,
+		.size_in = sizeof(pi),
+		.payload_in = &pi,
+		.size_out = cxlds->payload_size,
+		.payload_out = po,
+		.min_out = struct_size(po, record, 0),
+	};
+
+	do {
+		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+		if (rc)
+			break;
+
+		/* TODO TRACE the media error records */
+
+		/* Protect against an uncleared _FLAG_MORE */
+		nr_records = nr_records + le16_to_cpu(po->count);
+		if (nr_records >= cxlds->poison.max_errors) {
+			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
+				nr_records);
+			break;
+		}
+	} while (po->flags & CXL_POISON_FLAG_MORE);
+
+	mutex_unlock(&cxlds->poison.lock);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
+
 static void free_poison_buf(void *buf)
 {
 	kvfree(buf);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 16e0241d72a9..07775ab5af4e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -571,6 +571,50 @@ struct cxl_mbox_set_timestamp_in {
 
 } __packed;
 
+/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
+struct cxl_mbox_poison_in {
+	__le64 offset;
+	__le64 length;
+} __packed;
+
+struct cxl_mbox_poison_out {
+	u8 flags;
+	u8 rsvd1;
+	__le64 overflow_ts;
+	__le16 count;
+	u8 rsvd2[20];
+	struct cxl_poison_record {
+		__le64 address;
+		__le32 length;
+		__le32 rsvd;
+	} __packed record[];
+} __packed;
+
+/*
+ * Get Poison List address field encodes the starting
+ * address of poison, and the source of the poison.
+ */
+#define CXL_POISON_START_MASK		GENMASK_ULL(63, 6)
+#define CXL_POISON_SOURCE_MASK		GENMASK(2, 0)
+
+/* Get Poison List record length is in units of 64 bytes */
+#define CXL_POISON_LEN_MULT	64
+
+/* Kernel defined maximum for a list of poison errors */
+#define CXL_POISON_LIST_MAX	1024
+
+/* Get Poison List: Payload out flags */
+#define CXL_POISON_FLAG_MORE            BIT(0)
+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
+#define CXL_POISON_FLAG_SCANNING        BIT(2)
+
+/* Get Poison List: Poison Source */
+#define CXL_POISON_SOURCE_UNKNOWN	0
+#define CXL_POISON_SOURCE_EXTERNAL	1
+#define CXL_POISON_SOURCE_INTERNAL	2
+#define CXL_POISON_SOURCE_INJECTED	3
+#define CXL_POISON_SOURCE_VENDOR	7
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -642,6 +686,8 @@ void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cm
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
 int cxl_set_timestamp(struct cxl_dev_state *cxlds);
 int cxl_poison_state_init(struct cxl_dev_state *cxlds);
+int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
+		       struct cxl_region *cxlr);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
-- 
2.37.3

