Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C6BC77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 02:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjDZCqM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 22:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239047AbjDZCqK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 22:46:10 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6AD189
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 19:46:08 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0DE6264201F;
        Wed, 26 Apr 2023 02:46:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7014364203A;
        Wed, 26 Apr 2023 02:46:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682477167; a=rsa-sha256;
        cv=none;
        b=e5mNtXPZ+0aLOIulmKUYrntmo6ZZlcm9bRi9aZosI61/Fs3mRJgPMdHxTy7aQGFjzgW9y4
        G+rq9Rcd0rKIgdrtv/URaV5jYB10fG2aYBXcHROoNGW/PV6VT6nuuL2TNvZgZFrZ7yHmgo
        rnTeHvOkTjUHCC2WdSxdE2kBL2Xarih/tiLA9KNEPUhWcsidXsCMiLVe8WIxoBikTsijKH
        M4KP2tGx4TQmrT18qqJ/MHIgBPppNrJL5PTcDWMqzWQGHqFLwN2pNmtf2KUarYYflZwKmK
        yqoaq9veMrqoCJMmcgubo5sNlRlXCuCQD8f5Th3ItF7Uf+FwBr0/KQ6HaZEnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682477167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cDlBBkIQrKGmh/G7kK0lYtW2tyvUghmmcSfwFxPE5Lc=;
        b=TO0yevNRjJZw2tqFmB5zLiPZY7x5MVIQAKEqka3OFmiHRwjXAC/Px6w85CJ3lgKWqCbu9N
        ZVG3NjLPxzzfgnHFughdIMXCJ8d1Vv1WjC1m/1AL8yKrL94yhixc9dRNMZTuuWqXSi5dUn
        i85Ojc/TBhrTXrccw3S+1aiuZGdW7uEl9TbO+MzlFLSwWm1OKyEENNJLmBNQ9yMLWyECI2
        HsBr4D5TV2g8IK70jQaleH6IYBCg/AzRy8v4sBH0KuEfZufaQTUdwEQ0aurNCaUpocU9+Y
        TVVpwC9P1IhIuka6WZWmjwYlN9neHqKrf3iiPOtpAIrAxsTy0RQs+uOUIAoQKQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-lplmj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Suffer-Zesty: 14151f2a617b606e_1682477167833_1586177106
X-MC-Loop-Signature: 1682477167833:3360432559
X-MC-Ingress-Time: 1682477167833
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.52 (trex/6.7.2);
        Wed, 26 Apr 2023 02:46:07 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Q5jt659lpz4s;
        Tue, 25 Apr 2023 19:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682477167;
        bh=cDlBBkIQrKGmh/G7kK0lYtW2tyvUghmmcSfwFxPE5Lc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=bOx4cn/ofOIqIhnxtd+8YuP6TGsv4TftkYcvDf7ingxOcCMZw2ENF/PBdQGj6b86O
         n0fwnIWwYAbLS3pF1iXR+In2tmSzavF8cW+9rGYWWf+sDudu0/kDQHliYe+lFiSuWU
         L1GgqgT+AQlxhqO/I6Nln8t3bWwFR7CUEqfqxxQ6RhyGIKzN6Qw496xogdz8HWeofu
         PHuceEjd25yMYU+Lh8QaYbT1qG5cbTo22g7IHPl9hG/W5HGhIhqIOWhfd6ZFm6kVuk
         ajd2BxlPlk+JVaoRty2RTauw9/hEOa+H6sqZdmVSD3gWU7QB41w/kYtcUJ7cJpwMFR
         H+NOV/+8yhi/Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     alison.schofield@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] hw/cxl: Add get scan media capabilities mailbox command support
Date:   Tue, 25 Apr 2023 19:14:16 -0700
Message-Id: <20230426021418.10186-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426021418.10186-1-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Use simple heuristics to determine the cost of scanning any given chunk,
assuming cost is even across the whole device.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 45 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0849cfbc2a4c..f346aa8ce3b2 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -79,6 +79,7 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
     PHYSICAL_SWITCH = 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -882,7 +883,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
             return CXL_MBOX_INTERNAL_ERROR;
         }
     }
-  
+
     QLIST_FOREACH(ent, poison_list, node) {
         /*
          * Test for contained in entry. Simpler than general case
@@ -934,6 +935,45 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode
+cmd_media_get_scan_media_capabilities(struct cxl_cmd *cmd,
+                                      CXLDeviceState *cxl_dstate, uint16_t *len)
+{
+    struct get_scan_media_capabilities_pl {
+        uint64_t pa;
+        uint64_t length;
+    } QEMU_PACKED;
+    struct get_scan_media_capabilities_out_pl {
+        uint32_t estimated_runtime_ms;
+    } QEMU_PACKED;
+    struct get_scan_media_capabilities_pl *in = (void *)cmd->payload;
+    struct get_scan_media_capabilities_out_pl *out = (void *)cmd->payload;
+    uint64_t query_start;
+    uint64_t query_length;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * 64;
+
+    if (query_start + query_length > cxl_dstate->mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /*
+     * Just use 400 nanosecond access/read latency + 100 ns for
+     * the cost of updating the poison list. For small enough
+     * chunks return at least 1 ms.
+     */
+    stq_le_p(&out->estimated_runtime_ms,
+             MAX(1, query_length * (0.0005L/64)));
+
+    *len = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -972,6 +1012,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
+        cmd_media_get_scan_media_capabilities, 16, 0 },
+
 };
 
 static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
-- 
2.40.0

