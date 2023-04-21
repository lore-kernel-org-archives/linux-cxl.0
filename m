Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACA7C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjDUJzq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDUJzo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:44 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAEA26F
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EABB2261530;
        Fri, 21 Apr 2023 09:55:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6881D2612E8;
        Fri, 21 Apr 2023 09:55:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070935; a=rsa-sha256;
        cv=none;
        b=3dJPF9CT27GCyKiqCqXhDmFs62OsLqYhq7oxBxozjKPGo1GWfN69GF5W+8se0BdeAGwjJE
        YHHak/9vykWXwp5CJZjWXLNnFZIVxrTboayCxEwOP8wv+OJzd60z7WlmLIyXfccwQo93Gv
        rFgJJdjvOA92H3DhyFxqoa9xU4OnE8OSZwLzInoeSlCsPYp0WNhTVStZVMXysaL6GWEt0+
        VbU5op54Rr2cXer2yPFp8tz3qWzy8oRgjtlqPqe9gbq1RGuPlMMYE09ftyFc04KLwDqdST
        dsEnreL04PQVO8pk769TpYzaDYt4CT5XdpNN9o0YugC4OZvZm+4lAIU+oomMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4eIfNY0hhGeCxQCOwxzBSyINTGHhiZWIvl9JqNlwl9k=;
        b=nHmicJiUDoxFZdu9C7hvVzN6Usq1yoB8igVk0m5wW2nx1ItIGNApPH3R/+Tw+qk/QlZZdz
        SVdGkvEEXryb27zq3QwjSsRuBUauuiqg1/uwn8bTcu0GSZZ11evTr9OPnsk13t+3mo2iUd
        PouYVpJ9VgbjFEtiByJq7XXtTKUbspar3iIlrdaPt7utsdnp7YWVlTaLTqzxCu/9g1KMyw
        9WJ9yvPq67kIdG3y8hXWx7JPIL1g6HGvc9hk9BZOBAxZNMBhmulRVVq4XAr/f87cpSQpbK
        gqpkCcdKPZ9xGZ+1VPeODg0tKzL9C40jrKZXJylCK9SwPB2BwLFr4gkep7piew==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zn4rt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Eyes: 471fa54263f0b5f3_1682070935736_2921905457
X-MC-Loop-Signature: 1682070935736:1101810703
X-MC-Ingress-Time: 1682070935736
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.45 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:35 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qdy3N15z80;
        Fri, 21 Apr 2023 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070935;
        bh=4eIfNY0hhGeCxQCOwxzBSyINTGHhiZWIvl9JqNlwl9k=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Bx7z2vmK0vBKMfbxWr8uuzpUH/2Y2ra2ZROK1FxNbeOV0sQUcxY9iUlgtpgzmDBF0
         0po6Or6NtvyLdydj29Hl1baeS7dMBjtKPvuah5MT9D5U2pGhaOuWLYij7kA/l9tdgh
         IBwSGmYNxPcje7DMwrcuMymLYHa4xHuLTkE8zskp/8hQviddCLg/MHNjtp5l4dudSb
         SL4eILEeKFF+MFqPC5dDMbVZqnjt7/iR6eBDkXnoh66ixL8bt5cvnX70Do1u3UZNA3
         Ircx+K9M6bUXHtxL3k4S6UF0mT1xR0BqtpQRuukzOyNXLxWft9uKM3RdiOUflruN1x
         +rtL3cZu8e+Lw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/7] cxl/pci: Allocate irq vectors earlier in pci probe
Date:   Fri, 21 Apr 2023 02:23:15 -0700
Message-Id: <20230421092321.12741-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move the cxl_alloc_irq_vectors() call further up in the probing
in order to allow for mailbox interrupt usage. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 60b23624d167..39b829a29f6c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -757,6 +757,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_alloc_irq_vectors(pdev);
+	if (rc)
+		return rc;
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
@@ -777,10 +781,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_alloc_irq_vectors(pdev);
-	if (rc)
-		return rc;
-
 	cxlmd = devm_cxl_add_memdev(cxlds);
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
-- 
2.40.0

