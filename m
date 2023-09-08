Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3933BEE57E0
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 07:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjIHHj6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 03:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHj5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 03:39:57 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F071BD2
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 00:39:50 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B53B82C190C;
        Fri,  8 Sep 2023 07:32:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 35B442C1943;
        Fri,  8 Sep 2023 07:32:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694158321; a=rsa-sha256;
        cv=none;
        b=FYS4v5RWCRITVWUmgeM4sWdiq2l8KhtLpn3ZAc5c8/zhdzmal8Y73SZiRPGdyLrkTYcj6P
        xR7bl2kVfW0Ez3nkODP6C33r8xY3TPGTWSuyl/K+toVAn7Jrm96ovf/IlwDDbEaB1TjFer
        nA8vcD/TI5+PMU8go+Xn6xv9IQ9+9qnKmog7GEwTogOXr1uyPPsXRYGw6I9xAm4tVgxT00
        RfuALmQ4thKT8v/nrBBmNZhWuETrJl2wh/MyIMLuLI4o995yjAyciM9B7nYBYqFYQe96Kx
        ykYCMXy9wV/znCKx5qOBN/stGMxjR50meGcUdF7XSsJC+q92G3su2JozxhMypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694158321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=/KcW86nEditGWL5h6dO8gU0mVCJalu6XxepCWU0hDTo=;
        b=7DWQ/TmhdF+IyMLpZEJBW0MQ7U+GGldVAR33Xpr7AHJQeiY2BoTKABms7MLVvY7CXliDbW
        spiH+S6h54kCEew1Rr3LFjqMWeB8H7tfAw/0eagOSXaE4sV+6mLfkwoJZBV2sg6BYRDxaP
        dIdR/uavQT2F1SxyAvcvN7ynzp1VNzVH0HMUpGY9RjCfpEZE+3o6BAV1Bcc0ROngM9uu8L
        t/4AXwihSuLW0+PXccNe5oI0bfRnf2ungKJkL0GwndO9NPnt5p8LKxAMMmn4cpiX8UfyQn
        FojVfhsRjVeMnMJ66lRPgFfrB4PwaMxBkmXCkTs8FxKOJhwWIOsov7NpYpEsuw==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-rp44c;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Shelf: 3697e2e2249319e3_1694158321549_259554858
X-MC-Loop-Signature: 1694158321549:1600169283
X-MC-Ingress-Time: 1694158321548
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.118.211.248 (trex/6.9.1);
        Fri, 08 Sep 2023 07:32:01 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rhnqh3g06z49;
        Fri,  8 Sep 2023 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694158321;
        bh=/KcW86nEditGWL5h6dO8gU0mVCJalu6XxepCWU0hDTo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Dxzc61nr0kL/a4GLlrYq1Xd1p8es9s0UhqNKYETT2bb3e/dCIi8egemi0+kH5315U
         9hLOTiwgxZmZiTX+pTcW4yHo5FkGL0tQQlhlGduQPo8MhG9m5C36Lhz6umL1fFOgcQ
         0hb3VSmD889QSi5i58XlQOM6kKp5G2ZH+vQAYODUvl+uYHndUCNoLn5OTYd0ygDtCv
         h5T6dDI+OQXHMTzMJGSzEAFfCKCZlFsH2/C4c+TxLc7nrmD5qVDORQeFG85RClMGqE
         yK6enpn2NLV3A4ZfKVzYbJF5CvyxG61tbOBk+9sqhhGnavFThwqTDoQoI2jMJp+8F/
         z167L8BhM2NfQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/4] hw/cxl: Add get scan media results cmd support
Date:   Fri,  8 Sep 2023 00:31:52 -0700
Message-ID: <20230908073152.4386-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908073152.4386-1-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Iterate over the list keeping the output payload size into account,
returning the results from a previous scan media operation. The
scan media operation does not fail prematurely due to device being
out of storage, so this implementation does not deal with the
retry/restart functionality.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 84 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 2 files changed, 85 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 399ac03962db..109b9ecfabf1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -82,6 +82,7 @@ enum {
         #define CLEAR_POISON           0x2
         #define GET_SCAN_MEDIA_CAPABILITIES 0x3
         #define SCAN_MEDIA             0x4
+        #define GET_SCAN_MEDIA_RESULTS 0x5
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1267,6 +1268,8 @@ static void __do_scan_media(CXLType3Dev *ct3d)
         ct3d->poison_list_cnt == results_cnt) {
         cxl_clear_poison_list_overflowed(ct3d);
     }
+    /* scan media has run since last conventional reset */
+    ct3d->scan_media_hasrun = true;
 }
 
 /*
@@ -1371,6 +1374,85 @@ static CXLRetCode cmd_media_scan_media(const struct cxl_cmd *cmd,
     return CXL_MBOX_BG_STARTED;
 }
 
+/*
+ * CXL r3.0 section 8.2.9.8.4.6: Get Scan Media Results
+ */
+static CXLRetCode cmd_media_get_scan_media_results(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct get_scan_media_results_out_pl {
+        uint64_t dpa_restart;
+        uint64_t length;
+        uint8_t flags;
+        uint8_t rsvd1;
+        uint16_t count;
+        uint8_t rsvd2[0xc];
+        struct {
+            uint64_t addr;
+            uint32_t length;
+            uint32_t resv;
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_scan_media_results_out_pl *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLPoisonList *scan_media_results = &ct3d->scan_media_results;
+    CXLPoison *ent, *next;
+    uint16_t total_count = 0, record_count = 0, i = 0;
+    uint16_t out_pl_len;
+
+    if (!ct3d->scan_media_hasrun) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    /*
+     * Calculate limits, all entries are within the same
+     * address range of the last scan media call.
+     */
+    QLIST_FOREACH(ent, scan_media_results, node) {
+        size_t rec_size = record_count * sizeof(out->records[0]);
+
+        if (sizeof(*out) + rec_size < CXL_MAILBOX_MAX_PAYLOAD_SIZE) {
+            record_count++;
+        }
+        total_count++;
+    }
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    QLIST_FOREACH_SAFE(ent, scan_media_results, node, next) {
+        uint64_t start, stop;
+
+        if (i == record_count) {
+            break;
+        }
+
+        start = ROUND_DOWN(ent->start, 64ull);
+        stop = ROUND_DOWN(ent->start, 64ull) + ent->length;
+        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
+        i++;
+
+        /* consume the returning entry */
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+    }
+
+    stw_le_p(&out->count, record_count);
+    if (total_count > record_count) {
+        out->flags = (1 << 0); /* More Media Error Records */
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 /*
  * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
  */
@@ -1803,6 +1885,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
         cmd_media_scan_media, 17, BACKGROUND_OPERATION },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
+        cmd_media_get_scan_media_results, 0, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index eb5c5284fa9f..e9d130e5c988 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -484,6 +484,7 @@ struct CXLType3Dev {
     /* Poison Injection - backup */
     CXLPoisonList poison_list_bkp;
     CXLPoisonList scan_media_results;
+    bool scan_media_hasrun;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
-- 
2.42.0

