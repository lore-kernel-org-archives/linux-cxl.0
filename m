Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D864C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 02:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376887AbiDDCOi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 3 Apr 2022 22:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358063AbiDDCOi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 3 Apr 2022 22:14:38 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4235DD4
        for <linux-cxl@vger.kernel.org>; Sun,  3 Apr 2022 19:12:40 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 4CF8021453;
        Mon,  4 Apr 2022 02:12:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 92762214E4;
        Mon,  4 Apr 2022 02:12:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649038359; a=rsa-sha256;
        cv=none;
        b=WBHAQUwav1DeWvG3G35Kj7Yu9TinzPzbEG3ZKXRtnxyJv24uNJ7UD6SqTk8GhI3J9/rW8G
        dWPqY+cnOWVOKnR4l0ulU0DnqFQaj69YwDFWIy2gAZ1kFjoGNeDgJH0+cSlw7e8Iv890wP
        PzkA+Dv9BNBqY4Z3XSUqT9yBWPEOrkEC3j8MWv0Cqr8V6VG8NO6+bkYF+w/mOxDXgh44PY
        9k0XrIr6HtFl3C90vngZXif5TGr6raN2ac02F6pqYAqd3uSbkpLuVchJxpGdRKwEeWHCpx
        4jO9Vv1zSzLUegBdL2ik8iRy2+Vv+tgsYyNwShtaUKgl+Fg/tw+wGRbaeAhFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649038359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=q8qIRFPV0uC+cNYd2+NI4qePMQ25+vLbZPWX145AKhM=;
        b=3qkbKo0+dys9KEu+ej4Y/X7emq0on7e0q/ttiibIQiacxbycNKInNTVbC1JOHF4UXwggvU
        hWVJDIo1JpR8+MNE1uLwVekQdzr59EdVaF1IVSZv6w75PIxT9euioiWX4qrHqQPujvL3yI
        U5CMo9l3qb6D3dm5K+LeoISvI9fjRAxJe1TpvT2p8w5Ujz9Hxo4qK5tzFPi52JL5LsvAWP
        w504CERzMTbPtfziydPGcS5KMSxUz8bydkm5yBDbnHA9mCT0+/DRYKOtsGnTSjQYgE69Hy
        p9G2Z3DlTdEj7JCd4I8mZdjulFsJ4hUdVAt0u59n9V7OhyLiiyj/S7z1A772JQ==
ARC-Authentication-Results: i=1;
        rspamd-786f77c8d-zm9p2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.202 (trex/6.7.1);
        Mon, 04 Apr 2022 02:12:40 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Squirrel-Illegal: 15baf8174aed050b_1649038359913_4204820175
X-MC-Loop-Signature: 1649038359913:79525924
X-MC-Ingress-Time: 1649038359913
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4KWvS52V9gz1Pg;
        Sun,  3 Apr 2022 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649038359;
        bh=q8qIRFPV0uC+cNYd2+NI4qePMQ25+vLbZPWX145AKhM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=aTQG7nTtIAP7LMjc1EnxQp+Cb/7FHha2GbO/Hdqix3QlxymEZg3dnu51UYOjKG1oF
         tiTsTmvBUOhz04yIQ6IlPHvE424INdbz4TGQIQq1V77N5ltBMD2I34S1aqbmOW9K3x
         PNIBgwO6w1HOyJXLFiHxnMwVSxxeywRieJwODkU8IohplMYY2QjBXl+Nu0oSfC8lE6
         zYUAk9SibWv7VognE5S267wYJ5C4WCG2uPRnDpo7b0/NugT7tH/z4YevvWs9/oQ5fb
         BPufp8RxGyitxEP32on6ArEjAZLheDFSH4zfwWQLo7lXRKc2Asp3USGaWi/jfMGJ+D
         8sbb2ZB2VpesA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net
Subject: [PATCH 2/4] cxl/pci: Use CXL_MBOX_SUCCESS to check against mbox_cmd return code
Date:   Sun,  3 Apr 2022 19:12:14 -0700
Message-Id: <20220404021216.66841-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220404021216.66841-1-dave@stgolabs.net>
References: <20220404021216.66841-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Also mention the need for the caller to check against any
errors from the hardware in return_code.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8a7267d116b7..8b131692ed61 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -177,9 +177,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != 0) {
+	if (mbox_cmd->return_code != CXL_MBOX_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error\n");
-		return 0;
+		return 0; /* completed but caller must check return_code */
 	}
 
 	/* #7 */
-- 
2.26.2

