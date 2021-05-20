Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F9C433B4
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D380F61353
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbhETTtN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 15:49:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:54753 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239913AbhETTtN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 20 May 2021 15:49:13 -0400
IronPort-SDR: VMLvQOg7g/0UH7bPHjdIyE0EulLHZC/LlCST5MXcdWhZg8zNgu7n1avwnJue5RsulAzLgYR6+7
 V7yt/wdMbdxg==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188722211"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188722211"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:47:49 -0700
IronPort-SDR: xgrA2qX7QxnKNzemwSEzi2UHlckVX2+aViPN912zdIfJudMLxW+J7ju7WA0IUY7qGKaOIbJyPQ
 co5MVo3PBQ2A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="468148740"
Received: from rtiwar1x-mobl1.gar.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.33.53])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 12:47:49 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
To:     <linux-cxl@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl/pci.c: Add a 'label_storage_size' attribute to the memdev
Date:   Thu, 20 May 2021 13:47:45 -0600
Message-Id: <20210520194745.1095517-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 'Identify Device' mailbox command returns an 'lsa_size', which is
the size of the label storage area on the device. Export it as a sysfs
attribute so that userspace tooling to read/write the LSA can determine
the size without having to run an 'Identify Device' on their own.

Cc: Ben Widawsky <ben.widawsky@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

Depends on "[PATCH v2] cxl: Rename mem to pci"

 drivers/cxl/mem.h |  3 +++
 drivers/cxl/pci.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 0a3f70316872..23fc40dde27e 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -54,6 +54,8 @@ struct cxl_memdev {
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
+ * @lsa_size: Size of Label Storage Area
+ *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
  * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
  * @enabled_cmds: Hardware commands found enabled in CEL.
@@ -68,6 +70,7 @@ struct cxl_mem {
 	struct cxl_regs regs;
 
 	size_t payload_size;
+	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
 	unsigned long *enabled_cmds;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7996c2a2054..606c88ca902b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1036,6 +1036,16 @@ static ssize_t payload_max_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(payload_max);
 
+static ssize_t label_storage_size_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%zu\n", cxlm->lsa_size);
+}
+static DEVICE_ATTR_RO(label_storage_size);
+
 static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -1065,6 +1075,7 @@ static struct device_attribute dev_attr_pmem_size =
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
+	&dev_attr_label_storage_size.attr,
 	NULL,
 };
 
@@ -1397,6 +1408,7 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 	cxlm->pmem_range.end =
 		le64_to_cpu(id.persistent_capacity) * SZ_256M - 1;
 
+	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
 
 	return 0;

base-commit: 399d34ebc2483c6091a587e5905c6ed34116fb05
prerequisite-patch-id: 2e73e8a6279ced23f8002424c5d3b623cc5abb3c
-- 
2.31.1

