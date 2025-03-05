Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70C2045A8
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166800; cv=none; b=XMoKwtNV5BvXVGsqlhzm7rqYnMosn/D8NsBRB0yKb1ATwG0P6bmARa1Cv6vL60BuFpMtzd8IefITFbdDXz/JXf8BbMqyM659eXEiulvYEmf9iZMERYJi7HaK6RRlQog1/uMDVRhPC4fUT/ZO02floFLMSXixUQvLlYHvde8hPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166800; c=relaxed/simple;
	bh=IUZGBJ7esxT3SWv5PioaSrVets8UN1/vh/qZl0xsnKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUiKyoSmkS+YQ21BcffeLiHNcj/TQfQLn+5dNswbLAElZ+PQ3WrBlHFmPvUb9c/ZxxKkVJjG8XjuF7xLppKPcBGR9RdgzW9YAPckrRRGu4kiY7bvtCMBJwEWR/MYO4bu3msM7FUvBHOxcNIvcHUbHWDhdpF9WuVrfeluUJwuij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76YQ3km6z6M4n6;
	Wed,  5 Mar 2025 17:23:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DF7E140A34;
	Wed,  5 Mar 2025 17:26:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:26:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 3/8] hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)
Date: Wed, 5 Mar 2025 09:24:54 +0000
Message-ID: <20250305092501.191929-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Vinayak Holikatti <vinayak.kh@samsung.com>

CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
CXL devices supports media operations discovery command.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bd25df033a..79b35d1405 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -89,6 +89,7 @@ enum {
     SANITIZE    = 0x44,
         #define OVERWRITE     0x0
         #define SECURE_ERASE  0x1
+        #define MEDIA_OPERATIONS 0x2
     PERSISTENT_MEM = 0x45,
         #define GET_SECURITY_STATE     0x0
     MEDIA_AND_POISON = 0x43,
@@ -1705,6 +1706,126 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+enum {
+    MEDIA_OP_CLASS_GENERAL  = 0x0,
+        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
+    MEDIA_OP_CLASS_SANITIZE = 0x1,
+        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
+        #define MEDIA_OP_SAN_SUBC_ZERO 0x1
+};
+
+struct media_op_supported_list_entry {
+    uint8_t media_op_class;
+    uint8_t media_op_subclass;
+};
+
+struct media_op_discovery_out_pl {
+    uint64_t dpa_range_granularity;
+    uint16_t total_supported_operations;
+    uint16_t num_of_supported_operations;
+    struct media_op_supported_list_entry entry[];
+} QEMU_PACKED;
+
+static const struct media_op_supported_list_entry media_op_matrix[] = {
+    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
+    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
+};
+
+static CXLRetCode media_operations_discovery(uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+        struct {
+            uint16_t start_index;
+            uint16_t num_ops;
+        } discovery_osa;
+    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
+    struct media_op_discovery_out_pl *media_out_pl =
+        (struct media_op_discovery_out_pl *)payload_out;
+    int num_ops, start_index, i;
+    int count = 0;
+
+    if (len_in < sizeof(*media_op_in_disc_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
+    start_index = media_op_in_disc_pl->discovery_osa.start_index;
+
+    /*
+     * As per spec CXL r3.2 8.2.10.9.5.3 dpa_range_count should be zero and
+     * start index should not exceed the total number of entries for discovery
+     * sub class command.
+     */
+    if (media_op_in_disc_pl->dpa_range_count ||
+        start_index > ARRAY_SIZE(media_op_matrix)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
+    media_out_pl->total_supported_operations =
+                                     ARRAY_SIZE(media_op_matrix);
+    if (num_ops > 0) {
+        for (i = start_index; i < start_index + num_ops; i++) {
+            media_out_pl->entry[count].media_op_class =
+                    media_op_matrix[i].media_op_class;
+            media_out_pl->entry[count].media_op_subclass =
+                        media_op_matrix[i].media_op_subclass;
+            count++;
+            if (count == num_ops) {
+                break;
+            }
+        }
+    }
+
+    media_out_pl->num_of_supported_operations = count;
+    *len_out = sizeof(*media_out_pl) + count * sizeof(*media_out_pl->entry);
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
+                                       uint8_t *payload_in,
+                                       size_t len_in,
+                                       uint8_t *payload_out,
+                                       size_t *len_out,
+                                       CXLCCI *cci)
+{
+    struct {
+        uint8_t media_operation_class;
+        uint8_t media_operation_subclass;
+        uint8_t rsvd[2];
+        uint32_t dpa_range_count;
+    } QEMU_PACKED *media_op_in_common_pl = (void *)payload_in;
+    uint8_t media_op_cl = 0;
+    uint8_t media_op_subclass = 0;
+
+    if (len_in < sizeof(*media_op_in_common_pl)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    media_op_cl = media_op_in_common_pl->media_operation_class;
+    media_op_subclass = media_op_in_common_pl->media_operation_subclass;
+
+    switch (media_op_cl) {
+    case MEDIA_OP_CLASS_GENERAL:
+        if (media_op_subclass != MEDIA_OP_GEN_SUBC_DISCOVERY) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        return media_operations_discovery(payload_in, len_in, payload_out,
+                                             len_out);
+    default:
+        return CXL_MBOX_UNSUPPORTED;
+    }
+}
+
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -2850,6 +2971,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
          CXL_MBOX_SECURITY_STATE_CHANGE |
          CXL_MBOX_BACKGROUND_OPERATION |
          CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
+    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
+        ~0,
+        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+         CXL_MBOX_BACKGROUND_OPERATION)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
-- 
2.43.0

