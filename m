Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A3C433F5
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 02:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376885AbiDDCOe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 3 Apr 2022 22:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiDDCOd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 3 Apr 2022 22:14:33 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF5C35DE1
        for <linux-cxl@vger.kernel.org>; Sun,  3 Apr 2022 19:12:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C81102130A;
        Mon,  4 Apr 2022 02:12:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5EAE42149B;
        Mon,  4 Apr 2022 02:12:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649038357; a=rsa-sha256;
        cv=none;
        b=hTzImmG6iCu7smtfEL3ldyHt3mup9HJEwwuwyW2kWC5CTYopvvVCGqIIVmyGv8QCQ+G+J2
        hIxtGd4Ej989e+9iTgmEQsPh/P4bu0zGfJgg2Law5uDaq1YQP2FocEd8GxI7PlWy6TZ1Xa
        y7KJzKetx5k1xu4f2WfaEGWuHBgVmZ4/ux7zilWwYsfWA/RNU3JKI8xbVY5IJ3U1Zoa5pd
        Ip+QPEVKkHJuJaDfbzMImqMMm+6qyxFZB90xwgMzNC8TUt4hNrZ6wCnEIRZOcPciA0JDm4
        lBKMZHwToCGwBiUlcndNU7+2VzYtJYlCUszXOPUPT2AKbwdVhgJReAHSnpDabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649038357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=wv4wN/nk0m+YPlolNyZl3U5/E6F+TwicTHeK8Y/RfeE=;
        b=V+WC33LKxOUB0eVixUhA51p79aQJPKy3dIIrgtsaZyeaTlHd4tzBwEhuYafh18by04exmd
        fYYgANohvnP6N1ygVEL9Fx1bLAyg+y6LticbMZLNVLk8wGdyqXJn+wRiPAwRy28m3K9huw
        7fSHzRMwoqd7W1yZdcxOkPwW5SNk+bZAQmFN6S7Y+D2O5rgW19fDSidKBkoc/M+8Q4UEse
        cd+Sc4glciyWdIDPB6tC84lMnnqQqvtjEb07Zf0Rxp7Y57UtYqOVseGDzvsvIA60qNpSBC
        Nd0Ulr3HV1J2DFoRS+pviHl05O/KrkWZmaHKuuTm9gu9m9oCbvHAO3ynMXnu3A==
ARC-Authentication-Results: i=1;
        rspamd-786f77c8d-gmnn5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.255.190 (trex/6.7.1);
        Mon, 04 Apr 2022 02:12:37 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Share: 5e09f16367772c79_1649038357702_2074411280
X-MC-Loop-Signature: 1649038357702:813509929
X-MC-Ingress-Time: 1649038357701
Received: from localhost.localdomain (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4KWvS44GpBz1PZ;
        Sun,  3 Apr 2022 19:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649038357;
        bh=q1KueJT9ZPCMhsJeqyptOzpcgqykjfhziky16keligg=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=dZqDkr3ttJ7YEdoyVpuL8EWgL5P+MC0Gox5hXKyQE7qKoxj3FLCSCQiSS8ah7N+yD
         iIIb6du+3M1E8fYRg2xNnc9hAltH0xbWw0P6x3hlfdNoKtiC3eZqIipau6wrtFZN/y
         IQZYgYgK44wBDGf+/LlKWRIvpq32dM7LgAjrYQlR4Z8S/WVRdQUJD1lXTvggPbX7Co
         kfVys0GQhhZABm/KNi8w34aiTVKFpwtxq8CAosCvQ7Kt6ilNQ3NWXBBfFdoqFp/OQe
         eYrKfvzKoAhNB92jzUeaPxwh6DZv7dm/aAqxIozpaDDnKycPwyDbVphtKGLhYNL7dW
         1f4tlpVRN3R2Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ben.widawsky@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net
Subject: [PATCH 1/4] cxl/mbox: Drop mbox_mutex comment
Date:   Sun,  3 Apr 2022 19:12:13 -0700
Message-Id: <20220404021216.66841-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220404021216.66841-1-dave@stgolabs.net>
References: <20220404021216.66841-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

... we have lockdep for this.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index be61a0d8016b..a586c0fa9555 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -136,7 +136,7 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
  * @out: Caller allocated buffer for the output.
  * @out_size: Expected size of output.
  *
- * Context: Any context. Will acquire and release mbox_mutex.
+ * Context: Any context.
  * Return:
  *  * %>=0	- Number of bytes returned in @out.
  *  * %-E2BIG	- Payload is too large for hardware.
-- 
2.26.2

