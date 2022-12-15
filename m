Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525A4C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 19:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiLOTDQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 14:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiLOTDP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 14:03:15 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D9F15831
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 11:03:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A42F9761DA9;
        Thu, 15 Dec 2022 19:03:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 2BEA07620A6;
        Thu, 15 Dec 2022 19:03:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1671130993; a=rsa-sha256;
        cv=none;
        b=AmCzDI1y5qq1d//cUOZk++2rbN6w4HgkClcttXbud3+7jqGR9EtONOane5EeDpRcE6aUby
        sMQfbeWN0ZaZDIeRyJeeUrRb1i2+jjZ3s/DyewKC7KY38rPGCMhGXZAbNOw4I1nyNU/qcC
        m9hnLFhjCDhF6Qo4asFrCq0Z6mpOTHn/PFtF5nBn4RKxCkXR56yQKx+slBKh4whJQIYUbB
        2B6XlHE3e48Q1dBplQTMHnNpP1CAl23OEsMlrfBfst/Z0i9+DoAYHJ0Es/m5nGc8iFGtPc
        0wyGr+dLThQVPB6ITaZOzDpx1GYp8LqfIKjHmOyoaLRPW7YxyyM2Nl3z+pQkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1671130993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=+r8tJLyEOuMVUOiImkq8Jx2e57M/bsRFyld06qpYC8M=;
        b=d1zsF1ErfGp217fPxyaWv4V4qVIg+O81LU6pmz/C1wdC7aqwkZkp5tIZTbnxF8nBq3g1a/
        2aiNrKBlm7o7uYWl2+3bbcWdJmTZ+qFHI02uhIPcKxuCpRVPRW19MDhE2sZZ7mj1AxW0Je
        Km++zhAEzcz7I2Ej6e7T+Vb5DR5oXfN7aZcNa1uiHwp+vOfAQBBZAUNvYQIPtCNAtX4Hdy
        km1eL2uqJVvo/Ij/gwSk/8W3FZE8Zf+KvGysPcIE+FuUph5Vnx22Hrzb3DKmCgz6l1yNxY
        Y4gxHN0BRrbzzrIGB/52C1ulHHiiHX6Q7txzr4Gct0Hv0jvJitxuqcUhDiiJdw==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-g8cdp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Lonely: 462aad5464ffc1ef_1671130993463_1197704576
X-MC-Loop-Signature: 1671130993463:3090551336
X-MC-Ingress-Time: 1671130993462
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.43 (trex/6.7.1);
        Thu, 15 Dec 2022 19:03:13 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4NY1pS1NHCz4r;
        Thu, 15 Dec 2022 11:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1671130992;
        bh=+r8tJLyEOuMVUOiImkq8Jx2e57M/bsRFyld06qpYC8M=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ReAedZoAgigLXgHp3eSqza/YGRxSFk+Wh6BtBl7lywde5A1EiRph1Vow4nsRF53sZ
         4GQTbJUM9q6vbBjHFsaraOpjeHY9VHciSdHuo7Yb/ndw6FwEfArJHz8GjmrJaqFdGr
         rT2auGJ6xhoBhhyQH75HHjc4/VQP0JkWhla8XCeKsta/l0Cr5SFayyQSc3FNShLsAt
         dF2lS/rAw1PRQX2DqU7Xu1OHXL/OWtGyB5mhaYsk89SFdYw99DJLZzE5YZeq+38RSn
         WnE3ZFOKWfJjPw4zFTKr/h0s8I07DICrZen+obLJwy00t21ga1ikr4Y6uR0XxZodyv
         KRY2ob2tmVTzQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, mcgrof@kernel.org, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH v2] cxl/region: Only warn about cpu_cache_invalidate_memregion() once
Date:   Thu, 15 Dec 2022 10:38:36 -0800
Message-Id: <20221215183836.24136-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

No need for more than once per region.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 02f28da519e3..c11a6ab5e48d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1967,7 +1967,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 
 	if (!cpu_cache_has_invalidate_memregion()) {
 		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
-			dev_warn(
+			dev_warn_once(
 				&cxlr->dev,
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
-- 
2.38.1

