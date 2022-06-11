Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E790C43334
	for <linux-cxl@archiver.kernel.org>; Sat, 11 Jun 2022 02:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiFKCLz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFKCLy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Jun 2022 22:11:54 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BD99827
        for <linux-cxl@vger.kernel.org>; Fri, 10 Jun 2022 19:11:52 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2E6256C1821;
        Sat, 11 Jun 2022 02:02:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id A0DAF6C178B;
        Sat, 11 Jun 2022 02:02:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1654912977; a=rsa-sha256;
        cv=none;
        b=6IceBlbpI29QcHf7l81dglQc3kVTnQYwl3pXNFwTquPX6aBUFkrnWBc6ZyjEJCIdMAXZT0
        42qJrzT3nSmU9zzdb+X1/D+U7rcEfYFZAGtem7X6kLMMJevSfeuOVne5QHo1kqHDsQnT3R
        SXXoGLIoqgbO7T4r0X5MKbgEtTNIb8EV12pp6We1lPEf45Xk7Pz2ypK0GPf2UkxdV7Apfw
        V2eWfJK0egHnJeBxpCi4x8z+Ur4tVQVod5nVa1GX9S0nCUp9Xho0P7xxPDXfuJTPsg+Mit
        XI7/YuoGZkYbStl1rwi4wpyiEvtVpKpkpj1XttUqhAiviNTnd3R1Au+07ZUGZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1654912977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=/EKdKMYQlkED0wOnzGNnwnCPCW0oniU3CZiV+Eb68zY=;
        b=sUaAq4ByS9DbcO37i0cP42DAtkG3ztrZAtmGgy6bAbOUtNz1h8DHQzHm4sUR4tw7R/z2uY
        prgfksGttApAfuRM9JIeKFehWyBTaO1IxeM4OFVkcZWKTYWS1YnW2D0jDZCcXAl7YS+1YA
        pieUabXWbxJVfHKOj71/U268ipJU9OmT+iOSTH91Sx2ib1YWTIHWvPrFafOHlasoK+HuaX
        exjn+UhAuiRi49JX/lYjaLtw4QaOsIiRNB1RAt1mY13g1+pF+XkG7hPL7O51g/eZLh0TuN
        KYd5MwozQflQG5RNvAxifC25x+7GvUeLXRcuAdVnJkx/8/x8w5TWse3g6sgEUg==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-mqmm2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wide-Eyed-Name: 62b98a9a178eda8d_1654912977979_400923136
X-MC-Loop-Signature: 1654912977978:1587980225
X-MC-Ingress-Time: 1654912977978
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.94 (trex/6.7.1);
        Sat, 11 Jun 2022 02:02:57 +0000
Received: from offworld.. (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LKh1X6kknz2W;
        Fri, 10 Jun 2022 19:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1654912977;
        bh=/EKdKMYQlkED0wOnzGNnwnCPCW0oniU3CZiV+Eb68zY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=dxEqCjI26GaFGsxkgBCadqrLK7MZlXuCnEzoDYj495HaKx7gquDHEjOXjUxWUCYmI
         aeSZT4tDf9Y3e2QCnFfr9nN1xkWKrj7VkVYjqD87tkOO95/Iv+eJGwxfpVMpS4RP/a
         ZCiW5aySICRx/cUFKi1z9IDRLxlntPIOKt4bc5oFFIM5iI1LrgUqFs7QvPl5VRbxu0
         Cnw0px3YUaAJisBIvSL90U6KB0OtYPwjYS7UFHxzDOCOT364G4r993vfY227k1HSOU
         ghVs0UVeLeLjrMXWtTxHW4D5HIxlBoaek55S0vk/dUInbPoXLZ8xIY6ZAoVR+fMKvT
         YSB0OoF9rB4Jw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net
Subject: [PATCH] cxl/port: Check for sane CXL.io values for device DVSEC
Date:   Fri, 10 Jun 2022 19:02:46 -0700
Message-Id: <20220611020246.140637-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

These must always be set in the capability and control words.
Explicitly check for these and identify any bogus setups
while doing cxl_hdm_decode_init().

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/pci.c | 14 ++++++++++++--
 drivers/cxl/cxlpci.h   |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c4c99ff7b55e..c69be8f120fc 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -367,12 +367,22 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
 	if (rc)
 		return rc;
 
+	if (!(cap & CXL_DVSEC_IO_CAPABLE)) {
+		dev_dbg(dev, "Not IO Capable\n");
+		return -ENXIO;
+	}
+
+	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
+		dev_dbg(dev, "Not MEM Capable\n");
+		return -ENXIO;
+	}
+
 	rc = pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl);
 	if (rc)
 		return rc;
 
-	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
-		dev_dbg(dev, "Not MEM Capable\n");
+	if (!(ctrl & CXL_DVSEC_IO_ENABLE)) {
+		dev_dbg(dev, "Not IO Enable\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index fce1c11729c2..845f59288dc3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -18,9 +18,11 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
+#define     CXL_DVSEC_IO_CAPABLE	BIT(1)
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
 #define   CXL_DVSEC_CTRL_OFFSET		0xC
+#define     CXL_DVSEC_IO_ENABLE		BIT(1)
 #define     CXL_DVSEC_MEM_ENABLE	BIT(2)
 #define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + (i * 0x10))
 #define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + (i * 0x10))
-- 
2.36.1

