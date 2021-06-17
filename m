Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB8DC2B9F4
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32BC61369
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 22:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhFQWSx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 18:18:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:58451 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhFQWSw (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 18:18:52 -0400
IronPort-SDR: 4KiXf3tIP280R3mppBt0D4I3Xyv/WuIwvBae2Efrq+iO/5t+mpmoVKGFIuXd4c/IpRjhcsdkmg
 pXP8RMijnp5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267604719"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267604719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:16:42 -0700
IronPort-SDR: 9UDWKDAv+cW2jrpPYm46t6WMMxdSQRmQUYjM4b2Aa51XN7VCT+mPNMjSAO8FRKrqu4wxcEzSHF
 mrEsYgxJqvuw==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="479609136"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:16:42 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH V2 1/3] cxl/pci: Store memory capacity values
Date:   Thu, 17 Jun 2021 15:16:18 -0700
Message-Id: <20210617221620.1904031-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210617221620.1904031-1-ira.weiny@intel.com>
References: <20210617221620.1904031-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The Identify Memory Device command returns information about the
volatile only and persistent only memory capacities.  Store those values
in the cxl_mem structure for later use.  While at it, reuse those
calculations to calculate the ram and pmem ranges.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V2:
	Ben
		Change names to be more clear
			total_bytes
			volatile_only_bytes
			persistent_only_bytes
---
 drivers/cxl/mem.h |  4 ++++
 drivers/cxl/pci.c | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 13868ff7cadf..9dc34418db36 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -75,5 +75,9 @@ struct cxl_mem {
 
 	struct range pmem_range;
 	struct range ram_range;
+	u64 total_bytes;
+	u64 volatile_only_bytes;
+	u64 persistent_only_bytes;
+	u64 partition_align_bytes;
 };
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5a1705b52278..94b7ee08ef67 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -57,6 +57,15 @@ enum opcode {
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
+/*
+ * CXL 2.0 - Memory capacity multiplier
+ * See Section 8.2.9.5
+ *
+ * Volatile, Persistent, and Partition capacities are specified to be in
+ * multiples of 256MB - define a multiplier to convert to/from bytes.
+ */
+#define CXL_CAPACITY_MULTIPLIER SZ_256M
+
 /**
  * struct mbox_cmd - A command to be submitted to hardware.
  * @opcode: (input) The command set and command submitted to hardware.
@@ -1542,16 +1551,37 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 	if (rc < 0)
 		return rc;
 
+	cxlm->total_bytes = le64_to_cpu(id.total_capacity);
+	cxlm->total_bytes *= CXL_CAPACITY_MULTIPLIER;
+
+	cxlm->volatile_only_bytes = le64_to_cpu(id.volatile_capacity);
+	cxlm->volatile_only_bytes *= CXL_CAPACITY_MULTIPLIER;
+
+	cxlm->persistent_only_bytes = le64_to_cpu(id.persistent_capacity);
+	cxlm->persistent_only_bytes *= CXL_CAPACITY_MULTIPLIER;
+
+	cxlm->partition_align_bytes = le64_to_cpu(id.partition_align);
+	cxlm->partition_align_bytes *= CXL_CAPACITY_MULTIPLIER;
+
+	dev_dbg(&cxlm->pdev->dev, "Identify Memory Device\n"
+		"     total_bytes = %#llx\n"
+		"     volatile_only_bytes = %#llx\n"
+		"     persistent_only_bytes = %#llx\n"
+		"     partition_align_bytes = %#llx\n",
+			cxlm->total_bytes,
+			cxlm->volatile_only_bytes,
+			cxlm->persistent_only_bytes,
+			cxlm->partition_align_bytes);
+
 	/*
 	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
 	 * For now, only the capacity is exported in sysfs
 	 */
 	cxlm->ram_range.start = 0;
-	cxlm->ram_range.end = le64_to_cpu(id.volatile_capacity) * SZ_256M - 1;
+	cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
 
 	cxlm->pmem_range.start = 0;
-	cxlm->pmem_range.end =
-		le64_to_cpu(id.persistent_capacity) * SZ_256M - 1;
+	cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
 
 	cxlm->lsa_size = le32_to_cpu(id.lsa_size);
 	memcpy(cxlm->firmware_version, id.fw_revision, sizeof(id.fw_revision));
-- 
2.28.0.rc0.12.gb6a658bd00c9

