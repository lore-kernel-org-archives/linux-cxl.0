Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DDC7EE2E
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEZEHe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjEZEHb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:07:31 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD213D
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:07:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 85EE11418A9;
        Fri, 26 May 2023 04:07:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E265214097C;
        Fri, 26 May 2023 04:07:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074049; a=rsa-sha256;
        cv=none;
        b=z6vDWiKDcaVDYrqI//UVwwB3nsxT0TKlpTCHUmPFPBiptK2GCnRQ5DJg8katk5xISFJHU4
        P5rCT7cvTMspzSrI0vs8vlrUtjZzeVVO+zjiYlZqLiRllLKXG/2ZdTmQ08GnAXTDlwArLI
        H0xe2L7RJSb591ZPPGyvE0xmMuQI5PMdgDAv6nzh9+wNmZ0RGy1CuLI8yCkwxdvCPyIZI/
        Tx29nnNTpK5+XREovq2lhuBfdUf2WjUOgwzyp18e9alSSlW5vJnAE8hZ78HnYwJr2OXq5r
        A4jkRpxziEbtu5v7PRwYqNHYjepB4HvGa3Gxs5jMywLdEBASz1kU4jP0u9Ci5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=5kFRLMZaWI3QVK5U9m8zFRl7JLxzfW57oqqEF93hP6k=;
        b=28VY0lUZdhXO6zi2A1O5UNu7U4OFfnYarKjeOw6qagVFNhPVe5UbXoUlirha5nLCpePI3m
        0NBYF5mAevIO6qTOiFVPo9CAh7bBDCTW9XvLKg4bDLdC7PvtjnELL9TYM65gJp7J5PrDPE
        9uHyBeA+2F5OsonOgmn4a2KgEQ4efxtYDpf/bAKYjAgqcwX97w9SMnNUVha2jS6fzimju2
        /b+ONaxtGiVtDsxdfVBapJqNthawPTRI6fuJDDDeUH12dEkwhmYBAqUXldQd0U0bSsvxrw
        3WT8p2l47RyGJeCfCSguSHk8bbe5mBJFsADx59TTakeyLPWaqWNAp4iKoMLGBg==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-vcjp2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Vacuous: 141864191ee87c0c_1685074049342_1439482764
X-MC-Loop-Signature: 1685074049342:4041502261
X-MC-Ingress-Time: 1685074049342
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.163.32 (trex/6.8.1);
        Fri, 26 May 2023 04:07:29 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBG81d70zRt;
        Thu, 25 May 2023 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074048;
        bh=5kFRLMZaWI3QVK5U9m8zFRl7JLxzfW57oqqEF93hP6k=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=XNm3NUEw1/75g5zxGLMu4vhED7+nydsOhG5ISXvWH9TxwKSCR3XJheDEFbXgr+4b1
         bvo1I7PQDEQZheUSeYNO7LAwqDlootN5zPlVIbPhqtxUW1g+zOKuptzvcLLs0VZltr
         zEimcPaSkCDf7ITuqjR2lkuFXjUBjGYXn3G41mlWxcW4saCfFmOlI1cNrDZ4zrIXET
         if5bh+FbLSF0Tu5O7VxokruOKQQC/BmTkFpjzyD2cc0xlY0t3BwIQ7MYsfuOy4gIR0
         G0I4p5IZawxemURkgH7fiI+KbiDA7/WK4tt8xLFJ2O12RjwkhPXbrC6usu5lM6kl67
         7p0SvXKXvzA4g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 6/6] cxl/test: Add Secure Erase opcode support
Date:   Thu, 25 May 2023 20:33:44 -0700
Message-Id: <20230526033344.17167-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526033344.17167-1-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate the CXL the "Secure Erase" operation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index faa484ea5b0b..97de0d3b2fd0 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -557,6 +557,30 @@ static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
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
@@ -1178,6 +1202,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
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
2.40.1

