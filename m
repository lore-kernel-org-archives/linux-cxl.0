Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475ABC433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EFE610CE
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Sep 2021 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhINOrP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbhINOqt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Sep 2021 10:46:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65460C0613E3
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 07:39:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d17so8325987plr.12
        for <linux-cxl@vger.kernel.org>; Tue, 14 Sep 2021 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ny4Iw/l0TNDZfHOBQyHos4VqpRE+iwUzJExGaWbUC7U=;
        b=omfk3IvXikMatIM0j00qarQ9R3UZ/Y5XEH0bPp1nghTcYHaSUQSNBupD7asHAkDqcI
         TQXAhG/jjQ2RPVD0o6LzbRxIEk0ncEAdw9FlrlpQmabIn+U3nsHd2AB2sTe8u7Q4H6FO
         Kpbu2BSMbd/HartxTIV/jEIo/dk0BjzSgWl7lMcHBnJ9+FTg4BwXY1obwH2E/sAOdnX/
         yuW55c35FzxIEbuTONFOB1SNcIAzPcy3ukmCME2g16QVuG4Iu2HHmWDUalaL52Ym1VDx
         doJIZ8EofFknbVdT2hWKtCL7nA4r32UBcw+OzM2iClECS1YF4Gn/pPbGPeyOS1b2ILvi
         ETiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ny4Iw/l0TNDZfHOBQyHos4VqpRE+iwUzJExGaWbUC7U=;
        b=HP7WfXt7qmOs0tZwD8ciRvapeAAoYNfwPpF7hF3xxaH58aHoxoJZGvEAezckzQogRj
         btJIHQSG/wQC8wUPDmhTfMY8VEYPyiZnc3+wCyqFvq20qx/pmBmjZR4ACawYMgQ/dK78
         1dfmuaQoLjo51n0RMA9RntUczHwzdWOhe/klMrLaCH0TBK2IbAz90D0y3Vljdmr2Rtri
         DW+nsjyNDoYLTgE9U7f8OiQE3ZuI8JqBcw6fGBTueqyilKBYRspAkARP2zgvVgQNXaXR
         a+Mtyz21n4OKgnTnYZMMH0c1viXJ8I3rtWDFBun85V72n9T8U5NB0Ej6+ulGt5r1TGhI
         SXjA==
X-Gm-Message-State: AOAM5301/CoA9nrKFsHG++T7bD4E1lo028vDBsglI/wgrhhbYhsL3uYS
        ls4FyC9hpm3Jja1zVUoLUX16se+litrxMTqLVHik4A==
X-Google-Smtp-Source: ABdhPJzBeT9wOUlksnXrdvlW92B8z9km4BViKiA8JlXDrw1CVYIqfsNhP9cJVf3Pdh65XWfSZ6L+DVd4NUNleoPCV70=
X-Received: by 2002:a17:902:cec8:b0:13b:9ce1:b3ef with SMTP id
 d8-20020a170902cec800b0013b9ce1b3efmr6727100plg.4.1631630397857; Tue, 14 Sep
 2021 07:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116436926.2460985.1268688593156766623.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210910103348.00005b5c@Huawei.com> <CAPcyv4i48AHtHOAJVsDKQ+Zg2QqnvQg1Ur8ekb6qR6cRDbkAzQ@mail.gmail.com>
 <20210914122211.5pm6h3gppwfh763t@meerkat.local>
In-Reply-To: <20210914122211.5pm6h3gppwfh763t@meerkat.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 07:39:47 -0700
Message-ID: <CAPcyv4j5FxmDX0fjgCKs9V4Avn3JD-5JMt4MxNy3_DH_x_tGug@mail.gmail.com>
Subject: Re: [PATCH v4 14/21] cxl/mbox: Add exclusive kernel command support
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 14, 2021 at 5:22 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Mon, Sep 13, 2021 at 04:46:47PM -0700, Dan Williams wrote:
> > > In the ideal world I'd like to have seen this as a noop patch going from devm
> > > to non devm for cleanup followed by new stuff.  meh, the world isn't ideal
> > > and all that sort of nice stuff takes time!
> >
> > It would also require a series resend since I can't use the in-place
> > update in a way that b4 will recognize.
>
> BTW, b4 0.7+ can do partial series rerolls. You can just send a single
> follow-up patch without needing to reroll the whole series, e.g.:
>
> [PATCH 1/3]
> [PATCH 2/3]
> \- [PATCH v2 2/3]
> [PATCH 3/3]
>
> This is enough for b4 to make a v2 series where only 2/3 is replaced.

Oh, yes, I use that liberally, istr asking for it originally. What I
was referring to here was feedback that alluded to injecting another
patch into the series, ala:

[PATCH 1/3]
[PATCH 2/3]
\- [PATCH v2 2/4]
 \- [PATCH v2 3/4]
[PATCH 3/3]   <-- this one would be 4/4

I don't expect b4 to handle that case, and would expect to re-roll the
series with the new numbering.

>
> -K
>
> (Yes, I am monitoring all mentions of "b4" on lore.kernel.org/all in a totally
> non-creepy way, I swear.)

I still need to do that for my sub-systems.
