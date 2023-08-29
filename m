Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD84C83F14
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Aug 2023 16:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjH2QAg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Aug 2023 12:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjH2QAH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Aug 2023 12:00:07 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80DA12F
        for <linux-cxl@vger.kernel.org>; Tue, 29 Aug 2023 09:00:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 262BDC21A9;
        Tue, 29 Aug 2023 15:59:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8C833C221B;
        Tue, 29 Aug 2023 15:59:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1693324797; a=rsa-sha256;
        cv=none;
        b=9a3nLSUQ3ifhna7v6KnHzysD2JG5ssLsue81GjasnyGXeZVBZl9ebTUD2qFeI4z2DZCWkX
        +KhpLvUPrr4Pr9+2c+TJp2vYh/RI5ZoR9sPlL/P8Z2jc2hDAhQZ38BkqAhfdaf0pNOTxvJ
        WnEh2yCq3DGaF8nnasz7ib5jEUVkkb4lDRD6J6KSTOz+frBjimcZlh7jmAXwEXRN1oV4YO
        zlG3FHX2AJRfaNfPhPTTv8AwiXco9coBw9r34frnT2hxYAmmriyfGkC6wBUzGKFE8Ez47J
        7NiWgSiIRX19/dB2JiJ16fnDNXL3k0vnqKA3J90EgeTfjR+kUaGzc77OscF+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1693324797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=47V2Up6mGm2/5CBXMq8JUze4uivbsFTAHlxndpR1Imo=;
        b=os6zSlp4pXsNTMiGKWp8TYJXa3QeVN+qiF4sbd7Y86VKtTgyKLrJmIxAqo6xm23C6olkBu
        6pWqLgfqLkriWM6jdWjH+0URuIR5OogTLTs/p6OdnGrMJ6a7DGqaR6fvrWu+0n9lQpXdiI
        ku0eF7kxbVPtC/RE1XM3ZMYxGSRtr/TDqgxN78K6hJ8ilNTKL78lD4Vfpltlr4SDrBzEbx
        D+B3JnPj7H1vLN31aiyTIzTnaZ2+XKBAmBf5shFYQiMzhSq+n+mJY9wBoyTi+XVi/2qsdZ
        2L+cpB7bJh8Uqg4VVk7MnqlLlWO8vmCWQrXgqDjJ0pao3DJl/WV2ZTEAKPtAQw==
ARC-Authentication-Results: i=1;
        rspamd-6fd95854bb-m87fk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Trade: 3cea3ca4463bb72f_1693324797941_2673886472
X-MC-Loop-Signature: 1693324797941:2032674457
X-MC-Ingress-Time: 1693324797940
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.75.198 (trex/6.9.1);
        Tue, 29 Aug 2023 15:59:57 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4RZsZN4xJ4z3S;
        Tue, 29 Aug 2023 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1693324797;
        bh=47V2Up6mGm2/5CBXMq8JUze4uivbsFTAHlxndpR1Imo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=LsHAGWpCEqJey+pNSmCHywMW7jt6RGj8hpuxRMw4JEyu6n1JLZSJXh435yBzdX979
         vRtyo6OtDgiTYffEf9eYMq/SHQvBr/0sOhuus3xtlF8PE0/FZbtnP9NDGwH0c64La2
         CvtmVyAdFQP4oIgBpEqc4LyNCXrWBr7kJ8pIf/Uo129WyTR5jx1ZAI9QSNquA+ToJx
         yoOy2oTjjL4gbYJcf2FLKsrax4hsAhstWi193exyZZ7lzmVplg/ma9j0OAZv2fq0dr
         N6MgcyxHnYSZHOfm6+iZ6XhqhmaB1gDOvccDfVwfHsGsKlIjnjUFb8QwMUTxahr9Ot
         wYgdY0rdYnX/A==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, deepak.ukey@samsung.com, sathya.m@samsung.com,
        d.palani@samsung.com, fan.ni@samsung.com, a.manzanares@samsung.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Add Support for Get Timestamp
Date:   Tue, 29 Aug 2023 08:20:14 -0700
Message-ID: <20230829152014.15452-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add the call to the UAPI such that userspace may corelate the
timestamps from the device log with system wall time, if, for
example there's any sort of inaccuracy or skew in the device.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c      | 1 +
 drivers/cxl/cxlmem.h         | 1 +
 include/uapi/linux/cxl_mem.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..2444faac1e4c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -63,6 +63,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 };
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..ec6dfcc7bb99 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -500,6 +500,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
 	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
 	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
+	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
 	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
 	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
 	CXL_MBOX_OP_GET_LOG		= 0x0401,
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 14bc6e742148..42066f4eb890 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -46,6 +46,7 @@
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
+	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.41.0

