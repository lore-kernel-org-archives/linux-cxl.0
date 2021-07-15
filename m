Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B36CC636CA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8D8613D3
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbhGOT6l (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:58:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:23363 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344358AbhGOTtX (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 15 Jul 2021 15:49:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197803792"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="197803792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="489564776"
Received: from cherrera-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.149])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:32 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/6] cxl/core: Improve CXL core kernel docs
Date:   Thu, 15 Jul 2021 12:41:21 -0700
Message-Id: <20210715194125.898305-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210715194125.898305-1-ben.widawsky@intel.com>
References: <20210715194125.898305-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that CXL core's role is well understood, the documentation should
reflect that information.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/bus.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 00b759ff92d3..f50872e8e7af 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -12,8 +12,15 @@
 /**
  * DOC: cxl core
  *
- * The CXL core provides a sysfs hierarchy for control devices and a rendezvous
- * point for cross-device interleave coordination through cxl ports.
+ * The CXL core provides a set of interfaces that can be consumed by CXL aware
+ * drivers. The interfaces allow for creation, modification, and destruction of
+ * regions, memory devices, ports, and decoders. CXL aware drivers must register
+ * with the CXL core via these interfaces in order to be able to participate in
+ * cross-device interleave coordination. The CXL core also establishes and
+ * maintains the bridge to the nvdimm subsystem.
+ *
+ * CXL core introduces sysfs hierarchy to control the devices that are
+ * instantiated by the core.
  */
 
 static DEFINE_IDA(cxl_port_ida);
-- 
2.32.0

