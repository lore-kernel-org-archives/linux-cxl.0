Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCC4C636D4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Feb 2023 01:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBCBFa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjBCBF3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 20:05:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216C54573
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675386329; x=1706922329;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R4XKfG9JMHsfbq65atGQCPp98ZqBkdqh//cpSQf3DTY=;
  b=es+CQvkbDnzListSqj2/3nB6cZEMFk9PwlnQ/f6wk9oU2kbk5PqfZd0s
   HpzB8f4pibmvkl6ajT77iB5jxEERLD0XgzcJMEr3s2mA7/tivejSAaC+O
   wOvkrJ5HETvpxjq20TqEYlr692i9TB0/7mmTVkNcP/By8pU2dMBDEh1BT
   1JEUKV8rDHPsoiWQVrBGO4CO8Yhi+zC5P3e7wKS/rlHfm0+CS0/njx7OI
   aRPlf7X7Y7jcQGEP/6zeyrwwHmVGQncJt8JDW5PC+bK+Ln8R0YA2Oby6O
   VE1psew2HAfuMMgpj2ttpLNNn7VfUtKUJ9IplC6o5R2elidOopJ4+cnnq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393215324"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="393215324"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839412549"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="839412549"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.229.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 17:04:37 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Thu, 02 Feb 2023 17:04:25 -0800
Subject: [PATCH v4 2/4] cxl/uapi: Add warning on CXL command enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v4-2-62f701c1cdd1@intel.com>
References: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
In-Reply-To: <20221222-cxl-misc-v4-0-62f701c1cdd1@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.11.0-dev-e429b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675386275; l=1198;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=R4XKfG9JMHsfbq65atGQCPp98ZqBkdqh//cpSQf3DTY=;
 b=Dio+sSBtQhPz45HxQHbI9y33WppAFDXybPuPB8Qxp/JO1En/ixHIms4wwJxnAa8fRl/roGQA+9Ya
 H6PFlDsBAyZjkRMaAhJIuN8lCIKsS1zQCDEYHPpcZQGbDSPcy53R
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL command enum is exported to user space and must maintain
backwards compatibility.

Add comment that new defines must be added to the end of the list.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/uapi/linux/cxl_mem.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c71021a2a9ed..459a3f7f764b 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -19,6 +19,10 @@
 #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
 #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
 
+/*
+ * NOTE: New defines must be added to the end of the list to preserve
+ * compatibility because this enum is exported to user space.
+ */
 #define CXL_CMDS                                                          \
 	___C(INVALID, "Invalid Command"),                                 \
 	___C(IDENTIFY, "Identify Command"),                               \

-- 
2.39.1
