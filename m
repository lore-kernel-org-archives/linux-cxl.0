Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD04C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 23:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiCQXmY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiCQXmX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 19:42:23 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C355174BB0
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 16:41:01 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 52337881B14;
        Thu, 17 Mar 2022 23:41:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9D9D9881AF6;
        Thu, 17 Mar 2022 23:40:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647560459; a=rsa-sha256;
        cv=none;
        b=y6KyjucrUfFqoV9JGPBDDFIVf1u4WEPorB8f/b+m4ZMYKlvYdZouFPkjkEoQRwaq1+A+Xa
        xBuwO5UFucfQQLM4ROXUIvmLvDyVc+TAUfmCityghdei8svKvO1QmEXpEyAhs+9bCk8hHe
        k+7Oxfm61zs9M+XUF8JrPfMReCWSqRZVpPcWc5fR+9Bafom70ByRaePqLVxoNdWl/0Ddzx
        DaeBvpPWrrj8AAuuYOHZ0KKfVlUX7/cxxWxOfob2TnxVw5xCvmf7q76Oro+N9ves5T91Ed
        TSQqbQ+2nFDXJ/LySk5oqRDpSroU8Yspls/uhYsPTwd/ApweMhE6xiyH6B/H8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647560459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=v6w9eM5yxxYzkqILV6KU6C0yQ19ho4zxdRRyRz7Hnf4=;
        b=MFtpBPAMJIgD6SAR82mqFe8scX8BPDxJn35rHZOQ4XizlaYs9EbIRS7IpKF1+vk/ovrZ0T
        fg9eQDD6km3CyK5+jgS9kQ7QcLxJLYvtJE51N5CDw8U8cPjqwimGDGZ2lwMR/Z38WaJiav
        ThVvEI0VAyptiQ56ymE0g31n+6JIv4f4Qvd6XFbLABFvmEjnqAvtpMKY8PwTomWHoKIRnh
        n4ucc/PADUAb1r6CeeddmlD7PIxrUEEYJ1fNYUw+LAdtR4zIuxO47YWY1zKPVrmBuyo7t6
        vqiWjeNqzl2If1ONSNRcgTiCidfzckxobGIedWfDJyEfPOjVtuZKGRLFhTzrzg==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-xgcgv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.126.219 (trex/6.5.3);
        Thu, 17 Mar 2022 23:41:00 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Supply: 5267f1c85b2c46c2_1647560460111_3057755779
X-MC-Loop-Signature: 1647560460111:1595744512
X-MC-Ingress-Time: 1647560460111
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4KKNty65pPz1fQ;
        Thu, 17 Mar 2022 16:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647560459;
        bh=v6w9eM5yxxYzkqILV6KU6C0yQ19ho4zxdRRyRz7Hnf4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=XF6d6UbZjfHAa2i57aFiclfj5YnR1oj8ymLaAqmN8okyJhQ8NGs2JNZ0/M2bhrP/G
         lJURrAB5lY8dbHYHVfxVcUlhLl0rUUbTvy940fsaqtYXurbjBqi+N2KDbdD4fs+J1o
         PCr2zaJzUdCHYIaYRJEQF9nQginC74NOHda9HfK8JO9XBz8hda8ZByooBIBWM2K4Re
         TttEpCR7GG/l29GHLO8t63A4zp0AIMsz+KaLdPwZXdJoQMa7vuwdgw6xr6YyEfmRYj
         tUonCEur1HYYgoKjV8HOSmb27q6/SAeulQYkRdaSalE91Bf/XHRXczkyhGQNqwA56H
         ZHfHyn0JdDDdA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net
Subject: [PATCH 3/5] cxl/mbox: Improve handling of mbox_cmd return codes
Date:   Thu, 17 Mar 2022 16:40:47 -0700
Message-Id: <20220317234049.69323-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220317234049.69323-1-dave@stgolabs.net>
References: <20220317234049.69323-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Upon a completed command the caller is still expected to check
the actual return_code register for to ensure it succeed. This
adds, per the spec, the potential command return codes. It maps
the hardware return code with the kernel's errno style, and by
default continues to use -ENXIO (Command completed, but device
reported an error).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |  2 +-
 drivers/cxl/cxlmem.h    | 90 ++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/pci.c       |  2 +-
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 778b04a0fb0a..d4d4a16820b7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -171,7 +171,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 		return rc;
 
 	/* TODO: Map return code to proper kernel style errno */
