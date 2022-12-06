Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A612C47089
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 01:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiLFBPb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiLFBPa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 20:15:30 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E01CB1B
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 17:15:17 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B0ADE3418CD;
        Tue,  6 Dec 2022 01:15:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E12873418D5;
        Tue,  6 Dec 2022 01:15:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670289311; a=rsa-sha256;
        cv=none;
        b=N6mem2rGnyy4YLRrkVvxLculjyA5U07TvgCm9nPyY59rG65Zh67FNXDKzBEgY2pK75rrvN
        RtEhZxZ1EuWd9rk+nURl1WCh2HxwBcrTwAQqTR5ijYnnOhfAU6dayJLNYNkks/ogjGmCMB
        qJNUXWGgk2JXEMIncNnYckfrSLRcX0AG+ETUHfyXXMvf/vWdnVZzqtlyC/4QcGWJdrqUkp
        EIKfaA+FxYYB1wIlnRJgHDMeHqGIwwae84JeeoBI+7KptZAxl39zL0LCwzJyTp7psA/5uN
        /bkqSDVkwPxaFMDKJMOrx/pX5Jiqb7FCFc66MRFgi3hjKr7sNcrGeMKhrft7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670289311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=i7254630W1xZ8Zy4YPKxzp3ddRNgxWSvamg6mvTvkLc=;
        b=GIl5lmBSpHTWGo9PswepZEvnj4/nQD6LBIfSUakVdeRzDKWWuNBblmzEAJwyD7UBdeotEX
        nR4qzD3AUCh/ImHn0Fqbg4XPwDBPxAXnB4QWPZJEENWgsYm3SqofTlqtrw7o//s1X3iroo
        QN5QpgTgcpLVKogTJSGohSQg0LeNd33kSezwYCG9/NlLNT7xOURhhuFq29V9thu6MjHCUX
        GAz9jLhhEzbneJMaG3+UIwWUuV2HcsRUtT9Ty9FdBGH2fq3nG4ZUPd9XT4PWi0Q45K4yyr
        r6viCk3XwDcpo6bi92Zip1avL8Q2GNWKp/qG9VQZsApHU4BtqG8jzI584OCrWg==
ARC-Authentication-Results: i=1;
        rspamd-7bd68c5946-pr87t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Eyes: 33cbe8f94b467fd1_1670289314548_100064982
X-MC-Loop-Signature: 1670289314548:1616103490
X-MC-Ingress-Time: 1670289314548
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.39 (trex/6.7.1);
        Tue, 06 Dec 2022 01:15:14 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4NR2XG1n7xzYQ;
        Mon,  5 Dec 2022 17:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670289310;
        bh=i7254630W1xZ8Zy4YPKxzp3ddRNgxWSvamg6mvTvkLc=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=VlzxafB2sqKGAyZVzS3/z+UbdCcDW2NZNhdxupomG1evpnEYSeQbcM9En3awQPyuS
         9k8v5VU969RZN1jlKK2ywhjUJhmRhXVd9EXS/R0TLjbKbts3hInV75a8z3LTqw8C6W
         0vYgK5q/zEqSDLEhaoQzvOaOr6TfSyQ/tbUwKHsMoReq31Mf2m6dvQycHdKU4cZlbG
         rr+PJRwoPAF+8Y8gws0STLn+23X5aRxMOjq3BlgN201ORCTB6xAdQZ90rQIR2SWJZy
         LAekSWChu7lWO5GC5Xpe2WvEV+5LNi7e3ggOgr23TZlhUQlfRlTUDRMh/sVddkbMgd
         EJ+lfvjvVJAUA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] tools/testing/cxl: Add "Secure Erase" opcode support
Date:   Mon,  5 Dec 2022 17:15:01 -0800
Message-Id: <20221206011501.464916-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206011501.464916-1-dave@stgolabs.net>
References: <20221206011501.464916-1-dave@stgolabs.net>
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
index 35d9ad04e0d6..0f3101f65901 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -149,6 +149,30 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+static int mock_secure_erase(struct cxl_dev_state *cxlds,
+			     struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_platdata(cxlds->dev);
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
@@ -567,6 +591,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	case CXL_MBOX_OP_GET_HEALTH_INFO:
 		rc = mock_health_info(cxlds, cmd);
 		break;
+	case CXL_MBOX_OP_SECURE_ERASE:
+		rc = mock_secure_erase(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_GET_SECURITY_STATE:
 		rc = mock_get_security_state(cxlds, cmd);
 		break;
-- 
2.38.1

