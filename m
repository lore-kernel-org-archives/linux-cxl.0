Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0267EC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D890960FDC
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Sep 2021 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347396AbhIBTvc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:51:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:41966 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347398AbhIBTva (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 2 Sep 2021 15:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198778206"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="198778206"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="533451636"
Received: from kappusam-mobl.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 12:50:26 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 08/13] cxl/mem: Add memdev as a port
Date:   Thu,  2 Sep 2021 12:50:12 -0700
Message-Id: <20210902195017.2516472-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902195017.2516472-1-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL endpoints contain HDM decoders that are architecturally the same as
a CXL switch, or a CXL hostbridge. While some restrictions are in place
for endpoints, they will require the same enumeration logic to determine
the number and abilities of the HDM decoders.

Utilizing the existing port APIs from cxl_core is the simplest way to
gain access to the same set of information that switches and hostbridges
have.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c |  5 ++++-
 drivers/cxl/mem.c      | 10 +++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 56f57302d27b..f26095b40f5c 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -377,7 +377,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 
 	dev = &port->dev;
 	if (parent_port)
-		rc = dev_set_name(dev, "port%d", port->id);
+		if (host->type == &cxl_memdev_type)
+			rc = dev_set_name(dev, "devport%d", port->id);
+		else
+			rc = dev_set_name(dev, "port%d", port->id);
 	else
 		rc = dev_set_name(dev, "root%d", port->id);
 	if (rc)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index b6dc34d18a86..9d5a3a29cda1 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -63,6 +63,7 @@ static int cxl_mem_probe(struct device *dev)
 	struct device *pdev_parent = cxlm->dev->parent;
 	struct pci_dev *pdev = to_pci_dev(cxlm->dev);
 	struct device *port_dev;
+	int rc;
 
 	if (!is_cxl_mem_enabled(pdev))
 		return -ENODEV;
@@ -72,7 +73,14 @@ static int cxl_mem_probe(struct device *dev)
 	if (!port_dev)
 		return -ENODEV;
 
-	return 0;
+	/* TODO: Obtain component registers */
+	rc = PTR_ERR_OR_ZERO(devm_cxl_add_port(&cxlmd->dev, &cxlmd->dev,
+					       CXL_RESOURCE_NONE,
+					       to_cxl_port(port_dev)));
+	if (rc)
+		dev_err(dev, "Unable to add devices upstream port");
+
+	return rc;
 }
 
 static void cxl_mem_remove(struct device *dev)
-- 
2.33.0

