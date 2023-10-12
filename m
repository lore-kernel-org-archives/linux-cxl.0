Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B0B2AB35
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22834C4
	for <linux-cxl@vger.kernel.org>; Thu, 12 Oct 2023 07:05:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5rvq1jgSz6K60K;
	Thu, 12 Oct 2023 22:03:35 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 15:05:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
	<mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
CC: <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/4] hw/cxl: Use a switch to explicitly check size in caps_reg_read()
Date: Thu, 12 Oct 2023 15:05:11 +0100
Message-ID: <20231012140514.3697-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Bring this read function inline with the others that do
check for unexpected size values.

Also reduces line lengths to sub 80 chars.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-device-utils.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index bd68328032..eb7195272e 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -32,10 +32,13 @@ static uint64_t caps_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
     CXLDeviceState *cxl_dstate = opaque;
 
-    if (size == 4) {
-        return cxl_dstate->caps_reg_state32[offset / sizeof(*cxl_dstate->caps_reg_state32)];
-    } else {
-        return cxl_dstate->caps_reg_state64[offset / sizeof(*cxl_dstate->caps_reg_state64)];
+    switch (size) {
+    case 4:
+        return cxl_dstate->caps_reg_state32[offset / size];
+    case 8:
+        return cxl_dstate->caps_reg_state64[offset / size];
+    default:
+        g_assert_not_reached();
     }
 }
 
-- 
2.39.2

