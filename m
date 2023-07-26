Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB187C001E0
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 05:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGZF6B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 01:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGZF57 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 01:57:59 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18D1995
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 22:57:58 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 77A6590182D;
        Wed, 26 Jul 2023 05:57:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0AD2C9017A6;
        Wed, 26 Jul 2023 05:57:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1690351077; a=rsa-sha256;
        cv=none;
        b=yLcCGw7ncHFav8TvchZjnXQbmw0rrQjqGkaBoXL91yjAks1jfmFgRTeVRs9yECLMPGoCNu
        QNT0jrxoiusfd00HuAV9Uxp1K37/w2XufIZOV7hxpE0J6cfz4bSyqAzZse/NLInenJFfQx
        XUwslIqGEMTFQxGOp9b9+RRY45Zlh1t3Eiya1DMHfLEROG7LxDMKhppu8TXXc96a087zkX
        QDdjrGRtF+ml3PpDJ5qTqrO8lgC3Ba8m+F4kkJppowfihfSj6sY5aPDB4bktEJH+Yp41Rd
        D6uWAnMXDVM2MQnq/rwkUEy/Sd0NtgkkYOysdtaCj+k+IR/4aBeGP+ksKOkPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1690351077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=H/9uORMFHViYZ/WYdnGZmR3jvE01Jxyrl5CczKfVeSg=;
        b=MaRYyZujLuz+Di8CI08Uf0edS4OR14IZ8TrzFxmBPYa+xYXG2Ga3H6g7zFy4MhbBlxHU1N
        z8LLDBLTewfmylMcg/NPgnnsAxK+uF+jBzznAcVbizIAAET7Xhhoe41/w49CLVjXT223kg
        NeFWulLzoGLF91BMkaa7YG+WBzQrYIz4v9f/9t4wJBt+wQhdwUuQv7zq5vdsl1luk8XWgl
        0MfvoSpmURiJtM76hSdq4hpGwHEri5bTcVEzYF5QewOkHSsH/Z8IliMUyoUCTs5CqgqM/j
        6oTNFBEzNUnhtVHn6vRHOMWcOul9TEv/GDurrLBFtKRl+s4mYeZiV3e5jsFhIQ==
ARC-Authentication-Results: i=1;
        rspamd-d58c88954-npfzb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Quick-Company: 7595139b01bd7fa5_1690351077320_1755573927
X-MC-Loop-Signature: 1690351077320:451146119
X-MC-Ingress-Time: 1690351077319
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.140.16 (trex/6.9.1);
        Wed, 26 Jul 2023 05:57:57 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4R9jqS25M0z1t;
        Tue, 25 Jul 2023 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1690351076;
        bh=MHABQArLBSm5wEdnmq0OIM2jYtAYYCtdeBpSn4U+Wa4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=dYxhRnoCEqmNLNMYIh0KU1SB1gdFmqroYcMoPfxHpIk4T0VaMZtcWFjbxvZ3RR7rg
         pX5Zp/x8l4Hu4+TmMO3QM6d5sXoIQ7TUv71MCqunF6tRulD5TG5lQdVH5w2P1zF5pI
         /jyf+1bMofVi/Hf2VhztEXLyzpb4cQywHip0AP04WI5AKLugjZTbvf+7IGPaPy+eBJ
         l2Ly+z6N8+CUvhtW7LeOMm5HGcypT7C+R7CtH78OQ6tKRXYnhiXhRA0FDwxWC59GTs
         gENSTrFKJ7kDXffJebd65ug7qLbqfrpUKvtHN+3I4yJZcwokos/OK0qNNxGp/R/Bp6
         8VrGFGf89Fxtw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, jonathan.cameron@huawei.com,
        fan.ni@samsung.com, dave.jiang@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/memdev: Document security state in kern-doc
Date:   Tue, 25 Jul 2023 22:19:39 -0700
Message-ID: <20230726051940.3570-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726051940.3570-1-dave@stgolabs.net>
References: <20230726051940.3570-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

... as is the case with all members of struct cxl_memdev_state.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxlmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 79e99c873ca2..083c6e58bc49 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -434,6 +434,7 @@ struct cxl_dev_state {
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @event: event log driver state
  * @poison: poison driver state info
+ * @security: security driver state info
  * @fw: firmware upload / activation state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
-- 
2.41.0

