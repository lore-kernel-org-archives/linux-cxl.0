Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1336C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 15:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FE660F11
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhINPxL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234989AbhINPxE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 11:53:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D472C0613E1
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 08:51:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r21so11847199qtw.11
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wpm3EKcVYyz7LQSzWSg/19JHgrxbG8xZ10fGoXa6mFA=;
        b=DDAhlig91/9XaQ6Ex1B8amqRl4P77Qh6wJzLlL9yX9K0IzUF+p4ztuhhey1yn9bxSZ
         7JjQg3EEvuUO+l34US04F0v5tdxGBcMDi7JTSD/wJqdOcM3/NQFmZrt8c2A0PFTzxm79
         QO81/MGIXBZB/AzZaoUx7lhUFUPTvgfjymY68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wpm3EKcVYyz7LQSzWSg/19JHgrxbG8xZ10fGoXa6mFA=;
        b=HCgfxSezgyBjv7M5nA2+e0YRh3Ayb5Nv1DU0nl8Em9JyTxHtztO2JIpQ1Q4j44MVTd
         3t3eb0kcHeDwtoQMyA0rP+kUyN6+Eb/Q3sUXpkFHlqokmBby3ykLj9H1iRL9y/Mxm7sI
         WpgHVH12paASKptomTbqn4ThDRY4BBTXP/ggV6h1PenftSXS1sSoy5GDAB6owQCijkKX
         q6aSItE0jbsEz0mMyzquGa5Vibrn8Qxq4HZDRgg7eo2+M3wKHw7w5YtworgRYGwjmsbQ
         akByd/z7vQ505skzIQz7j21YyypwIIMHZqKLTiRE82I9l2rgzeoi6VVnyBT8xCpMscdE
         8+Ng==
X-Gm-Message-State: AOAM530xHOgV0xzyZs6o2jq2yZZ/M+7OSb/Hmq/BzqD/D4vC85k0aGMK
        qHhZnoficA4M1ScysO1VxBteLA==
X-Google-Smtp-Source: ABdhPJyTkD7AX/OAq0MPZ7v+TkEUDhAIH8BSJ3PJuBuMuksD9qKKq6mx7wPMEQfaGXkmHTzYqcy10g==
X-Received: by 2002:a05:622a:1792:: with SMTP id s18mr5472991qtk.136.1631634704548;
        Tue, 14 Sep 2021 08:51:44 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id c20sm7582006qkk.121.2021.09.14.08.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 08:51:44 -0700 (PDT)
Date:   Tue, 14 Sep 2021 11:51:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 14/21] cxl/mbox: Add exclusive kernel command support
Message-ID: <20210914155142.sshxiqaorrmoxfna@meerkat.local>
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116436926.2460985.1268688593156766623.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210910103348.00005b5c@Huawei.com>
 <CAPcyv4i48AHtHOAJVsDKQ+Zg2QqnvQg1Ur8ekb6qR6cRDbkAzQ@mail.gmail.com>
 <20210914122211.5pm6h3gppwfh763t@meerkat.local>
 <CAPcyv4j5FxmDX0fjgCKs9V4Avn3JD-5JMt4MxNy3_DH_x_tGug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4j5FxmDX0fjgCKs9V4Avn3JD-5JMt4MxNy3_DH_x_tGug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 14, 2021 at 07:39:47AM -0700, Dan Williams wrote:
> > > It would also require a series resend since I can't use the in-place
> > > update in a way that b4 will recognize.
> >
> > BTW, b4 0.7+ can do partial series rerolls. You can just send a single
> > follow-up patch without needing to reroll the whole series, e.g.:
> >
> > [PATCH 1/3]
> > [PATCH 2/3]
> > \- [PATCH v2 2/3]
> > [PATCH 3/3]
> >
> > This is enough for b4 to make a v2 series where only 2/3 is replaced.
> 
> Oh, yes, I use that liberally, istr asking for it originally. What I
> was referring to here was feedback that alluded to injecting another
> patch into the series, ala:
> 
> [PATCH 1/3]
> [PATCH 2/3]
> \- [PATCH v2 2/4]
>  \- [PATCH v2 3/4]
> [PATCH 3/3]   <-- this one would be 4/4
> 
> I don't expect b4 to handle that case, and would expect to re-roll the
> series with the new numbering.

Oooh, yeah, you're right. One option is to download the mbox file and manually
edit the patch subject to be [PATCH v2 4/4].

> > (Yes, I am monitoring all mentions of "b4" on lore.kernel.org/all in a totally
> > non-creepy way, I swear.)
> 
> I still need to do that for my sub-systems.

I'll provide ample docs by the time plumbers rolls around next week.

-K
