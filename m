Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B59C77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 22:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjDWWoS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDWWoR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 18:44:17 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412FE56
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 15:44:16 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 94728540C5B;
        Sun, 23 Apr 2023 22:44:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id EEB40540BAC;
        Sun, 23 Apr 2023 22:44:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682289855; a=rsa-sha256;
        cv=none;
        b=0bV0tBoQHISO3Hv/tiNRjsIORUWFt5+xBPN1jcCBbqnaYEtR1g7uRQxR5mq2efIUyMuOHA
        sF9qrMbiMX2GH6aoZP4d0MX76WdD7cioIwGzT1E1BAz7yOU2tUau9fqZ3WGMnXn04WpIX7
        s3mXSrP9OBje/ixMyEoxMJhnj942MyN5BmULthkOCWrdBNbqcaWZSdASNWundMEdwQeYk1
        hfArT1fGMTARKsLgcVPQo4dGBb4ejcxwoscghxByUlM/afNJLtPfc0hrgURDKJbhmA+ZmT
        k//a9Ohkseeh6jsbu75juPuwzIjDx+f7Uh3bZfU2RTu83cWTNLDdpLw1EMLqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682289855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=ODxX98x4u7wOzA1sJIyXRijVwHshQC3Clozws7Zx43Q=;
        b=eTcVXofr7DOIGJAsChQopjX9KXY+NeiSG6lozjf4s466lw/p9luWilXmBwekPH4ffDIH+v
        19KwZFc6v/g/9MDq9OeJL6CPNiF8YbqwtxeyH961RDIgfNV9Pki5zlrZDQ3z+nPwCR6dpv
        72kEXcdo8/XfzPhGMcD58BB40RX+/u+N1mj1eZfvnzrw9od+rZ5CSOZ3Mbk9KaEBYj+XNq
        4Qm/Qo9qzuA4nW2f02LzHFYO7ggXs8SpLtI12W77pSntkH7KI6I3824hGaadguoD6iMw+c
        4Aow055uQ8yhcpyuV6Mk7mqK9JW24eq5+KWH/OTCvDA/Lt3f4lQoDDq+ynvV/Q==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-cn6zf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Share: 2e0941fc0c8a4836_1682289855308_3558863119
X-MC-Loop-Signature: 1682289855308:1228113731
X-MC-Ingress-Time: 1682289855308
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.65 (trex/6.7.2);
        Sun, 23 Apr 2023 22:44:15 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4Q4Nby2R8Cz9q;
        Sun, 23 Apr 2023 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682289854;
        bh=ODxX98x4u7wOzA1sJIyXRijVwHshQC3Clozws7Zx43Q=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=VX7o5tuN//HUn4Ghg7yGSWeX7qKf/4oud4TzIyA+/8RN/qvo7b4KzeQv78eJ5JaHv
         qzcJxNLERlDuUA92qIR2cp6lUmx8qH8PBW4SI8cpycTK7TEy9IIrnGv8JCKSSnGVSt
         Ds5mFCV5Jrd9CbsRK2vlPpsAfOp8pM7nESEzJGbEZ4SuXi1pXSJpHDFeg/0GhJXxKP
         1hom3wQXg5m8zl89fIQMWQdKmQTTZHJVlGRDumwxwxqtNlBT2taDxibM1jwkXmhVYU
         E5UCvFYqjVopd8zx7kP6IGleP/VE+8ohfPpR+OSkZMGEqlD94RXx9Pt6jBHO4wx2PJ
         5Wd9ULXd95I/Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/test: Add mock test for set_timestamp
Date:   Sun, 23 Apr 2023 15:12:31 -0700
Message-Id: <20230423221231.6357-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Support the command testing in a unit-test fashion.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Resending as a new thread. Applies against 'pending' branch.

 tools/testing/cxl/test/mem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 0fd7e7b8b44a..ba572d03c687 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -116,6 +116,7 @@ struct cxl_mockmem_data {
 	int master_limit;
 	struct mock_event_store mes;
 	u8 event_buf[SZ_4K];
+	u64 timestamp;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -379,6 +380,22 @@ struct cxl_event_mem_module mem_module = {
 	}
 };
 
+static int mock_set_timestamp(struct cxl_dev_state *cxlds,
+			      struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
+	struct cxl_mbox_set_timestamp_in *ts = cmd->payload_in;
+
+	if (cmd->size_in != sizeof(*ts))
+		return -EINVAL;
+
+	if (cmd->size_out != 0)
+		return -EINVAL;
+
+	mdata->timestamp = le64_to_cpu(ts->timestamp);
+	return 0;
+}
+
 static void cxl_mock_add_event_logs(struct mock_event_store *mes)
 {
 	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
@@ -1103,6 +1120,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	int rc = -EIO;
 
 	switch (cmd->opcode) {
+	case CXL_MBOX_OP_SET_TIMESTAMP:
+		rc = mock_set_timestamp(cxlds, cmd);
+		break;
 	case CXL_MBOX_OP_GET_SUPPORTED_LOGS:
 		rc = mock_gsl(cmd);
 		break;
@@ -1232,6 +1252,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_set_timestamp(cxlds);
+	if (rc)
+		return rc;
+
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;
-- 
2.40.0

