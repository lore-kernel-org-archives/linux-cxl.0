Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD567C54EAA
	for <linux-cxl@archiver.kernel.org>; Mon, 30 Jan 2023 14:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjA3Olm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 30 Jan 2023 09:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjA3Oll (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 30 Jan 2023 09:41:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8111A949
        for <linux-cxl@vger.kernel.org>; Mon, 30 Jan 2023 06:41:40 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P59pJ47R4z6J9dr;
        Mon, 30 Jan 2023 22:40:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 14:41:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/10] qemu/uuid: Add UUID static initializer
Date:   Mon, 30 Jan 2023 14:37:04 +0000
Message-ID: <20230130143705.11758-10-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
References: <20230130143705.11758-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

UUID's are defined as network byte order fields.  No static initializer
was available for UUID's in their standard big endian format.

Define a big endian initializer for UUIDs.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/qemu/uuid.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
index 9925febfa5..dc40ee1fc9 100644
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

