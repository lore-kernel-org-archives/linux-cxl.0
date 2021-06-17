Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895FC49EA3
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 22:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47029613BD
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 22:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhFQWSz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 18:18:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:58457 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhFQWSz (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 18:18:55 -0400
IronPort-SDR: G3UrsL787pEuCH9h7ZgpQOM0E+ZUpwVtfDnGlCfzmM/Zb5p1K+T4TevaGx4rcghBVlUjkDEYba
 Y62r1SWItyPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267604728"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="267604728"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:16:46 -0700
IronPort-SDR: yhFZosmx7fN/U2OzqGKnw6yZUFxABr7Yc3q3fkjFX478r8YILnCRReX2qy5JK3MOMEnJZkMgeq
 iNCGtkvBRPEQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="479609146"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:16:46 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH V2 3/3] cxl/mem: Adjust ram/pmem range to represent DPA ranges
Date:   Thu, 17 Jun 2021 15:16:20 -0700
Message-Id: <20210617221620.1904031-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210617221620.1904031-1-ira.weiny@intel.com>
References: <20210617221620.1904031-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL spec defines the volatile DPA range to be 0 to Volatile memory size.
It further defines the persistent DPA range to follow directly after the
end of the Volatile DPA through the persistent memory size.  Essentially

Volatile DPA range   = [0, Volatile size)
Persistent DPA range = [Volatile size, Volatile size + Persistent size)

Adjust the pmem_range start to reflect this and remote the TODO.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 341885345b53..a1fd7923dfb9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1635,8 +1635,9 @@ static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
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
 
@@ -1660,15 +1661,12 @@ static int cxl_mem_create_range_info(struct cxl_mem *cxlm)
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

