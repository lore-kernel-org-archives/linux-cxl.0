Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A921CA0C
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346208; cv=none; b=s3Yk4R1fSWJjuOyuz1/uhcIU8OG7a9Kw8VHeCZ50/urQctFT/q9I8zhVFi2omupAdvIEspl4OKyRdaffNYs5eOjPm5ZelfduOSzo2l9h49IvqjgOG02F3ko4Law9+0CjnF237uSPhErYFyT8Zc0CHDb2vfaeuBWEkNSrk/iCaRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346208; c=relaxed/simple;
	bh=EsQOXl9G269JzwxwB6tJ+r8t9pTzYFsPWkd/Qv47rE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLZNUECe209XALhKbx9/QHof2R4sgMp7FtRipZvCA8je7iSNTL6SkKzDgGEBId4b3ZPJJozzrnFOwM/QzUMg4ydrqpbWEiRkxl+EWYJlBcnEdk8G9ZY5g2mpEF0JgSJJCQyG+4pkd5ZasC6aoOsffSh8pu6svKRqzCbyuetDNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNPGT06ykz6L5ZT;
	Thu, 19 Jun 2025 23:12:01 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A32B3140275;
	Thu, 19 Jun 2025 23:16:44 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.81) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 17:16:44 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 5/7] hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature attributes in cmd_features_set_feature()
Date: Thu, 19 Jun 2025 16:16:17 +0100
Message-ID: <20250619151619.1695-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250619151619.1695-1-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Move the declaration of scrub and ECS feature attributes in cmd_features_set_feature()
to the local scope where they are used.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4d0c0b3edc..83668d7d93 100644
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
@@ -1508,8 +1504,9 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ps_set_feature = (void *)payload_in;
-        ps_write_attrs = &ps_set_feature->feat_data;
+        CXLMemPatrolScrubSetFeature *ps_set_feature = (void *)payload_in;
+        CXLMemPatrolScrubWriteAttrs *ps_write_attrs =
+                                &ps_set_feature->feat_data;
 
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->patrol_scrub_wr_attrs)) {
@@ -1535,8 +1532,8 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
-        ecs_set_feature = (void *)payload_in;
-        ecs_write_attrs = ecs_set_feature->feat_data;
+        CXLMemECSSetFeature *ecs_set_feature = (void *)payload_in;
+        CXLMemECSWriteAttrs *ecs_write_attrs = ecs_set_feature->feat_data;
 
         if ((uint32_t)hdr->offset + bytes_to_copy >
             sizeof(ct3d->ecs_wr_attrs)) {
-- 
2.43.0

