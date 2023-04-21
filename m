Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D3AC77B78
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDUJz6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjDUJzt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:49 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855081731
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:42 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 3273354106B;
        Fri, 21 Apr 2023 09:55:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9C562541027;
        Fri, 21 Apr 2023 09:55:38 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070938; a=rsa-sha256;
        cv=none;
        b=g2M7Z/PcOx8XHKDjTKi6H2Bjw2aR2UoAfqeGfO+WRB2JDp90zZvcvvmmpgijNgMajA4FJs
        Qi3wR7C69nKPg6/mlDaM93h6JXMWVntqouzAevfHpPCTWAHbk1WI+Vux3k4fSAgvhVoAMe
        lBceTNOR/x+x7XKLKFnA69gIK0s3S3JOvApGiukxvF0wsswiRIPTQnZCfYzakm3W0gVq5L
        wZdxPPuuIxbtvuhmuG06ECE3zrZaHBRrNOxgRKg10w+PRH21ClJYr0jPimBTqpUMxQhbX8
        YkLIoXsAlropfdeYq9Bt5+Tl86kg/OHlvnfED0LI+cDp4FbZFZnldqbdKpkHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ZDPsBwrc50OjUFzXMCvacM4OJBMKw+QwL8oWaq3FOAM=;
        b=bjHW5esaXXF1G5h2VZJ07Wt2PLBseSREqIiDdLskZn2bZhOX9fBJayaqktQRJhZ36BIWAN
        Q5MUhzmUFbxgV85HvKVn4eY9V4hgrF8z8ewRbYR84y4I3wY0FfAn/MkA6peqsyMWLe/YJH
        JVvpG9Aj3h4c5w6ZuehLbFF1eD4a3git2NSCEEjGDIW0F5ma3j8MYfcgwXOPT+c0eF+YjP
        6atdlB7BmBUl8reIU/5shgQfSvSDPfjD7Ri+Vlqk+YRgkoXBjwkVOxTkIsOubknbXZ5iog
        mIlwgI1GxgCtZeollFhv8pGq6CH0fdfQthEEHtBYyxRaa7YFCV/DSgfKhqbSrw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-tqw7k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thread-Bottle: 6377929a453fcf26_1682070938980_1044007556
X-MC-Loop-Signature: 1682070938980:1159866529
X-MC-Ingress-Time: 1682070938980
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.53 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:38 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qf15cSGz80;
        Fri, 21 Apr 2023 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070938;
        bh=ZDPsBwrc50OjUFzXMCvacM4OJBMKw+QwL8oWaq3FOAM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ND/JrPMx+P8bVH9JF+/35h84ELD0OMO6H93hLSkhPk/AQ4H1N3LlEr8VDCua5CHs/
         GlD6tYsdNOXBi1sgixnFr8DS0xfsi5vcgoi9gxXhH3zNoKLig9CCsdD+xBRr3UL0pF
         1mDET3Y6I+9R+CqDVHldElTnK2/0RK/xpQEFQdE+3/VQCylybusG1B6M00E7DkGVne
         Yaxa/Gw2sxv74RZ+lXzMlfgmUdUkasiCGnD7J8i+zlVaqUBSM8vMTscFd7yeM6syil
         4SYA/1CvIL/TDxQbp7JPKZkvGVQDmdhTqpnpK6lELIT6V3G1FFRw1A5f+0WMF46ify
         +cCeS16qX1IDQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 5/7] cxl/test: Add Sanitize opcode support
Date:   Fri, 21 Apr 2023 02:23:19 -0700
Message-Id: <20230421092321.12741-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Add support to emulate the "Sanitize" operation, without
incurring in the background.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
2.40.0

