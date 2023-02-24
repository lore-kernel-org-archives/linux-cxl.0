Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF71C6FA8E
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBXTpE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBXTpD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:45:03 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026911168
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:44:59 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D7A268C0E83;
        Fri, 24 Feb 2023 19:44:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4C1368C1127;
        Fri, 24 Feb 2023 19:44:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677267898; a=rsa-sha256;
        cv=none;
        b=pkZTGyR24/5cbbUKPcAzR5x2iJmICgclpw42lUeNhh6idMX/iZh+uAcDMJKXsNI9E9YNHw
        GZzDNLsb/XXiL9azCcjttR9CRy5x48vx6VnKuyQKuIkWLCoUrbWRm146x8umJi9lShiPC2
        QEo82CSMoScjyvFWKrq+MmYxXzk4vrUW1sAuLFOCIiMr6/n4iLSQJzYzQnws+C+p9CCcLM
        iRp8KpsMypUK9rDpvGCcIJBTF0liV7DNv4MKW/v5lHHGEkhQ178X3IMCaGB3lLK2y2rp9J
        MYXYypjraDV7an972EQVUWuqIVMaiGhE+0hlnA/P9OPDuKBuxl2LRMz7ounYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677267898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ikC1LO3vxcDXQf+xSuIkYwrqnOjS6KA7A32KL9FtDxY=;
        b=1DgPm7tWWKBpo12TBI67zgFHfHHaKmKcqHFalSJIQYpVLvAs0VHkbp/OQ6RiAkcp0DX2kq
        MwHSv0XcmiApz1W8aNfHQ7qCDDUgxrs7YxET9Q5A/7u5sq2Kpy7lt/86YgU0/bUzwKWjrz
        AmT3jhoVe87SSyIyVvrvt+Txv7czOKfYoZgi28jhxoXeqwyqaA9rG+SMrAVL2UFlUwxwsO
        osQ0XeFcpZb1Kb17FuZ9pHR5VZQZBlkG/wxkqnKg6CqpfAG2TyYwIKQs1YRTWbzGR5nfX8
        IF+S7m+ivJs6UaWTOsWFWLzyighgmyYP6i6KC41iGEDUZHLBujUHPv0c66pD6A==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-x62tj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Scare: 26b13fdb5407b346_1677267898683_3042248368
X-MC-Loop-Signature: 1677267898683:708471927
X-MC-Ingress-Time: 1677267898682
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.200.110 (trex/6.7.1);
        Fri, 24 Feb 2023 19:44:58 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgMr6nm0z2Q;
        Fri, 24 Feb 2023 11:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677267897;
        bh=ikC1LO3vxcDXQf+xSuIkYwrqnOjS6KA7A32KL9FtDxY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=cnLysW/8FM1AwIdUiuJxq2CAcT+V/c2OFbqS8fgKrPZy35FuD7ACLC4Oz48PZBJbD
         9QmoFaliOim86lyhKFV65r9RKkbJ1sqar/6V7O2PIjAVBLWVHwW3PBdo+zxOzLIrpe
         mnUKSupPoVex65n62XRYS9pdcA+8zHQlDKWKKvY1Lu9sNTvp0a0CTIcfAGdY+igy8W
         XFdk4d4dv7VZfXyX8aS/H4aA1SElnZ12nERnHgfnwPPg8KuxNzaZPVhRk8VxtHlppb
         7H5XG96EKBgQZ9uKhNwGPo4ooUyeXj5GTp/qAxeIALPDyTcCXv427jJMhXBPl/osJm
         ERziYakY/7bXw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 2/3] cxl/mbox: Wire up interrupts for background completion
Date:   Fri, 24 Feb 2023 11:44:42 -0800
Message-Id: <20230224194443.1990440-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194443.1990440-1-dave@stgolabs.net>
References: <20230224194443.1990440-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Notify when the background operation is done.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-device-utils.c   | 10 +++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 11 +++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 4bb4e85dae19..a4a2c6a80004 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -272,10 +272,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt */
+    const uint8_t msi_n = 9;
+
+    /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
+    /* irq support */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     BG_INT_CAP, 1);
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MSI_N, msi_n);
+    cxl_dstate->mbox_msi_n = msi_n;
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 82923bb84eb0..61f0b8d675bc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -8,6 +8,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
@@ -984,9 +986,18 @@ static void bg_timercb(void *opaque)
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
 
     if (cxl_dstate->bg.complete_pct == 100) {
+        CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+        PCIDevice *pdev = &ct3d->parent_obj;
+
         cxl_dstate->bg.starttime = 0;
         /* registers are updated, allow new bg-capable cmds */
         cxl_dstate->bg.runtime = 0;
+
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, cxl_dstate->mbox_msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, cxl_dstate->mbox_msi_n);
+        }
     }
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index dbb8a955723b..f986651b6ead 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -189,6 +189,7 @@ typedef struct cxl_device_state {
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
+        uint8_t mbox_msi_n;
         union {
             uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
-- 
2.39.2

