Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF7C88CB2
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbjFLSpc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjFLSpb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269A189
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:29 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8DBC25C0F9E;
        Mon, 12 Jun 2023 18:45:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F2E325C1F5D;
        Mon, 12 Jun 2023 18:45:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595527; a=rsa-sha256;
        cv=none;
        b=uPhxwpRwPsIxm5QRY7o0jA07jgSEtAnCTMHnYc6HNvxHa8ASn/Ve4DXrQW3Git3JerHsSa
        vhWydEdAkSY0eUPIZaQrE6GVi/Jl/mFs1ctHXS4T9u5SGnVacaaLlfPPxhTFWct3WRd9/y
        loEvMewZD8qrXjsQb6+yql5AXUQa5OsX8ccMaVQ/qnU3gZwTMdf7hVtXGOuibtm3NHlm9H
        vB5WDqn1NrmK1mb/INn9okcdJ44MRPt4072CxvHppfPulhM34jX+mqI+0yq71FkVeW7/f+
        ZKMGq7sl3g3boESrpuqjZY9YunUT3iDvEmPEnrUoyr8PeCcOZeuyc0D3IFqjJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=L57OL2I0km+iVH2GRtjxDe9Nt335wagH+I9yCKu5UY0=;
        b=RRQiYraIzadg1EQj8CwGnH/flkwsi8PGAujjhwb+gmoqvGh6ElzirtgyVWMkDO3fPnlSHB
        GsPnVOxqQyvUilqcR2CFPMb1BRH7rnybeU7z7ed2fMU9ipJgfX2weplOclYlqTs8ihjkzI
        WWBq0KiPGz14LNIsTmtkuaZi2YFkScaOD4Xb3oYVwAMnDgWAIUvkZOohJp/k/3bXY/9KH0
        30OJCrUs5bXCAa7AddulgKLMgKr8Tep3XnV+SGymYX4051CCzXEjJ96Cr3QEQDETPnLBe2
        D7s9bwvckV3u8nxXusBC4Ik5+0/fOI4vsuYICLnZx3PEbPfo0mRYaixnU1kwLw==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-szjxp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Tank: 7ac5083a0cd34650_1686595527297_741114936
X-MC-Loop-Signature: 1686595527297:3373070763
X-MC-Ingress-Time: 1686595527297
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.15 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:27 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xL1wdSz63;
        Mon, 12 Jun 2023 11:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595526;
        bh=L57OL2I0km+iVH2GRtjxDe9Nt335wagH+I9yCKu5UY0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Gqv6yP5Uv5g8YOeF7jZeBWSiXu7bSlM2L8ApKtwrVHAGrOpPDhyQRFr7LKtmJFRCX
         ZiUmTP2Ztn4MIIzbf28JiSvpWDlRiC+l8c46PTb5lWhUpS1g1TXGorV1wbE8MXL/zQ
         rOL8uRP56NVJU1x8hY7qRI+KvBbfm5fGPJb2lU8RDR13Z2Y3K0h1oQfRK88+/eHLHd
         SpOfRuvekgpp5D6/o4/fiPUERRxhc0BLXBlXbLpkNMdJC0zr5KOZ9f7nry0DA1MVTm
         XGpXZ4IJrx1nqF/Yqj2daRaQ/P3VtZwYHpUOhLeMuJTLn8U6wd2f/JSeG4RfptkCEE
         FVB1mPGSkxzgw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 7/7] cxl/test: Add Secure Erase opcode support
Date:   Mon, 12 Jun 2023 11:10:38 -0700
Message-ID: <20230612181038.14421-8-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
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
2.41.0

