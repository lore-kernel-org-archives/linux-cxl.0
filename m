Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DDAC636D3
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 18:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjBHSUE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBHSUD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 13:20:03 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73E23C63
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 10:19:53 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A88F641210;
        Wed,  8 Feb 2023 18:19:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a221.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2A11B414A2;
        Wed,  8 Feb 2023 18:19:52 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675880392; a=rsa-sha256;
        cv=none;
        b=zDG6Eo8akf5kmP9YhlAcYU7EJFl82mDlWFOsHWvW+x348BmxEN4LcgbFI7fdXOdLnjIs51
        Vkr9YpqxWDYMj7A9rIlZ+/ZHxndQ2CveVFC2DpNezLk6GzsLoEwh5YYcff+AfOdrgVrlx+
        +bDV1qGZj8/1R31HQgE8i3vkWq6JziXyAOCOjvxABSw1YSj7yoJiTulOyBqoCdkrat/HgN
        Q0B/IlO925ponlKVFoVEnSR1jVEL4O1tnAsr+QyJ0IA9g0j1KjQEn2wB2NVLFx5NdOZYKo
        lnjQdgEILyerMqAKXy25FXwUNB22u0GzrhHdq+fCswKMEpz55OxuldlqBnljZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675880392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=xxUxYYHw/YgTO6eJDmqY26sR5Y9GqPwtdYGot8Bba+0=;
        b=9nppaOWgYIMNZImW+xpmFljYszNhrdFAuMnsmokI6WpDJqErmrQPETGZX2ogyk14rfILWe
        Fg4iqLdV0/6XMtymtKXnTxmuMdPAb8PnFnOegefchKRPccaeB1k/aMZ/3c8l5sswf0+OeV
        xbrqxE0JusdD9zcna8IxbUEcOc95MQPARgZxU46kSv0zL9NxYWhX711khbVIrMLOEathnE
        3CoBa6nhN4tZQT1qhdK7d6PxGEIxdxZyXe/2YmMzh4dpjjHuQqFb/M3gQojY1YbbXHi6dM
        UcM8hZHMHotrYwn/R/+dlN57s0/JoafCQ8pJMKoSVe31ndSF4rWHhMARybzQxg==
ARC-Authentication-Results: i=1;
        rspamd-98dc9695d-ck2tl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Well-Made: 43129bff2abcc16b_1675880392420_1076735980
X-MC-Loop-Signature: 1675880392420:2735452551
X-MC-Ingress-Time: 1675880392419
Received: from pdx1-sub0-mail-a221.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.196.238 (trex/6.7.1);
        Wed, 08 Feb 2023 18:19:52 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a221.dreamhost.com (Postfix) with ESMTPSA id 4PBpF34j8mz9r;
        Wed,  8 Feb 2023 10:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1675880391;
        bh=xxUxYYHw/YgTO6eJDmqY26sR5Y9GqPwtdYGot8Bba+0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=EDLgayY/BkoZnCZmAwxDWOXT0/NIwSVakunsX8JSngDWoUxzxPyRb733h1/tr7dUh
         W/Br0CKUZQY8Po2H9cqV6U5KtMSaBr2RxuB5uB/qn/IPjYu4fFNSRD8vqOfHwGebsK
         61ItWkrwd19riEUwOwnLx5kDiiU/v7bhR64sphEKMzUV9RK0GAcp1fv5RsmOEsyOeF
         etta2zWunsomq1BSO9RdufM8IYzHoOPvqtz4QVs3211FHoDC6n+6/jVp+/ZqR7gDe6
         X1eYYffxSDfAGNNSyDQwz52A0Pl4UHaWE4BbI7dgdihPvfTYL9MTBsJU7wwmKk5/nj
         NlTWPJLDwkWpw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH] cxl/mem: Correct full ID range allocation
Date:   Wed,  8 Feb 2023 10:19:44 -0800
Message-Id: <20230208181944.240261-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For ID allocations we want 0-(max-1), ie: smatch complains:

	 error: Calling ida_alloc_range() with a 'max' argument which is a power of 2. -1 missing?

Correct this and also replace the call to use the max() flavor instead.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/memdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a74a93310d26..12bd9ddaba22 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -242,7 +242,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	if (!cxlmd)
 		return ERR_PTR(-ENOMEM);
 
-	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
+	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
 	if (rc < 0)
 		goto err;
 	cxlmd->id = rc;
-- 
2.39.1

