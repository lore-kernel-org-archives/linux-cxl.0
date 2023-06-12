Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0390C7EE2F
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjFLSpf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFLSpd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:33 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B05184
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:31 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EE843141F7B;
        Mon, 12 Jun 2023 18:45:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A56AF141E34;
        Mon, 12 Jun 2023 18:45:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595525; a=rsa-sha256;
        cv=none;
        b=3UcSZhNbJ9sJwpf0KF3oiB5e+bHOy298+1iWKw9YUhqLqa2SozUdMR7yl8bqy1n4LE/zVQ
        vb65BfybGKB7XD/e5EUObBhMzZGmqTITAlwGsCkSLgC6ItiRiBxeqS/A+6mIeyv6wrJ/p1
        zoCqWq5gXkTXX2pu9epvNZ0d/IfSuUQaHEJTJUtQ28t8sPN9aCK22Bdu/B+FE4CzAVIf7y
        OvnLoIvdcRkCJQZ61g0NVOQ39TZlCenhdRBYWX2YaGkhEvtrc5ktqlYISLUoUQO4EW5dkp
        MUb7wSQEHmAdJjWR9y4tvL1QYtnmt77TdoC1748FLTQpQIsorkbAiyVJQigxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=SYR1NzqvlOdPtUIClEJ40zzrZ9ngdRKg2ieOzKpEG9Q=;
        b=gDxBQ/QB4sPt8fUSDLoZ3sR2GpWpiKChJ6HwjI5ngkTYWkY9Xpk5fZm0csi9TNtA+ggYoz
        TRH7gzoUspGj5FRtvtXG+sEq+V7J4sovkRFOCsuVlF4KaFTRRUkaFU84ose/0/UJYbxeiS
        PZHLF1qTuM0oECo2ybsTi4nJMXQDfDux1UGOVZev8tJgkdpVOpwv3M90SpEg/sG+HvXJdM
        TQqvhVa2le7e6dF1iXW/UR/2Z7ffAxuMq0vQrlobFsbvPQ4ahDQZJPZq0pQgk1/3SP/53G
        OOUYkRcQNhUVRRAkf2eBb01pMNEOhJiIXrY9QoVSLtmmg0Pvs9Rti++YMBTcYw==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-swvgs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Tart: 214cc1ea7d7e1892_1686595525985_1131337458
X-MC-Loop-Signature: 1686595525985:2382123884
X-MC-Ingress-Time: 1686595525985
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.98 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:25 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xK08c8z6Y;
        Mon, 12 Jun 2023 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595525;
        bh=SYR1NzqvlOdPtUIClEJ40zzrZ9ngdRKg2ieOzKpEG9Q=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=eCS/o0Ji3oTnVJf8sdgCCzFyjvsXfl06tbMsF+p44R6lS6Tc4/seEe0HYNKCN7y7O
         sxKobu0oD3cxatlT274jmW7XKGApZylHLVH1ec2/9PvC6Myk6uR61fbdRIguB6zpf2
         lhhlkBiSSgBYoE+I3ollGF/EYkkiNz/MwOXng4fw5TNONJLDnH7d5Llm67k5pggmP4
         zMPpeKAiZH5wq04BBExushEYt1keTabIcbZTkbANhwViThTILmMH5DW/RQno/pf258
         GhdT1eBAVLx/8T+EKnI0QHUFuy80bSj+dJCT78w+qq5GXtpr6CCna3ATTKpDxddmWN
         wvrVR9NmdxVeg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 5/7] cxl/test: Add Sanitize opcode support
Date:   Mon, 12 Jun 2023 11:10:36 -0700
Message-ID: <20230612181038.14421-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
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
2.41.0

