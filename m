Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB24C433DB
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C067365024
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Mar 2021 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhCLQ4I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Mar 2021 11:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhCLQzj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Mar 2021 11:55:39 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74C4C061574
        for <linux-cxl@vger.kernel.org>; Fri, 12 Mar 2021 08:55:38 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 16so7609711ljc.11
        for <linux-cxl@vger.kernel.org>; Fri, 12 Mar 2021 08:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVxxlSblY2Jv1PepmVc7ufPTCYwn/WDjxlTaqDbi1iU=;
        b=AGZEq3q6wjkaklbfCNzVGunxR4TyIYCF1+2zV1hjerN37gnGU3+dlyA3ZhrAclx2SH
         BlxESV7saLJrNekQUH9LgeFmHQr5/UFF49lTssiW543q/a1x3T3Mm50KCzQ2nQxer7yq
         C/Ioo1IQ/A5XW9ADSrvGznKC+SUH/UswlRQ1Z8YZSAOfxRPfRu0CulRkOs/i/gT35ucW
         IbTzDKPUUfonUAlhX+VAYV0vrdVRdmSUAcCQ/QB4dxVJChsbhoDGblaQImYvg0IEI4mI
         FDfPgNJX3uxedWsUO3I1RCFymkFTVtUje8y/juyg/AMuhq5l3BrEuyhyw9s9gFquSdOi
         /vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVxxlSblY2Jv1PepmVc7ufPTCYwn/WDjxlTaqDbi1iU=;
        b=pg0kYb1pGGU7YKHGvB+TMD1vVaYTMXDSHJFj9OV+3mNshEl5aBepwsWP3W5OtFGJRL
         Ue8Lt1FHRkGJcDF+umgPNjIgWsv6GNqVXZpVo1W8Wd2cshlRlFy3T4mjM5g1BYzcKKK8
         0PvxyrH/hTfA7kt8SDv5DEzlYs1gjrSOg9N7xaMAOjHyBVdM6PsrlatVHOHQ9cNTkSE9
         j/MrboR40wXbejn2ZvDl7hwlGtgxXrbhFTONr+I6LDR7m8+j1XbLIAstD/+fZrp9Oz+F
         C3fID6LCGVJ1PkHGr0kqLIkCHLPJroK+oC1l+Cg3MmccRFTwDTxDHtRHN/BFkRFmkhhF
         N3RA==
X-Gm-Message-State: AOAM530U5MOx6fhxKqH+inqZGVzmzV2J5opG8UNrlvRvnyB8wuUxfutl
        HCrNUxY7AIZ2QSxstaqwtQasM8OOSfAwX+Lslb5vYdJJ
X-Google-Smtp-Source: ABdhPJxMeFfMPZmJoRso7nIC0Ry1tJkDVRlwBTivmAMCkdWGYLe1K+i3Zp0irbcUs4A4ab3NzREoU/KBUP8Uv8MdZK8=
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr3045465ljo.491.1615568137243;
 Fri, 12 Mar 2021 08:55:37 -0800 (PST)
MIME-Version: 1.0
References: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
 <20210312004449.akcgmidgyupzqbyn@intel.com> <7f5066f5ec2587229258bf33da84f1275e0d044a.camel@intel.com>
In-Reply-To: <7f5066f5ec2587229258bf33da84f1275e0d044a.camel@intel.com>
From:   Raj Vishwanathan <raj.vishwanathan@gmail.com>
Date:   Fri, 12 Mar 2021 08:55:25 -0800
Message-ID: <CA+-5cKeZKUONViHiQbGJ=sjA43iHHQRxsrsqzT-nG3X6Wo89sQ@mail.gmail.com>
Subject: Re: Testing CXl with qemu and Linux
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vishal, Ben

Thanks for replying.

I am trying to understand who exposes these CXL devices. If I
understood correctly,  qemu, with the host OS support, will create and
expose a CXL.mem endpoint that will be discovered by the CXL root
complex driver on Linux ( thanks to the CXL patches)

What I am not able to do is to expose the CXL endpoint using Qemu.

Raj

On Thu, Mar 11, 2021 at 5:51 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Thu, 2021-03-11 at 16:44 -0800, Ben Widawsky wrote:
> > On 21-03-08 15:33:49, Raj Vishwanathan wrote:
> > > Raj Vishwanathan <raj.vishwanathan@gmail.com>
> > > 1:55 PM (1 hour ago)
> > > to linux-cxl
> > >
> > > I am trying to setup and take a look at an system with CXL enabled
> > >
> > > 1. I downloaded and installed linux.5.11 + CXL patches on a regular qemu system
> > > 2. I built qemu using Ben Widawsky's CXL-2.0 branch ( I see that there
> > > is a 2.0v4 tree)
> > > 3. I also built ndactl  from 2.0v2 branch
> > >
> > > From what I understand, I use the ndactl to create a  memory namespace
> > > and I use this in the qemu command line to start. Given this and the
> > > Linux having CXL support  I should be able to see the CXL.mem device
> > > with lspci. Correct me if I am completely messed up.
> > >
> > > I am not able to create the memory namespace with ndctl
> > >
> > > I tried with
> > >
> > > "./ndctl  create-namespace -t pmem -m raw -n mem0 -v -s 268435456" and
> > > it fails with
> > >
> > > "failed to create namespace: No such device or address"
> > >
> > > Is there a step by step direction of how to test CXL on Linux? I can
> > > document this process if someone can describe where am I making a
> > > mistake
> > >
> > > Raj
> >
> > Aside from command errors, for which I'm not the expert...
> >
> > The cxl command will be used to control CXL devices, not ndctl. Nothing other
> > than sending commands to the CXL device are actually hooked in in any of the:
> > application, kernel. QEMU has minimal support which may need more and I will be
> > looking into that.
>
> In addition to what Ben said, the things that are added in the ndctl
> branch you built are 'libcxl', and 'cxl-cli'. You can run 'cxl list' to
> enumerate the cxl devices found, and libcxl has APIs to create and send
> a partial subset of mailbox commands.
>
> Eventually 'ndctl create-namespace' will be able to use a region coming
> from a CXL device, but that functionality is still some time away.
>
