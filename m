Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DD4C49EA4
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C37C61209
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 00:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhFRAyR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:54:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:2051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhFRAyQ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 17 Jun 2021 20:54:16 -0400
IronPort-SDR: i6urxZZtJumNY/2VnjAQjTJ/N3YD9Qr0N0TjRvXDA1uhKKNMITLKJdqyaa5mt51zkZ+9je4peL
 uJydRMyj0+Og==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="292105420"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="292105420"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:07 -0700
IronPort-SDR: 5DGK/nR6/3K8bBQ6S5en1nWGt+slLsslx/gvQWUcBVfe+OaGn81EFK6flgyLdq7JQ7tFH0yhCg
 4890aLwpPjEQ==
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="622223128"
Received: from mkalyani-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.138.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:52:06 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 4/5] cxl/pci: Export CXL DVSEC functionality
Date:   Thu, 17 Jun 2021 17:51:59 -0700
Message-Id: <20210618005200.997804-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618005200.997804-1-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 2 +-
 drivers/cxl/pci.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f9c0eaf3ff4e..b1a5a18dba92 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -973,7 +973,7 @@ static void cxl_mem_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
 	pci_iounmap(cxlm->pdev, base);
 }
 
-static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
+int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 {
 	int pos;
 
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index dad7a831f65f..0d6f50f725bc 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -28,4 +28,6 @@
 
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
+int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec);
+
 #endif /* __CXL_PCI_H__ */
-- 
2.32.0

