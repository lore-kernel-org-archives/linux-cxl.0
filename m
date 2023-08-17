Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097EBC3065A
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Aug 2023 15:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353320AbjHQPtj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Aug 2023 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353325AbjHQPt0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Aug 2023 11:49:26 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9F930D1
        for <linux-cxl@vger.kernel.org>; Thu, 17 Aug 2023 08:49:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E16B3941379;
        Thu, 17 Aug 2023 15:49:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 682419420B5;
        Thu, 17 Aug 2023 15:49:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692287364; a=rsa-sha256;
        cv=none;
        b=SI6/LuqCaUPCsU30BFtLe1uXMXG67ry7G7+5lTME4jWnB8M7K2nedbUQRTq4fPPy9ee0+1
        QQjdmrXTQHHiwoQhajlgOzlP6VASmRT2GHBhZ0VUyGyUUaJKzuUGON9eTZCPGvEyKccYeE
        cId7JqBan3k3YS6/tMQ3Hy9FSxSJ+6Qj7zxbxn+M3vS65gxC3GSQYN/X1h8jGMbC2OfH6t
        tzJEJyI5K8OrmVrXqGfdUmNj/BE4FLu6iWQmcPjEB0y91cflZNnPq7E9PfBhYxI7ks/Tvh
        AX8VJWF6tm2guPzU7Kqa4SMsF/EEdGWFRhfLk2WeAIvF3/IUscW5pmlRKxTIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692287364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=E7jg/oUT2hDPMy25e+AWHYUoH7O5Rzd+DNdc58AwwA8=;
        b=jWu1vFTuoZMQ5TcS4dhqeX0HyfjdlLIVz7m/5Sac6leFGX93mS7gPtY+lbZlzJ2cyauVK4
        /ev36Pt5iq65pQkcTQnkeyVWwNj2Ptr7rGZdPoRO83vFDd4G0ZLWllxIurIOiwfwnLYPNr
        Uqxfk8l3copgGqhDZaAJUmDicIq34S7Hy4mUAHFcO0NkuSLJCjaYN4IwoOAxZJrZV6i1vB
        pnA5gswveLIZGkQPwvc7NdN6kepHEoAuqht21Nn/xqt5iv8q9F5mYbUMUAWX7dPH83lF1m
        on0nk/oKKbBKLOeF4TnF7HeBExcEH2qjtKvsOk1ro5pKcOGYQ0KLRvqWPn/zag==
ARC-Authentication-Results: i=1;
        rspamd-849d547c58-4gfb4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Name-Reaction: 581be5b160e56f1a_1692287364728_2298459895
X-MC-Loop-Signature: 1692287364728:939042887
X-MC-Ingress-Time: 1692287364728
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.205.174 (trex/6.9.1);
        Thu, 17 Aug 2023 15:49:24 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4RRTvl4lxRzFN;
        Thu, 17 Aug 2023 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1692287364;
        bh=E7jg/oUT2hDPMy25e+AWHYUoH7O5Rzd+DNdc58AwwA8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=MAuyhIQoJNMw2CRipewhxHMFiPIJ1wqTNDXuPs8Xc6qFPTfypMK7lfJdp53V+hwDH
         APHSX/IXdXZUm9VX2D6AkiKlojLH5HfYzaibnSCOIFTaeabGPjlZbjdUw2tzbkJgMC
         XqHK7cY0OH93OiRu/CIYSLGpbHkItu16xnfIIA1UsZTE+Dx1e1t1meaKmUBHy4UHkg
         zhp8heC5Dz8yvaQydPRemkb0AZtTVhyy6Xi40909oRLWqJXZwudvUOqWIkXzK8woT0
         ncCVRDGW3FNw2a/JsivE+urXycZRzelvDfTnih1HT/v7p/7SJONo+/NBCF/aYtYSzF
         whKn2kvuSewug==
Date:   Thu, 17 Aug 2023 08:10:46 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     alison.schofield@intel.com
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/mbox: Remove useless cast in
 cxl_mem_create_range_info()
Message-ID: <voyg6vhb52canw7pkddszhvsix5hetph42j7vf4bqh3u3gyymp@q2iaecfi7lnz>
References: <20230815172052.22514-1-alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230815172052.22514-1-alison.schofield@intel.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 15 Aug 2023, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED() macro
>which already has the (struct resource) for the compound literal.
>The user of the macro should not repeat the cast.
>
>Cleans up these sparse warnings:
>drivers/cxl/core/mbox.c:1184:18: warning: cast to non-scalar
>drivers/cxl/core/mbox.c:1184:18: warning: cast from non-scalar
>
>Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