-	if (mbox_cmd.return_code != CXL_MBOX_SUCCESS)
+	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
 		return -ENXIO;
 
 	/*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5d33ce24fe09..268597d1ff33 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -85,9 +85,97 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	u16 return_code;
-#define CXL_MBOX_SUCCESS 0
 };
 
+/*
+ * Per CXL 2.0 Section 8.2.8.4.5.1
+ */
+enum {
+	CXL_MBOX_CMD_RC_SUCCESS = 0,
+	CXL_MBOX_CMD_RC_BACKGROUND,
+	CXL_MBOX_CMD_RC_INVINPUT,
+	CXL_MBOX_CMD_RC_UNSUPPORTED,
+	CXL_MBOX_CMD_RC_INTERNAL,
+	CXL_MBOX_CMD_RC_RETRY,
+	CXL_MBOX_CMD_RC_BUSY,
+	CXL_MBOX_CMD_RC_MEDIADISABLED,
+	CXL_MBOX_CMD_RC_FWINPROGRESS,
+	CXL_MBOX_CMD_RC_FWOOO,
+	CXL_MBOX_CMD_RC_FWAUTH,
+	CXL_MBOX_CMD_RC_INVSLOT,
+	CXL_MBOX_CMD_RC_FWROLLBACK,
+	CXL_MBOX_CMD_RC_FWRESET,
+	CXL_MBOX_CMD_RC_INVHANDLE,
+	CXL_MBOX_CMD_RC_INVPA,
+	CXL_MBOX_CMD_RC_INJPOISON,
+	CXL_MBOX_CMD_RC_MEDIAFAILURE,
+	CXL_MBOX_CMD_RC_ABORT,
+	CXL_MBOX_CMD_RC_INVSECURITY,
+	CXL_MBOX_CMD_RC_PASSPHRASE,
+	CXL_MBOX_CMD_RC_MBOXUNSUPPORTED,
+	CXL_MBOX_CMD_RC_INVPAYLOAD,
+};
+
+#define CXL_CMD_RC(_value, errno, str)		\
+	[CXL_MBOX_CMD_RC_##_value] = {		\
+		.err = errno,			\
+		.desc =	str,			\
+	}
+
+/*
+ * mbox cmd hardware return_code handling
+ */
+struct cxl_mbox_cmd_rc {
+	int err; /* proper kernel style errno */
+	const char *desc;
+};
+
+static const struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = {
+	CXL_CMD_RC(SUCCESS, 0, NULL),
+	CXL_CMD_RC(BACKGROUND, ENXIO, "background cmd started successfully"),
+	/* errors here on out */
+	CXL_CMD_RC(INVINPUT, ENXIO, "cmd input was invalid"),
+	CXL_CMD_RC(UNSUPPORTED, ENXIO, "cmd is not supported"),
+	CXL_CMD_RC(INTERNAL, ENXIO, "internal device error"),
+	CXL_CMD_RC(RETRY, ENXIO, "temporary error, retry once"),
+	CXL_CMD_RC(BUSY, ENXIO, "ongoing background operation"),
+	CXL_CMD_RC(MEDIADISABLED, ENXIO, "media access is disabled"),
+	CXL_CMD_RC(FWINPROGRESS, ENXIO,
+			"only one FW package can be transferred at a time"),
+	CXL_CMD_RC(FWOOO, ENXIO,
+			"FW package content was transferred out of order"),
+	CXL_CMD_RC(FWAUTH, ENXIO, "FW package authentication failed"),
+	CXL_CMD_RC(INVSLOT, ENXIO,
+			"FW slot specified is not supported for requested op"),
+	CXL_CMD_RC(FWROLLBACK, ENXIO,
+			"rolled back to the previous active FW"),
+	CXL_CMD_RC(FWRESET, ENXIO, "FW failed to activate, needs cold reset"),
+	CXL_CMD_RC(INVHANDLE, ENXIO,
+			"one or more Event Record Handles were invalid"),
+	CXL_CMD_RC(INVPA, ENXIO, "physical address specified is invalid"),
+	CXL_CMD_RC(INJPOISON, ENXIO,
+			"allowed poison injection has been reached"),
+	CXL_CMD_RC(MEDIAFAILURE, ENXIO, "permanent issue with the media"),
+	CXL_CMD_RC(ABORT, ENXIO, "background cmd was aborted by device"),
+	CXL_CMD_RC(INVSECURITY, ENXIO,
+		   "not valid in the current security state"),
+	CXL_CMD_RC(PASSPHRASE, ENXIO,
+			"passphrase doesn't match current passphrase"),
+	CXL_CMD_RC(MBOXUNSUPPORTED, ENXIO,
+			"not supported on the mailbox it was issued on"),
+	CXL_CMD_RC(INVPAYLOAD, ENXIO, "invalid payload length"),
+};
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
index c77e06aff8dc..0c36d111232b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -177,7 +177,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != CXL_MBOX_SUCCESS) {
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error\n");
 		return 0;  /* completed but caller must check return_code */
 	}
-- 
2.26.2

