Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2411CC761AF
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Mar 2023 05:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjC0FD0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FDW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 01:03:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE98111A
        for <linux-cxl@vger.kernel.org>; Sun, 26 Mar 2023 22:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679893401; x=1711429401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJPWku0KkXoiqr6ccOU6+JBs3IaavHOdrNuTrLyzHA8=;
  b=jAzCf5R29Dk8XDsVd0SrD/RaUYKgArx3RD1GrRII8q9kK6MZ87I0afe3
   0EAZ++5nWtUV1WdsLbfAMBD2RdpXJLiVXQF6fd/Lg4RNXlXj4EHzVCaXp
   AxEpk8IIBpzctBAdSHxfOBvggow1CzN0gK6i3BEHeXJBw04f+mFhqgcdm
   UIP38kJ9OYY4Xw+dEzIAoE7cZSSqh1nOgUqeS3veXBHQB9nwtcM+vyzTB
   Lt1P04L6s4BwHnAO+zXPk57gJuJSmNbViy9VWcWJ5Y21U4TiiUK3oiBP5
   Qzcm4UR4Y08rEUybkXAV2y/uG7zG7qzCD++fKn7b4+PUS5M88H76ATPZ+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="367920179"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="367920179"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633492249"
X-IronPort-AV: E=Sophos;i="5.98,293,1673942400"; 
   d="scan'208";a="633492249"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.227.2])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 22:03:21 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v5 02/12] cxl/memdev: Add support for the Clear Poison mailbox command
Date:   Sun, 26 Mar 2023 22:03:08 -0700
Message-Id: <548e2a175a2f20cdc886297430102ee851d30f26.1679892337.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
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
of an address that is not poisoned. In this case, the device does not
overwrite the address and the device does not return an error.

If the address is not contained in the device's dpa resource, or is
not 64 byte aligned, return -EINVAL without issuing the mbox command.

Poison clearing is intended for debug only and will be exposed to
userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.

Implementation note: Although the CXL specification defines the clear
command to accept 64 bytes of 'write-data' to be used when clearing
the poisoned address, this implementation always uses 0 (zeros) for
the write-data.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/memdev.c | 43 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |  7 +++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 3b3ac2868848..0e39c3c3fb09 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -268,6 +268,49 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
 
+int cxl_clear_poison(struct device *dev, u64 dpa)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mbox_clear_poison clear;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_validate_poison_dpa(cxlmd, dpa);
+	if (rc)
+		goto out;
+
+	/*
+	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
+	 * is defined to accept 64 bytes of 'write-data', along with the
+	 * address to clear. The device writes the data into the address
+	 * atomically, while clearing poison if the location is marked as
+	 * being poisoned.
+	 *
+	 * Always use '0' for the write-data.
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
+	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
+
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
index 527efef2d700..1d8677ab2306 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -607,6 +607,12 @@ struct cxl_mbox_inject_poison {
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
@@ -684,6 +690,7 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t len);
 int cxl_inject_poison(struct device *dev, u64 dpa);
+int cxl_clear_poison(struct device *dev, u64 dpa);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
-- 
2.37.3

