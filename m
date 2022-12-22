Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F27FC3DA7A
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Dec 2022 04:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiLVEZ1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 23:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiLVEZC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 23:25:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EFDED
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 20:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683101; x=1703219101;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UQnornUfT/vaDjeF5Z6CteaB75obyZRj7zvuhg79FR0=;
  b=aZTqVpL4Pn+c8vfPyNQKOBRhiqa5mc8s0WfRumMuzxLdVyPnJGp9dHuu
   bVh9Ix1b7lTOiKa/Bzimxzs+o4NKBtm3GtGcHSpH2uEUhSPIlu1pdBzh9
   F32A+cri14D0cSDiv5NE4kMRy2rD2aDHa+DnGVATGFUtRL+DfaVYqh82D
   JXkGNJmTYpSrMnZrt5o2glhebHq/eOjsbEeKhHIcDx3FytY0jarogToc5
   bHDgSDplur/1XTsMRCE6QTgedDVfgukzuIJ27Gh1KFAiOt+iZhwiLCOnd
   LaXbNRpdS4c3VYxDDtpL1g0TxLNWcWCDN3yF78k9U0NZ6ZHIFo4/O+4wS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321957632"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321957632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:25:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601733212"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="601733212"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.20.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:25:00 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 21 Dec 2022 20:24:37 -0800
Subject: [PATCH v2 7/8] bswap: Add the ability to store to an unaligned 24 bit field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-ira-cxl-events-2022-11-17-v2-7-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671683093; l=2387;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=UQnornUfT/vaDjeF5Z6CteaB75obyZRj7zvuhg79FR0=;
 b=bW3809h1Txum7nDYbsKD/2LjWN3Nt7V86syYEfxpIeK26nBUMDZsF5aVinGGfsLwWD7NkRKvmPB4
 rfqk7tx1DINr9J5m9o1egvcmFluIEEzXsehen96H+4IcxbeqWlqJ
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL has 24 bit unaligned fields which need to be stored to.  CXL is
specified as little endian.

Define st24_le_p() and the supporting functions to store such a field
from a 32 bit host native value.

The use of b, w, l, q as the size specifier is limiting.  So "24" was
used for the size part of the function name.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/qemu/bswap.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index e1eca22f2548..8af4d4a75eb6 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -25,6 +25,13 @@ static inline uint16_t bswap16(uint16_t x)
     return bswap_16(x);
 }
 
+static inline uint32_t bswap24(uint32_t x)
+{
+    return (((x & 0x000000ffU) << 16) |
+            ((x & 0x0000ff00U) <<  0) |
+            ((x & 0x00ff0000U) >> 16));
+}
+
 static inline uint32_t bswap32(uint32_t x)
 {
     return bswap_32(x);
@@ -43,6 +50,13 @@ static inline uint16_t bswap16(uint16_t x)
             ((x & 0xff00) >> 8));
 }
 
+static inline uint32_t bswap24(uint32_t x)
+{
+    return (((x & 0x000000ffU) << 16) |
+            ((x & 0x0000ff00U) <<  0) |
+            ((x & 0x00ff0000U) >> 16));
+}
+
 static inline uint32_t bswap32(uint32_t x)
 {
     return (((x & 0x000000ffU) << 24) |
@@ -72,6 +86,11 @@ static inline void bswap16s(uint16_t *s)
     *s = bswap16(*s);
 }
 
+static inline void bswap24s(uint32_t *s)
+{
+    *s = bswap24(*s);
+}
+
 static inline void bswap32s(uint32_t *s)
 {
     *s = bswap32(*s);
@@ -233,6 +252,7 @@ CPU_CONVERT(le, 64, uint64_t)
  * size is:
  *   b: 8 bits
  *   w: 16 bits
+ *   24: 24 bits
  *   l: 32 bits
  *   q: 64 bits
  *
@@ -305,6 +325,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
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
@@ -354,6 +379,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
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
2.38.1
