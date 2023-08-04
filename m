Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0384C001DE
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 19:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjHDTEC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjHDTD2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 15:03:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E974EF5
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691175805; x=1722711805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lbvwVrzdIkR3fQeeAyY/bIGl0yojWDf9oIUbzwn5FNg=;
  b=ilLMFReZazQCB7s642Pdes1OgO4FZS+xD6yZzML1B6B39/SM35cfkiXu
   P1QNCZjV8kCSDSmbmeLeTpz9+GQqrrgApnu8gjBQVpTBsZCM9a+f6L0tk
   dZL9HPMzHod2TXV7SW0QFl6UG8BoILEAAWaGzkXvLqf65pcQ4me2eqZjN
   /lTLS1w+jzUqqQEopK8YNIPr2/anCOFLNYuIkJ5HPgEwyTfA5XNIL91SJ
   ZlYHs31+xdXcJo0rpgvATdnh3468BOgf3gFdlt8wnahbBMF9e8bNLgz0c
   seA6Ub+cqx9cZiYyIXxRafNcrisPBUke0OlVCUHLMs/mB9O/TreDiLXQu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="436551038"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="436551038"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="976682413"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="976682413"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.168.219])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:03:23 -0700
From:   alison.schofield@intel.com
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/mbox: Remove useless cast in cxl_mem_create_range_info()
Date:   Fri,  4 Aug 2023 12:03:09 -0700
Message-Id: <20230804190309.1665132-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

DEFINE_RES_MEM() returns a struct resource so the cast is not needed.
Remove it.

Found using sparse:
drivers/cxl/core/mbox.c:1184:18: warning: cast to non-scalar
drivers/cxl/core/mbox.c:1184:18: warning: cast from non-scalar

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/mbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d6d067fbee97..01de4b438b2a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1180,8 +1180,7 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 		return 0;
 	}
 
-	cxlds->dpa_res =
-		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
+	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
 
 	if (mds->partition_align_bytes == 0) {
 		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,

base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9
-- 
2.37.3

