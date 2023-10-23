Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8F1CA80
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5827C1
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 09:15:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SDgDT3LFNz6JB9n;
	Tue, 24 Oct 2023 00:11:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 23 Oct 2023 17:15:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Gregory Price
	<gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>, Klaus
 Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2 14/17] hw/cxl/mbox: Add Get Background Operation Status Command
Date: Mon, 23 Oct 2023 17:08:03 +0100
Message-ID: <20231023160806.13206-15-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

For now, provide this command on type 3 main mailbox only.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2463f239af..2b78136588 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -50,6 +50,7 @@
 enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
+        #define BACKGROUND_OPERATION_STATUS    0x2
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -452,6 +453,36 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.0 8.2.9.1.2 */
+static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    struct {
+        uint8_t status;
+        uint8_t rsvd;
+        uint16_t opcode;
+        uint16_t returncode;
+        uint16_t vendor_ext_status;
+    } QEMU_PACKED *bg_op_status;
+    QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
+
+    bg_op_status = (void *)payload_out;
+    memset(bg_op_status, 0, sizeof(*bg_op_status));
+    bg_op_status->status = cci->bg.complete_pct << 1;
+    if (cci->bg.runtime > 0) {
+        bg_op_status->status |= 1U << 0;
+    }
+    bg_op_status->opcode = cci->bg.opcode;
+    bg_op_status->returncode = cci->bg.ret_code;
+    *len_out = sizeof(*bg_op_status);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -1111,6 +1142,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
 
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
+        cmd_infostat_bg_op_sts, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 0,
                          IMMEDIATE_POLICY_CHANGE },
-- 
2.39.2

