Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54548EB64DD
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 17:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGLRTA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGLRS7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 13:18:59 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36C1BD
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 10:18:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5614EC1EEF;
        Wed, 12 Jul 2023 17:18:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 85D51C0C40;
        Wed, 12 Jul 2023 17:18:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689182335; a=rsa-sha256;
        cv=none;
        b=nYZ/DGWmfMi9nTRpCSEFmIrtgoNZEGXwVo5zvjXqGRPVMz6m7HPxidd5ddd8XYn1EGbt5s
        Yf7Luq+Wu2+uxj1X7ggFaLeIjmcjq1U+XLAMEMlE66frnv2bkY8Oy12Mg8gLy9Yf+ajBiS
        QzOW5cgJ/dKmX+QZBVBVn+chB33x0qnj+tlQmZ36bLLE8rmaH8t8649vTZotPcLmCCYyDm
        qUHQwVEB4SN17ueolXlM8OfwaGqPArclKPfWoXDu97jOxPL49EAa/J3UN9Ur1/Gonpfh59
        LC/dv3W6xRGAikIg8KYHfFcC9kD1wYB8lgabQt7GvHfZEsnokbYIrqajmPfxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689182335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=6hpiQ2toj2WymukXkVKZdIwKBjfjjV3j7k2TGFf/Xr0=;
        b=Sc8orQUcBwpN28QbANvY/5wNrGz9ISEeZRNr/r0et0zUkWFcazWWxmz+wsS2YRAQF9i9KM
        Y+ftFfOKTdCfDWhwOWWe8iiLejAK9aLeYE1xk1oHQJnLJt32KIs2BCRp0KY9+/JrhPCkZr
        gV4XyGQRzWvSWkBKetwtnThHhfqiPVg5OoJMoJEtFPtrtHC+iGH4B1glWKNqOjMYzINyRp
        B6XkZpjP6bFeLbq+9eDbYYlD4qZPh5fdUwp/EdCC+HXoBfaZCpqIweRmyqtuf0ATq3X7RN
        SSl0/mHO6m0iGF0N7Wjg6ux/BCM2vPvY4ewcnY4pDbyFbj1rTFoMZBZ1WrkjzA==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-5nmrh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Arithmetic: 05147d4c77f9936e_1689182335848_127243914
X-MC-Loop-Signature: 1689182335848:525139851
X-MC-Ingress-Time: 1689182335847
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.148.213 (trex/6.9.1);
        Wed, 12 Jul 2023 17:18:55 +0000
Received: from localhost.localdomain (unknown [104.36.30.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4R1Pbf3NFLz54;
        Wed, 12 Jul 2023 10:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689182335;
        bh=6hpiQ2toj2WymukXkVKZdIwKBjfjjV3j7k2TGFf/Xr0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=FuV1Iyf2ME+LdwZXhVjm2pPgNevq1pUR6gdwuXcmEg3WSg2FOXzrfOzkiTZXZAT3m
         tsavwcnaur6Dj69wQzElpA1TCirQo/7jpW4NTF96HG+4hKIIXpg4x+YAVDh/PlFc0b
         YzMdwIy0r5ODXhG4PGWirhIqzlhMQ5K/I/vTV54r8wLEiuki2y+eu2qfOzGDO3gXeL
         ST5RvXRnCaIqpMrqdK/5kZwcKwHRW4UZHQsgvj826H6c3NmADMS+8+3LvMHOcGFvUl
         mMf4LImq4W/CpIQZyl+E56rGw+TDXSQykkJXM4D27/krpBbBrHGY6xp3WlON9hRVPU
         zXO+bfxyB/EWw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, jonathan.cameron@huawei.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Fix double shift of CXL_FW_CANCEL
Date:   Wed, 12 Jul 2023 09:42:24 -0700
Message-ID: <20230712164224.31891-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Directly use the bit number for bitops, which already has a shift
built in. This bug is benign as its done consistently and it doesn't
clash with any other flags.

Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxlmem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..499113328586 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -323,7 +323,7 @@ struct cxl_mbox_activate_fw {
 
 /* FW state bits */
 #define CXL_FW_STATE_BITS		32
-#define CXL_FW_CANCEL		BIT(0)
+#define CXL_FW_CANCEL			0
 
 /**
  * struct cxl_fw_state - Firmware upload / activation state
-- 
2.41.0

