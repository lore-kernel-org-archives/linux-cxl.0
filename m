Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE5BC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 743FC6044F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbhFRQdr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:33:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:12929 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231203AbhFRQdq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 18 Jun 2021 12:33:46 -0400
IronPort-SDR: wCMYwn2+EqxlnwLcmMu6mCO/VVmrpdBLT/DBeY0FBR2DBNTtuNrWzsRgFywpJAgZDPp0AxrEDv
 I2ItVZ/pSR/A==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="228110588"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="228110588"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:31:34 -0700
IronPort-SDR: jLxbgL2jCT6lurIAEj49rrqMDYsGS3jbb3eYa4DIX4uxkAjxbisQy98KZ4n5OxE+kzdcN3ScmW
 zafX+4Y83edw==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485744888"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:31:32 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH V3] cxl/mem: Account for partitionable space in ram/pmem ranges
Date:   Fri, 18 Jun 2021 09:31:29 -0700
Message-Id: <20210618163129.1912453-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210617221620.1904031-3-ira.weiny@intel.com>
References: <20210617221620.1904031-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Memory devices may specify volatile only, persistent only, and
partitionable space which when added together result in a total capacity.

If Identify Memory Device.Partition Alignment != 0 the device supports
partitionable space.  This partitionable space can be split between
volatile and persistent space.  The total volatile and persistent sizes
are reported in Get Partition Info.  ie

	active volatile memory = volatile only + partitionable volatile
	active persistent memory = persistent only + partitionable persistent

Define cxl_mem_get_partition(), check for partitionable support, and use
cxl_mem_get_partition() if applicable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V3:
	Johnathan
		Stop over documenting 'in bytes'...  :-D

Changes for V2:
	Jonathan
		Account for Get Partition Info being optional
		Fix documentation
	Dan
		Store the active capacities in struct cxl_mem
		Make cxl_mem_get_partition() static until there is a
		need to export it.
---
 drivers/cxl/mem.h |  5 +++
 drivers/cxl/pci.c | 96 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 9dc34418db36..8d7bd966a298 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -79,5 +79,10 @@ struct cxl_mem {
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
 	u64 partition_align_bytes;
+
+	u64 active_volatile_bytes;
+	u64 active_persistent_bytes;
+	u64 next_volatile_bytes;
+	u64 next_persistent_bytes;
 };
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 94b7ee08ef67..3c8b7aa8c273 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1455,6 +1455,53 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mem *cxlm)
 	return ret;
 }
 
+/**
+ * cxl_mem_get_partition_info - Get partition info
+ * @cxlm: The device to act on
+ * @active_volatile_bytes: returned active volatile capacity
+ * @active_persistent_bytes: returned active persistent capacity
+ * @next_volatile_bytes: return next volatile capacity
+ * @next_persistent_bytes: return next persistent capacity
+ *
+ * Retrieve the current partition info for the device specified.  If not 0, the
+ * 'next' values are pending and take affect on next cold reset.
+ *
+ * Return: 0 if no error: or the result of the mailbox command.
+ *
+ * See CXL @8.2.9.5.2.1 Get Partition Info
+ */
+static int cxl_mem_get_partition_info(struct cxl_mem *cxlm,
+				      u64 *active_volatile_bytes,
+				      u64 *active_persistent_bytes,
+				      u64 *next_volatile_bytes,
+				      u64 *next_persistent_bytes)
+{
+	struct cxl_mbox_get_partition_info {
+		u64 active_volatile_cap;
+		u64 active_persistent_cap;
+		u64 next_volatile_cap;
+		u64 next_persistent_cap;
+	} __packed pi;
+	int rc;
+
+	rc = cxl_mem_mbox_send_cmd(cxlm, CXL_MBOX_OP_GET_PARTITION_INFO,
+				   NULL, 0, &pi, sizeof(pi));
+	if (rc)
+		return rc;
+
+	*active_volatile_bytes = le64_to_cpu(pi.active_volatile_cap);
+	*active_persistent_bytes = le64_to_cpu(pi.active_persistent_cap);
+	*next_volatile_bytes = le64_to_cpu(pi.next_volatile_cap);
+	*next_persistent_bytes = le64_to_cpu(pi.next_volatile_cap);
+
+	*active_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
+	*active_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
+	*next_volatile_bytes *= CXL_CAPACITY_MULTIPLIER;
+	*next_persistent_bytes *= CXL_CAPACITY_MULTIPLIER;
+
+	return 0;
+}
+
 /**
  * cxl_mem_enumerate_cmds() - Enumerate commands for a device.
  * @cxlm: The device.
@@ -1573,18 +1620,53 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 			cxlm->persistent_only_bytes,
 			cxlm->partition_align_bytes);
 
+	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
+	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
+
+	return 0;
+}
+
+static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
+{
+	int rc;
+
+	if (cxlm->partition_align_bytes == 0) {
+		cxlm->ram_range.start = 0;
+		cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
+		cxlm->pmem_range.start = 0;
+		cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
+		return 0;
+	}
+
+	rc = cxl_mem_get_partition_info(cxlm,
+					&cxlm->active_volatile_bytes,
+					&cxlm->active_persistent_bytes,
+					&cxlm->next_volatile_bytes,
+					&cxlm->next_persistent_bytes);
+	if (rc < 0) {
+		dev_err(&cxlm->pdev->dev, "Failed to query partition information\n");
+		return rc;
+	}
+
+	dev_dbg(&cxlm->pdev->dev, "Get Partition Info\n"
+		"     active_volatile_bytes = %#llx\n"
+		"     active_persistent_bytes = %#llx\n"
+		"     next_volatile_bytes = %#llx\n"
+		"     next_persistent_bytes = %#llx\n",
+			cxlm->active_volatile_bytes,
+			cxlm->active_persistent_bytes,
+			cxlm->next_volatile_bytes,
+			cxlm->next_persistent_bytes);
+
 	/*
 	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
 	 * For now, only the capacity is exported in sysfs
 	 */
 	cxlm->ram_range.start = 0;
-	cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
+	cxlm->ram_range.end = cxlm->active_volatile_bytes - 1;
 
 	cxlm->pmem_range.start = 0;
-	cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
-
-	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
-	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
+	cxlm->pmem_range.end = cxlm->active_persistent_bytes - 1;
 
 	return 0;
 }
@@ -1618,6 +1700,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_mem_create_range_info(cxlm);
+	if (rc)
+		return rc;
+
 	return cxl_mem_add_memdev(cxlm);
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

