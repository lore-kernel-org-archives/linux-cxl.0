Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F03C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Apr 2023 03:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjDSD0o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSD0m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 23:26:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1C102
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681874799; x=1713410799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MidIsQlIM4zJIgFr+qxCOrJ1GVKYvbwSepxMgtPhpsk=;
  b=XWGB84SkwmxpQyxmS5PUZwsNO/g/uHxccm21p1GXqW7otjZLqNiUhCjg
   fqyho2+RbJWxnVWwASJftFYSxAG/GWFVMDef5ooGUvzW43tog38xa9/wq
   6MlpYhhlG68iCqKoaKoMqK12pkeLAn5SAJYS+rUkIN8LQRD0c0T6DHXvX
   UrKqPhqCQrBCmNmZp/MbcCSe/4CBOGw4tYEkDrb7Hc2xUSu2aYAb9x4bX
   GxXUdLQRns2JVMD1b8tAyHthVohWaE+gPKOh0JFi0sWComSYAsY8uyEUz
   +IwNzht23g1tPs6JD9MmZsjlI+p41sf4ufmjwqKQaKMM2GMBjFrF1DPcJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431621686"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431621686"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780711094"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="780711094"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.152.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:26:39 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 01/10] cxl/memdev: Add support for the Inject Poison mailbox command
Date:   Tue, 18 Apr 2023 20:26:25 -0700
Message-Id: <241c64115e6bd2effed9c7a20b08b3908dd7be8f.1681874357.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices optionally support the INJECT POISON mailbox command. Add
memdev driver support for the mailbox command.

Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
inject poison request, the device will return poison when the address
is accessed through the CXL.mem driver. Injecting poison adds the address
to the device's Poison List and the error source is set to Injected.
In addition, the device adds a poison creation event to its internal
Informational Event log, updates the Event Status register, and if
configured, interrupts the host.

Also, per the CXL Specification, it is not an error to inject poison
into an address that already has poison present and no error is
returned from the device.

If the address is not contained in the device's dpa resource, or is
not 64 byte aligned, return -EINVAL without issuing the mbox command.

Poison injection is intended for debug only and will be exposed to
userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/memdev.c | 56 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |  6 +++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 8db7f220f182..474f7c2f4f6e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -160,6 +160,62 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
 
+static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_FS))
+		return 0;
+
+	if (!resource_size(&cxlds->dpa_res)) {
+		dev_dbg(cxlds->dev, "device has no dpa resource\n");
+		return -EINVAL;
+	}
+	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
+		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
+			dpa, &cxlds->dpa_res);
+		return -EINVAL;
+	}
+	if (!IS_ALIGNED(dpa, 64)) {
+		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n", dpa);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_mbox_inject_poison inject;
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
+	inject.address = cpu_to_le64(dpa);
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_INJECT_POISON,
+		.size_in = sizeof(inject),
+		.payload_in = &inject,
+	};
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+out:
+	up_read(&cxl_dpa_rwsem);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 68b9db545aae..8a3ea9cabf1f 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -615,6 +615,11 @@ struct cxl_mbox_poison_out {
 #define CXL_POISON_SOURCE_INJECTED	3
 #define CXL_POISON_SOURCE_VENDOR	7
 
+/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
+struct cxl_mbox_inject_poison {
+	__le64 address;
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
@@ -689,6 +694,7 @@ int cxl_poison_state_init(struct cxl_dev_state *cxlds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
+int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
-- 
2.37.3

