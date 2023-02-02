Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C48BC636CD
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 01:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjBBBXm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 20:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBBBXk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 20:23:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FDB6AC82
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 17:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675301011; x=1706837011;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R4XKfG9JMHsfbq65atGQCPp98ZqBkdqh//cpSQf3DTY=;
  b=OYc1snI389WiyIUfXtUeSFnJH93SLVdH0vc0YG4nzZhVRdAgdiQMdOYj
   xH8E6Dq4UJ+zfeBlvlAps7wJzPFP25EMP1ufwjJVovYfXz93uFVd/lUxt
   EuHxVdbZzJiuDOtgJ0bk+Zn2e/Z64O87T27NJHcldFe5QA2345CdMOaX7
   qPWbKrEZr68TlC0LrcatIy6hFAaRauCmK75UzqnQm5aPOxFLyrveWS4XB
   oRNE+UDHAmvWJjkolH/snFkhSAxg5sxGQXmcrBVX2ozvk22/OkVuC1cAK
   WG2GRC0ahdEDFKaEfTQ0xrVf2l0IvkWdtGbFGeoVo/vVItukwjvV3qHLQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308661526"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="308661526"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="993888782"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="993888782"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.15.11])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 17:23:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 01 Feb 2023 17:23:11 -0800
Subject: [PATCH v3 2/4] cxl/uapi: Add warning on CXL command enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v3-2-60d4f35e4b39@intel.com>
References: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
In-Reply-To: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675301007; l=1198;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=R4XKfG9JMHsfbq65atGQCPp98ZqBkdqh//cpSQf3DTY=;
 b=bim2eULyAMgHMnUaiAwHsX5GoZ6pDKAIdFSAgY0bNSQIntgYSxLFmpR+Odq/Mm3VwLP8FRmqVYD2
 f19t6If7BMzBIJdhF+vWKcTmEyRnrnSDG3Krb1diP1J9DdotfziS
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
