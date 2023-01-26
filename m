Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A2C54E94
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 05:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjAZFhd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjAZFhc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 00:37:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7A851C7B
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 21:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674711451; x=1706247451;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wbtXIUSQfh3quDpVU0waBxAZRw2Bard66Q1jLzQ6/v4=;
  b=BD8R+xnVfWQazYMhefT/Xnkkdyo2CZtS+ul7UCaMr2Iccl4mvunhiTsH
   fmIqDKF3sP4LrNIXAw8EmunqnT7K2GHXDAip9OT71AZiQsxJ06t2hK9T5
   Ky73Zd0uBf5Ct4+uPSAhURu4PSpzR5ZcDP3SzaoenlIHwD46X9k4U4xlH
   hxPHHeJPVl1OVCs+3HJO7scy8vMf1HGAQLkSNqRRSz9BZ3oGmgSsNIPJe
   Wkc+lewShvUIUdOJiS7sF1gE6zZ3vXlG57j8qZ+cJ1aW6I60YAVyhgdVw
   HQsKs5nygjy9EituR2PIRRQv7EPhc3YAZteprmICXYgEtDdXXRGI7jDjJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310328966"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="310328966"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:37:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786704008"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="786704008"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.115.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:37:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 25 Jan 2023 21:37:27 -0800
Subject: [PATCH 1/2] hw/cxl: Fix event log time stamp fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-ira-cxl-events-fixups-2023-01-11-v1-1-1931378515f5@intel.com>
References: <20230125-ira-cxl-events-fixups-2023-01-11-v1-0-1931378515f5@intel.com>
In-Reply-To: <20230125-ira-cxl-events-fixups-2023-01-11-v1-0-1931378515f5@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674711449; l=4001;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=wbtXIUSQfh3quDpVU0waBxAZRw2Bard66Q1jLzQ6/v4=;
 b=JpcOxvvrvGTjf1ozWyWNB8NAoCkavbUxwTNnrwrTW2etv+OTwmsLyC1AIdK3RSrHAyhHDeJi2uX2
 W+v3cP5pDMx3sWgkF4r1iPVz2StVtOHh+YNn+81GTRBQVWZkiR4f
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 3.0 8.2.9.4.2 Set Timestamp and 8.2.9.4.1 Get Timestamp define the
way for software to set and get the time stamp of a device.  Events
should use a time stamp consistent with the Get Timestamp mailbox
command.

In addition avoid setting the time stamp twice.

Fixes: fb64c5661d5f ("hw/cxl/events: Wire up get/clear event mailbox commands")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-device-utils.c   | 15 +++++++++++++++
 hw/cxl/cxl-events.c         |  4 +++-
 hw/cxl/cxl-mailbox-utils.c  | 11 +----------
 hw/mem/cxl_type3.c          |  1 -
 include/hw/cxl/cxl_device.h |  2 ++
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 7f29d40be04a..5876a3703e85 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -325,3 +325,18 @@ void cxl_device_register_init_swcci(CXLDeviceState *cxl_dstate)
 
     cxl_initialize_mailbox(cxl_dstate, true);
 }
+
+uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
+{
+    uint64_t time, delta;
+    uint64_t final_time = 0;
+
+    if (cxl_dstate->timestamp.set) {
+        /* First find the delta from the last time the host set the time. */
+        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        delta = time - cxl_dstate->timestamp.last_set;
+        final_time = cxl_dstate->timestamp.host_set + delta;
+    }
+
+    return final_time;
+}
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 08fd52b66188..2536aafc55fb 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -100,7 +100,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds,
                       enum cxl_event_log_type log_type,
                       struct cxl_event_record_raw *event)
 {
-    uint64_t time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    uint64_t time;
     struct cxl_event_log *log;
     CXLEvent *entry;
 
@@ -108,6 +108,8 @@ bool cxl_event_insert(CXLDeviceState *cxlds,
         return false;
     }
 
+    time = cxl_device_get_timestamp(cxlds);
+
     log = &cxlds->event_logs[log_type];
 
     QEMU_LOCK_GUARD(&log->lock);
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 75703023434b..0e64873c2395 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -394,17 +394,8 @@ static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
                                     CXLDeviceState *cxl_dstate,
                                     uint16_t *len)
 {
-    uint64_t time, delta;
-    uint64_t final_time = 0;
-
-    if (cxl_dstate->timestamp.set) {
-        /* First find the delta from the last time the host set the time. */
-        time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        delta = time - cxl_dstate->timestamp.last_set;
-        final_time = cxl_dstate->timestamp.host_set + delta;
-    }
+    uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    /* Then adjust the actual time */
     stq_le_p(cmd->payload, final_time);
     *len = 8;
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a7b587780af2..42e291dd9f76 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1291,7 +1291,6 @@ static void cxl_assign_event_header(struct cxl_event_record_hdr *hdr,
     hdr->flags[0] = flags;
     hdr->length = length;
     memcpy(&hdr->id, uuid, sizeof(hdr->id));
-    hdr->timestamp = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 }
 
 static const QemuUUID gen_media_uuid = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cbb37c541c44..31579af342f1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -426,4 +426,6 @@ CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
 
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
+uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
+
 #endif

-- 
2.39.1
