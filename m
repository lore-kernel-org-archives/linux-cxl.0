Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABE4C001DE
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 05:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGZF6C (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjGZF56 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 01:57:58 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A01982
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 22:57:57 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D56DD901627;
        Wed, 26 Jul 2023 05:57:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 47AFD901A01;
        Wed, 26 Jul 2023 05:57:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690351076; a=rsa-sha256;
        cv=none;
        b=xhGp/WVXhdVLh5XclRqu8Z74vYyOOudbesYOxqsyZVN1OHDJnXW8h050RuzxLQmZIUZ0bv
        a12ziNDdRxl7FmfE2+Mo0fIS46Z03sqBV75+BkQRrLwwYAqpEXgrjxq0vaGP8Y/gpIdmru
        h+DlbTEHVg+mOfQiunSeOlcGURYGRCPiEf2COVSXSLJpZs6v/92S4y3DBzs00T7fnmp/4Q
        ovTxtKelUHTpeizBEu9diXOQu93p4gOQcPG53EHCdmHUBB/ZA2HxYiCJKcIX0ilPHyX4iA
        UEfOcG1C9gPqpD+shlAhW9dwtqolIGo10Ngir10eNRghSUjf9dprhL4CVWQabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690351076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LO8JD7Nln053u2c4qsQ3BL9S5JIJlz5OVQGPHXKevys=;
        b=MOQpDMeo1JwW+kexvq3DFUBp1T/aave/Wop5xXP4iXjgfnP4T535SiZ7slTtxd1qHGsxW+
        MoW+RFapJFdfF3fkE1uMMM279oFdMIFpDmx6ytQFdEod9rxCTfpLiPDoPjwBRGPpgwAyM1
        J2Aejt6srSLr1w5IR/lBbNUx+5+u8Ac9Ld8PW1eBLXIovTGTZCIv+h3EO0sE/stuvr0DDF
        FSbpR49dU2LkLKHdweWkKmQtL30HNJJhAUCIhHVvw8GMpr/xAXHc4lPi54bPyqncfTB4Ux
        PW5YkwKR5W9xFGIt1WqQ9TYu4JkgzhRYjVMOaOLACwD3lmLA1/OXfTV0zONJjA==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-npfzb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Occur: 6d8771d321d79e81_1690351076699_4274607401
X-MC-Loop-Signature: 1690351076699:1478576246
X-MC-Ingress-Time: 1690351076699
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.140.16 (trex/6.9.1);
        Wed, 26 Jul 2023 05:57:56 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4R9jqR4KchzY8;
        Tue, 25 Jul 2023 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690351076;
        bh=LO8JD7Nln053u2c4qsQ3BL9S5JIJlz5OVQGPHXKevys=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=X9+X9ue5npshGd1sDbBhDeO9feFae+S0Fk+KwFscRmkMGcREELis1cda9Y0ITaAd+
         sCIfPPkqfFXyzkt+NjPPMGm0qcoe+NZDnX4E0ktHPqLghJmFN8c5UpozxbMLe/FC4d
         d0BAKm05Z8i47yb6FMTlkzc0bU0/VoPAhJrdjXU5EynyJCIw1PRa9DwhLetS/3rP7M
         j1NqK8S83SYSSh8OO1lziOTh6rGnvA/YO+YKx8xD5Y94JsaPgi3vxABY6xM+rLHNV7
         WCmaQiJUJwFOAoW0EzuuxfQGDARCwaNmXfUBBWoxvgxR5kfAgtKpAff95Gy+luS+3g
         ent7JM0afg/6Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, jonathan.cameron@huawei.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/memdev: Improve sanitize ABI descriptions
Date:   Tue, 25 Jul 2023 22:19:38 -0700
Message-ID: <20230726051940.3570-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726051940.3570-1-dave@stgolabs.net>
References: <20230726051940.3570-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Be more detailed about the CPU cache management situation. The same
goes for both sanitize and secure erase.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6350dd82b9a9..c4c4acb1f3b3 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -82,7 +82,11 @@ Description:
 		whether it resides in persistent capacity, volatile capacity,
 		or the LSA, is made permanently unavailable by whatever means
 		is appropriate for the media type. This functionality requires
-		the device to be not be actively decoding any HPA ranges.
+		the device to be disabled, that is, not actively decoding any
+		HPA ranges. This permits avoiding explicit global CPU cache
+		management, relying instead for it to be done when a region
+		transitions between software programmed and hardware committed
+		states.
 
 
 What            /sys/bus/cxl/devices/memX/security/erase
@@ -92,7 +96,12 @@ Contact:        linux-cxl@vger.kernel.org
 Description:
 		(WO) Write a boolean 'true' string value to this attribute to
 		secure erase user data by changing the media encryption keys for
-		all user data areas of the device.
+		all user data areas of the device. This functionality requires
+		the device to be disabled, that is, not actively decoding any
+		HPA ranges. This permits avoiding explicit global CPU cache
+		management, relying instead for it to be done when a region
+		transitions between software programmed and hardware committed
+		states.
 
 
 What:		/sys/bus/cxl/devices/memX/firmware/
-- 
2.41.0

