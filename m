Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD47EB64DA
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Jul 2023 15:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjGLPo1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Jul 2023 11:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLPo0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Jul 2023 11:44:26 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4219A7
        for <linux-cxl@vger.kernel.org>; Wed, 12 Jul 2023 08:44:24 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 51F97141C17;
        Wed, 12 Jul 2023 15:44:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a313.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 57008140EF7;
        Wed, 12 Jul 2023 15:44:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689176663; a=rsa-sha256;
        cv=none;
        b=Jgv/+bFmHToGyLkV1ACc+SCoX+NN/J4wdVoVyIMvVHkcaoG50Wb24UGiPLCL53sdXd2S57
        /eRp1WGP9Hc85fa/aUojMZdV12tWKaN2eAJv8onaAgtLsAAXIPobTcs1rK3UKSsLixlpZn
        +nv3PAAiNeHdhiHJj8TzrYGyBzVBS8jMghs08Xnegvpdvd6ScUaWhV8M/TbGIZPgz0vtSp
        FasRvCURCC4ThJl/fiS+HPYt9LAvHt/wbdQQHNmA/nlEJOo45vGvsbwethKFnluc2ABURM
        RfjgK/5zEmo5DUS3UB8OtQ+DfePc2yGoCS7I2s6lzUiUJH+KtUT7pRhSK/oHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689176663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=+Nwv4OTPBGtVJOGjZUss1kkTgtXvLO9sCoJf9CP/d4I=;
        b=iQJWQHwwwQgm5C6vwX1RNN3XYJnJghnvJ03TV+mjeT+43neOZM7You30YYMwObeCvd1HpQ
        5mjDlTmzv/OZPZeHFPUbTiOxZ9HFuuHDdNlTGio0F+6rxwl5vMXcKLQer8EGDfWjg0xE9m
        eL3XpWmohlFf1Kb6PmQ7bZALxRAACy1kZo8fPBg+jObEh1KGOURmWRykdZiGLFi3ypVBYI
        398BBJc93ADhCouFHS8TqJxuWgtFBj4M5NSxSZxmnk9TsFSBpR4dKJjP417tB+zggSHTjE
        W54/4qowom2P2FfQQtbcUyj5pMhnI0DL40yjFen8rwjbMDLNzLJikxb5sRHukg==
ARC-Authentication-Results: i=1;
        rspamd-5595f87fc9-mg5xj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Industry-Abortive: 0fe5f76d2d4add6b_1689176663692_1982780177
X-MC-Loop-Signature: 1689176663692:2281207018
X-MC-Ingress-Time: 1689176663692
Received: from pdx1-sub0-mail-a313.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.231.136 (trex/6.9.1);
        Wed, 12 Jul 2023 15:44:23 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a313.dreamhost.com (Postfix) with ESMTPSA id 4R1MVZ3wjPz6s;
        Wed, 12 Jul 2023 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689176663;
        bh=+Nwv4OTPBGtVJOGjZUss1kkTgtXvLO9sCoJf9CP/d4I=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=Xac2o1tAXxdl90NExD+vEqduIG4kXuQu06QFaWQxpJVYbUjnDqQkw5y9la74JA2dT
         7HCEhWi1tkrBiVQFwoMs+3Wmzi335oE7Jg/t9/nkESS4eGlTJjHUowN2iT+uuXnGSM
         H3UHAzbPAPmNIJfvxUBrG+I0cIaQqLVaCxmq17AoSIrt7yer9LFFIlTB4ovMY2SvTf
         Y0dNIr3x89LuIqS9+qZH2ITrm0mXZ4hfbL88fTDyvRvDtG4Yd3qNRUApCN9ArJyfz5
         d0PtR6oMkKxLC1+/eoNXZZxSClb4H44fBjdzdl26q1/JvLgKu/oi3qfqbPn0AZEhrU
         PdRc/lzmuPBLQ==
Date:   Wed, 12 Jul 2023 08:07:52 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Update MAINTAINERS
Message-ID: <zlt563tl4efor4wixv37sdevqjdsasjousxj4aiyjbjqi22lyp@vxkgzu55fkmy>
References: <168911543699.1871721.9186039943252294173.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <168911543699.1871721.9186039943252294173.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 11 Jul 2023, Dan Williams wrote:

>Ben, thank you for all the work to get the CXL subsystem off the ground
>and establishing QEMU as a place where hardware vendors can collaborate
>on the new advancements and mechanisms appearing in the CXL
>specification.
>
>Jonathan, thank you for your continued review and collaboration, you have
>been a defacto CXL maintainer for a while now.
>
>Davidlohr, thank you for getting the background command infrastructure
>off the ground and your leadership on and off the lists.
>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Ben Widawsky <bwidawsk@kernel.org>
>Cc: Adam Manzanares <a.manzanares@samsung.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> MAINTAINERS |    3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 3be1bdfe8ecc..eba395274018 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -5140,10 +5140,11 @@ S:	Maintained
> F:	include/linux/compiler_attributes.h
>
> COMPUTE EXPRESS LINK (CXL)
>+M:	Davidlohr Bueso <dave@stgolabs.net>
>+M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> M:	Alison Schofield <alison.schofield@intel.com>
> M:	Vishal Verma <vishal.l.verma@intel.com>
> M:	Ira Weiny <ira.weiny@intel.com>
>-M:	Ben Widawsky <bwidawsk@kernel.org>
> M:	Dan Williams <dan.j.williams@intel.com>
> L:	linux-cxl@vger.kernel.org
> S:	Maintained
>
