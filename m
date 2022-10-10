Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D75C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJJWaX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJJWaW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:30:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ABF5AC68
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441021; x=1696977021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aJ1RcbZAq/8zOfhTcPqGwjNzmTWe3mf1nzcgNFpOldo=;
  b=ciIHk+1tcE8VjCZkZYIDWdKAPlAwvJLFiBqLvqXudxd2Abors2ypU29N
   qVVaKHckZJYeqRpFxcXMsFSFcJ2JjFq0nkhONszWU3wf3Q5MLf+BKmldv
   oU7tpGSYwM8NYAXpDbjDy4Wr/wjVZFC+jWtZrOrsB44ZCaxQv60ScgGFH
   3eZpFyMnZe2ho4UN10Ai7nJWtJrGPNu9mEEaMfy+R54+rfrNrmvIOwMMo
   sO+9wj6kebqv5dnASkWFE18qMvkfJEM9sjn1N3xljbcX7lEZGNAduGUwk
   HSFLOXBGaiwx3vyCF5zessJFWu3+svfyYTKxu8zsOs+5HrClFgc3Uw8XL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291661238"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291661238"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628456969"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628456969"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.104.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:19 -0700
From:   ira.weiny@intel.com
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: [RFC PATCH 1/6] qemu/bswap: Add const_le64()
Date:   Mon, 10 Oct 2022 15:29:39 -0700
Message-Id: <20221010222944.3923556-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Gcc requires constant versions of cpu_to_le* calls.

Add a 64 bit version.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/qemu/bswap.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 346d05f2aab3..08e607821102 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -192,10 +192,20 @@ CPU_CONVERT(le, 64, uint64_t)
      (((_x) & 0x0000ff00U) <<  8) |              \
      (((_x) & 0x00ff0000U) >>  8) |              \
      (((_x) & 0xff000000U) >> 24))
+# define const_le64(_x)                          \
+    ((((_x) & 0x00000000000000ffU) << 56) |      \
+     (((_x) & 0x000000000000ff00U) << 40) |      \
+     (((_x) & 0x0000000000ff0000U) << 24) |      \
+     (((_x) & 0x00000000ff000000U) <<  8) |      \
+     (((_x) & 0x000000ff00000000U) >>  8) |      \
+     (((_x) & 0x0000ff0000000000U) >> 24) |      \
+     (((_x) & 0x00ff000000000000U) >> 40) |      \
+     (((_x) & 0xff00000000000000U) >> 56))
 # define const_le16(_x)                          \
     ((((_x) & 0x00ff) << 8) |                    \
      (((_x) & 0xff00) >> 8))
 #else
+# define const_le64(_x) (_x)
 # define const_le32(_x) (_x)
 # define const_le16(_x) (_x)
 #endif
-- 
2.37.2

