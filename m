Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C56EE57E0
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 07:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbjIHHcJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 03:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjIHHcI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 03:32:08 -0400
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43CA1BD3
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 00:32:03 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A6BB7361A1C;
        Fri,  8 Sep 2023 07:31:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 26EFC360E9B;
        Fri,  8 Sep 2023 07:31:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694158319; a=rsa-sha256;
        cv=none;
        b=s2dZW0awDnhcMLM8Dn1RrP4AdjzVQyXluh+HGDMkxXY1avPZOHBWtoq8q059muazb5uA2X
        K50+pZZv/0j4PUz/GkosuW0K0MAZEv8OIZiGHY/gdoNLg1slKjaojgEOZx+cldF5a2CPBh
        If+jbGTz9bCceKUdguFAI0HC5eL9rsfhNkz1XTRSO+Yo6E+YbXz1lRPpgJvD65GMWxQV1k
        px7EcpsJQyZyA8fpXCvJQ6IrQ2LoAMgpjh1bzU8IcpHCoL+GSopjBadhFpGlgzxzBymS9B
        dtlm6avLiK60W9Af3JjqAfhAbAWC30Zbq1aWGPCSY+cORt4yhLjJkDbLrvuMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694158319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Qogp6aNolSnF4EAdV0owZ7+CrCP9RfrgmImKZcsyo4o=;
        b=H963Wu03kQith8QIl21RsijOOPxYdMONUuXfUwSvogmQnNRlsgEVcQb90fvRMVp9nQlYQl
        pQQQ9PF209UJFqdrKSCnUJm1hqJ0d13O9V8vrwZ+bNvs62X4xRtJoORsTSrnjat8pB3N+q
        V7MCn2oNZ2gDewlVgx+KI0AiLIf80DVFr2P/nmZVmSYrSZD34XwX9N1IVzA8NnIt7KtcIn
        d30kaeMJlAO69uK6H9tPwlpjko5p4A2LuprOVIYGZNrtaU/VJuaiRFc+yHvKjEb9PUEwb+
        l+ZQG/l6vihdfKxC52rT+gch53RjyP+EkheITtK+6JSaHV8d7UMRm0jnOAMXdA==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-b54zv;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Bored: 255b3aee62f8d860_1694158319479_1383069635
X-MC-Loop-Signature: 1694158319478:3812799854
X-MC-Ingress-Time: 1694158319478
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.191.91 (trex/6.9.1);
        Fri, 08 Sep 2023 07:31:59 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Rhnqf2wxYzM9;
        Fri,  8 Sep 2023 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694158318;
        bh=Qogp6aNolSnF4EAdV0owZ7+CrCP9RfrgmImKZcsyo4o=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=dp4lRInDu6/aL10YS59LxPAuoxcVirY2Psx09aMb+dfVHLQF/Wn04EWBtUtrCEc14
         kaD/bTGpbCLFgQRWKzG2uLXTbJFeIrPVhGXGzkSZU7kcUoPCzRR9Iw3LyILo91MIx9
         C/RSYjl9AZtGZZ16q1Ki4snKVN+SeCyp1L8ZF/gAAY6HuTB4VEuQqm90BRF3hQx6uc
         HzXgJWZqddYSxM1OMxyM92As7epnwpnOikcFkjHLwlk+v6LRb1yq8O6Rj+2dnwWwWx
         +SHFZ9bbqCDY8XNN/G16Qyuek2AYS4D27Xc2FotcNkO8wyhaZamsGACirlgyzJxmfF
         WLQwooHC8uIQw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     fan.ni@samsung.com, dan.j.williams@intel.com,
        alison.schofield@intel.com, ayush.m55@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/4] cxl/type3: Fix crash in set_cacheline()
Date:   Fri,  8 Sep 2023 00:31:49 -0700
Message-ID: <20230908073152.4386-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908073152.4386-1-dave@stgolabs.net>
References: <20230908073152.4386-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Use the correct vmr_size, otherwise a clear poison operation, for
example, can crash the emulator.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/mem/cxl_type3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index fd9d134d468f..b90a7397d62f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1417,7 +1417,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
         as = &ct3d->hostvmem_as;
     } else if (dpa_offset < vmr_size + pmr_size) {
         as = &ct3d->hostpmem_as;
-        dpa_offset -= vmr->size;
+        dpa_offset -= vmr_size;
     } else {
         as = &ct3d->dc.host_dc_as;
         dpa_offset -= (vmr_size + pmr_size);
-- 
2.42.0

