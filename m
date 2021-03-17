Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0FDC433DB
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Mar 2021 01:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DDD164F92
	for <linux-cxl@archiver.kernel.org>; Wed, 17 Mar 2021 01:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhCQBuP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Mar 2021 21:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCQBtn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Mar 2021 21:49:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C545C06174A
        for <linux-cxl@vger.kernel.org>; Tue, 16 Mar 2021 18:49:43 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f26so1203137ljp.8
        for <linux-cxl@vger.kernel.org>; Tue, 16 Mar 2021 18:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDrbrwxOjGWa9otVMYsB35cBGdQWV4+Rz7O3JtLSYbA=;
        b=EXRqFb3MQufgpPp7NUQ+TOeI6DCesO7AceK5q2zwfb5TNABK+BCOBK7V7kw7KS2Hjd
         8ujkmRfpJLYJmrToMLGkDGm7SdE4vIYhmfXep+MCnH7K70OyHry9ainYC3qOo51cYMVo
         JRde++mrzr/Rc0gbDeJpNh+2FCRj7cHAeE/GgNWSeXLumprStTP4VeJarEaFJoNALfIA
         AGL2h58uIQXxezwl6fOI87AJy2e7hQTv5xuG94htzrdmBbrGSOXlDD9Or+UsuLjC1CCT
         h6Vny+QcbbNFMtLP6anDtr1kF0CEa4zQJv9N83lc6zJDGwE8euZmGLXhRqYI+LbyFZN3
         1l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDrbrwxOjGWa9otVMYsB35cBGdQWV4+Rz7O3JtLSYbA=;
        b=ciCMkUrvtOH5M8ACb3OOoFmYuyMsqu0/NdFQZSH2HLDODgOhH8BuxnB4+7jfma+kVd
         oyR5pKCe/vQ9PfnQoSWHw2Q2jmb2LCnyP4Qei230TMtT2H1c3bAo1fVz0Tq7JFmvuzkc
         QQJ7cuJbdpVC71msOMDNiTPBuMsjQAkTAsA/TsQtTD7hqvMaqctZ+sHDWiT0dPC1I9eB
         KLFXEXtLCg5Ruh6b0tAaRR1LSmMoXgQSsb1h6G76liZfQWpjE4bwJaUSbcYhuu6TdnYQ
         qSl26azytF2AzKj8fm7S7k0z+hmYfYdIs1G582XwedHZ15oDEym7EO++Z8vSIv0Ri1pE
         5Adg==
X-Gm-Message-State: AOAM532H9irpYhAptcF4Xt1zhVlPPJHbAFh17Q/CBupr9qylK8yytfo7
        ZKOYg+4kTjF4w7UiV2QjV22S/JF55fzRyy+LY4xTykfL
X-Google-Smtp-Source: ABdhPJx7r/5JS7jMMRDM3Ej92j68CbRx21wBwRp1jzg0ETNAULnTWuGRCXHiVK7jby6TeLTfApQyswVBjjH5qiwzR04=
X-Received: by 2002:a2e:b894:: with SMTP id r20mr935174ljp.222.1615945781420;
 Tue, 16 Mar 2021 18:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
 <20210312004449.akcgmidgyupzqbyn@intel.com> <7f5066f5ec2587229258bf33da84f1275e0d044a.camel@intel.com>
 <CA+-5cKeZKUONViHiQbGJ=sjA43iHHQRxsrsqzT-nG3X6Wo89sQ@mail.gmail.com>
 <947272c24b860ef9ac9609134a6f481874c71219.camel@intel.com> <CA+-5cKcYsD_g=YDpAfqpEAnVdq_zScLDXDumxygT6Xvw-CHUYg@mail.gmail.com>
In-Reply-To: <CA+-5cKcYsD_g=YDpAfqpEAnVdq_zScLDXDumxygT6Xvw-CHUYg@mail.gmail.com>
From:   Raj Vishwanathan <raj.vishwanathan@gmail.com>
Date:   Tue, 16 Mar 2021 18:49:30 -0700
Message-ID: <CA+-5cKdaaK3nA6aiEXp4WrH3g936rw8rfLCjXOu0-YYdrQeTTQ@mail.gmail.com>
Subject: Re: Testing CXl with qemu and Linux
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Vishal, Ben

