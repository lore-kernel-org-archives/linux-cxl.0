Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56FEC61DA4
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 15:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbjA3POa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 10:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbjA3POO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 10:14:14 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837CC2DE71
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 07:13:50 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5BS04lpqz67RRb;
        Mon, 30 Jan 2023 23:09:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 15:13:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: [PATCH v2] cxl/pci: Set the device timestamp
Date:   Mon, 30 Jan 2023 15:13:27 +0000
Message-ID: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL r3.0 section 8.2.9.4.2 "Set Timestamp" recommends that the host sets
the timestamp after every Conventional or CXL Reset to ensure accurate
timestamps. This should include on initial boot up. The time base that
is being set is used by a device for the poison list overflow timestamp
and all event timestamps.  Note that the command is optional and if
not supported and the device cannot return accurate timestamps it will
fill the fields in with an appropriate marker (see the specification
description of each timestamp).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: Thanks to DavidLohr, Alison and Dan for quick reviews.
 - Drop exposure to userspace.
 - Drop prevention of raw command based access.
 - Check for a Not Supported return code. If that happens eat the error.
 - Fix missing endian conversion.
 - Switch to ktime.h include rather than timekeeping.h as per comments in
   the headers.

Based on cxl/pending as of today.

Open question: Should we only do this if Linux has control of the
error handling?  In theory it should be safe anyway given the
specification is clear that the timestamp base should always be the
same - so subject to small errors we shouldn't cause any firmware first
handling to get confused.
---
 drivers/cxl/core/mbox.c | 27 +++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    |  9 +++++++++
 drivers/cxl/pci.c       |  4 ++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b7c8d7608a33..a0bd2170af48 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -3,6 +3,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
+#include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <cxlmem.h>
 #include <cxl.h>
@@ -1074,6 +1075,32 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
 
+int cxl_set_timestamp(struct cxl_dev_state *cxlds)
+{
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mbox_set_timestamp_in pi;
+	int rc;
+
+	pi.timestamp = cpu_to_le64(ktime_get_real_ns());
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_SET_TIMESTAMP,
+		.size_in = sizeof(pi),
+		.payload_in = &pi,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	/*
+	 * Command is optional. Devices may have another way of providing
+	 * a timestamp, or may return all 0s in timestamp fields.
+	 * Don't report an error if this command isn't supported
+	 */
+	if (rc && (mbox_cmd.return_code != CXL_MBOX_CMD_RC_UNSUPPORTED))
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
+
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 {
 	struct cxl_dev_state *cxlds;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f21692ccb7a2..802b5b396daf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -309,6 +309,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
+	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
@@ -537,6 +538,12 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+/* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
+struct cxl_mbox_set_timestamp_in {
+	__le64 timestamp;
+
+} __packed;
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -607,6 +614,8 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
+int cxl_set_timestamp(struct cxl_dev_state *cxlds);
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d47005223c4f..ad2ebe7bfaeb 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -708,6 +708,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_set_timestamp(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;

base-commit: ace4b76d4ab70335cffb5a1c8450d3b34c16771a
-- 
2.37.2

