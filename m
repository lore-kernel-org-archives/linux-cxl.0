Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349FFC77B78
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Apr 2023 02:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjDZCqN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Apr 2023 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbjDZCqL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Apr 2023 22:46:11 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DDE69
        for <linux-cxl@vger.kernel.org>; Tue, 25 Apr 2023 19:46:09 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 64554540BD1;
        Wed, 26 Apr 2023 02:46:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DA575541234;
        Wed, 26 Apr 2023 02:46:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682477169; a=rsa-sha256;
        cv=none;
        b=3JJ60ndLA6ZsSUICVYfnaoUS69xMcOKCckn4uj2Cf52RbHIBIQjOgEbuWZxJH6cpvWyHzQ
        EaS5L02lKKzUSzo/ImUkDmdPfh8PdzdEr3+KL8wJNS8M+MKvNbBJHW4OMzOlz5j8PAeAf3
        NBeq64bSYzUPDTlsOnRngsWxh11Vwl5PzjcxZZ5f06If+8NgJ8xztxx/0Miw5p6K+gZy/b
        KvDeURn5z1462d5WzHVpsSD/rvuza0d5ySWq3349nAzNpeoOxARmjUYKPSZSxikdgIMn4D
        xjwVfmOhZyq2TnB/47nBzLp1emcxChiPNe8qOTespHnOPe21uT5xoqvahuaGbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682477168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=3scxXsTcK2ZsqkI/Sa/VJOB5q8oBKP9/01gBFYOd5LQ=;
        b=44WQmvEXkNRk1k/GEeq0560ycl8Ryz/Fo2ZnY3H7cgR3VESHepF2itj1Z8l8pYX5+AHaNj
        OuG51znW98IGB0VtEAsQ6DnpXdfCIfYyzKLMbUKXVWIAq0/jJMD3BqkmIO1XC41bpu1zK2
        6gX/PpqheN17Qm2Sk32HhMmFg3CvNUJysLsbJD6dyBBsc/yeSNd1/Pev9eW1P5aooahdoz
        tI9IcS6aMRf+MRqrwaes6sU2DWx5E66ubHyJT0iqVtX/0J8IY5vFHRfhBW9bih6qWz26/c
        W0l5JUh61yhlvtPUk7FDnuHApE2Pw4YN85rgpL1B2t24ahU2MGuDHZ7HjkmnSA==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zn4rt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Eight: 120e6e2b6681b129_1682477169208_713630856
X-MC-Loop-Signature: 1682477169208:1352998720
X-MC-Ingress-Time: 1682477169208
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.62 (trex/6.7.2);
        Wed, 26 Apr 2023 02:46:09 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4Q5jt80sXLz4s;
        Tue, 25 Apr 2023 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682477168;
        bh=3scxXsTcK2ZsqkI/Sa/VJOB5q8oBKP9/01gBFYOd5LQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=H01CDvH1a4acgLEfbs1RnkofEMb+jzYAFvdjwUvA6V1eByj8e31deDyXUVrj9oofq
         G6OmvlYm+v3aWRa/38k2m4lDxCOvLRLAsbvjAGMIZjK0HFFHynYHY4VzF/65eEPjKl
         gClQyGUV5An+JG8f4ZfVWsm+Ton22ftPmHTSH94oPVFuHOhmpw4B9wJhFHEV5fc3vw
         qebEMAZSi84MsTA10Nb7UQE++ANNZVpGUa/owyE4Yd6KEck+7/HvWBlRaxGFdJm6sx
         vTAbdFALm7JJX9fughnXtzJN9Veoj8AcmFWk6TzMsxbzJ8+UguXBg06cn0aLinOvPc
         von00TAknLFqw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     alison.schofield@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] hw/cxl: Add scan media mailbox command support
Date:   Tue, 25 Apr 2023 19:14:18 -0700
Message-Id: <20230426021418.10186-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426021418.10186-1-dave@stgolabs.net>
References: <20230426021418.10186-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Allow the caller to retrieve the results of a previous scan media
operation, with similar semantics to the get poison list command.
Number of returned records is to the max payload output size.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7f29b840a2c9..f978180d8e21 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -81,6 +81,7 @@ enum {
         #define CLEAR_POISON           0x2
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
         #define SCAN_MEDIA             0x4
+        #define GET_SCAN_MEDIA_RESULTS 0x5
     PHYSICAL_SWITCH = 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -1079,6 +1080,58 @@ cmd_media_scan_media(struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+static CXLRetCode cmd_media_get_scan_media_results(struct cxl_cmd *cmd,
+                                                   CXLDeviceState *cxl_dstate,
+                                                   uint16_t *len)
+{
+    struct get_scan_media_results_out_pl {
+        uint64_t dpa_restart;
+        uint64_t length;
+        uint8_t flags;
+        uint8_t rsvd1;
+        uint16_t count;
+        uint8_t rsvd2[20];
+        struct {
+            uint64_t addr;
+            uint32_t length;
+            uint32_t resv;
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+    struct get_scan_media_results_out_pl *out = (void *)cmd->payload;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    uint16_t record_count = 0, i = 0;
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent;
+    uint16_t out_pl_len;
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
+            record_count++;
+        }
+    }
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    QLIST_FOREACH(ent, poison_list, node) {
+        if (ent->type == CXL_POISON_TYPE_SCANMEDIA) {
+            uint64_t start, stop;
+
+            start = ent->start & 0xffffffffffffffc0;
+            stop = ent->start & 0xffffffffffffffc0;
+            stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+            stl_le_p(&out->records[i].length, (stop - start) / 64);
+            i++;
+        }
+    }
+
+    stw_le_p(&out->count, record_count);
+
+    *len = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1121,6 +1174,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
         cmd_media_scan_media, 17, 0 },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
+        cmd_media_get_scan_media_results, 0, 0 },
 };
 
 static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
-- 
2.40.0

