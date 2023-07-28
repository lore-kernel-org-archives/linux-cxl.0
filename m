Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA7C001DF
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jul 2023 17:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjG1Rhm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jul 2023 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjG1Rhj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jul 2023 13:37:39 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9683C30
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jul 2023 10:37:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7A3C2502CFF;
        Fri, 28 Jul 2023 17:35:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DBF87502CD4;
        Fri, 28 Jul 2023 17:35:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690565712; a=rsa-sha256;
        cv=none;
        b=cCh7CJPdY1zHd5dOqwg0JtAcnTFvOtfU988N638YSlEk803sy+QB7bIdNk/mmmJDZDhReq
        RFXUfQGmT+SWzfoH+Xe4ArkEhg6ZwcWPqfN01VTcaoWvbmdFZ1oUMBnst8khGbZevDwnPD
        tkS4j3oCmy9eGqfxYQe9+Eu7xc0lTx+a2PRhZmv5GVCR40l8GwsCPkktA2rrxVIZ0bCABC
        OSwezPRApNv9bWBXKaMidj1ocavNVX5nlg7fSqmn6B/5O+44cLtyJMa7ju7Lm5NRW06sod
        nGP3e2QOcdd0yyX12/jDmXIoj0SIHyaOEB37Lz4R7MJzjigb71vpF+58nHz9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690565712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KCvhQ3i3Hb+0Sr7NgbYrw5C2Gh06Pq0WOpp19yOEohs=;
        b=GwOD90nCP7NnBbDirIhtSGS27pCj8ysD5e2V6I7Rx2bdzXPf0QbeO/vpp8Tz0JgQDvDvtP
        S95WkbEfHeYZK2y6blTNullAJIRC9QZQ1J3WBycbmhqCzGBanflI5eaxBalRaSL4vHotBu
        kRmW8nA7jXt4VlPASZ4LzydP00eb1dsblW52IKaBkMzusKOIGjI5BqtIyPOUKIlRKfRq7+
        Rzwan/j4DpSl+0osNnM5NjAlP4NEo9kH1pVmNHOV2osUvMCpTVl60Ixh0XM/FdY029XD2r
        8Vu1CMXiVhwpq7KHdtzW4y+gX4LdCp+pe8M57Meo9PeBPo8rFDr1najiXHdqFA==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-mxbjj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Bored: 31173d9b4b553cc4_1690565712311_3673145438
X-MC-Loop-Signature: 1690565712311:4219711277
X-MC-Ingress-Time: 1690565712310
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.0.198 (trex/6.9.1);
        Fri, 28 Jul 2023 17:35:12 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4RCFC32hhrz4T;
        Fri, 28 Jul 2023 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690565711;
        bh=KCvhQ3i3Hb+0Sr7NgbYrw5C2Gh06Pq0WOpp19yOEohs=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=jFNKBfZtpe3A+eWz0drIrJv1JN+yRosQCZ/KdDu3D7bf5EwOJ8dz3C8CfEt4bx0FV
         8FD7cfFRVkIHXNDPLgHVT6AwrzVL5ohRCHP6oLryLcPJzapkq6hbpLz1Y1wLJjhXfo
         kiWLXTbpoP8Sesy4f81CkkkDPxwUtpw0onw6AWDnBwLqTVWB3mLKPkFuFn7BoiVjI3
         cwVSp5pq/1r2MH0xiKLwsP99dwQm3xYRZdKgTeoS/BJWukSB9uwg5euahtGugu61jW
         RY8KlisonXSIyOcrbl5zr2xw/EB6yTrWjAwJqlaU/7DzRvP3zqO5H4zO/qzWjxEDlH
         fpgONfwp5XGdQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] hw/cxl: Update comments for Get Log
Date:   Fri, 28 Jul 2023 09:57:04 -0700
Message-ID: <20230728165705.5889-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728165705.5889-1-dave@stgolabs.net>
References: <20230728165705.5889-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The current notes regarding some of the literature in the spec
no longer applies, update from 2.0 to 3.0.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2819914e8d09..5152a83c6fdd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -608,7 +608,7 @@ static const QemuUUID cel_uuid = {
                  0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
 };
 
-/* 8.2.9.4.1 */
+/* CXL 3.0 8.2.9.5.1 */
 static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
                                          size_t len_in,
@@ -634,7 +634,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-/* 8.2.9.4.2 */
+/* CXL 3.0 8.2.9.5.2 */
 static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
                                    uint8_t *payload_in,
                                    size_t len_in,
@@ -651,12 +651,6 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     get_log = (void *)payload_in;
 
     /*
-     * 8.2.9.4.2
-     *   The device shall return Invalid Parameter if the Offset or Length
-     *   fields attempt to access beyond the size of the log as reported by Get
-     *   Supported Logs.
-     *
-     * XXX: Spec is wrong, "Invalid Parameter" isn't a thing.
      * XXX: Spec doesn't address incorrect UUID incorrectness.
      *
      * The CEL buffer is large enough to fit all commands in the emulation, so
-- 
2.41.0

