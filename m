Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E571C77B73
	for <linux-cxl@archiver.kernel.org>; Tue,  2 May 2023 17:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjEBRvC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 May 2023 13:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjEBRvB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 May 2023 13:51:01 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA180E7B
        for <linux-cxl@vger.kernel.org>; Tue,  2 May 2023 10:50:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D68B16420C2;
        Tue,  2 May 2023 17:50:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5160964197E;
        Tue,  2 May 2023 17:50:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683049857; a=rsa-sha256;
        cv=none;
        b=ud75Oi9crG73L52mclNJEddvVR3GBzzY1XnZ8X8qtst24qyKSuSFFp98spPgp7+E4tl3Gn
        ZISBirA5aQ63vvj+KLzuFDrwjh6g3NI0fycnWCdKFc6dHqJXr5AHk6xiYzHA89FTOVStxD
        OuaihyUf084TfUltKUOgNlpo3yWQpBPe4GMzjnzNW8os/7cJcXrEqKcVirsOcneAApmdqb
        he2NdD0zI2Nv3IqZOSf1fIKqnk7g6KJYR4GOq5leHh7ifvvYz/zgc/18PC8QYIr9NwHXzE
        p3tVseL9kxzHxPzjnnYBY5eA/VfsLgNbybhOW61jXaIXcvA7Gm25ABdY0EK8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683049857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=2y4P+pyw3v7ufnBEm9DUjA6wsrjArOpU43ejgMZM8rY=;
        b=TvQGCTf28gaz3F+u1Kfsp9q7ZI/yjAQRxFg2m31TwI/V/hWI3rE17sK9k1+EFfvhZtbH0V
        SLAuvz0capB8NzOIkeD18uMvTK2uwdLLWTtEZzhoUt04Y8y1GOVBzQun6awZb2//FUdmOq
        eftxns5DlvF/pptJeRAmwL5UGB2LJJP8B4gv06suiNNo1bD9uMVjrq1gCs91s/GdFxpNZD
        hKPFybJxU5BiLwGMogsoqd5aHWaYkFjmn1WmaVe4o95zD7Y11Tm+KDU6ya1QAuroPkG460
        oQbF4CVsS3IgEoY38x7TeiuIIxdnwsIr60tfRxZGTQZ/m8U+8QkHBAWmtSZ40g==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-mm5t4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Snatch: 6768e0066b076807_1683049857658_2394531164
X-MC-Loop-Signature: 1683049857657:3960526112
X-MC-Ingress-Time: 1683049857657
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.8.80 (trex/6.7.2);
        Tue, 02 May 2023 17:50:57 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Q9ngN3v7xz6d;
        Tue,  2 May 2023 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683049857;
        bh=2y4P+pyw3v7ufnBEm9DUjA6wsrjArOpU43ejgMZM8rY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=PaIYUnKeL2DZaMPKPQvuqKX8nR560dSgCzABrBReI4IMotdq0m5Ue6p1v+SnytBxs
         3A1MQFC65FWqlqO9IvWVg6ySOlyCkpTGp59ycat/3fTUiTIWSweu8lznfKuvLp+9qK
         +Vjt9WRuBK+l+v9PwXplJwWStQshCHJlbVFHN6xYrvQ0y/CBdLpfhS5hVUdBjUg+MZ
         7OLv9QpLlJI+ZMtXcCD9FunzVkGRiyP1ri9u/m3JuTIMP5TmIxBBThTsZivwPhn4L5
         sYtWhht6fQSYOXfv4qmc6ysAgi0TwCrYVguTg5V/aD+mmbaXIl0MRW5fxoGnyMvT/+
         v07O2a+i3Z67Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/pci: Allocate irq vectors earlier in pci probe
Date:   Tue,  2 May 2023 10:18:40 -0700
Message-Id: <20230502171841.21317-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171841.21317-1-dave@stgolabs.net>
References: <20230502171841.21317-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Move the cxl_alloc_irq_vectors() call further up in the probing
in order to allow for mailbox interrupt usage. No change in
semantics.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f7a5b8e9c102..8bdf58c0c643 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -708,6 +708,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_alloc_irq_vectors(pdev);
+	if (rc)
+		return rc;
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
@@ -732,10 +736,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
2.40.1

