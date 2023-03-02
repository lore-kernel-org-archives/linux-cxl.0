Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D7C678D4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 10:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCBKSt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCBKSp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 05:18:45 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3813DD8
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 02:18:44 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PS6Q11Fyrz6J7x4;
        Thu,  2 Mar 2023 18:13:45 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 10:18:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 3/6] bswap: Add the ability to store to an unaligned 24 bit field
Date:   Thu, 2 Mar 2023 10:17:07 +0000
Message-ID: <20230302101710.1652-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
References: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL has 24 bit unaligned fields which need to be stored to.  CXL is
specified as little endian.

Define st24_le_p() and the supporting functions to store such a field
from a 32 bit host native value.

The use of b, w, l, q as the size specifier is limiting.  So "24" was
used for the size part of the function name.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v8:
  - Picked up tag from Fan Ni.
---
 include/qemu/bswap.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 15a78c0db5..ee71cbeaaa 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,11 +8,23 @@
 #undef  bswap64
 #define bswap64(_x) __builtin_bswap64(_x)
 
+static inline uint32_t bswap24(uint32_t x)
+{
+    return (((x & 0x000000ffU) << 16) |
+            ((x & 0x0000ff00U) <<  0) |
+            ((x & 0x00ff0000U) >> 16));
+}
+
 static inline void bswap16s(uint16_t *s)
 {
     *s = __builtin_bswap16(*s);
 }
 
+static inline void bswap24s(uint32_t *s)
+{
+    *s = bswap24(*s);
+}
+
 static inline void bswap32s(uint32_t *s)
 {
     *s = __builtin_bswap32(*s);
@@ -176,6 +188,7 @@ CPU_CONVERT(le, 64, uint64_t)
  * size is:
  *   b: 8 bits
  *   w: 16 bits
+ *   24: 24 bits
  *   l: 32 bits
  *   q: 64 bits
  *
@@ -248,6 +261,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
+static inline void st24_he_p(void *ptr, uint32_t v)
+{
+    __builtin_memcpy(ptr, &v, 3);
+}
+
 static inline int ldl_he_p(const void *ptr)
 {
     int32_t r;
@@ -297,6 +315,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
     stw_he_p(ptr, le_bswap(v, 16));
 }
 
+static inline void st24_le_p(void *ptr, uint32_t v)
+{
+    st24_he_p(ptr, le_bswap(v, 24));
+}
+
 static inline void stl_le_p(void *ptr, uint32_t v)
 {
     stl_he_p(ptr, le_bswap(v, 32));
-- 
2.37.2

