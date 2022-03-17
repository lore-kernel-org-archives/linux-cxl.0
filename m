Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3042C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 23:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiCQXme (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiCQXme (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 19:42:34 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FAF18005E
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 16:41:17 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id ABA5D461A9D;
        Thu, 17 Mar 2022 23:41:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6959E461704;
        Thu, 17 Mar 2022 23:41:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.102.3.17 (trex/6.5.3);
        Thu, 17 Mar 2022 23:41:16 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Lyrical: 559af1812f0965ff_1647560476565_1436234604
X-MC-Loop-Signature: 1647560476565:2611649312
X-MC-Ingress-Time: 1647560476565
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4KKNv034kqz1fQ;
        Thu, 17 Mar 2022 16:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647560461;
        bh=i60qDhbVCCREqjnZZ3dUJy0KfFl+7Z1pcY2boobd42Y=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ekfgegTX4ZiF0+UsTobZNigPja4IBxmGdQitFzPjpMasyr9xf2uUH6QTrcKqOAwNY
         e+sy2vM7Tjz0ohZLWh/HJyK0l0RGulNlmhpDMbDNAwAgLnkKcTqjnGY7eJ/rkyXvlu
         C5Mo1BCQbSBgrkrrZcwuJ6UCdj7Sj7LG+y/kUy6uj0In9LROjk6mm2k+GMErQ6k0/L
         Xdq24c9oLbUKEfSo5Y6YgHLDp+vOiZhDNoKX6v993ZHycPIlfaCedLxEmx0dZWu4qS
         3c40JAcyW9cAs5pa855Oy0Uo6CvpvmzGIk3PFpmlK3CIIMLiIJ06AL0NnBw0CVhYEW
         9W1k31+P76IGw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net
Subject: [PATCH 5/5] cxl/mbox: Retry sending mbox command upon RETRY return_code
Date:   Thu, 17 Mar 2022 16:40:49 -0700
Message-Id: <20220317234049.69323-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220317234049.69323-1-dave@stgolabs.net>
References: <20220317234049.69323-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As mentioned in CXL 2.0 specs: the hardware can set a Retry
Required if the the command was not completed due to a
temporary error. An optional single retry may resolve the
issue. This is the only retry case as in general they are
not recommended for commands that return an error.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index fa9e7043f158..567987052b68 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -160,20 +160,25 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 		.size_out = out_size,
 		.payload_out = out,
 	};
-	int rc;
+	int rc, retry = 1;
 
 	if (out_size > cxlds->payload_size)
 		return -E2BIG;
 
-	/* acquire and releases the mbox_mutex */
-	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
-	if (rc)
-		return rc;
+	do {
+		/* acquire and releases the mbox_mutex */
+		rc = cxlds->mbox_send(cxlds, &mbox_cmd);
+		if (rc)
+			return rc;
 
-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS) {
-		int err = cxl_mbox_cmd_rc2errno(&mbox_cmd);
-		return -err;
-	}
+		if (mbox_cmd.return_code == CXL_MBOX_CMD_RC_SUCCESS)
+			break;
+
+		if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_RETRY || !retry) {
+			int err = cxl_mbox_cmd_rc2errno(&mbox_cmd);
+			return -err;
+		}
+	} while (retry--);
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
-- 
2.26.2

