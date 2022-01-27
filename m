Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFA9C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 27 Jan 2022 21:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiA0V3e (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:29:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:50502 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbiA0V3d (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 27 Jan 2022 16:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643318973; x=1674854973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c1aM+hrXlpfMyS4zpoHXcSqxmp0h+TQpG3apP92+EwM=;
  b=Ypo4wPoTLQXlVdRw/Cvq/RJqI5HMUo9XaXeSLZd1sBp5SsI2TiWo80/8
   bd1mMtXnU9nRjQHYGUFYSGR8G9inz3LjV5mg6hOAA7WoLBEmeTbfF32ra
   L7X1uon0Y+IYzx8EC0cy3me42JpYjnFQVgxqq0kouNAuaKNHyf+Uy92uy
   geVCdk7SYlubXwWc9Uvr3wcl7NbHhXU5mBszvVUZ+dmJyPdAtyabaK1Yp
   km8NvbsCoA2Cw1vN+a62grnbxGlf0gK4PlRJ8t5g6ZEvqa7elpCKprU4m
   CopYS92ZNDo/6lffjf6O63gi0+ZE+4iyvvKLcmaaxx5SdIw8SZ1SWwMT3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230546182"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230546182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="521402198"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:29:33 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 4/4] cxl/acpi: Use common IW/IG decoding
Date:   Thu, 27 Jan 2022 13:29:11 -0800
Message-Id: <20220127212911.127741-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127212911.127741-1-ben.widawsky@intel.com>
References: <20220127212911.127741-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Now that functionality to decode interleave ways and granularity is in
a common place, use that functionality in the cxl_acpi driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f99cad8350fd..d6dcb2b6af48 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -10,8 +10,8 @@
 #include "cxl.h"
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
-#define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
-#define CFMWS_INTERLEAVE_GRANULARITY(x)	(1 << ((x)->granularity + 8))
+#define CFMWS_INTERLEAVE_WAYS(x)	(cxl_to_interleave_ways((x)->interleave_ways))
+#define CFMWS_INTERLEAVE_GRANULARITY(x)	(cxl_to_interleave_granularity((x)->granularity))
 
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
-- 
2.35.0

