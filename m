Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D1C2B9F4
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47528613BF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Jun 2021 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhFQRjN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:39:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:2462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232584AbhFQRjM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 13:39:12 -0400
IronPort-SDR: VutIaQGrJLm9afyF32dqp5+a3qgy+UVsniNPwBwrcsiHK7j1itXz/bWlyKEs+vUrer4mi46dGj
 oYpgMIYf9Xbw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193732190"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193732190"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:03 -0700
IronPort-SDR: c69xTWiXudctKDerMXNfX0ldB+SSM1szGer4FHq97HM9j7HYOvtEQBamE4ziJ7GPcmLB0pX7mC
 VOa6i8kIPueg==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="421944104"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 10:37:03 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/6] cxl: Move cxl_memdev conversion helper to mem.h
Date:   Thu, 17 Jun 2021 10:36:51 -0700
Message-Id: <20210617173655.430424-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617173655.430424-1-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.h | 5 +++++
 drivers/cxl/pci.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 8f02d02b26b4..fe12ef3c3dde 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -48,6 +48,11 @@ struct cxl_memdev {
 	int id;
 };
 
+static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
+{
+       return container_of(dev, struct cxl_memdev, dev);
+}
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f8408e5f0754..52508282ec37 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1161,11 +1161,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	return ret;
 }
 
-static struct cxl_memdev *to_cxl_memdev(struct device *dev)
-{
-	return container_of(dev, struct cxl_memdev, dev);
-}
-
 static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-- 
2.32.0

