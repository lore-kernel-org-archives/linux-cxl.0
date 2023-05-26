Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B5C7EE2F
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjEZEHh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjEZEHe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:07:34 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CB212F
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:07:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 02CC176142F;
        Fri, 26 May 2023 04:07:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7A8BC76107A;
        Fri, 26 May 2023 04:07:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074047; a=rsa-sha256;
        cv=none;
        b=z7Cl/se0ATLL0tVjaF4mDQ4iXpr0VhslkYDB/ne90jPzq2GcGe36Re7HK4NR40Rcq3CaAt
        ZKfdMD90f/3reycfkpdcH3DYJIij95xulkC70/5ugLrtvkT9y0+/20toTD4zWs8puwR9ZQ
        CsjzE/IgAklAfATkIRL2mvo+jd3GsacbVWjzBE1YKh3tBYRvjK2wLuIPPspYDI2CwL+qca
        HFwsj+JtTkG/hrUgm3SaEH4xrL19RkscSm2LtVlbBIJai0dEi4msv7zHj0MQgZR8dO77uT
        NlDjtzVWRn28JjzecjnFDawIY4QVYEYgnD+mFcNWda64smwpVbvR0U7n5uByWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=EzW8plH9Cn2oCq96jajWEloNSjbDvAL6TKoIJ9/5lqE=;
        b=9/6LnWpy59IwN+5hqJCht1bFQj4Z+0xj2CH6vHYe86lOolyaHXS86qkItSVtb/bdeJ+s4i
        7elc8eFxQcEtKQS06OEGLkiItmSepfkqr+hp515uLKjcQufSIt2wuMfaYRa6GDXAgfFZ56
        3nDNoEsdxIL7Q1Q1HEUnTK11I9RPytIImyqVqwaOXyl6t/0rUoTxPBLCrf5tJAdxipOlIL
        sltFd4HoE4kIgtiT/7i8hiHIVqOWn4sgdn5BoeF4xJ8xlSuRgzoO7JUi/pkMSBujcPKq/j
        8JO+fMBPNjD0EBySxgVQ9Sz3rhaYqltmXLxdOm2J8rEKL4rRM3lHydGLz/UM6w==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-8m4kk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Imminent-Tangy: 301fc9055c7e297a_1685074047795_3860556627
X-MC-Loop-Signature: 1685074047795:2832264115
X-MC-Ingress-Time: 1685074047795
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.127.59.37 (trex/6.8.1);
        Fri, 26 May 2023 04:07:27 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBG65rlgz36;
        Thu, 25 May 2023 21:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074047;
        bh=EzW8plH9Cn2oCq96jajWEloNSjbDvAL6TKoIJ9/5lqE=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=OntKWziWefy5oOwgp1p78TDXfP8mnZ0zbX71f1liWhGg2xfl9OLTanQAh+vRENGZg
         9yicYevJbFlHoPip9hi0YPdrwUGI0RtEqub9/YR8NZw2ruh2PybdrZ6ZkgRmqZFxU0
         x2CmY0Eq7OUdJOS1Y9sMrWfciWYhrNXd9gzj2K8kwT31ZmmktlUx7U5ajruVkUJ2x4
         4ALfwJ4VkAnWlL9n8T2dolUyLrl+LeGedf++dVLhTZFTPO3FiBbZ/gf+30MePOuE1O
         /klIXOTWChxMNqGROzVbeGKcu67moB8izTslLESiWHcBPEDrMjbWtJQercflHnu6Ag
         VA4hNBjn2qe7A==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/6] cxl/test: Add Sanitize opcode support
Date:   Thu, 25 May 2023 20:33:42 -0700
Message-Id: <20230526033344.17167-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526033344.17167-1-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate the "Sanitize" operation, without
incurring in the background.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 34b48027b3de..faa484ea5b0b 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -535,6 +535,28 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
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
@@ -1153,6 +1175,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
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
2.40.1

