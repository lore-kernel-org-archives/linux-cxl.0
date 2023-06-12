Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE0DC7EE2E
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjFLSp0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjFLSpZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:25 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE5B184
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:24 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CAB656C19AD;
        Mon, 12 Jun 2023 18:45:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 377FE6C29F7;
        Mon, 12 Jun 2023 18:45:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595523; a=rsa-sha256;
        cv=none;
        b=nRaGPjRMagQ98Jc7Fxbn7nb9Nhbzuo8A+fcSDMu83DSMJsVbGd8JWffkqEDZNkYw0qQJm2
        GkW9Ue4fNT6wZ3rpbCKVjVEPdPBP7LjIywh0Nrg3FrXGpbZcvP7kZ6eVb7fajqH4A0KHoz
        M2Yz8ttFKqHLgrM6OTQTBB9a99lBdKfbaqEsqqPQuTHQQ6p5tz7/GznqNyqmCEm6sjh3Mo
        jnBKtMQD/AmzZ3Fx7IWf6inJd6SKBLJwUqNwKVjYqrxgP4H620AFx2InbQ2JpLsVP3ctsy
        dbQv1bvechhA9D8O5LVRh44W/0lWnraFtV12Uhca6NHxuRdJECuHoqxYRV/olQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=0k20K5jL/JRKSzlK03R/s3Lcb5oxhDJApBvL4XqqMaQ=;
        b=oM+IgYEmwTGiahm2A7ivzxHDUFl0p0aoC2R8tZgrXpCgzEUQ6z5afKuz+YweO4mgxlJGiZ
        hdBgDOiMFv70ueOdQnwtwUPzxLKgdrQB7TOD26TR66u5rN1yb3OCTKGZicEUOaGD286ogZ
        af0KRXvvD3WuiNwp/wi1Erhs2LOmeoVd1I1XtQ4gsiYiZjY9x1a1TYlX9jYvwAh//R7q3G
        G4/IPhhTTKJBmtMbJYk3ahBJGsUqIHv2qADgqNa6N/uF91VadaqnmAz0azNRXxfeIa6+hX
        wpP9dZ04W9Ax6upFoAN11mQ/uc/3vJcEBv6WUtxFGLqtYozS/8UKGgnnHi6Ixg==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-p8dcm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Macabre: 15963fa658c9ff10_1686595523546_2939337686
X-MC-Loop-Signature: 1686595523546:4244141998
X-MC-Ingress-Time: 1686595523545
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.21 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:23 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xG3QQcz63;
        Mon, 12 Jun 2023 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595523;
        bh=0k20K5jL/JRKSzlK03R/s3Lcb5oxhDJApBvL4XqqMaQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=B6g3TazEyVaAPWUNcUgcsh3mVJE99UDC3zDO2+dzF/d8WoQ1ETBN+whZ944F61iM7
         i7lat3TMMWvyiY7mcMcqLOwnhfcOn+81slNxoRyW0Qpi/M6PyUav2EpqNv+zSBhK0J
         jOTFV1tRelhpMET3EUUPcMHoL/ITQ3CcDB8AP/14FIPsOP5zvI4e7IbDXoCGDiOwBg
         OPTpVRyTQE+afrtQ1xInwsdxpPgjr/kZy+Tlla+uEUMGkBvw20PjlYMSCW3SHSXiFk
         L6pJsIwfLgI8cXCIwCxA6II2GsyYh5OMiNp6WNkdu9KjObiRFhyuE6Ip6DpYw6aqbS
         VB7trHBrqH65w==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH 1/7] cxl/mbox: Allow for IRQ_NONE case in the isr
Date:   Mon, 12 Jun 2023 11:10:32 -0700
Message-ID: <20230612181038.14421-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For cases when the mailbox background operation is not complete,
do not "handle" the interrupt, as it was not from this device.
And furthermore there are no racy scenarios such as the hw being
out of sync with the driver and starting a new background op
behind its back.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Fixes: ccadf1310fb (cxl/mbox: Add background cmd handling machinery)
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a78e40e6d0e0..4b2575502f49 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -118,9 +118,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 
+	if (!cxl_mbox_background_complete(cxlds))
+		return IRQ_NONE;
+
 	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-	if (cxl_mbox_background_complete(cxlds))
-		rcuwait_wake_up(&cxlds->mbox_wait);
+	rcuwait_wake_up(&cxlds->mbox_wait);
 
 	return IRQ_HANDLED;
 }
-- 
2.41.0

