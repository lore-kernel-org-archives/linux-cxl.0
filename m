Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D827DC54EBD
	for <linux-cxl@archiver.kernel.org>; Thu, 12 Jan 2023 10:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjALKfu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjALKfJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 12 Jan 2023 05:35:09 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37771DDC2
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jan 2023 02:29:49 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nt10n15ntz6J6JQ;
        Thu, 12 Jan 2023 18:26:01 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 10:29:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] qemu/bswap: Add const_le64()
Date:   Thu, 12 Jan 2023 10:26:42 +0000
Message-ID: <20230112102644.27830-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
References: <20230112102644.27830-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Gcc requires constant versions of cpu_to_le* calls.

Add a 64 bit version.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2: Update comment (Philippe)

 include/qemu/bswap.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 346d05f2aa..c5cb9686c5 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -182,11 +182,20 @@ CPU_CONVERT(le, 32, uint32_t)
 CPU_CONVERT(le, 64, uint64_t)
 
 /*
- * Same as cpu_to_le{16,32}, except that gcc will figure the result is
+ * Same as cpu_to_le{16,32,64}, except that gcc will figure the result is
  * a compile-time constant if you pass in a constant.  So this can be
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
2.37.2

