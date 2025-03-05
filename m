Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B2202969
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166638; cv=none; b=Bo/6JiFAXyf7iU8lMGQ3512Bsi0V7jD20UIW4UkFPg1x8e/7tdJqRZvi0ye65EDGqKPbjR7ixz1ukn+XL3hkYgx/PeGH+YtuEapUeyqPTyrqGSNEzkLm1cLwGY9aNu+Rx2AyiqzgddLbIBoF3eJIRHKSb0WO2KfrHZoYYqpXReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166638; c=relaxed/simple;
	bh=t5hy1xhuVV4zzDLFbQjdB/4uRAG+tTXKgNBjr0CjuXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+J58/Q+QRFJu4dcHcQHEUvPesHUy1w8SkDmD1qgB6pn99oB3nSEIoI2v4/EHA/MZI1w31NgvArHB1YsTO/B2xEWsKgrUSH6xg6ed1zAPZZD4wAwG6cD2ICHMMYH1+oh22F/VWqfxS/fYZ5nMLZWULMqhnfuS/l/qjMAajHexDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Sz3b1Xz6L577;
	Wed,  5 Mar 2025 17:19:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5888C140751;
	Wed,  5 Mar 2025 17:23:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:23:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 2/8] hw/cxl: Support get/set mctp response payload size
Date: Wed, 5 Mar 2025 09:22:42 +0000
Message-ID: <20250305092249.191812-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092249.191812-1-Jonathan.Cameron@huawei.com>
References: <20250305092249.191812-1-Jonathan.Cameron@huawei.com>
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

From: Davidlohr Bueso <dave@stgolabs.net>

Add Get/Set Response Message Limit commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 58 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4401f446d9..bd25df033a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -7,6 +7,8 @@
  * COPYING file in the top-level directory.
  */
 
+#include <math.h>
+
 #include "qemu/osdep.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
@@ -56,6 +58,8 @@ enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
         #define BACKGROUND_OPERATION_STATUS    0x2
+        #define GET_RESPONSE_MSG_LIMIT         0x3
+        #define SET_RESPONSE_MSG_LIMIT         0x4
         #define BACKGROUND_OPERATION_ABORT     0x5
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
@@ -413,12 +417,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         is_identify->component_type = 0x3; /* Type 3 */
     }
 
-    /* TODO: Allow this to vary across different CCIs */
-    is_identify->max_message_size = 9; /* 512 bytes - MCTP_CXL_MAILBOX_BYTES */
+    is_identify->max_message_size = (uint8_t)log2(cci->payload_max);
     *len_out = sizeof(*is_identify);
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.1.3: Get Response Message Limit (Opcode 0003h) */
+static CXLRetCode cmd_get_response_msg_limit(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *get_rsp_msg_limit = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*get_rsp_msg_limit) != 1);
+
+    get_rsp_msg_limit->rsp_limit = (uint8_t)log2(cci->payload_max);
+
+    *len_out = sizeof(*get_rsp_msg_limit);
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.1.4: Set Response Message Limit (Opcode 0004h) */
+static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *in = (void *)payload_in;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 1);
+    struct {
+        uint8_t rsp_limit;
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*out) != 1);
+
+    if (in->rsp_limit < 8 || in->rsp_limit > 10) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    cci->payload_max = 1 << in->rsp_limit;
+    out->rsp_limit = in->rsp_limit;
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
                                   void *private)
 {
@@ -3105,6 +3155,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 
 static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
-- 
2.43.0

