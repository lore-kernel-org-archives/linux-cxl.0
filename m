Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED723C7EE31
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBXTrL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBXTrK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:47:10 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F286C198
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:47:09 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2010A502021;
        Fri, 24 Feb 2023 19:47:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 783E35020D7;
        Fri, 24 Feb 2023 19:47:08 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677268028; a=rsa-sha256;
        cv=none;
        b=X3nL9BUb/3JsEpxLlNflbob7AQP5z7E6cl204FLt4hdNoq1NySkE4GX96jeHOYVvWHkjgo
        Cewq9pDbdd0B2KHqq2iBXMEZUJfO4us5pVYtaFIh+u4sWgOSuhkHa6w89N4zyEVPwT8IZ0
        iV6QmhApOl/MW5Nh+Cd8u/z69t5lH3kW8v1Ab6Qd5mpN6+tjAqnmBQu/wxkwvubhSkq+ph
        NgFABD/3NzJeFloh34y6JaH2BX1IkAsbMMTqtohTCJfUzd8kb88jc1v+an1kduJsgBMJAC
        kHYhkQkU7cJ5Ohyr3w+b/71BGdKG380L+PzxHPnpCwfOIVtsHhtLfXxTJcPlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677268028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=V5tX9bU4PXyDcIBGDeJkgwU79PnzSt35DBkXyyj3TIk=;
        b=BXRikArfGOoS7k2wRtCqjrYmfs+UC7KjNwPFy0Xs+0KjXWDTn/wlKttTZXr/iV/cXB5c6/
        q7xsZODhAkMPi6pYyuAOgdupXQ0HSuX6fC9MxDGjqxsKtoEOEzlUfk/4cd+08bSY0XNx79
        fjCSYJ02rHcf6CTZgi2s/AH0AsuiPt9PxKYaGPlhaWWWlTlhAhMnsoZrEZjjY89JIIL4dZ
        63TR8hfoCt+7aBOV2CetAeLfTv33Cs7+uCE1svnrNIYcC8hJlZYpAVuJmIFJ9VqsJIze6p
        9oZH+BONv+rrTS8l/PQn1ee5eb6CZ32gglJSLbN6oqRfWLKLcdMLxXh9xVbtfQ==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-vj54m;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Cold: 5325c312441a9da7_1677268028895_479796182
X-MC-Loop-Signature: 1677268028895:2149259742
X-MC-Ingress-Time: 1677268028895
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.15 (trex/6.7.1);
        Fri, 24 Feb 2023 19:47:08 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgQM3FFSz2Q;
        Fri, 24 Feb 2023 11:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677268028;
        bh=V5tX9bU4PXyDcIBGDeJkgwU79PnzSt35DBkXyyj3TIk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=kRLJ/XO+IRyhFRfxOJC7dD0yp/YwVrsdH7GVz7QvPXn+Jebm1Q+L/Tnijp0dtVu7H
         VUFggEeKA1i1eR34AyqGjm492iLMEPDtNwHTtQ24mENbqYgpINdoKDtPPNarUmwiBR
         SPsm7+rZcAoyXjRKWbsUbdffFPa4l4Hecu/fBXCuZEdt9wE/7VUVN9IxKbzFsWRLjo
         cfSW02avLb9ALQakw8nJz8vbI+Ve0UKnJzaHdJ3yczeAfODRfipAH8aojEVYh+sqZM
         FF8Av0oMU9fv1NJARO5GFXDNAWyFmUs0Xw549N1EOndnBFtN0nGoVYfyAAuB8OSaKz
         zY1kkKuR8gWdQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH 5/7] cxl/test: Add "Sanitize" opcode support
Date:   Fri, 24 Feb 2023 11:46:50 -0800
Message-Id: <20230224194652.1990604-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194652.1990604-1-dave@stgolabs.net>
References: <20230224194652.1990604-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate a CXL mem device support the "Sanitize"
operation, without incurring in the background.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9263b04d35f7..d4466cb27947 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -497,6 +497,28 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
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
+	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
+		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
+		return -ENXIO;
+	}
+
+	return 0; /* assume less than 2 secs, no bg */
+}
+
 static int mock_get_security_state(struct cxl_dev_state *cxlds,
 				   struct cxl_mbox_cmd *cmd)
 {
@@ -924,6 +946,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_HEALTH_INFO:
 		rc = mock_health_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_SANITIZE:
+		rc = mock_sanitize(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_GET_SECURITY_STATE:
 		rc = mock_get_security_state(cxlds, cmd);
 		break;
-- 
2.39.2

