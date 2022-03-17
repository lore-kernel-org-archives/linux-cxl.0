Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB87C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 23:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiCQXmZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 19:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiCQXmX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 19:42:23 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39935174BA6
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 16:41:01 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E2A6F6213E9;
        Thu, 17 Mar 2022 23:40:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 130176217FA;
        Thu, 17 Mar 2022 23:40:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1647560458; a=rsa-sha256;
        cv=none;
        b=SOdQ7EaNRqiFK6k5tkBekpyNMu0hsYx4Q47xk95QpAmLdexwDyNO+x9a5tDm8u1OT+9Jo5
        o+V76NpnT0cA4WQfWCgqSPE/XbHzjjWuk3BawV+mFZt1BmgHkU/1dIAMREtQZyyO8mCVyK
        JcWe/cVxaIrTp1+Q3j8eRfkcUpDa4WKRlRqIRSIb7ailUgvIlRpOtBE1W0L81n6o6u7i/h
        r7LZBR6/WVSLTgtBLT8mdxU8eF1hfisL/tIbZ4I7RXJpwt/dsf1FOc6Rl7VKHLJbF3QicE
        /srmsDR+GU+tR78eDrSJpksQcGNPkVUBHvUKx6X+T49KoL7C0MZRZBTla+kjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1647560458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=7u6SLBHOxzczR8velHOksChPK96jmeJqkciQmedcR7Q=;
        b=5DqKGsANM/dJcriT79hGrHP5dQT3aNYZ5aV8eZCO3PcjWqj5+p+LpA2Kvg3ypcBCnmUSCq
        WpFhDC4Lw2feqqWxCnF8Qp7cxlsQ3QSCera8NKV8grG3xkHoWpamZMCY5uHgA5vJsaFsio
        Zhk/jcgGqn1Z5v/yNL1rIS8N8iKeog6hu23ymm8hgtRkpa7J2utjWqTI9KIUBjqZnuQJJs
        /e9NsVwdBpD54gEk6RwLKsdrylxBqHlwuP6VKki/dmGf1+MKOKIDTDsC3hUDqT83hQP6Im
        4AXYdj8JY+9APGLC+7FSCTFXGfAE7s94QsppBygZpgALRUSvP6kpa4yKdzBi2g==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-kn94c;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.144.24 (trex/6.5.3);
        Thu, 17 Mar 2022 23:40:59 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Shade: 6da52c301b533045_1647560459773_680018259
X-MC-Loop-Signature: 1647560459773:2814622097
X-MC-Ingress-Time: 1647560459773
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4KKNtx20tkz3h;
        Thu, 17 Mar 2022 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647560457;
        bh=R/o3Wa7CV1nyJi9TSaAyrkeotviZBwd03tMKWbujE6o=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=CDsIN/CpcgwhXwgRADycM1sgYfcwgNGrpF1FNbd2jU0f18VIObsHuaxWnalB6hoSF
         Jw0HCva9BoXyL2Z0s9YYrsrlm/ZlnEpw32W2UwZ3fwUa4pbdhWSSUjUvdBOqxyRyO1
         6RMXXpQD0cBzezg8ymA976Zr8yVBA74ZxgfVGtFAv9z65G092Cb86N2/aQa2cpn5gM
         B/EKDVkDPfbTdac5c3X67luHulRs7ipWfofcALWAWmqk7VdwL7rJR/UBlBbOGibXMN
         jcS+vd44PmL2XIVrXOMuENCQ3TVsZXCi6AMrBkZey4I7KPN/1RzBF3TDcD2eqldJfR
         Oeeu+vjzC3BSg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dave@stgolabs.net
Subject: [PATCH 1/5] cxl/mbox: Move mbox_mutex usage comment
Date:   Thu, 17 Mar 2022 16:40:45 -0700
Message-Id: <20220317234049.69323-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220317234049.69323-1-dave@stgolabs.net>
References: <20220317234049.69323-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

... this is better served in the callback that actually
grabs the lock.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index be61a0d8016b..778b04a0fb0a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -136,7 +136,7 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
  * @out: Caller allocated buffer for the output.
  * @out_size: Expected size of output.
  *
- * Context: Any context. Will acquire and release mbox_mutex.
+ * Context: Any context.
  * Return:
  *  * %>=0	- Number of bytes returned in @out.
  *  * %-E2BIG	- Payload is too large for hardware.
@@ -165,6 +165,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	if (out_size > cxlds->payload_size)
 		return -E2BIG;
 
+	/* acquire and releases the mbox_mutex */
 	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
 	if (rc)
 		return rc;
-- 
2.26.2

