Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620EBC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 443EF61252
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhJPFRv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:1745 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243689AbhJPFRt (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="225489609"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="225489609"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743291"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:42 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 15/27] cxl: Disable switch hierarchies for now
Date:   Fri, 15 Oct 2021 22:15:19 -0700
Message-Id: <20211016051531.622613-16-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Switches aren't supported by the region driver yet. If a device finds
itself under a switch it will not bind a driver so that it cannot be
used later for region creation/configuration.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 60fadf5a0262..fb0b3cb10482 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -118,6 +118,11 @@ static int cxl_mem_probe(struct device *dev)
 		goto out;
 	}
 
+	/* FIXME: Add true switch support */
+	dev_err(dev, "Devices behind switches are currently unsupported\n");
+	rc = -ENODEV;
+	goto err_out;
+
 	/* Walk down from the root port and add all switches */
 	cxl_scan_ports(ctx.root_port);
 
-- 
2.33.1

