Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610DC4743C
	for <linux-cxl@archiver.kernel.org>; Mon, 21 Jun 2021 19:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4715B610EA
	for <linux-cxl@archiver.kernel.org>; Mon, 21 Jun 2021 19:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhFUT40 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:56:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:1064 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231416AbhFUT4Z (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 21 Jun 2021 15:56:25 -0400
IronPort-SDR: dDbPxQdE829k9oHRlqTTIV2n/IEX0sCt80e0VAJuzN2Xv5H19cq3Tqgiuq/X8wWqaGHsTqH+tD
 nskfP7k+grQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="206866127"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="206866127"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 12:54:08 -0700
IronPort-SDR: 14Q6YW3UoGj91aU/mKvRulwZACplM7f8B5fc8hjeLGDVcbqZHjt3gdsp4aZnL+uWlgEIalsvYn
 bK4xOopJStqw==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="641426529"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 12:54:08 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH V3] cxl/mem: Adjust ram/pmem range to represent DPA ranges
Date:   Mon, 21 Jun 2021 12:54:06 -0700
Message-Id: <20210621195406.2061505-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210617221620.1904031-4-ira.weiny@intel.com>
References: <20210617221620.1904031-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Table 176 of the CXL spec defines the volatile DPA range to be 0 to
Volatile memory size.  It further defines the persistent DPA range to
follow directly after the end of the Volatile DPA through the persistent
memory size.  Essentially

Volatile DPA range   = [0, Volatile size)
Persistent DPA range = [Volatile size, Volatile size + Persistent size)

Adjust the pmem_range start to reflect this and remove the TODO.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
For some reason I fixed this but failed to send it out...

Changes for V3
	Jonathan -- Clean up commit message

---
 drivers/cxl/pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3c8b7aa8c273..592374baa005 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1633,8 +1633,9 @@ static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
 	if (cxlm->partition_align_bytes == 0) {
 		cxlm->ram_range.start = 0;
 		cxlm->ram_range.end = cxlm->volatile_only_bytes - 1;
-		cxlm->pmem_range.start = 0;
-		cxlm->pmem_range.end = cxlm->persistent_only_bytes - 1;
+		cxlm->pmem_range.start = cxlm->volatile_only_bytes;
+		cxlm->pmem_range.end = cxlm->volatile_only_bytes +
+					cxlm->persistent_only_bytes - 1;
 		return 0;
 	}
 
@@ -1658,15 +1659,12 @@ static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
 			cxlm->next_volatile_bytes,
 			cxlm->next_persistent_bytes);
 
-	/*
-	 * TODO: enumerate DPA map, as 'ram' and 'pmem' do not alias.
-	 * For now, only the capacity is exported in sysfs
-	 */
 	cxlm->ram_range.start = 0;
 	cxlm->ram_range.end = cxlm->active_volatile_bytes - 1;
 
-	cxlm->pmem_range.start = 0;
-	cxlm->pmem_range.end = cxlm->active_persistent_bytes - 1;
+	cxlm->pmem_range.start = cxlm->active_volatile_bytes;
+	cxlm->pmem_range.end = cxlm->active_volatile_bytes +
+				cxlm->active_persistent_bytes - 1;
 
 	return 0;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

