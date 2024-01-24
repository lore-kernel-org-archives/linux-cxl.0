Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B177F22
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104220; cv=none; b=B+ZoZn3nyzRRLrejbxmpnqjQ2xfuAIbWtZGV3Ar1HTwj44vjmQNHAkF7v6XtGXrwYUAguAwWiJz5j392rWj2/t6JDrspm5MFWI/aewN4KyV8GaHtrphl0Ne7Ly/jHD7Gje2AdMuAE59CXmefyYZb016r+T50RoRzS7jVdsjoxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104220; c=relaxed/simple;
	bh=ryxJGvBsJLU17jaAukXzvLxus4TGMHCEzbwyxLZEytM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hw9EMO56ckRasaDxRORLZp8sCr2mFzilNbfo1uyrtZ6xf8WmvDGQItUQah0aQ/obRgRxoqYepzidDLZn+3rZTMvkBGC3M/Ok5ZP5uMA2IyN1D5X8K6W/y4izNxnDICpPT8CwFYNG0j79AwXI4C4TAXDfxUfDnNB5AROzKlAtqB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKld22xcnz6K92X;
	Wed, 24 Jan 2024 21:47:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E183140390;
	Wed, 24 Jan 2024 21:50:15 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 13:50:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Fan Ni
	<fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/cxl: Update mailbox status registers.
Date: Wed, 24 Jan 2024 13:48:13 +0000
Message-ID: <20240124134814.8717-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Whilst the reported version was 1 so there should be no changes,
a couple of fields (where the value 0 was valid) were not
defined. Make those explicit and update references to be based
on CXL r3.1.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 17 ++++++++++-------
 hw/cxl/cxl-device-utils.c   |  6 +++++-
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 31d2afcd3d..9f51c586d7 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -189,7 +189,7 @@ typedef struct cxl_device_state {
         };
     };
 
-    /* mmio for the mailbox registers 8.2.8.4 */
+    /* CXL r3.1 Section 8.2.8.4: Mailbox Registers */
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
@@ -310,39 +310,42 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
 REG64(CXL_DEV_EVENT_STATUS, 0)
     FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
 
-/* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
+#define CXL_DEV_MAILBOX_VERSION 1
+/* CXL r3.1 Section 8.2.8.4.3: Mailbox Capabilities Register */
 REG32(CXL_DEV_MAILBOX_CAP, 0)
     FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
     FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
     FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
     FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
+    FIELD(CXL_DEV_MAILBOX_CAP, MBOX_READY_TIME, 11, 8)
+    FIELD(CXL_DEV_MAILBOX_CAP, TYPE, 19, 4)
 
-/* CXL 2.0 8.2.8.4.4 Mailbox Control Register */
+/* CXL r3.1 Section 8.2.8.4.4: Mailbox Control Register */
 REG32(CXL_DEV_MAILBOX_CTRL, 4)
     FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
     FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
     FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
 
-/* CXL 2.0 8.2.8.4.5 Command Register */
+/* CXL r3.1 Section 8.2.8.4.5: Command Register */
 REG64(CXL_DEV_MAILBOX_CMD, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
     FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
 
-/* CXL 2.0 8.2.8.4.6 Mailbox Status Register */
+/* CXL r3.1 Section 8.2.8.4.6: Mailbox Status Register */
 REG64(CXL_DEV_MAILBOX_STS, 0x10)
     FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
     FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
     FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
 
-/* CXL 2.0 8.2.8.4.7 Background Command Status Register */
+/* CXL r3.1 Section 8.2.8.4.7: Background Command Status Register */
 REG64(CXL_DEV_BG_CMD_STS, 0x18)
     FIELD(CXL_DEV_BG_CMD_STS, OP, 0, 16)
     FIELD(CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP, 16, 7)
     FIELD(CXL_DEV_BG_CMD_STS, RET_CODE, 32, 16)
     FIELD(CXL_DEV_BG_CMD_STS, VENDOR_RET_CODE, 48, 16)
 
-/* CXL 2.0 8.2.8.4.8 Command Payload Registers */
+/* CXL r3.1 Section 8.2.8.4.8: Command Payload Registers */
 REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
 
 REG64(CXL_MEM_DEV_STS, 0)
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 40b619ffd9..9df8738f86 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -366,6 +366,10 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      MSI_N, msi_n);
     cxl_dstate->mbox_msi_n = msi_n;
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MBOX_READY_TIME, 0); /* Not reported */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     TYPE, 0); /* Inferred from class code */
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
@@ -392,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
     cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
     device_reg_init_common(cxl_dstate);
 
-    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
+    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
     mailbox_reg_init_common(cxl_dstate);
 
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
-- 
2.39.2

