Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5D3C48BE5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461AB613F5
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Jun 2021 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFJS7f (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:59:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:35902 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhFJS7f (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 10 Jun 2021 14:59:35 -0400
IronPort-SDR: gs6TkBXxZDPMN3FCOXj86N0NFmB4XYH3Skd17U/NwuI4uU7x6ircPbhPOQ/wgkN1lY0enD1jDX
 S5On8CPfTx5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="266527360"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="266527360"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:38 -0700
IronPort-SDR: cGtR8Zoqv60kAIEFkNQBCVmEyMOrqflVMD0KhAlXFvQCj4S9TCf0QUdDjMgWjXKKmW3rrfK72m
 mh5jQYM7atCw==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="482963778"
Received: from millers-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.140.70])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:57:37 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 3/4] cxl: Move cxl_memdev conversion helper to mem.h
Date:   Thu, 10 Jun 2021 11:57:24 -0700
Message-Id: <20210610185725.897541-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610185725.897541-1-ben.widawsky@intel.com>
References: <20210610185725.897541-1-ben.widawsky@intel.com>
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
index 4c4eb06a966b..9795aa924035 100644
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
  * struct cxl_region - CXL region
  * @dev: This region's device.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5a1705b52278..be158f8f995e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1142,11 +1142,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
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

