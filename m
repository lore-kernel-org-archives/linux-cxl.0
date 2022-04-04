Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC76C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 02:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376886AbiDDCOj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 3 Apr 2022 22:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358063AbiDDCOi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 3 Apr 2022 22:14:38 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089C36179
        for <linux-cxl@vger.kernel.org>; Sun,  3 Apr 2022 19:12:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 863C8120AAA;
        Mon,  4 Apr 2022 02:12:41 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EC7F3120CED;
        Mon,  4 Apr 2022 02:12:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649038361; a=rsa-sha256;
        cv=none;
        b=4rXLSxmhVhR2cW5St2sQvxdIOA90QgMuoBOYUbzVRwBgv2LvCmE24b7CRLgLjHcv5oQ2e3
        roBPILqmGpkZMzEWrURZMdOmGzJTWJ+m5+cA3og/SVIE15fQbU7z4vbTtwNYeGhItD1gDi
        7ZsiopBg9bQl/FCL7UMqAg2gYaJLm3ScbFC94BmUrHY2OV1HhVnxGPR0MxqozHrEFE9H+9
        eCCbkdYzhqfjQRHRItbGhrxYproadtNKjZJ85NLADxOgdvy6o9hntmvvx7uS6X0QxdbWyY
        GIf2getarUyoXTiGLRY8+Pgp2ZEFy2CukoTZF2WQwzNhozU5LWA/0rVzD5XKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649038361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=55BdkeNpp+yee7dfWixViuBhPM+Zpl0q6QEV+CDcEL8=;
        b=9qR45srTrR4llX8BFP9OZVCCe5o1qq7o4T+6oMgm3Ec0AFEf8FVT7+kYEapPHtT2kW1dEh
        W3UWH2w58YzLSQRGQ6LM7lCMXVahDdJVYBWMGiVE5Yx+5y0z/OoASOmeMq5gHpAuvThC0/
        EAN23d1+ZoekZatfjU++vg72Xz2M3PezCzVB0mm9Gr91zCt7lexBXJbc4mBFeepVaSK5WA
        DdHMLOJrdhvGHiRW155a0y6+TtVGcySyMxvwZ9erV/+RqpR+8R9iMntGVGHoEh1sfO1PnW
        NSBmr1Zhcg9DyWIKWEpCoi1gtlDpNgeUGSnz2KLCDV37dNT+oUVcFwHjDm3//Q==
ARC-Authentication-Results: i=1;
        rspamd-786f77c8d-6kt9n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.30 (trex/6.7.1);
        Mon, 04 Apr 2022 02:12:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Macabre: 2463d21142c91d9b_1649038361272_856029037
X-MC-Loop-Signature: 1649038361272:3076096319
X-MC-Ingress-Time: 1649038361272
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4KWvS74mrZz22;
        Sun,  3 Apr 2022 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649038360;
        bh=55BdkeNpp+yee7dfWixViuBhPM+Zpl0q6QEV+CDcEL8=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=JIEzfRSmXnwAPNb6I21PbYQjAAUOOb7M8/8hRNpD4SWwou1SqauVelX6dzREeqqIq
         L332XE+tJk7WJqapQdC/CrBqlwDxlVppfI44yAesFGeyBkoSNi4CJqSrFDU2JltFSD
         mWZWVJal+UvcicrWlQQYeEGEh8PMKKtoX+NW/inaJM6Lx7vDjUDLL3XrELC6clQ1S5
         5+R5vYSfAL3LRT4dXpcBsq0lR/AwN5pNkKCEtQHg1N8RNbuggvZsXKYyQBtRaNoMLs
         1Bvy/Q6Uz/IQGtaDR7usUm3gG/m5cZxTgXSozL1B1ZSzN5MqdTbd1oUFaQZmnBP1u0
         VGqZmDrvtG+og==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net
Subject: [PATCH 3/4] cxl/mbox: Improve handling of mbox_cmd hw return codes
Date:   Sun,  3 Apr 2022 19:12:15 -0700
Message-Id: <20220404021216.66841-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220404021216.66841-1-dave@stgolabs.net>
References: <20220404021216.66841-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Upon a completed command the caller is still expected to check
the actual return_code register to ensure it succeed. This
adds, per the spec, the potential command return codes. It maps
the hardware return code with the kernel's errno style, and by
default continues to use -ENXIO (Command completed, but device
reported an error).

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |  2 +-
 drivers/cxl/cxlmem.h    | 53 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c       |  2 +-
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index a586c0fa9555..353b3f97c7e6 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -170,7 +170,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 		return rc;
 
 	/* TODO: Map return code to proper kernel style errno */
-	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
+	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
 		return -ENXIO;
 
 	/*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5d33ce24fe09..264a3cbfcad6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -85,9 +85,60 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	u16 return_code;
-#define CXL_MBOX_SUCCESS 0
 };
 
+/*
+ * Per CXL 2.0 Section 8.2.8.4.5.1
+ */
+#define CMD_CMD_RC_TABLE							\
+	C(SUCCESS, 0, NULL),							\
+	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
+	C(INPUT, -ENXIO, "cmd input was invalid"),				\
+	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
+	C(INTERNAL, -ENXIO, "internal device error"),				\
+	C(RETRY, -ENXIO, "temporary error, retry once"),			\
+	C(BUSY, -ENXIO, "ongoing background operation"),			\
+	C(MEDIADISABLED, -ENXIO, "media access is disabled"),			\
+	C(FWINPROGRESS, -ENXIO,	"one FW package can be transferred at a time"), \
+	C(FWOOO, -ENXIO, "FW package content was transferred out of order"),    \
+	C(FWAUTH, -ENXIO, "FW package authentication failed"),			\
+	C(FWSLOT, -ENXIO, "FW slot is not supported for requested operation"),  \
+	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
+	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
+	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
+	C(PADDR, -ENXIO, "physical address specified is invalid"),		\
+	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
+	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
+	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
+	C(SECURITY, -ENXIO, "not valid in the current security state"),         \
+	C(PASSPHRASE, -ENXIO, "phrase doesn't match current set passphrase"),   \
+	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
+	C(PAYLOADLEN, -ENXIO, "invalid payload length")
+
+#undef C
+#define C(a, b, c) CXL_MBOX_CMD_RC_##a
+enum  { CMD_CMD_RC_TABLE };
+#undef C
+#define C(a, b, c) { b, c }
+struct cxl_mbox_cmd_rc {
+	int err;
+	const char *desc;
+};
+
+static const
+struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
+#undef C
+
+static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
+{
+	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
+}
+
+static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
+{
+	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
+}
+
 /*
  * CXL 2.0 - Memory capacity multiplier
  * See Section 8.2.9.5
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8b131692ed61..4fbef05e9082 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -177,7 +177,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != CXL_MBOX_SUCCESS) {
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error\n");
 		return 0; /* completed but caller must check return_code */
 	}
-- 
2.26.2

