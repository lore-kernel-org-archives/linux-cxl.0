Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6ACC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiCQXmc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiCQXmc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 19:42:32 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E793B17F3E3
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 16:41:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3E752281004;
        Thu, 17 Mar 2022 23:41:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BEFCB281957;
        Thu, 17 Mar 2022 23:40:58 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.18.13 (trex/6.5.3);
        Thu, 17 Mar 2022 23:41:14 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cure-Vacuous: 288d36603fbaff1a_1647560474076_1027156811
X-MC-Loop-Signature: 1647560474076:2726396899
X-MC-Ingress-Time: 1647560474075
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4KKNtx6pmxz3d;
        Thu, 17 Mar 2022 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647560458;
        bh=xQh2PnCkjkzhaN3O5oXSokkJzc2IfmtlVvixyuG7EUg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=k9mbvRh+PJXCgiEio+iYkTxc5rCgQ4RBf2sAzS1zGT3LOrmb8hSsqetieOn4oweFx
         rMaGL8ZMuz/k0pqpq6aFZ9sLwsSziiqQUk3LIxtb73Gehsxs012WmuT1exgV9UIrCD
         Eo+DOZG+y6jObV3/ECQ8ZzWaq7PbxSE3RzxB6Dl7XNWzojz0nm/IFeS+heFPrK/Ngy
         oS7ci1JzTnW1Mo7ZbQZtLpURyyXjOm9wO32vCkASmzYvqvD/mNq6mVFebRAoxztTe8
         d1cgGHtuLLJMOOKMUpxouoH7pF/H+Wq7kmgB6LfK+UZKUd32kCeo2p0yzlKq9hDuI0
         hTjj+OQ1h5ZkQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net
Subject: [PATCH 2/5] cxl/pci: Use CXL_MBOX_SUCCESS to check against mbox_cmd return code
Date:   Thu, 17 Mar 2022 16:40:46 -0700
Message-Id: <20220317234049.69323-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220317234049.69323-1-dave@stgolabs.net>
References: <20220317234049.69323-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Also mention the need for the caller to check against any
errors from the hardware in return_code.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8a7267d116b7..c77e06aff8dc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -177,9 +177,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != 0) {
+	if (mbox_cmd->return_code != CXL_MBOX_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error\n");
-		return 0;
+		return 0;  /* completed but caller must check return_code */
 	}
 
 	/* #7 */
-- 
2.26.2

