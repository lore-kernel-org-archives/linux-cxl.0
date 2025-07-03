Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA942DE701
	for <linux-cxl@vger.kernel.org>; Thu,  3 Jul 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534235; cv=none; b=jlvpk3Cs47Qg/SoIb6fWsVDXE2Ep7OqetKrNBoJrZ/nUEQj0yrusGH/WeoFODo+YPH3Dl4IHFGMt9LAY3eyaXNXkZ220cAVk/pKjFDlKHPIXBsnuabNgZJxaxyx+I0uIG0TekJHsoKZ2NSp7rQ2Cm6nRWU12s6349G0g4zs1Ypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534235; c=relaxed/simple;
	bh=jiYZeSiBzbRi0zvyBm6pkNokkq5NOOEK9EllPVEZJ50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfaiYNGVElQewFBT5WXFZQthZVRSposqJKHlem/pk6rtsO3Lby8PphhThap5g/tnWXhCgxQP2rc3SgrQI+cb9dO9q1vQbdoEq6Lu7zd+CyE+kKu+vk0BiyoAozraf7Q27Tx2hEIgzr9piihqHG72KLrKfeqOZj8gNoyM9p+sZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXrjW0rm5z6M561;
	Thu,  3 Jul 2025 17:16:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 0220E1402F5;
	Thu,  3 Jul 2025 17:17:12 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.244.176) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 11:17:11 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <fan.ni@samsung.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 5/7] hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature attributes in cmd_features_set_feature()
Date: Thu, 3 Jul 2025 10:16:54 +0100
Message-ID: <20250703091657.1868-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250703091657.1868-1-shiju.jose@huawei.com>
References: <20250703091657.1868-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Move the declaration of scrub and ECS feature attributes in
cmd_features_set_feature() to the local scope where they are used.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4f996365b3..0a2d2fcedf 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1459,10 +1459,6 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            CXLCCI *cci)
 {
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
-    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
-    CXLMemPatrolScrubSetFeature *ps_set_feature;
-    CXLMemECSWriteAttrs *ecs_write_attrs;
-    CXLMemECSSetFeature *ecs_set_feature;
     CXLSetFeatureInfo *set_feat_info;
     uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
@@ -1504,13 +1500,14 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     }
 
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        CXLMemPatrolScrubSetFeature *ps_set_feature = (void *)payload_in;
+        CXLMemPatrolScrubWriteAttrs *ps_write_attrs =
+                                &ps_set_feature->feat_data;
+
         if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ps_set_feature = (void *)payload_in;
-        ps_write_attrs = &ps_set_feature->feat_data;
-
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->patrol_scrub_wr_attrs)) {
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -1531,13 +1528,13 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         }
     } else if (qemu_uuid_is_equal(&hdr->uuid,
                                   &ecs_uuid)) {
+        CXLMemECSSetFeature *ecs_set_feature = (void *)payload_in;
+        CXLMemECSWriteAttrs *ecs_write_attrs = ecs_set_feature->feat_data;
+
         if (hdr->version != CXL_ECS_SET_FEATURE_VERSION) {
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ecs_set_feature = (void *)payload_in;
-        ecs_write_attrs = ecs_set_feature->feat_data;
-
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->ecs_wr_attrs)) {
             return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-- 
2.43.0

