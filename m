Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C1AC61D9D
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 05:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjAZFhe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjAZFhd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 00:37:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640193E60B
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 21:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674711452; x=1706247452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TmttUS7xwD55ClAuoEUKjKv5YzYGUkVO9chKYEHMpSM=;
  b=IK4aUwUGcUppelgleGIgFYFXx41McT+uB4UDix7dCN1gIfRc6CzOR1eM
   RFR4yjqU63pTRfDizGvVgaRKWQhL6UeAkrSNolJM5uX94hAVrYhTeglEQ
   SVT+HGaZe9zQCXot2zR7WMR/xXIaNAGx3pa/1yHyAWTwgD7f236gCOJ3w
   wHGHBAfBIY9T0I0KsQ/yw3xMhHSg1BIqx++I/f/XDdbZe6qW/WuiE+gZh
   YPzutBLJU+QEkuD1Vn7YAga6JB67s1Cxht4NWWhzYBg17ItLIVjyitJai
   CS71N01eriK23sVx2KLE+mjZ5G9w7Fnux7xzQx0HfSSYvp+ZaH9rFBBrz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="310328973"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="310328973"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:37:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="786704012"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="786704012"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.115.122])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:37:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 25 Jan 2023 21:37:28 -0800
Subject: [PATCH 2/2] hw/cxl: Remove check for g_new0() failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-ira-cxl-events-fixups-2023-01-11-v1-2-1931378515f5@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674711449; l=923;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=TmttUS7xwD55ClAuoEUKjKv5YzYGUkVO9chKYEHMpSM=;
 b=SjGQo8fu61yc0Hc9DTQNnWEmFHvaMA+6yZUN5MNbr+XC/5Y4Y9tYlIYgSAF92Whod51le4rB/Lcu
 QWYpyEVjCThrmtlIlECwrqzdZobehQV/tJuhyHNkq75KK8DlcxkY
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

g_new0() will terminate the application if it fails.  Remove the check.

Fixes: fb64c5661d5f ("hw/cxl/events: Wire up get/clear event mailbox commands")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-events.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index 2536aafc55fb..4cbc838e8ff4 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -124,13 +124,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds,
     }
 
     entry = g_new0(CXLEvent, 1);
-    if (!entry) {
-        error_report("Failed to allocate memory for event log entry");
-        return false;
-    }
-
     memcpy(&entry->data, event, sizeof(*event));
-
     entry->data.hdr.handle = cpu_to_le16(log->next_handle);
     log->next_handle++;
     /* 0 handle is never valid */

-- 
2.39.1
