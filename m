Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C277F18
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100217; cv=none; b=NpPIgxNKuYxmFV1Oj375QlKrEsI2kFkamJEZHGNICc1LHexUsGzOfIrcqPSMt8pCi6/5mcq4PmUZzb0PksgFgN2s0AbmuBbhWAIEPX6ULxqw79NN250RwtHrbyce/AVVQt62YMgGi8TSIO/eJirgtLwRf453eyiQURl/TFExELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100217; c=relaxed/simple;
	bh=GNiM/LYODQ8+rampErO2w5KqstAejFS3XBfPunzY93I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd4jioGYZqICbatRgdnxXrOATzTA/dDJy5KmcqXrM3Y6neDEwlvItEjwkYXmdJGUWIeGD1XdpVz7zQXig4JC8PR3c3ZYJSYmUIqLalIS2q5XBQBuNyIhFH39PrzcQldlqCqJTeGPpJitHfwKMUywZV3vDSarGn3qLYedwsKYAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKk8V4jS0z6K6Cq;
	Wed, 24 Jan 2024 20:40:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C4923140D26;
	Wed, 24 Jan 2024 20:43:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:43:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>, Huai-Cheng Kuo
	<hchkuo@avery-design.com.tw>, Dave Jiang <dave.jiang@intel.com>, Peter
 Maydell <peter.maydell@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
	Stefan Hajnoczi <stefanha@gmail.com>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/12] hw/cxl/mbox: Remove dead code
Date: Wed, 24 Jan 2024 12:40:53 +0000
Message-ID: <20240124124100.8218-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Davidlohr Bueso <dave@stgolabs.net>

Two functions were reported to have dead code, remove the bogus
branches altogether, as well as a misplaced qemu_log call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6eff56fb1b..dc42850767 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
 
     cxl_dev_disable_media(&ct3d->cxl_dstate);
 
-    if (secs > 2) {
-        /* sanitize when done */
-        return CXL_MBOX_BG_STARTED;
-    } else {
-        __do_sanitization(ct3d);
-        cxl_dev_enable_media(&ct3d->cxl_dstate);
-
-        return CXL_MBOX_SUCCESS;
-    }
+    /* sanitize when done */
+    return CXL_MBOX_BG_STARTED;
 }
 
 static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
@@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
 
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
-        if (ret == CXL_MBOX_SUCCESS) {
-            switch (cci->bg.opcode) {
-            case 0x4400: /* sanitize */
-            {
-                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-
-                __do_sanitization(ct3d);
-                cxl_dev_enable_media(&ct3d->cxl_dstate);
-            }
+        switch (cci->bg.opcode) {
+        case 0x4400: /* sanitize */
+        {
+            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+            __do_sanitization(ct3d);
+            cxl_dev_enable_media(&ct3d->cxl_dstate);
+        }
+        break;
+        case 0x4304: /* TODO: scan media */
+            break;
+        default:
+            __builtin_unreachable();
             break;
-            case 0x4304: /* TODO: scan media */
-                break;
-            default:
-                __builtin_unreachable();
-                break;
-            }
         }
-
-        qemu_log("Background command %04xh finished: %s\n",
-                 cci->bg.opcode,
-                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
     } else {
         /* estimate only */
         cci->bg.complete_pct = 100 * now / total_time;
-- 
2.39.2

