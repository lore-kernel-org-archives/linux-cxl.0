Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BB8EE57CA
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 07:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjIHHj5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjIHHj4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 03:39:56 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D641990
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 00:39:50 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 276962C09A1;
        Fri,  8 Sep 2023 07:32:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CCED12C1D17;
        Fri,  8 Sep 2023 07:31:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694158319; a=rsa-sha256;
        cv=none;
        b=wz38pPHXYlw7IpVTh2utkWVXO5oPNgXAZzyEh7dmO35dTMogDFUvwfhGHxp9b87DuYAuvz
        4aCgwPbjRbHKKivIozgjG2/H5H9EHZLCqFVRV2zLVonItkyGaJZwdWC3cZ6YIPwflceu3h
        YqZyXBi2qCraVt/j+N9S50AZMxPKoZWzSaQ14aCe4kyOizYFgQjrae44geVc6Ob5QbCTT4
        uIQKSQB0MtrB3uceCyGimR9ZC5tEP6LuJeI017bBkD2OGwh8jL3bDjFCDy/uZ3CKdXrdAf
        wSPjmIdt3SgThLatk7j9eDCZFx99iRJs7zu8cBbXLA2RzdZMmpw9i1rKVqheWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694158319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=6ycJfni9jKUd6GiZIznlvVpk6tvDdHyWkuCktxvnD4o=;
        b=E8YJLTDUM11PGV71a/FSBZ2NkfkbYlaCCflpewNAOuabKd1Be28M3zkv8EAcfPn8IzMAXu
        afiRRjFvNQYCTWw1Skeb2EhTEgiFP1sXq9ul/5rYsTsJA8zIh1XXM88FDEf7Ncecp+ReiC
        nVoN3wltBJPZToD4SPWHGNLRZHsQJmMT6mCM9QgaSIF/xiWPQWCR3Lf2FIXz8/NxagoxCg
        c0pNOycq+GgetCPf/91QGhLiJeFxIeiZv6mJyq3gSeyaw0Rr9JLwMEn3epJBCpo0wD4qNL
        0G835h+4IXachABFMcJiPtPq1BQUVR4FZWgLoihmeNiTlHPkglSnENdmv1S+lA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-jlhqk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Troubled: 72f9ba67616ade42_1694158319978_1419977940
X-MC-Loop-Signature: 1694158319978:3610082025
X-MC-Ingress-Time: 1694158319978
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.77.25 (trex/6.9.1);
        Fri, 08 Sep 2023 07:31:59 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rhnqg0yS8z49;
        Fri,  8 Sep 2023 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694158319;
        bh=6ycJfni9jKUd6GiZIznlvVpk6tvDdHyWkuCktxvnD4o=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Zjgk0vOy7rzY7Tz/0cq6Auc3Ch/Risvi/4ZjhWRKQz5BQfloLhbMRdg8mcdiwJ26R
         q8PyA4OuabEcGHoI8IylCCr/ACeqogL+2H8n21SWmppKJq7GExZHhzvnrJuxVjbrXy
         Sp4D6G5ZL6DwdC98yHbKfsu1mqetmBDDLsXqlMhoBJcC7EcKpf9F8AVx3+zL8ndOxn
         Yr3YBIDjUZSE4PQ7JRskb36O/jQJcutZdLXgPtqKa0oPFri0jv2Ay1fivwWpeLZ588
         QX9lqfla1xakncmqsBbkuLOuAI4yn8/tiF0nY9XKZKUyEvwN+KslHKiDyo/OJ34RVa
         tRsghXmQ05iPw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] hw/cxl: Add get scan media capabilities cmd support
Date:   Fri,  8 Sep 2023 00:31:50 -0700
Message-ID: <20230908073152.4386-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908073152.4386-1-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Use simple heuristics to determine the cost of scanning any given
chunk, assuming cost is equal across the whole device, without
differentiating between volatile or persistent partitions. This
is aligned to the fact that these constraints are not enforced
in respective poison query commands.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4e8651ebe2e9..3073222060ab 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -80,6 +80,7 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
     DCD_CONFIG  = 0x48,
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
@@ -1174,6 +1175,56 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.0 section 8.2.9.8.4.4: Get Scan Media Capabilities
+ */
+static CXLRetCode
+cmd_media_get_scan_media_capabilities(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct get_scan_media_capabilities_pl {
+        uint64_t pa;
+        uint64_t length;
+    } QEMU_PACKED;
+
+    struct get_scan_media_capabilities_out_pl {
+        uint32_t estimated_runtime_ms;
+    } QEMU_PACKED;
+
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+    struct get_scan_media_capabilities_pl *in = (void *)payload_in;
+    struct get_scan_media_capabilities_out_pl *out = (void *)payload_out;
+    uint64_t query_start;
+    uint64_t query_length;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignment required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
+
+    if (query_start + query_length > cxl_dstate->static_mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /*
+     * Just use 400 nanosecond access/read latency + 100 ns for
+     * the cost of updating the poison list. For small enough
+     * chunks return at least 1 ms.
+     */
+    stl_le_p(&out->estimated_runtime_ms,
+             MAX(1, query_length * (0.0005L/64)));
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 /*
  * CXL r3.0 section 8.2.9.8.9.1: Dynamic Capacity Configuration
  */
@@ -1602,6 +1653,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MEDIA_AND_POISON][GET_SCAN_MEDIA_CAPABILITIES] = { "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
+        cmd_media_get_scan_media_capabilities, 16, 0 },
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
-- 
2.42.0

