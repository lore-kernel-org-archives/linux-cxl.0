Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3970AC4167B
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Dec 2021 04:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355533AbhLBEny (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Dec 2021 23:43:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:61244 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355539AbhLBEnq (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 1 Dec 2021 23:43:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236438388"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="236438388"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="745717501"
Received: from liudanie-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.143.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:40:10 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 13/14] cxl/port: Cleanup adding passthrough decoders
Date:   Wed,  1 Dec 2021 20:37:49 -0800
Message-Id: <20211202043750.3501494-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211202043750.3501494-1-ben.widawsky@intel.com>
References: <20211202043750.3501494-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This makes the resulting code easier to read and matches similar code
already existing in the port driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/port.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 527b027dcf24..4100cf395ec3 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -243,13 +243,8 @@ static int add_passthrough_decoder(struct cxl_port *port)
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
 	single_port_map[0] = dport->port_id;
 
-	rc = cxl_decoder_add_locked(cxld, single_port_map);
-	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(&port->dev, cxld);
-
-	if (rc == 0)
+	rc = add_hdm_decoder(port, cxld, single_port_map);
+	if (!rc)
 		dev_dbg(&port->dev, "add: %s\n", dev_name(&cxld->dev));
 
 	return rc;
-- 
2.34.1

