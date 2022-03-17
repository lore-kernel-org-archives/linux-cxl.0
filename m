Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B05C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 23:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiCQXme (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiCQXmd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 19:42:33 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401C180051
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 16:41:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 186B092227B;
        Thu, 17 Mar 2022 23:41:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 76A979218B6;
        Thu, 17 Mar 2022 23:41:00 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.18.13 (trex/6.5.3);
        Thu, 17 Mar 2022 23:41:16 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Thread: 621a4b4c0180b2ee_1647560475822_3605548828
X-MC-Loop-Signature: 1647560475822:1271953928
X-MC-Ingress-Time: 1647560475822
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4KKNtz4G6xz1fK;
        Thu, 17 Mar 2022 16:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647560460;
        bh=9Z4uOC7dwkUjTIQHUcRpTqAo7KQFNI1z+w+uTn0tSeU=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=klyEl4IHS87HgV4FPGuTK7EUmP6tTjrHGemPPcjaVoY1i4vaqedyLcG74jVOZ97QB
         oJT58BLOR13SrewAxaocpp56Nw95LOpYhpLbfHxew6FOHT6G46qjdyebs4/rOA2yqR
         FdJ2oRjiRwPQPPa195K93FnrNew9w7iBDe6fot8lwKuXTNHkiwz4c9PalPhZoXBbve
         1slCf2azmBWaAEyXDKVInjxIZfPNqMM0wtheaRJIitZ632MlLDL0LeQ8GMY1kuUoZv
         bhAs4pUUalyalI1IEzueQBNz5CBtu5yEjlpc9lB4JtosfDUfbyYBVadIdaFUyKFFj/
         KjhWoPbrauvQw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net
Subject: [PATCH 4/5] cxl/mbox: Use new return_code handling
Date:   Thu, 17 Mar 2022 16:40:48 -0700
Message-Id: <20220317234049.69323-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220317234049.69323-1-dave@stgolabs.net>
References: <20220317234049.69323-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Use the global cxl_mbox_cmd_rc table to improve debug messaging
in __cxl_pci_mbox_send_cmd() and allow cxl_mbox_send_cmd()
to map to proper kernel style errno codes - this patch
continues to use -ENXIO only so no change in semantics.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 7 ++++---
 drivers/cxl/pci.c       | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index d4d4a16820b7..fa9e7043f158 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -170,9 +170,10 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	if (rc)
 		return rc;
 
-	/* TODO: Map return code to proper kernel style errno */
-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
-		return -ENXIO;
+	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
+		int err = cxl_mbox_cmd_rc2errno(&mbox_cmd);
+		return -err;
+	}
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0c36d111232b..67ec0220826f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -178,7 +178,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
-		dev_dbg(dev, "Mailbox operation had an error\n");
+		dev_dbg(dev, "Mailbox operation had an error: %s\n",
+			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0;  /* completed but caller must check return_code */
 	}
 
-- 
2.26.2

