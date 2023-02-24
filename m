Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD17C64ED8
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBXTrO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBXTrN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:47:13 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292396C194
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:47:11 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5F80B200F97;
        Fri, 24 Feb 2023 19:47:11 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BC753201248;
        Fri, 24 Feb 2023 19:47:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268030; a=rsa-sha256;
        cv=none;
        b=uMO8i8LqTYXMMAgK0LE79KLpd0h1v1HatK2i/cRENtF9GJcDfSOKXuxBiRxpRy/F1rLCpn
        U4wktnbG7fVBx2R8yFnPGsUXGPAdz0pP+9mQQYeOZchcvGYwRbeHfA5OZPDXC4cfO/Gb8F
        y7150dNPx7F3fElM72C2PJedqI0PbvhNaAn2TNVh1wQ/z3hLTzyhg0WjoBpNUbJ5xiLzZF
        BdkU6tuHDZMbIspRuAsi1o1MQARYsAKedBuu46tXNxT9D0GQ5p62Vi8hkbgvbGtM3Vkr20
        V1Y8fcKDDDcUr2jey5HR/Oh8IKVL7tgSXeY4HUGb3OLygEkLlEY31YL5Lljvvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ankyqMP5oBsP3OoxQ0mKfhsnHGElQxwf0AyjpHp4i0E=;
        b=Um4qde9NRpKU0daFwyGTSZEpxcdu7hg2PJ1V4zDV7EnMKVe/g8SRtQXQwmA8iyQeXBGn5q
        1BlwEJZKXrDfK3PiLuClse+S+OjnQjqzKaPgcxlWTYL8KMtLBbnMrY2b9zdmLjYc9UUXPR
        f/El0leJhfFm433c7yk6fSg2fsBqUKcBVEcVcBri1PPvnEjmUCANGaTrAoJIelyAD8wwCM
        B4IVGd3P2HEs5jxzREmlzbQmCP+kouCkQXI6XWl1rasUjEWowoO8L+epuOTz9wfDbNeXHr
        B8MRY4AsTVukVVQ0UIt3yNiLRhHXiv73oI3WT+mM3LzfEIOLndEemsBpnsZtJA==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-c6rpd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Whispering: 371ae32d1a393fb6_1677268031175_819311173
X-MC-Loop-Signature: 1677268031175:2119673856
X-MC-Ingress-Time: 1677268031175
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.87 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:11 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQP2kLVz2Q;
        Fri, 24 Feb 2023 11:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268030;
        bh=ankyqMP5oBsP3OoxQ0mKfhsnHGElQxwf0AyjpHp4i0E=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=BIKI7cz6lAVA6Ti1w84JHLbQrGk6wq2RB0Y2xvgPhFUn/7dT3a13LINcPE19uXTxQ
         CceJiw04DXzbJidugodutLono5NsF1FZkKUhJTeAZ/m41p4DKEcF0ZHz38a/5I3Olv
         j6GKMkzUjsSTRAiZiQ0v6sgAsghhBina/AYtz8u5J7RAMxQEJuELYKgrr3aif8OV1E
         a+OpPwZV4FQEJS4oBStg4xxTQ+gf/a+AbY+APhui3pBEw60wSK4c5WAT0iY431x5Sw
         67fOj6PjOP5r7MkdGfefgLEM4A59YYot/EC1v4pG2Pg6OVCxRQYnkFI4L4kl/0lk4e
         7tOvg6JiZQPCQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 7/7] cxl/test: Add "Secure Erase" opcode support
Date:   Fri, 24 Feb 2023 11:46:52 -0800
Message-Id: <20230224194652.1990604-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "Secure Erase"
operation.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d4466cb27947..8a22a4e592c6 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -519,6 +519,30 @@ static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 	return 0; /* assume less than 2 secs, no bg */
 }
 
+static int mock_secure_erase(struct cxl_dev_state *cxlds,
+			     struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+
+	if (cmd->size_in != 0)
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int mock_get_security_state(struct cxl_dev_state *cxlds,
 				   struct cxl_mbox_cmd *cmd)
 {
@@ -949,6 +973,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_SANITIZE:
 		rc = mock_sanitize(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_SECURE_ERASE:
+		rc = mock_secure_erase(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_GET_SECURITY_STATE:
 		rc = mock_get_security_state(cxlds, cmd);
 		break;
-- 
2.39.2

