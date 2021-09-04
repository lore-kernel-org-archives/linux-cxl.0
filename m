Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D24C433F5
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EBE61056
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Sep 2021 02:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhIDCVx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:21:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:34504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240791AbhIDCVw (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Sep 2021 22:21:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206784721"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="206784721"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:20:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="603362535"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 19:20:51 -0700
Subject: [PATCH 3/6] cxl/pci: Fix debug message in cxl_probe_regs()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     stable@vger.kernel.org,
        "Li Qiang \(Johnny Li\)" <johnny.li@montage-tech.com>,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 03 Sep 2021 19:20:50 -0700
Message-ID: <163072205089.2250120.8103605864156687395.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Li Qiang (Johnny Li) <johnny.li@montage-tech.com>

Indicator string for mbox and memdev register set to status
incorrectly in error message.

Cc: <stable@vger.kernel.org>
Fixes: 30af97296f48 ("cxl/pci: Map registers based on capabilities")
Signed-off-by: Li Qiang (Johnny Li) <johnny.li@montage-tech.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 37903259ee79..8e45aa07d662 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1041,8 +1041,8 @@ static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
 		    !dev_map->memdev.valid) {
 			dev_err(dev, "registers not found: %s%s%s\n",
 				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "status " : "",
-				!dev_map->memdev.valid ? "status " : "");
+				!dev_map->mbox.valid ? "mbox " : "",
+				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
 

