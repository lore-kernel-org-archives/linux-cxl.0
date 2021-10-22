Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E5C4321E
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76272611BD
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbhJVSjf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:5577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233931AbhJVSje (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528933"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854622"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:15 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 07/28] cxl/core: Move target population locking to caller
Date:   Fri, 22 Oct 2021 11:36:48 -0700
Message-Id: <20211022183709.1199701-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A CXL port driver which would be responsible for adding decoders will
want to do so during probe. Unfortunately, the device lock is held
during probe. Making this change allows for a new lock-free variant of
cxl_decoder_add which will be used by the port driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 5564a71773e2..5f2bde47a5c2 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -478,25 +478,18 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	if (!target_map)
 		return 0;
 
-	device_lock(&port->dev);
-	if (list_empty(&port->dports)) {
-		rc = -EINVAL;
-		goto out_unlock;
-	}
+	device_lock_assert(&port->dev);
+	if (list_empty(&port->dports))
+		return -EINVAL;
 
 	for (i = 0; i < cxld->nr_targets; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
-		if (!dport) {
-			rc = -ENXIO;
-			goto out_unlock;
-		}
+		if (!dport)
+			return -ENXIO;
 		cxld->target[i] = dport;
 	}
 
-out_unlock:
-	device_unlock(&port->dev);
-
 	return rc;
 }
 
@@ -548,7 +541,7 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
 	struct device *dev;
-	int rc;
+	int rc = 0;
 
 	if (WARN_ON_ONCE(!cxld))
 		return -EINVAL;
@@ -562,11 +555,13 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 	dev = &cxld->dev;
 
 	port = to_cxl_port(cxld->dev.parent);
-	if (!is_endpoint_decoder(dev)) {
+
+	device_lock(&port->dev);
+	if (!is_endpoint_decoder(dev))
 		rc = decoder_populate_targets(cxld, port, target_map);
-		if (rc)
-			return rc;
-	}
+	device_unlock(&port->dev);
+	if (rc)
+		return rc;
 
 	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
 	if (rc)
-- 
2.33.1

