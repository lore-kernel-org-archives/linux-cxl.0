Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC30C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJJWaY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJJWaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:30:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C858164
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441021; x=1696977021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/t8uS0dJ6+AOQCZeLPwusIK7WCU31QkWkBGL5ijeEMc=;
  b=N/HfYju0bAIB4Jrb8PEWj3IPvXFqcaEARrF9eDhUdO4M6THwCOpLq+pk
   UO+zVxnPj3ZPjcUKsD8ayXT+HobcduQSKOpyUowD58+8VujDlC7IUaR0e
   kGX4+kdR0JyxxmHiJPA3f/M5KHHDsbMPrBcis31nH0+wBtwG5NDPrfccu
   ljVTLD4y3ox+xSqop00FsWHyxbElazIag1pzvhrPUEB8SBRl0glyXebIl
   krgojJ2jIqB2Mh0FKApRqk6Qqf3P1tmWZpcad4CWzUbLIcB+UHDC/NWlP
   NTtchll8VXJ8BIoELFmmXsvl+VrNAerzRsa4TptS+xuwgqd7q+bdanCDY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291661241"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291661241"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628456977"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628456977"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.104.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:19 -0700
From:   ira.weiny@intel.com
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: [RFC PATCH 2/6] qemu/uuid: Add UUID static initializer
Date:   Mon, 10 Oct 2022 15:29:40 -0700
Message-Id: <20221010222944.3923556-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

UUID's are defined as network byte order fields.  No static initializer
was available for UUID's in their standard big endian format.

Define a big endian initializer for UUIDs.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/qemu/uuid.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 9925febfa54d..dc40ee1fc998 100644
--- a/include/qemu/uuid.h
+++ b/include/qemu/uuid.h
@@ -61,6 +61,18 @@ typedef struct {
     (clock_seq_hi_and_reserved), (clock_seq_low), (node0), (node1), (node2),\
     (node3), (node4), (node5) }
 
+/* Normal (network byte order) UUID */
+#define UUID(time_low, time_mid, time_hi_and_version,                    \
+  clock_seq_hi_and_reserved, clock_seq_low, node0, node1, node2,         \
+  node3, node4, node5)                                                   \
+  { ((time_low) >> 24) & 0xff, ((time_low) >> 16) & 0xff,                \
+    ((time_low) >> 8) & 0xff, (time_low) & 0xff,                         \
+    ((time_mid) >> 8) & 0xff, (time_mid) & 0xff,                         \
+    ((time_hi_and_version) >> 8) & 0xff, (time_hi_and_version) & 0xff,   \
+    (clock_seq_hi_and_reserved), (clock_seq_low),                        \
+    (node0), (node1), (node2), (node3), (node4), (node5)                 \
+  }
+
 #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
                  "%02hhx%02hhx-%02hhx%02hhx-" \
                  "%02hhx%02hhx-" \
-- 
2.37.2

