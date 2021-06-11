Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E2C48BE0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DEC613C3
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhFKAY1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:24:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:34366 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231322AbhFKAY1 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 20:24:27 -0400
IronPort-SDR: 9MT7D94f9MUacOnmyjIjZ4zGhVgAmOMgcSMYHSOvicywJH5mlXyRIv2KIwJpU9eEE8rrLM9EBg
 C2adhrm8p8/A==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="291064272"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="291064272"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:22:30 -0700
IronPort-SDR: Cuxhiakn1bazL3DtblVD3C6C/LJ863OtGpK+mWjcgmpMt+NonhxQA4UIcyBnoNUx3glrNjDS4J
 +GBtz03CqYZA==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="638530587"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 17:22:29 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/mem: Report correct ram/pmem size in sysfs
Date:   Thu, 10 Jun 2021 17:22:23 -0700
Message-Id: <20210611002224.1594913-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210611002224.1594913-1-ira.weiny@intel.com>
References: <20210611002224.1594913-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Memory devices may specify volatile only, persistent only, and
partitionable space which when added together result in a total capacity.

The partitionable space is configurable between volatile and persistent
space.  To account for the dynamic partitionable space the correct ram
and pmem size information is reported in the Get Partition Info device
command.

Define cxl_mem_get_partition() and call it to retrieve the correct
ram and pmem ranges sizes.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 97 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9995f97d3b28..bcc2829e4475 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1455,6 +1455,62 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
 	return ret;
 }
 
+/**
+ * cxl_mem_get_partition_info - Set partition info
+ * @cxlm: The device to act on
+ * @active_volatile_cap_bytes: returned active volatile capacity; in bytes
+ * @active_persistent_cap_bytes: returned active persistent capacity; in bytes
+ * @next_volatile_cap_bytes: return next volatile capacity; in bytes
+ * @next_persistent_cap_bytes: return next persistent capacity; in bytes
+ *
+ * Retrieve the current partition info for the device specified.  The active
+ * values are the current capacity in bytes.  If not 0, the 'next' values are
+ * the pending values, in bytes, which take affect on next cold reset.
+ *
+ * Return: 0 if no error: or the result of the mailbox command.
+ *
+ * See CXL @8.2.9.5.2.1 Get Partition Info
+ */
+int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
+			       u64 *active_volatile_cap_bytes,
+			       u64 *active_persistent_cap_bytes,
+			       u64 *next_volatile_cap_bytes,
+			       u64 *next_persistent_cap_bytes)
+{
+	struct cxl_mbox_get_partition_info {
+		u64 active_volatile_cap;
+		u64 active_persistent_cap;
+		u64 next_volatile_cap;
+		u64 next_persistent_cap;
+	} __packed pi;
+	int rc;
+
+	/* On error report 0 */
+	*active_volatile_cap_bytes = 0;
+	*active_persistent_cap_bytes = 0;
+	*next_volatile_cap_bytes = 0;
+	*next_persistent_cap_bytes = 0;
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
+				   NULL, 0, &pi, sizeof(pi));
+
+	if (rc)
+		return rc;
+
+	*active_volatile_cap_bytes = le64_to_cpu(pi.active_volatile_cap);
+	*active_persistent_cap_bytes = le64_to_cpu(pi.active_persistent_cap);
+	*next_volatile_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
+	*next_persistent_cap_bytes = le64_to_cpu(pi.next_volatile_cap);
+
+	*active_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
+	*active_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
+	*next_volatile_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
+	*next_persistent_cap_bytes *= CXL_CAPACITY_MULTIPLIER;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_mem_get_partition_info);
+
 /**
  * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
  * @cxlm: The device.
@@ -1573,20 +1629,45 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 			cxlm->persistent_cap_bytes,
 			cxlm->partition_align_bytes);
 
+	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
+	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
+
+	return 0;
+}
+
+static void cxl_mem_create_range_info(struct cxl_mem *cxlm)
+{
+	u64 active_volatile_cap_bytes;
+	u64 active_persistent_cap_bytes;
+	u64 next_volatile_cap_bytes;
+	u64 next_persistent_cap_bytes;
+
+	if (cxl_mem_get_partition_info(cxlm,
+			       &active_volatile_cap_bytes,
+			       &active_persistent_cap_bytes,
+			       &next_volatile_cap_bytes,
+			       &next_persistent_cap_bytes))
+		dev_err(&cxlm->pdev->dev, "Failed to query partition information\n");
+
+	dev_dbg(&cxlm->pdev->dev, "Get Partition Info\n"
+		"     active_volatile_cap_bytes = %#llx\n"
+		"     active_persistent_cap_bytes = %#llx\n"
+		"     next_volatile_cap_bytes = %#llx\n"
+		"     next_persistent_cap_bytes = %#llx\n",
+			active_volatile_cap_bytes,
+			active_persistent_cap_bytes,
+			next_volatile_cap_bytes,
+			next_persistent_cap_bytes);
+
 	/*
 	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
 	 * For now, only the capacity is exported in sysfs
 	 */
 	cxlm->ram_range.start = 0;
-	cxlm->ram_range.end = cxlm->volatile_cap_bytes - 1;
+	cxlm->ram_range.end = active_volatile_cap_bytes - 1;
 
 	cxlm->pmem_range.start = 0;
-	cxlm->pmem_range.end = cxlm->persistent_cap_bytes - 1;
-
-	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
-	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
-
-	return 0;
+	cxlm->pmem_range.end = active_persistent_cap_bytes - 1;
 }
 
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -1618,6 +1699,8 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	cxl_mem_create_range_info(cxlm);
+
 	return cxl_mem_add_memdev(cxlm);
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

