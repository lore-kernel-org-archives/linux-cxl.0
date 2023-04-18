Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E8C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 17:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjDRRzP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 13:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjDRRzM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 13:55:12 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3344688
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 10:55:10 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B5BF27E277A;
        Tue, 18 Apr 2023 17:55:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 371C77E2818;
        Tue, 18 Apr 2023 17:55:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681840509; a=rsa-sha256;
        cv=none;
        b=4/j6v1HiYzyO+fUNRNWl4ez+2FHcKk0w21udiLeBNi1G8LAN8dx7mU4bkwPCoGQ3L/XJAA
        Ycywx7sDbi8sig9mX4CApfoWUYvFhhBjV3xoKkqLHmLPdRS0syonb+9zAWzOtWzM2sZem5
        Vu80Tz/ulthFDA31zya6aRMycUFAfSaxdSU8chYu0Dt1V48WzqDu6sm3cc5zKFqg3IWd7d
        64//JGntZSrhwC6FfcrVrM36w5+iCxmSgNkoC5xEpxQ9m1c0xG6YpzQMJ2CZyLaV9M0E8j
        5xtQr9WBRLAAzO5YCOVfaBK7/P58lA77+0ivwUjnMMemo8Q5YGaen5hTOzV5Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681840509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=E6s93KH+ZAPOkb9pHYT5RNI2+vfthKtochxbW4rHpuQ=;
        b=uwIEaM7brlLnlccw4c9ZbRg33tz+IB2Cx0omcWTH69lf2CUmA4aP6VPZ3n6qai+u9xoHWJ
        Wil/T9MpBmx2WNRaCyXpV1O97yXa8tQs2mmx11cXbl+0FD1b1bQtpYY+VfKxPaS0vC3MCq
        /ql7OHZcBv9KBvOh2jXTKNJCftUBcvmXXUKKb8KbrOC8TRAEiY42wF88bs51oUQ3WZaZd7
        FK17up98K2zplQrUITrBANb20+aTjcEO8UptwEAv8MGJTPHn+Vjy0n1fynt0Uscfu3B6UG
        +Vnyt4IBkHMv9eoyjQANcM2nhMnaKvZXf2TIu84g9CqxZlmn051YiE1q4Zvayg==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-kj4fj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Glossy-Juvenile: 597acd4b524b480d_1681840509531_394784509
X-MC-Loop-Signature: 1681840509531:3930250491
X-MC-Ingress-Time: 1681840509531
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.222 (trex/6.7.2);
        Tue, 18 Apr 2023 17:55:09 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4Q1BQh1Dv1zBW;
        Tue, 18 Apr 2023 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681840509;
        bh=E6s93KH+ZAPOkb9pHYT5RNI2+vfthKtochxbW4rHpuQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=AQ9RQZuJMAoAzh/mZo6ihjpPJti+kNfcRrtWugFDPYoasewkDCIdCiZT4PACExQIM
         5t4TGhbkBJTplbOhwQczkwGyDXFuwt5iMKlMO7Xz8jaViQV4awUtMMf/0fKWyl9DBi
         1uQeU6GstVDF5Esv1dZAWNN9ZGrR+kPnwXIx6aotqiG6iJ3xjojooM8IN2NcEe+F6+
         YwCpgNjtcBq5Dxy0VDAwsUExTxTk+Dh+agF+PnAkF2x7DfN9uleR8CQNOrmsez6UOE
         t68tedjjBMVW+/qTxNt5Y5/TyJMkjcbDVWmoFdxttV+EvZBoYqjGw6udDPkNfvXytq
         qy+NZrdoWGu9w==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 5/5] cxl/type3: Remove superfluous statements
Date:   Tue, 18 Apr 2023 10:23:37 -0700
Message-Id: <20230418172337.19207-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418172337.19207-1-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Simple cleanup while going through the code, remove the
bogus return statements from end of void returning
functions.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/mem/cxl_type3.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 707bdc263f03..415a8c8a3973 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -864,7 +864,6 @@ err_address_space_free:
     if (ct3d->hostvmem) {
         address_space_destroy(&ct3d->hostvmem_as);
     }
-    return;
 }
 
 static void ct3_exit(PCIDevice *pci_dev)
@@ -1290,8 +1289,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
 
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, unc_err);
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
-
-    return;
 }
 
 void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
@@ -1564,7 +1561,6 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
         cxl_event_irq_assert(ct3d);
     }
-    return;
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
-- 
2.40.0

