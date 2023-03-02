Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20400C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 01:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjCBBSD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 20:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCBBSC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 20:18:02 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F6EC7D
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 17:18:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c18so9712697wmr.3
        for <linux-cxl@vger.kernel.org>; Wed, 01 Mar 2023 17:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUlICSsItzogtsE+dYcejxsa1xJXEIYNaUAlJE/kEm0=;
        b=ACR46OnbqMFt8tfJ//F7wfCxEcoQ+TXrRgq3KRKcLOd0od/ZsUseqoeYH2IO3rwN6P
         Mr+DbgEAkB8TiYsyFSYVELeeMpVrJM4xXRoNGnR/12mWUQaKUvLufj8GFtghMZAqwdD9
         Ji6VLn+3e8STjO8jc0Bm4p/sq5lBd20oAV3F1f0WzqSQlwFA8p6GxCMFFijXqqDcod08
         2GInK+b5GwxNVlU5FuDZKb5JAGAOfuELvcqJYNA/61meFlXcX5z5WDqKTqCjFl/juZCo
         wUhSD5+tE2ql+npIwdfHDtGXOANlBTwOt1rTVdAXaTJcfSEEeERq4L1pj/v3Ifr2N99n
         /2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUlICSsItzogtsE+dYcejxsa1xJXEIYNaUAlJE/kEm0=;
        b=qd5GlAJ3V3cgomcFvtOZHiKrsiR3tUKCNybcLUrA9JLvlYqTFkEKfllGC55Qy1BTvn
         v5u/sRplAMb6w/7lLRvGp6eW+VmdyZ5dssteq9pCgzwyZD7LN7GeMorkI5TqWuV2v9ae
         5uc9sCvjfkprCORuKO/W9B3H5AGSRPzde2TaBjuM8KWzJOfUhj8RIdbZXO3/ZDbG7qfM
         3FTRIQXuACwsCuWS4ahQ+3WOr1cyUFowvendEgBqgVBBIOiM038km3iRB9z81Cp/rgtH
         NZl3HthX50t9WZfIastAYGFwcHbDbulVsBX/J/9xMRRWOsqx9vIf8E1+My259ev8jH/A
         6ZtA==
X-Gm-Message-State: AO0yUKXCQLtJjjQJOQPY1dStqPTgeue4SKY5iHup0zhHkWCSg9CC3A2a
        LN8/clBdnGdJfZQaDQRr/C80RFFl5QnkUlb3pK8=
X-Google-Smtp-Source: AK7set+QWhNMKWZY+9vXt4zAcZPVKgozO8BgB3yYArSjmnScbTlXwgAEjYP8oAwayV50wkrWYa0+wtUQmi0NLKww6Uw=
X-Received: by 2002:a05:600c:3c9b:b0:3df:97ed:dde8 with SMTP id
 bg27-20020a05600c3c9b00b003df97eddde8mr2411874wmb.5.1677719878772; Wed, 01
 Mar 2023 17:17:58 -0800 (PST)
MIME-Version: 1.0
References: <Y/Cm5nuJl3G2CG2p@memverge.com> <b066510e-8420-26ba-019b-fef2b255634e@wdc.com>
 <20230228104916.00003d9a@Huawei.com>
In-Reply-To: <20230228104916.00003d9a@Huawei.com>
From:   Ajay Joshi <ajaysjoshi1978@gmail.com>
Date:   Thu, 2 Mar 2023 06:47:47 +0530
Message-ID: <CAJmyj+CqfJY2kPQC5UzQWuHgnDfdrcAuPMdDj2REmHMcrmQyYA@mail.gmail.com>
Subject: Re: [RFC] CXL: TCG/KVM instruction alignment issue discussion default
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     =?UTF-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        Gregory Price <gregory.price@memverge.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 28, 2023 at 4:54=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 27 Feb 2023 11:06:47 +0000
> J=C3=B8rgen Hansen <Jorgen.Hansen@wdc.com> wrote:
>
> > On 2/18/23 11:22, Gregory Price wrote:
> > > Breaking this off into a separate thread for archival sake.
> > >
> > > There's a bug with handling execution of instructions held in CXL
> > > memory - specifically when an instruction crosses a page boundary.
> > >
> > > The result of this is that type-3 devices cannot use KVM at all at th=
e
> > > moment, and require the attached patch to run in TCG-only mode.
> > >
> > >
> > > CXL memory devices are presently emulated as MMIO, and MMIO has no
> > > coherency guarantees, so TCG doesn't cache the results of translating
> > > an instruction, meaning execution is incredibly slow (orders of
> > > magnitude slower than KVM).
> > >
> > >
> > > Request for comments:
> > >
> > >
> > > First there's the stability issue:
> > >
> > > 0) TCG cannot handle instructions across a page boundary spanning ram=
 and
> > >     MMIO. See attached patch for hotfix.  This basically solves the p=
age
> > >     boundary issue by reverting the entire block to MMIO-mode if the
> > >     problem is detected.
> > >
> > > 1) KVM needs to be investigated.  It's likely the same/similar issue,
> > >     but it's not confirmed.
> >
> > I ran into an issue with KVM as well. However, it wasn't a page boundar=
y
> > spanning issue, since I could hit it when using pure CXL backed memory
> > for a given application. It turned out that (at least) certain AVX
> > instructions didn't handle execution from MMIO when using qemu. This
> > generated an illegal instruction exception for the application. At that
> > point, I switched to tcg, so I didn't investigate if running a non-AVX
> > system would work with KVM.
>
> Short term I'm wondering if we should attempt to error out on KVM
> unless some override parameter is used alongside the main cxl=3Don
This seems like a good idea. Avoids the trouble of discovering a lot later
during the execution.
>
> >
> > > Second there's the performance issue:
> > >
> > > 0) Do we actually care about performance? How likely are users to
> > >     attempt to run software out of CXL memory?
> > >
> > > 1) If we do care, is there a potential for converting CXL away from t=
he
> > >     MMIO design?  The issue is coherency for shared memory. Emulating
> > >     coherency is a) hard, and b) a ton of work for little gain.
> > >
> > >     Presently marking CXL memory as MMIO basically enforces coherency=
 by
> > >     preventing caching, though it's unclear how this is enforced
> > >     by KVM (or if it is, i have to imagine it is).
> >
> > Having the option of doing device specific processing of accesses to a
> > CXL type 3 device (that the MMIO based access allows) is useful for
> > experimentation with device functionality, so I would be sad to see tha=
t
> > option go away. Emulating cache line access to a type 3 device would be
> > interesting, and could potentially be implemented in a way that would
> > allow caching of device memory in a shadow page in RAM, but that it a
> > rather large project.
>
> Absolutely agree.  Can sketch a solution that is entirely in QEMU and
> works with KVM on a white board, but it doesn't feel like a small job
> to actually implement it and I'm sure there are nasty corners
> (persistency is going to be tricky)
>
> If anyone sees this as a 'fun challenge' and wants to take it on though
> that would be great!
>
> Jonathan
>
> >
> > > It might be nice to solve this for non-shared memory regions, but
> > > testing functionality >>> performance at this point so it might not
> > > worth the investment.
> >
> > Thanks,
> > Jorgen
>
