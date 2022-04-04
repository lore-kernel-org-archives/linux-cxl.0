Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF6CC433FE
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 02:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376888AbiDDCOj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 3 Apr 2022 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376886AbiDDCOi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 3 Apr 2022 22:14:38 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1236315
        for <linux-cxl@vger.kernel.org>; Sun,  3 Apr 2022 19:12:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 490DF21516;
        Mon,  4 Apr 2022 02:12:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A9B90214E3;
        Mon,  4 Apr 2022 02:12:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649038361; a=rsa-sha256;
        cv=none;
        b=45vZmLw90pfvbS9O23635SmbY/RaMG0rnEJ9G+94OxIlLXb5Ks1m1Rnl00LLcEmHyWMVC+
        HipyBQpXZ+i7e19w3uw1vVdLO62AVsDKZjN+wy7NJJ5t5inhLpLRKy6Ljdnh3k8BxGZ2pw
        eq4YqofVq8QKtnv+WvqpSVGWxIADiFNkomx7dSYQ6vC9g1gcMov1D+sjsfRLp8Xu7PAG4n
        d2V3aP1HOftZnKY4X1FX83w4bC5litz8ZcYIUzSvkkY0hrBgf5EWUbFWAW4ZxA/Bo1YeA4
        JGRc4HpRnGYEURr45jjQY/TSb9UXOgIIFP9iuSczOGbboQwVCI6MJek5KfBoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649038361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=QjAt7BEVg32lputG6KlvHYYRfRmAJUzltFsX0NgaDiE=;
        b=3PFTzETMlh/6AYgl6bhkVnoNvWJiyehrab9p5SVscMsKhQGWsp3a8rb6Lm8kv7Vj+wqRWG
        aW25miyhaisbN5095IOkx3d2YyhZpPYHjXK1z5uVVKZ6KE9wM3Ig4hOvu40DJGor8HNUL+
        FGPdnyp3wLwNhem85xc7FKCwgsjHhQREaAgQNQKz4xOvYWJAPZ9ulhY/Tt7cIdXvm7OhMy
        0R4QAs3OyBl6FX8H50HMx+5zwZiwFs3Slu+hSxzoUUwq4XKf1T1B0wlaz1vavbK1YKCk0c
        bYYR/nkPfdqQmSOAAlvvnBvbs6NY1ekTJvVkvANSAycDQ5+OWg0du19/JzLhJg==
ARC-Authentication-Results: i=1;
        rspamd-786f77c8d-kx8xc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.202 (trex/6.7.1);
        Mon, 04 Apr 2022 02:12:42 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Grain: 67cb2353672f48ed_1649038362149_196462450
X-MC-Loop-Signature: 1649038362149:2677610679
X-MC-Ingress-Time: 1649038362149
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4KWvS853Qgz1Pg;
        Sun,  3 Apr 2022 19:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649038361;
        bh=QjAt7BEVg32lputG6KlvHYYRfRmAJUzltFsX0NgaDiE=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=aS8WISrSRk7HmLAC9dBwM3YJOHABM+ICNdi6Auvm6fseSdBQUrQM/v8bxio/xbror
         QO9kGpX3ncyK5VyPgJrGyL27OmHh11W+zJHRczPDS2ue3RlzyXERveErRZxt7mF/q+
         HlS2hnLWBmagyWEH2KBh/uHEW9E9b7P3coPLiZOy4woQV/dPl+UuA8mKbbFsJtwtXM
         +4aX9Rz2rOu/0DsagIvPxmx0BkClgg4fKzc42wb7g5oP4HMcd/WwgWiiX+mciKuc7r
         qzxucazjK26UmzAPzxw6NtD7CXBM7cxZjjNxiTVuLodNxtcT/VyMczk/IygndgCEp0
         Bt0zFYz02MkJg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net
Subject: [PATCH 4/4] cxl/mbox: Use new return_code handling
Date:   Sun,  3 Apr 2022 19:12:16 -0700
Message-Id: <20220404021216.66841-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220404021216.66841-1-dave@stgolabs.net>
References: <20220404021216.66841-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Use the global cxl_mbox_cmd_rc table to improve debug messaging
in __cxl_pci_mbox_send_cmd() and allow cxl_mbox_send_cmd()
to map to proper kernel style errno codes - this patch
continues to use -ENXIO only so no change in semantics.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 3 +--
 drivers/cxl/pci.c       | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 353b3f97c7e6..d7286c256e1c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -169,9 +169,8 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	if (rc)
 		return rc;
 
-	/* TODO: Map return code to proper kernel style errno */
 	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
-		return -ENXIO;
+		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4fbef05e9082..18d31fafc856 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -178,7 +178,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
-		dev_dbg(dev, "Mailbox operation had an error\n");
+		dev_dbg(dev, "Mailbox operation had an error: %s\n",
+			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0; /* completed but caller must check return_code */
 	}
 
-- 
2.26.2

