Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4238F22094
	for <linux-cxl@vger.kernel.org>; Thu, 10 Oct 2024 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728524996; cv=pass; b=XWHsdoR1fDRIJ2Kd+S21aGqzDIaiDLxQEgXb7U8G8JwqWPfigw6UGXb+ah80MHw2NV8y1JDyI+Zws+IESjFce0PFFU26rN7Ycl17Z9qY/qw3vb9BKWluw6Ft8oX4TOyNlM8iSCUFtoYXdQLJC+aLkezECjWdkjBlTIJ3Fzykppg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728524996; c=relaxed/simple;
	bh=lVFoSa0yGcqRrnQFMj6ILdPA7azJiiKDDF6NFHsX8BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cEjsH7kbowxQvi8AivdCLhnx7HMznkVENzARsmbF9uFK+KeM2Yq6J5WtHuvi/We0fmnnLvcgULfRUMZoYFu1Ov9j20Jivp3wy5Cb0e1yDelbPB/x2LFH7mMCYqg8lkfbV7LkiP0qbNsgBTovi/yoR9l2rDCPJ8p3R47mDhLfxF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gHwJuKr7; arc=pass smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gHwJuKr7"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BE77D325D71;
	Thu, 10 Oct 2024 01:44:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a297.dreamhost.com (trex-11.trex.outbound.svc.cluster.local [100.98.255.245])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4FEBA3250C5;
	Thu, 10 Oct 2024 01:44:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728524642; a=rsa-sha256;
	cv=none;
	b=aNKvsXahHaL8ZtWO96p+95CwnGxCkugJHW4OOJlBNI+wyCRb4U7jyRIBNoQ/GZYnqBKWM4
	dB/wvlcZevctprFbCQQp3hjt32ky94ERZy7OcH9z1+0VjM+dHUtjqaDJZOXd0YdYNvoaYK
	qe0S9BO7xYon1JShj0socwTwrVREQ8N4r1DqZR/zfwoZOVh0fOrJAtRQk2jzpOwuPiIFP+
	3bau/10JjMwXfocOmarlDcdm7yF+/eVhke9CzallmT8bcADiUXH/pcBK+j0YtDUOS4soVL
	T3rfmr9tH9aHR+U4TGQnR6rHnzo1NrFAuJv3A5RFhcd/+ffWik6aidBj8pxZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1728524642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=NqrxnXGiiQfljak1MBS98Jqy6zC08yTGa6fSZ3v41OI=;
	b=Mc6eofpDl3vjwdbKBhxa0r6O5dQxYSpD5rIoLP3N9VgvmIewDlxDiaF8brBISRlvuaekUb
	fVUlYHHHgXY/S1c07NtOlYnQWucCyN6El/wPMZJ6yBdNDpxhuOghX0xND1MyYvVaLLfwvg
	cP0CQXDEe1dEy74n//dK/JTTGYfZWPtBZ9Lf8ZNVzDyqiexHLKLN2lRrxqcaG5zIRcihbt
	42S1SYLsHmdu2rgvledlYGpk4zjtsn++LuhWjfJw1SKxUZJfHKWftGcoLNSxMlWJdHraSn
	UcjZMYX+km9ijjsb0noM9FshWnzfnkFBShsgNREmsqiUkuOHBo2hXHKxD7q2bw==
ARC-Authentication-Results: i=1;
	rspamd-5fcd6bf96c-tz4fs;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Juvenile: 39e0825c34d70b95_1728524642581_1154290375
X-MC-Loop-Signature: 1728524642581:937976098
X-MC-Ingress-Time: 1728524642581
Received: from pdx1-sub0-mail-a297.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.255.245 (trex/7.0.2);
	Thu, 10 Oct 2024 01:44:02 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a297.dreamhost.com (Postfix) with ESMTPSA id 4XPCGT62rBzJJ;
	Wed,  9 Oct 2024 18:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1728524642;
	bh=NqrxnXGiiQfljak1MBS98Jqy6zC08yTGa6fSZ3v41OI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gHwJuKr7IBgS8jLC0CkCMxYhnZ+Y1WiuHOmrbaxs5nmoPYSfSrZ2j0JChzWZQkjMX
	 NRYFl+38tpMpYCBo/wYcBfUr12+ao7bs8cPy2ye5TT1m6ubs92mfnBqAChfqclzPdD
	 bu6oh5vbsO40ke9mGBNKEbLg8vY2l/G2MN6Hlv6W9mSIned+TiPzb0FUGvuqjNusSe
	 Q9DzTFE2KLe2t9TTNGRXPSrbljEHN9HfOLhtPBUPrMGrbkCm+XcX5o+jVI3IzeVmRN
	 3QJBJkSFEtfaamRt4kWhe8wBYd+h06T/0U9Kk9Xj2Yn3hv/1sPs1TxgDPd+rcP+ecW
	 u/sc4Ky4Q4zBg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: fan.ni@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH -qemu] hw/cxl: Support get/set mctp response payload size
Date: Wed,  9 Oct 2024 18:41:57 -0700
Message-ID: <20241010014157.175548-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Get/Set Response Message Limit commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 68 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c2d776bc96eb..98416af794bb 100644
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
+        #define GET_RESPONSE_MSG_LIMIT   0x3
+        #define SET_RESPONSE_MSG_LIMIT   0x4
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -393,7 +397,7 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
         uint16_t pcie_subsys_vid;
         uint16_t pcie_subsys_id;
         uint64_t sn;
-    uint8_t max_message_size;
+        uint8_t max_message_size;
         uint8_t component_type;
     } QEMU_PACKED *is_identify;
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
@@ -422,12 +426,58 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
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
@@ -3000,6 +3050,10 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 
 static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
@@ -3035,6 +3089,10 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
 
 static const struct cxl_cmd cxl_cmd_set_t3_fm_owned_ld_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0,  0},
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
                               0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
@@ -3055,6 +3113,10 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
 
 static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][GET_RESPONSE_MSG_LIMIT] = { "GET_RESPONSE_MSG_LIMIT",
+                                           cmd_get_response_msg_limit, 0, 0 },
+    [INFOSTAT][SET_RESPONSE_MSG_LIMIT] = { "SET_RESPONSE_MSG_LIMIT",
+                                           cmd_set_response_msg_limit, 1, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
-- 
2.46.1

