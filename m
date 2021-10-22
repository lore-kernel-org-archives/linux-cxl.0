Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA3C18E7D
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E29B60F50
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhJVSjl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:5590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233968AbhJVSji (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528979"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528979"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:20 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854738"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:20 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 26/28] cxl/mem: Store the endpoint's uport
Date:   Fri, 22 Oct 2021 11:37:07 -0700
Message-Id: <20211022183709.1199701-27-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Keeping track of an endpoint's port is important when attempting to
assemble all relevant components in the CXL.mem route from root to
endpoint. Without this change, the endpoint's port can be obtained
through walks of the hierarchy.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxlmem.h | 1 +
 drivers/cxl/mem.c    | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index cc5844150ce0..02efb270acac 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -45,6 +45,7 @@ struct cxl_memdev {
 	int id;
 	resource_size_t creg_base;
 	struct cxl_dport *root_port;
+	struct cxl_port *uport;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0b0272576e55..d348056f320f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -61,8 +61,7 @@ static void remove_endpoint(void *_cxlmd)
 	if (cxlmd->root_port)
 		sysfs_remove_link(&cxlmd->dev.kobj, "root_port");
 
-	endpoint = dev_get_drvdata(&cxlmd->dev);
-
+	endpoint = cxlmd->uport;
 	devm_cxl_remove_port(endpoint);
 }
 
@@ -83,7 +82,7 @@ static int create_endpoint(struct device *dev, struct cxl_port *parent,
 		device_del(&endpoint->dev);
 		return rc;
 	}
-	dev_set_drvdata(dev, endpoint);
+	cxlmd->uport = endpoint;
 	dev_dbg(dev, "add: %s\n", dev_name(&endpoint->dev));
 
 	return devm_add_action_or_reset(dev, remove_endpoint, cxlmd);
-- 
2.33.1

