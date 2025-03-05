Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF72045AC
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166830; cv=none; b=ZWYQ78Rrk65Kyghoz6VerqpD6lZOinQJ0TAcTUTgjgHsoYGsqOtcPPO6K19vqjH6I08SS9oZTfB2jyBqCJvZyeAEQrAF3mD7xMlavRpFMT+z+wUYAJBra06meZc3zV0p8J6Hazf1LDfohAyb7N9ZgKzrNJwSugsvBOAvFk4uJqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166830; c=relaxed/simple;
	bh=dkWixyRopmOvykd6DOM+L+KzFlRM7QamxfXcAAElanQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti/zJOiFBxDOH9s6Ey86bYmr3HnH9e45GOC0lQkH66LR1QpjQS+k0sVH8uOMXuGJg6FroeM85zPFaQ23hqIQLeMoGjKX/hkj+E/1uzLa5DhhjonSOpN2GLTF7IWNDgG9OP/LnyZBCGxNmTjw9pSS9Y42MxnxgmVR4B8YceVUcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z76Zq3z6kz6K9Sf;
	Wed,  5 Mar 2025 17:24:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7DC9E140A08;
	Wed,  5 Mar 2025 17:27:06 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 5 Mar 2025 10:27:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <linuxarm@huawei.com>, <fan.ni@samsung.com>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>, Arpit Kumar <arpit1.kumar@samsung.com>,
	Sweta Kumari <s5.kumari@samsung.com>, Vinayak Holikatti
	<vinayak.kh@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi
	<ajay.opensrc@micron.com>
Subject: [PATCH qemu 4/8] hw/cxl: factor out calculation of sanitize duration from cmd_santize_overwrite
Date: Wed, 5 Mar 2025 09:24:55 +0000
Message-ID: <20250305092501.191929-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Vinayak Holikatti <vinayak.kh@samsung.com>

Move the code of calculation of sanitize duration into function
for usability by other sanitize routines

Estimate times based on:
             https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 61 ++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 79b35d1405..9f9d475678 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1640,34 +1640,10 @@ static void __do_sanitization(CXLType3Dev *ct3d)
     cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
-/*
- * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
- *
- * Once the Sanitize command has started successfully, the device shall be
- * placed in the media disabled state. If the command fails or is interrupted
- * by a reset or power failure, it shall remain in the media disabled state
- * until a successful Sanitize command has been completed. During this state:
- *
- * 1. Memory writes to the device will have no effect, and all memory reads
- * will return random values (no user data returned, even for locations that
- * the failed Sanitize operation didn’t sanitize yet).
- *
- * 2. Mailbox commands shall still be processed in the disabled state, except
- * that commands that access Sanitized areas shall fail with the Media Disabled
- * error code.
- */
-static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
-                                         uint8_t *payload_in,
-                                         size_t len_in,
-                                         uint8_t *payload_out,
-                                         size_t *len_out,
-                                         CXLCCI *cci)
+static int get_sanitize_duration(uint64_t total_mem)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
-    uint64_t total_mem; /* in Mb */
-    int secs;
+    int secs = 0;
 
-    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
     if (total_mem <= 512) {
         secs = 4;
     } else if (total_mem <= 1024) {
@@ -1696,6 +1672,39 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
         secs = 240 * 60; /* max 4 hrs */
     }
 
+    return secs;
+}
+
+/*
+ * CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h)
+ *
+ * Once the Sanitize command has started successfully, the device shall be
+ * placed in the media disabled state. If the command fails or is interrupted
+ * by a reset or power failure, it shall remain in the media disabled state
+ * until a successful Sanitize command has been completed. During this state:
+ *
+ * 1. Memory writes to the device will have no effect, and all memory reads
+ * will return random values (no user data returned, even for locations that
+ * the failed Sanitize operation didn’t sanitize yet).
+ *
+ * 2. Mailbox commands shall still be processed in the disabled state, except
+ * that commands that access Sanitized areas shall fail with the Media Disabled
+ * error code.
+ */
+static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
+                                         uint8_t *payload_in,
+                                         size_t len_in,
+                                         uint8_t *payload_out,
+                                         size_t *len_out,
+                                         CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    uint64_t total_mem; /* in Mb */
+    int secs;
+
+    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
+    secs = get_sanitize_duration(total_mem);
+
     /* EBUSY other bg cmds as of now */
     cci->bg.runtime = secs * 1000UL;
     *len_out = 0;
-- 
2.43.0

