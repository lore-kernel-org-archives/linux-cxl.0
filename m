Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540F2C4320A
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 20:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C21F604D7
	for <linux-cxl@archiver.kernel.org>; Fri, 30 Jul 2021 20:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhG3UHT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 30 Jul 2021 16:07:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:64370 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhG3UHT (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 30 Jul 2021 16:07:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="192758544"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="192758544"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:07:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="418063728"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 13:07:06 -0700
Subject: [PATCH v3 2/6] cxl/core: Improve CXL core kernel docs
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Fri, 30 Jul 2021 13:07:06 -0700
Message-ID: <162767562636.3322476.12211722876145119343.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162767561501.3322476.716972045397140827.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Now that CXL core's role is well understood, the documentation should
reflect that information.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/bus.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 6ce04e3976d2..647b8a00ab36 100644
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

