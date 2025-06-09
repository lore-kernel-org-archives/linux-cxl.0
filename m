Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527A7212B3A
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486851; cv=none; b=o0MZWSHI+kUSLMjdkxwA9h6/r2oalREqKXgD2sbkaCSOqJuOYqsJo4n1qoTKHkfDWk00FG8vvMcJ8VUR7aMglO2wDYu0powMcDrdRnGRLz5nIBTuntoZLxIVBOhiqBv942dMmH9eZtWu1FtSk23m3DOr/I6VHFMYe+oGJUJvtGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486851; c=relaxed/simple;
	bh=DbZBfPiPAo9kYo00SpM+TSczSnQEcJPZ0fUBBgo6PPE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AunByUPVRSZJr308v6sMpYw1JbTvmv/R6w0J/ztHCXoUPkd29zCGtSXrg1yZbwX2uPs8jB+HJMBjxw30ZxsZPUIgWMN6nI2iEYuE1CgxX1e3MGCO8ZN4vrjbTZRWZBOd8WVP4AOruHMglcaJyF6NFqSt1alKLJCzfGm2qPx+lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGHYP30K0z6M52w;
	Tue, 10 Jun 2025 00:33:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F0FC91404C5;
	Tue, 10 Jun 2025 00:34:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Jun 2025 18:34:06 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Klaus Jensen <k.jensen@samsung.com>, <cminyard@mvista.com>, Fan Ni
	<fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
	<qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
	<philmd@linaro.org>
Subject: [RFC PATCH qemu 1/5] hw/i2c: add smbus pec utility function
Date: Mon, 9 Jun 2025 17:33:29 +0100
Message-ID: <20250609163334.922346-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
References: <20250609163334.922346-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Klaus Jensen <k.jensen@samsung.com>

Add i2c_smbus_pec() to calculate the SMBus Packet Error Code for a
message.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Link: https://lore.kernel.org/r/20230914-nmi-i2c-v6-1-11bbb4f74d18@samsung.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/i2c/smbus_master.h |  2 ++
 hw/i2c/smbus_master.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.h
index bb13bc423c..d90f81767d 100644
--- a/include/hw/i2c/smbus_master.h
+++ b/include/hw/i2c/smbus_master.h
@@ -27,6 +27,8 @@
 
 #include "hw/i2c/i2c.h"
 
+uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len);
+
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
 int smbus_receive_byte(I2CBus *bus, uint8_t addr);
diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
index 6a53c34e70..01a8e47002 100644
--- a/hw/i2c/smbus_master.c
+++ b/hw/i2c/smbus_master.c
@@ -15,6 +15,32 @@
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/smbus_master.h"
 
+static uint8_t crc8(uint16_t data)
+{
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        if (data & 0x8000) {
+            data ^= 0x1070U << 3;
+        }
+
+        data <<= 1;
+    }
+
+    return (uint8_t)(data >> 8);
+}
+
+uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len)
+{
+    int i;
+
+    for (i = 0; i < len; i++) {
+        crc = crc8((crc ^ buf[i]) << 8);
+    }
+
+    return crc;
+}
+
 /* Master device commands.  */
 int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
 {
-- 
2.48.1