I got it working. I can see the cxl mem devices using lspci.

Thanks for your pointers

Raj

On Fri, Mar 12, 2021 at 9:11 PM Raj Vishwanathan
<raj.vishwanathan@gmail.com> wrote:
>
> Thanks, I'll check it out.
>
> On Fri, Mar 12, 2021 at 4:29 PM Verma, Vishal L
> <vishal.l.verma@intel.com> wrote:
> >
> > On Fri, 2021-03-12 at 08:55 -0800, Raj Vishwanathan wrote:
> > > Vishal, Ben
> > >
> > > Thanks for replying.
> > >
> > > I am trying to understand who exposes these CXL devices. If I
> > > understood correctly,  qemu, with the host OS support, will create and
> > > expose a CXL.mem endpoint that will be discovered by the CXL root
> > > complex driver on Linux ( thanks to the CXL patches)
> >
> > The qemu branch you're using creates and exposes CXL devices when called
> > with the right cli arguments. The Linux kernel enabling then is able to
> > comprehend these devices, show them in sysfs, and is able to send down
> > mailbox commands.
> >
> > >
> > > What I am not able to do is to expose the CXL endpoint using Qemu.
> >
> > You might take a look at this set of scripts that help create a working
> > environment for CXL development using qemu:
> > https://github.com/pmem/run_qemu
> >
> > >
> > > Raj
> > >
> > > On Thu, Mar 11, 2021 at 5:51 PM Verma, Vishal L
> > > <vishal.l.verma@intel.com> wrote:
> > > >
> > > > On Thu, 2021-03-11 at 16:44 -0800, Ben Widawsky wrote:
> > > > > On 21-03-08 15:33:49, Raj Vishwanathan wrote:
> > > > > > Raj Vishwanathan <raj.vishwanathan@gmail.com>
> > > > > > 1:55 PM (1 hour ago)
> > > > > > to linux-cxl
> > > > > >
> > > > > > I am trying to setup and take a look at an system with CXL enabled
> > > > > >
> > > > > > 1. I downloaded and installed linux.5.11 + CXL patches on a regular qemu system
> > > > > > 2. I built qemu using Ben Widawsky's CXL-2.0 branch ( I see that there
> > > > > > is a 2.0v4 tree)
> > > > > > 3. I also built ndactl  from 2.0v2 branch
> > > > > >
> > > > > > From what I understand, I use the ndactl to create a  memory namespace
> > > > > > and I use this in the qemu command line to start. Given this and the
> > > > > > Linux having CXL support  I should be able to see the CXL.mem device
> > > > > > with lspci. Correct me if I am completely messed up.
> > > > > >
> > > > > > I am not able to create the memory namespace with ndctl
> > > > > >
> > > > > > I tried with
> > > > > >
> > > > > > "./ndctl  create-namespace -t pmem -m raw -n mem0 -v -s 268435456" and
> > > > > > it fails with
> > > > > >
> > > > > > "failed to create namespace: No such device or address"
> > > > > >
> > > > > > Is there a step by step direction of how to test CXL on Linux? I can
> > > > > > document this process if someone can describe where am I making a
> > > > > > mistake
> > > > > >
> > > > > > Raj
> > > > >
> > > > > Aside from command errors, for which I'm not the expert...
> > > > >
> > > > > The cxl command will be used to control CXL devices, not ndctl. Nothing other
> > > > > than sending commands to the CXL device are actually hooked in in any of the:
> > > > > application, kernel. QEMU has minimal support which may need more and I will be
> > > > > looking into that.
> > > >
> > > > In addition to what Ben said, the things that are added in the ndctl
> > > > branch you built are 'libcxl', and 'cxl-cli'. You can run 'cxl list' to
> > > > enumerate the cxl devices found, and libcxl has APIs to create and send
> > > > a partial subset of mailbox commands.
> > > >
> > > > Eventually 'ndctl create-namespace' will be able to use a region coming
> > > > from a CXL device, but that functionality is still some time away.
> > > >
> >
