Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8D4C4167B
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDD561181
	for <linux-cxl@archiver.kernel.org>; Sat, 16 Oct 2021 05:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243689AbhJPFRz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:17:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:31045 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243696AbhJPFRx (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sat, 16 Oct 2021 01:17:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="214961674"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="214961674"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:45 -0700
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="442743341"
Received: from asimon-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.133.4])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 22:15:45 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH 24/27] cxl/mem: Store the endpoint's uport
Date:   Fri, 15 Oct 2021 22:15:28 -0700
Message-Id: <20211016051531.622613-25-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016051531.622613-1-ben.widawsky@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
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
 drivers/cxl/mem.c    | 1 +
 2 files changed, 2 insertions(+)

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
index fb0b3cb10482..345281e69b6b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -62,6 +62,7 @@ static int create_endpoint_port(struct device *dev, struct device *host,
 	endpoint = devm_cxl_add_port(host, dev, cxlmd->creg_base, parent);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
+	cxlmd->uport = endpoint;
 	dev_dbg(host, "add: %s\n", dev_name(&endpoint->dev));
 
 	return 0;
-- 
2.33.1

