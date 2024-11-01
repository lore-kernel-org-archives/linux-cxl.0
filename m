Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364619AD5C
	for <linux-cxl@vger.kernel.org>; Fri,  1 Nov 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468550; cv=none; b=SomeRSNwR5b6RLLcohPF5o26TFuRJ+bwu9YwWICWzOOy9XBkABAiV3Q51tm9cU7RPtRbJRq+KQVoKNfknwtQIaFmMD0RE9ea9pHBR57J9Rp+vnGrItcKpt1tdH480Se2+PZ2gXzVz7WHPpdfQQyOoslvWkUxekopOyHUrN1zSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468550; c=relaxed/simple;
	bh=S/RnwaZL+PvGHIUT6xkVkzEqDmzMNU72MnSgyVfJD0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piPomEuClL7VMyRWSRiSyBe/KLtsPJdJDfTIWloLbIgO5YO7mnCHQm3tfpFU5I/chYqKnTI4rYqbtdjyd3mKwkQPlwOwErX5ZET2uN3D5VJeVz1naDBcUw4hvYLPUmXLzd8z+LMZvoxcLi2KC8tLSIuh/9kI8Ogw7/K723RqM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xg26K0qkxz6K6jx;
	Fri,  1 Nov 2024 21:39:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A67E1140C72;
	Fri,  1 Nov 2024 21:42:24 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 14:42:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>
CC: Fan Ni <fan.ni@samsung.com>, <linuxarm@huawei.com>
Subject: [PATCH qemu 06/10] hw/cxl: Avoid accesses beyond the end of cel_log.
Date: Fri, 1 Nov 2024 13:39:13 +0000
Message-ID: <20241101133917.27634-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
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

Add a check that the requested offset + length does not go beyond the end
of the cel_log.

Whilst the cci->cel_log is large enough to include all possible CEL
entries, the guest might still ask for entries beyond the end of it.
Move the comment to this new check rather than before the check on the
type of log requested.

Reported-by: Esifiel <esifiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2aa7ffed84..5e571955b6 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -937,24 +937,28 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
 
     get_log = (void *)payload_in;
 
+    if (get_log->length > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
     /*
      * CXL r3.1 Section 8.2.9.5.2: Get Log (Opcode 0401h)
      *   The device shall return Invalid Input if the Offset or Length
      *   fields attempt to access beyond the size of the log as reported by Get
-     *   Supported Logs.
+     *   Supported Log.
      *
-     * The CEL buffer is large enough to fit all commands in the emulation, so
-     * the only possible failure would be if the mailbox itself isn't big
-     * enough.
+     * Only valid for there to be one entry per opcode, but the length + offset
+     * may still be greater than that if the inputs are not valid and so access
+     * beyond the end of cci->cel_log.
      */
-    if (get_log->length > cci->payload_max) {
+    if ((uint64_t)get_log->offset + get_log->length >= sizeof(cci->cel_log)) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
-        return CXL_MBOX_INVALID_LOG;
-    }
-
     /* Store off everything to local variables so we can wipe out the payload */
     *len_out = get_log->length;
 
-- 
2.43.0

