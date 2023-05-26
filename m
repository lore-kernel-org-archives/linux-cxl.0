Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA3BC77B73
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjEZRAp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjEZRAo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 13:00:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9671A2
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 10:00:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWJt1KdQz6J74Z;
        Sat, 27 May 2023 00:55:58 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 18:00:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v8 1/4] bswap: Add the ability to store to an unaligned 24 bit field
Date:   Fri, 26 May 2023 18:00:07 +0100
Message-ID: <20230526170010.574-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/devel/loads-stores.rst |  2 ++
 include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index d2cefc77a2..dab6dfa0ac 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
 ``size``
  - ``b`` : 8 bits
  - ``w`` : 16 bits
+ - ``24`` : 24 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
@@ -65,6 +66,7 @@ of size ``sz`` bytes.
 Regexes for git grep
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
+ - ``\<st24\(_[hbl]e\)\?_p\>``
  - ``\<ldn_\([hbl]e\)?_p\>``
  - ``\<stn_\([hbl]e\)?_p\>``
 
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 15a78c0db5..933a66ee87 100644
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
+    *s = bswap24(*s & 0x00ffffffU);
+}
+
 static inline void bswap32s(uint32_t *s)
 {
     *s = __builtin_bswap32(*s);
@@ -26,11 +38,13 @@ static inline void bswap64s(uint64_t *s)
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
 #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
             do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
+#define le_bswap24(v) (v)
 #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
 #define be_bswaps(p, size) \
@@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
  * size is:
  *   b: 8 bits
  *   w: 16 bits
+ *   24: 24 bits
  *   l: 32 bits
  *   q: 64 bits
  *
@@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
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
@@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
     stw_he_p(ptr, le_bswap(v, 16));
 }
 
+static inline void st24_le_p(void *ptr, uint32_t v)
+{
+    st24_he_p(ptr, le_bswap24(v));
+}
+
 static inline void stl_le_p(void *ptr, uint32_t v)
 {
     stl_he_p(ptr, le_bswap(v, 32));
-- 
2.39.2

