Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE2C678D5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Mar 2023 04:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjCGE4K (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Mar 2023 23:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCGE4I (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Mar 2023 23:56:08 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5EE34031
        for <linux-cxl@vger.kernel.org>; Mon,  6 Mar 2023 20:56:02 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1CD9F501A90;
        Tue,  7 Mar 2023 04:56:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A8024501649;
        Tue,  7 Mar 2023 04:56:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1678164961; a=rsa-sha256;
        cv=none;
        b=2V2O7Nco3h81n2XhZ2IxgJI4wco81Zko7Kpdf2OH4H1Mv/C1NP6krgi9kj3UARqWOaFA9D
        v5gcBQxnHmyTed3LGQHxnErJ7bPjtL23Emu+e+TnMz549Bv8igC3jEe+BFTNmFfwBy2GTv
        dHzFfGKjZEIo5ycF4ZosfTydx4GZn9uGo0V/Tgar7XMW+KFAOAsC1YhfJYhOGga9pIKDtg
        ZjX/CZ8XY5SlGSLnmeI/zuh3K4wW2i8OW5DoFxJ3lpENv9x6yRwrLIZ0l4ghOFC12XSCxn
        Zi1Qj4D8JiYQU3qpFUvsdA9FpWFvHz+61unCto16MzGGaR7KaVaKTch0cjsNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1678164961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=K8xoszDutUcKX9Vb2SsTixBDQdQKhdtua86xkGB+luA=;
        b=HQba3wcXo7xz29ZZsfiDvQVS8F/Cx0qwiZA/xCOfYQcFzNdUwMODJM7T5OrqoofskzEChP
        yGPiq7wBlLmMsC3vUmDfi0VPYcxKgVfQ5sHlVplbDpCJJCDSagMw583usxP3/84lmELS0i
        X2HZdhJrTlPhrITalUQCzDwQD+qoy+BlLFs58DzLx66W9l7lG4B1pwn1n4Y2SSP6K/JCmT
        PHwN8RRBCDUr1f4rBZkA75AmEtHZo0afmp11oLXcfUQOiNwtQV+U6xcHaHH91SuGI16I2j
        5/RGubT41CnF/01j8Gykf4CK4ba/JCKfDrjglOSv0Z3AFfSjLJF9a+OMcWCBJA==
ARC-Authentication-Results: i=1;
        rspamd-69778c65cd-q7bdf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Desert: 2059c8082c90daeb_1678164961943_3927840040
X-MC-Loop-Signature: 1678164961943:1546168559
X-MC-Ingress-Time: 1678164961943
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.140 (trex/6.7.2);
        Tue, 07 Mar 2023 04:56:01 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4PW3750YCfz2R;
        Mon,  6 Mar 2023 20:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1678164961;
        bh=K8xoszDutUcKX9Vb2SsTixBDQdQKhdtua86xkGB+luA=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=SobZv7Q70QGxCr4iR7LwM2J6yM9oQCyNsNAkv1bQ9g2RL7Jv7YFFRn6HXrYzs/AGu
         I98X1Pk3v/QCGZNYYBYMC/p3sEbiWL4nGBwvziZHNhVObxMfi7GTYt2TZguZDdQZnl
         k33EHAWIVszI09dvJK3HJnY+oYa/8s+tABagSLONGkF4iK6FC1YaCUn8/OCijfBdHQ
         QcV7Xy+UHg+oXtJlDyp0UmSe5jC8smZAlIGRCkp4Wfr6GOOG8zv8wixNMcALfoygmc
         ibFlbZDsherWQGLK8jhtTy+69C/xlFhmt9NOR12MEhdZHNSWarQ0sAEh1ny7HKbMsk
         qZ4wfF50jYosg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH] cxl/mbox: Update CMD_RC_TABLE
Date:   Mon,  6 Mar 2023 20:26:55 -0800
Message-Id: <20230307042655.6714-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

As of CXL 3.0 there have some added return codes, update the
driver accordingly.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxlmem.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ccbafc05a636..3e5ed04b9d6b 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -127,7 +127,7 @@ struct cxl_mbox_cmd {
 };
 
 /*
- * Per CXL 2.0 Section 8.2.8.4.5.1
+ * Per CXL 3.0 Section 8.2.8.4.5.1
  */
 #define CMD_CMD_RC_TABLE							\
 	C(SUCCESS, 0, NULL),							\
@@ -152,7 +152,15 @@ struct cxl_mbox_cmd {
 	C(SECURITY, -ENXIO, "not valid in the current security state"),         \
 	C(PASSPHRASE, -ENXIO, "phrase doesn't match current set passphrase"),   \
 	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
-	C(PAYLOADLEN, -ENXIO, "invalid payload length")
+	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
+	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
+	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
+	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
+	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
+	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
+	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
+	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
+	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
 
 #undef C
 #define C(a, b, c) CXL_MBOX_CMD_RC_##a
-- 
2.39.2

