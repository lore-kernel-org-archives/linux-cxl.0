Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F6C38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 00:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjA1AKh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 19:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjA1AKg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 19:10:36 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E460A5D9
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674864615; x=1706400615;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=qMPXr5lu6JJOYJwR+zeX13hZ401ONKOyMsDw8/RU5ic=;
  b=WLEFLNkQ8qAJ1Sxz39/P/NtDoiw9gLvugN2mUW3BZps9EvDDLXlT4ftW
   vl7MDPGJGaQS9LfO9hC0ulWlr1micvxKXz76Cs4PndVMXZZJsHRBuEfO7
   8YopiYOMczYHQ6rHHI4wO1nkUo+z8Naw5iO/q6YPUkKhF6fhu0PFLtNKS
   B+jN3L5JWj+HO6iTX+DIzcdKtM3tZilk4m8UGzG+1aSMrDQJjutqvEMa3
   6Djx1cpotadTpeagIXB4pKGr8mbFb6yRL8aDBIuf+iFBgY9kdmCh4mQ+G
   npZEZG3pNmx9lRJOs9lQgTK3Tk2B1I8+VctV5obi7uyT1IXt8HFtzrvIj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="389608226"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="389608226"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="656793056"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="656793056"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.64.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 16:09:47 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Fri, 27 Jan 2023 16:09:39 -0800
Subject: [PATCH v2 2/4] cxl/uapi: Add warning on CXL command enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221222-cxl-misc-v2-2-60403cc37257@intel.com>
References: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
In-Reply-To: <20221222-cxl-misc-v2-0-60403cc37257@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674864584; l=1188;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=qMPXr5lu6JJOYJwR+zeX13hZ401ONKOyMsDw8/RU5ic=;
 b=A2r5G2QUpty6X5fZPPZiYtZtbEhMYqUPg7cfOv5obzBAuEMKUlVgM4f7YCNO6mlzDHKT71UHJKMh
 VN4t1h/JCmxymwa03n+F+Lrci2yehYNsHCVMqCenyAHXzmf/J15E
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
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
	Pick up tag
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
