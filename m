Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C87C77B78
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjDSD0p (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjDSD0o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F3D2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874801; x=1713410801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oISMxquKAyP3IlVniqN4Dihq55B/aDTywKD68Yj61Gs=;
  b=nAPmKkZfmof0HeqHgOeN2DivOT+uYIkqBsBFb3thEpG37H1cGLlplJV9
   bJYjPWW4VfSL5pVBW6P9LvatK3FOqD4m7AYBq9D9k3CRmuwz5fQ4NlYq8
   hUGnDL6a0Y+ZkOVkeZd68HmWMiNsjoP/lL0DVK2FM4TL2ARVTNNIAJ1kz
   e3quaQCQIQU6Cg+8X1JYZz0KQFbHuDf1Msb2EShplat5EFb8HO+QDxHoI
   ttWGUQTOPTx2/NHuwpXpyQAcox9YEkdHSmEUCNHGBCm1qSD8L1NbJ1Vhs
   HEF/5wI80UaguoJGLq3F3+3XwGmTXa4fYhGr+vJyakTXPsQctxYeFfBo/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621693"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621693"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711099"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711099"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:41 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 02/10] cxl/memdev: Add support for the Clear Poison mailbox command
Date:   Tue, 18 Apr 2023 20:26:26 -0700
Message-Id: <8682c30ec24bd9c45af5feccb04b02be51e58c0a.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the CLEAR POISON mailbox command. Add
memdev driver support for clearing poison.

Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid
clear poison request, the device removes the address from the device's
Poison List and writes 0 (zero) for 64 bytes starting at address. If
the device cannot clear poison from the address, it returns a permanent
media error and -ENXIO is returned to the user.

Additionally, and per the spec also, it is not an error to clear poison
of an address that is not poisoned.

If the address is not contained in the device's dpa resource, or is
not 64 byte aligned, the driver returns -EINVAL without sending the
command to the device.

Poison clearing is intended for debug only and will be exposed to
userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.

Implementation note: Although the CXL specification defines the clear
command to accept 64 bytes of 'write-data', this implementation always
uses zeroes as write-data.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/memdev.c | 43 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |  7 +++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 474f7c2f4f6e..3b48b6eec007 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -216,6 +216,49 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
 
+int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_clear_poison clear;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+
+	rc = down_read_interruptible(&cxl_dpa_rwsem);
+	if (rc)
+		return rc;
+
+	rc = cxl_validate_poison_dpa(cxlmd, dpa);
+	if (rc)
+		goto out;
+
+	/*
+	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
+	 * is defined to accept 64 bytes of write-data, along with the
+	 * address to clear. This driver uses zeroes as write-data.
+	 */
+	clear = (struct cxl_mbox_clear_poison) {
+		.address = cpu_to_le64(dpa)
+	};
+
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_CLEAR_POISON,
+		.size_in = sizeof(clear),
+		.payload_in = &clear,
+	};
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc)
+		goto out;
+out:
+	up_read(&cxl_dpa_rwsem);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8a3ea9cabf1f..fa73bbdc5327 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -620,6 +620,12 @@ struct cxl_mbox_inject_poison {
 	__le64 address;
 };
 
+/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
+struct cxl_mbox_clear_poison {
+	__le64 address;
+	u8 write_data[CXL_POISON_LEN_MULT];
+} __packed;
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -695,6 +701,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
+int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
-- 
2.37.3

