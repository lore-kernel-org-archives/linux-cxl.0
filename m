Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F0CC7618B
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Mar 2023 17:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCNR6s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Mar 2023 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCNR6q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Mar 2023 13:58:46 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE2762DAE
        for <linux-cxl@vger.kernel.org>; Tue, 14 Mar 2023 10:58:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 6EE3D8213EB;
        Tue, 14 Mar 2023 17:58:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a205.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 929D5820E0F;
        Tue, 14 Mar 2023 17:58:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1678816717; a=rsa-sha256;
        cv=none;
        b=ytjWoIkNOYfmhd7dHzeBYDcmtkS2367nyydoyMX+2Q0wWtOMF6Ndk1yVr/59kPwvSdfvSx
        biJz76os8Q/YvJMQ/vSH33hI99sf+gzGCkynd+I7uxQkYJVSCQdWW1fyeC4z4sbra3rtmh
        68GMjhEZcMFkc+OypHy8hwZ6/mFC7x2eAeuRmoEng9WDAmW/yxYLQq5kX7tewZLCzZnqjH
        70jbw+GerzDgOrpyU+QCXaUS1GKreoUKvFQwc74a0yrCo0C0z+e40RntL0dStv90tDkBDO
        AXjbfQLlWZSJmCrM+B4G56hRZXuWBW/zNCojf4xQT36z8UYzQUVVt11iNLbpJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1678816716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=PBSG1Zl26KdnK1pAiHWRiquRq4r5wjXZaWJGSKlBSig=;
        b=DpvTt+xVmV9EgkLvdOoY2dIpNQwzsJm1yLndO3DuHNsnvEK7D5mARD1GN5mfW/SmWoeTOW
        5GK1DyfjMmbgf0iwZwJvlWQmgndNbDusFU8MYVWA+PSEM3en9r2PKBVixAsO4GK/xmJPj4
        HV5tHNIPN02ODXHCII9X9kms/GcUgY6AFpui80KfRPq5UQwPtRq/lxJEiMTy2vwWUcztRz
        tfMUdKSleH2hv2WHU/FqXhDjI31egrKlKiErVxLEoUXs2zON8cqeps2xqpIap1MfUt/Dwp
        Vp/1C/d1jUWfMDgFjyPZeZ4IaPoX9DvjRduKK2jcqaUHFpKvZVGQrULGdVgs0Q==
ARC-Authentication-Results: i=1;
        rspamd-7b575b84b5-n8p2r;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Fumbling: 04095cc27bdf7cff_1678816717218_1920933532
X-MC-Loop-Signature: 1678816717218:4186272266
X-MC-Ingress-Time: 1678816717218
Received: from pdx1-sub0-mail-a205.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.117.156.54 (trex/6.7.2);
        Tue, 14 Mar 2023 17:58:37 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a205.dreamhost.com (Postfix) with ESMTPSA id 4Pbh8q4CcNz3Q;
        Tue, 14 Mar 2023 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1678816716;
        bh=PBSG1Zl26KdnK1pAiHWRiquRq4r5wjXZaWJGSKlBSig=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=RRWHyJJVLkPIb7jQbfdDT/Al1csF5b0tNCh2Nu3juOveHUYP36WauTgkJeeBNmOm7
         7MQNalH/1Toq6H9K4LhXVPr7EEFr5uqfiOkS0uQu9xXgpif1KJ3V1G2oo1Wve3uWOa
         otzwKxdOumo63CnWpN7UIxXgqxAE948YhO/4CM4EXZj3NU3YH8k7PYgaAwcbutG9IW
         YC+KI4VHY4/rJ25e+sAHDj71OHfbFbKmL5gTY5O6ycKaVMHjQpdBOgt8NosthHYO15
         LuCO0XXxXnsanXnYXuGuAZwXrNiF6rMU/5WO6rR8WHFbGQsm+2Mr7cAqLje+0q2y2Q
         TDNVnBxolgcww==
Date:   Tue, 14 Mar 2023 10:29:10 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Fan Ni <fan.ni@samsung.com>
Cc:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [qemu PATCH] hw/cxl/cxl_device: Replace magic number in CXLError
 definition
Message-ID: <20230314172910.eidt57homgiytpsk@offworld>
References: <CGME20230314165324uscas1p231d1f8aeceb1b8c118abb76e915e7614@uscas1p2.samsung.com>
 <20230314165317.1550986-1-fan.ni@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230314165317.1550986-1-fan.ni@samsung.com>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 14 Mar 2023, Fan Ni wrote:

>Replace the magic number 32 with CXL_RAS_ERR_HEADER_NUM for better code
>readability and maintainability.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Signed-off-by: Fan Ni <fan.ni@samsung.com>
>---
> include/hw/cxl/cxl_device.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>index d589f78202..34fde62eac 100644
>--- a/include/hw/cxl/cxl_device.h
>+++ b/include/hw/cxl/cxl_device.h
>@@ -235,7 +235,7 @@ REG64(CXL_MEM_DEV_STS, 0)
> typedef struct CXLError {
>     QTAILQ_ENTRY(CXLError) node;
>     int type; /* Error code as per FE definition */
>-    uint32_t header[32];
>+    uint32_t header[CXL_RAS_ERR_HEADER_NUM];
> } CXLError;
>
> typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
>--
>2.25.1
