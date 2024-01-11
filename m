Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95F15EBE
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jan 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T9nml3B1Dz6J6C1;
	Thu, 11 Jan 2024 22:56:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DB8EA140CB9;
	Thu, 11 Jan 2024 22:59:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 14:59:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, Fan Ni
	<fan.ni@samsung.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH v2 qemu] hw/cxl/device: read from register values in mdev_reg_read()
Date: Thu, 11 Jan 2024 14:59:05 +0000
Message-ID: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

In the current mdev_reg_read() implementation, it consistently returns
that the Media Status is Ready (01b). This was fine until commit
25a52959f99d ("hw/cxl: Add support for device sanitation") because the
media was presumed to be ready.

However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
during sanitation, the Media State should be set to Disabled (11b). The
mentioned commit correctly sets it to Disabled, but mdev_reg_read()
still returns Media Status as Ready.

To address this, update mdev_reg_read() to read register values instead
of returning dummy values.

Note __toggle_media() was overwriting the mailbox capability
register, but nothing was reading that after this so that bug had no
obvious effect unless the driver was reloaded.

Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/r/20231222090051.3265307-3-42.hyeyoo@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--

Hyeonggon - I've kept your sign-off. Let me know if this is ok.
Dropped RBs etc as this has changed quite a bit.

I plan to send out a group of fixes including this soon, but given
I've been pointing out the original fix didn't work thought I'd send
this one out for early review!

---
 include/hw/cxl/cxl_device.h |  9 +++++++--
 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index befb5f884b..31d2afcd3d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -202,6 +202,9 @@ typedef struct cxl_device_state {
         };
     };
 
+    /* Stash the memory device status value */
+    uint64_t memdev_status;
+
     struct {
         bool set;
         uint64_t last_set;
@@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
     uint64_t dev_status_reg;
 
-    dev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
-    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
+    dev_status_reg = cxl_dstate->memdev_status;
+    dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
+                                val);
+    cxl_dstate->memdev_status = dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \
         do { __toggle_media((cxlds), 0x3); } while (0)
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 61a3c4dc2e..40b619ffd9 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval = 0;
-
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval = FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate = opaque;
 
-    return retval;
+    return cxl_dstate->memdev_status;
 }
 
 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n = msi_n;
 }
 
-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
+{
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg = FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg = FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
+                                   MBOX_READY, 1);
+    cxl_dstate->memdev_status = memdev_status_reg;
+}
 
 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
-- 
2.39.2

