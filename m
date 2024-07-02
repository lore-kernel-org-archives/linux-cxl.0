Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B081E50F
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930937; cv=none; b=b4EheJl0+awXdijLIxqjNS9OBNQcMgXtXEQRJ+A17uPJEYIc4fKJy2QU4qFJrkVGdxMfjpLFakO8ldcv7kpe8Q5MysO6EQ0HzI4bCokrTLAcZIvkjMQuFu6ZPalYu/hP1lrk00bdNYWZ5mpHxlKr2fanlGbjrAxCdeNTinWBsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930937; c=relaxed/simple;
	bh=O3S9nsjPtoAcZUEfHwcOazmRVJ4HDKZcFz0TOrRzxn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dssncLhqZOd116yGZrkP4ojSOyCtv2nYRa/Y5ItDpOsMo5ciJHeyS3TBublRZPOkUL7FbfIAG9rWqTgXFyt93AsGoWq+ogv8BEHXk+BAf1rkOPbzwx7t77mSqxSfj3ShS3JEg9PqTjYd4BmHHWD3LTZW+KHY0LRofe810kaPzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD56850lFz6JBYT;
	Tue,  2 Jul 2024 22:34:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 95B04140684;
	Tue,  2 Jul 2024 22:35:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 15:35:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, Li Zhijian
	<lizhijian@fujitsu.com>
CC: <linuxarm@huawei.com>
Subject: [PATCH 2/3] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output payload space zeroing
Date: Tue, 2 Jul 2024 15:34:24 +0100
Message-ID: <20240702143425.717452-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
References: <20240702143425.717452-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Fan Ni <fan.ni@samsung.com>

The whole mailbox output payload space is already zeroed after copying
out the input payload, which happens before processing the specific mailbox
command:
https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204

Signed-off-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/20240221221824.1092966-1-nifan.cxl@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 74eeb6fde7..facec42dc8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -235,7 +235,6 @@ static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
     log_type = payload_in[0];
 
     pl = (CXLGetEventPayload *)payload_out;
-    memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
                 CXL_EVENT_RECORD_SIZE;
@@ -273,7 +272,6 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
     CXLEventLog *log;
 
     policy = (CXLEventInterruptPolicy *)payload_out;
-    memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     if (log->irq_enabled) {
@@ -372,7 +370,6 @@ static CXLRetCode cmd_infostat_identify(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*is_identify) != 18);
 
     is_identify = (void *)payload_out;
-    memset(is_identify, 0, sizeof(*is_identify));
     is_identify->pcie_vid = class->vendor_id;
     is_identify->pcie_did = class->device_id;
     if (object_dynamic_cast(OBJECT(cci->d), TYPE_CXL_USP)) {
@@ -606,7 +603,6 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     QEMU_BUILD_BUG_ON(sizeof(*bg_op_status) != 8);
 
     bg_op_status = (void *)payload_out;
-    memset(bg_op_status, 0, sizeof(*bg_op_status));
     bg_op_status->status = cci->bg.complete_pct << 1;
     if (cci->bg.runtime > 0) {
         bg_op_status->status |= 1U << 0;
@@ -647,7 +643,6 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     }
 
     fw_info = (void *)payload_out;
-    memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
     fw_info->slot_info = BIT(0) | BIT(3);
@@ -805,7 +800,6 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
     }
 
     id = (void *)payload_out;
-    memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
 
@@ -1095,7 +1089,6 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
     out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
     assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 
-    memset(out, 0, out_pl_len);
     QLIST_FOREACH(ent, poison_list, node) {
         uint64_t start, stop;
 
-- 
2.43.0

