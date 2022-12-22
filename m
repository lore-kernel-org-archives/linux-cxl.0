Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1B5C4167B
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Dec 2022 04:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLVEZU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 23:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLVEY5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 23:24:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3334C54
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 20:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683096; x=1703219096;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=r+jZpDuAJgbF8qG2z8hJ/QknHZJhBEpM5YCmYell9u0=;
  b=J9p0KUr3cpekHMQe48v2a7Q27/Hzsdg1RVrZA5GQMJAqgmywZSc3odoa
   hYactvNDE0ZVB+mchAlB9jzHc410HshxJE2d0V4H4sg92RnH7ENw+Cxxy
   xaDVDgwaTGEFFwRQQ/UmaFF98NnGzp6hiVSVlLervvzXrYMd5e7M307Oj
   sv9QaHMgF+2k5HnPZ0TQOZMe60p8iBVq726oziSUz/o03qEe1tDt2GevD
   UXgm+dJk+x70W3rpZX+lnHyO+PauZe3yF2Fe9/oLswI3SN+hLpsrtEOZd
   EeCJW7syMDRv5vIedqluMyQNDdSBAHIwwM5OvIMVWDGD2adsdMxEA0inV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321957583"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321957583"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601733189"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="601733189"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.20.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 21 Dec 2022 20:24:31 -0800
Subject: [PATCH v2 1/8] qemu/bswap: Add const_le64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-ira-cxl-events-2022-11-17-v2-1-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671683093; l=1569;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=r+jZpDuAJgbF8qG2z8hJ/QknHZJhBEpM5YCmYell9u0=;
 b=4U8LMfME7MtfbV2zXcVfJ6tolFzJKjjOLrvd5hsBWlgpAYj/h2hHLoDmaUVIoak86NiJ+kenVDRJ
 sftCVqvnAPwJkmfWkwFPRFkLGPQWAX5Mw7VGHPZ3mKVkqg2zJujp
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gcc requires constant versions of cpu_to_le* calls.

Add a 64 bit version.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC:
	Peter
		Change order of the definitions, 64-32-16
---
 include/qemu/bswap.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 346d05f2aab3..e1eca22f2548 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -187,6 +187,15 @@ CPU_CONVERT(le, 64, uint64_t)
  * used to initialize static variables.
  */
 #if HOST_BIG_ENDIAN
+# define const_le64(_x)                          \
+    ((((_x) & 0x00000000000000ffU) << 56) |      \
+     (((_x) & 0x000000000000ff00U) << 40) |      \
+     (((_x) & 0x0000000000ff0000U) << 24) |      \
+     (((_x) & 0x00000000ff000000U) <<  8) |      \
+     (((_x) & 0x000000ff00000000U) >>  8) |      \
+     (((_x) & 0x0000ff0000000000U) >> 24) |      \
+     (((_x) & 0x00ff000000000000U) >> 40) |      \
+     (((_x) & 0xff00000000000000U) >> 56))
 # define const_le32(_x)                          \
     ((((_x) & 0x000000ffU) << 24) |              \
      (((_x) & 0x0000ff00U) <<  8) |              \
@@ -196,6 +205,7 @@ CPU_CONVERT(le, 64, uint64_t)
     ((((_x) & 0x00ff) << 8) |                    \
      (((_x) & 0xff00) >> 8))
 #else
+# define const_le64(_x) (_x)
 # define const_le32(_x) (_x)
 # define const_le16(_x) (_x)
 #endif

-- 
2.38.1
