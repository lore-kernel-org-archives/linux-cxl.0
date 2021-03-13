Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA6C433DB
	for <linux-cxl@archiver.kernel.org>; Sat, 13 Mar 2021 05:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B0364F76
	for <linux-cxl@archiver.kernel.org>; Sat, 13 Mar 2021 05:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhCMFMb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 13 Mar 2021 00:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhCMFMA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 13 Mar 2021 00:12:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8F3C061574
        for <linux-cxl@vger.kernel.org>; Fri, 12 Mar 2021 21:11:59 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d3so48620119lfg.10
        for <linux-cxl@vger.kernel.org>; Fri, 12 Mar 2021 21:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPon1tOTb/dZB3jfXOOOoYk1yhbU4IDdTh8wIdg+Cws=;
        b=QV1uY94ciOCPLxuWV0FS4aAbICfYAk9c3uEB9PqIhdpjne4wORrceXr+hlFR87kazz
         myWAjU2Wpr1QQYG+XpfqEbqhVnErI3y4TyzUtvbuwa73v8Q95fB1k4yYjh8sVAmo+kOY
         oJIBwwaQEGZ1nQIk084eYUdqMyKxX5RINenllf85RNoirpyUMsxF0cQUusNpl4S8oqiv
         k32ZxWFsOMlzqNK64uK/SR2+kB4uSVikIPFmc0hQqLHu+q6bVCIh9rT9OUqU1bl8yo93
         1AfX9EKOPhRwORJSTu1Nh7v+k2lnURyxUXeKiODuaqRW++c5bNCXBj+y2XWojV6XzqW5
         2AHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPon1tOTb/dZB3jfXOOOoYk1yhbU4IDdTh8wIdg+Cws=;
        b=Z3PP5ljo3PpBCgP451Ob2p4d40xyal89AofoBB6dVeYwJwHdIlEW3bta2a9RiyS5wE
         CCiV20IyZcFQEnSAzQOq75Y4mXRz7KbniMorYrbJ0rw2sFPyAEbNTnX/sZjPcRKjumrB
         0ux1VECfZjv1oHiBi1r7gZVcmRa7dHBGEpwwECpVLL4+QvpKkQPrav0k5DHOEw41hPjy
         6mG0pVjdpqIT7PqDg6+FPP7BjCozgnVY3Mbw8juNUGfd0wnwjqeGyoXjG9CYExB2PKkX
         dRdO3q5/qnuht//D4YY98nn3w00693hOQGSybBUPohxUy5Q+cukve5aqPmOW2pGrUbrP
         lEUw==
X-Gm-Message-State: AOAM533B6QbbzQ7QuZYOvh82lzUKuGkB+Q4+8PkecF7yPACvu+JaQ5xW
        OnWyiTPJygIMWx6tJ6DPxMAR1/SJ84OTA8BRB2iaDKj2eos=
X-Google-Smtp-Source: ABdhPJz47X5b1CokPLUUrU7g5SAPKTsfqJqaTLOsC04Sx4HcaVwffZtHmGXWfH2/l+rZ7SrZPiI/JksIOV6fkn0PiEA=
X-Received: by 2002:a19:c185:: with SMTP id r127mr1578748lff.530.1615612317867;
 Fri, 12 Mar 2021 21:11:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+-5cKfDiDDG6zpnDSg12a=JPD8-FTypi9qA9qdr_CRnkrFuHg@mail.gmail.com>
 <20210312004449.akcgmidgyupzqbyn@intel.com> <7f5066f5ec2587229258bf33da84f1275e0d044a.camel@intel.com>
 <CA+-5cKeZKUONViHiQbGJ=sjA43iHHQRxsrsqzT-nG3X6Wo89sQ@mail.gmail.com> <947272c24b860ef9ac9609134a6f481874c71219.camel@intel.com>
In-Reply-To: <947272c24b860ef9ac9609134a6f481874c71219.camel@intel.com>
From:   Raj Vishwanathan <raj.vishwanathan@gmail.com>
Date:   Fri, 12 Mar 2021 21:11:46 -0800
Message-ID: <CA+-5cKcYsD_g=YDpAfqpEAnVdq_zScLDXDumxygT6Xvw-CHUYg@mail.gmail.com>
Subject: Re: Testing CXl with qemu and Linux
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks, I'll check it out.

On Fri, Mar 12, 2021 at 4:29 PM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
>
> On Fri, 2021-03-12 at 08:55 -0800, Raj Vishwanathan wrote:
> > Vishal, Ben
> >
> > Thanks for replying.
> >
> > I am trying to understand who exposes these CXL devices. If I
> > understood correctly,  qemu, with the host OS support, will create and
> > expose a CXL.mem endpoint that will be discovered by the CXL root
> > complex driver on Linux ( thanks to the CXL patches)
>
> The qemu branch you're using creates and exposes CXL devices when called
> with the right cli arguments. The Linux kernel enabling then is able to
> comprehend these devices, show them in sysfs, and is able to send down
> mailbox commands.
>
> >
> > What I am not able to do is to expose the CXL endpoint using Qemu.
>
> You might take a look at this set of scripts that help create a working
> environment for CXL development using qemu:
> https://github.com/pmem/run_qemu
>
> >
> > Raj
> >
> > On Thu, Mar 11, 2021 at 5:51 PM Verma, Vishal L
> > <vishal.l.verma@intel.com> wrote:
> > >
> > > On Thu, 2021-03-11 at 16:44 -0800, Ben Widawsky wrote:
> > > > On 21-03-08 15:33:49, Raj Vishwanathan wrote:
> > > > > Raj Vishwanathan <raj.vishwanathan@gmail.com>
> > > > > 1:55 PM (1 hour ago)
> > > > > to linux-cxl
> > > > >
> > > > > I am trying to setup and take a look at an system with CXL enabled
> > > > >
> > > > > 1. I downloaded and installed linux.5.11 + CXL patches on a regular qemu system
> > > > > 2. I built qemu using Ben Widawsky's CXL-2.0 branch ( I see that there
> > > > > is a 2.0v4 tree)
> > > > > 3. I also built ndactl  from 2.0v2 branch
> > > > >
> > > > > From what I understand, I use the ndactl to create a  memory namespace
> > > > > and I use this in the qemu command line to start. Given this and the
> > > > > Linux having CXL support  I should be able to see the CXL.mem device
> > > > > with lspci. Correct me if I am completely messed up.
> > > > >
> > > > > I am not able to create the memory namespace with ndctl
> > > > >
> > > > > I tried with
> > > > >
> > > > > "./ndctl  create-namespace -t pmem -m raw -n mem0 -v -s 268435456" and
> > > > > it fails with
> > > > >
> > > > > "failed to create namespace: No such device or address"
> > > > >
> > > > > Is there a step by step direction of how to test CXL on Linux? I can
> > > > > document this process if someone can describe where am I making a
> > > > > mistake
> > > > >
> > > > > Raj
> > > >
> > > > Aside from command errors, for which I'm not the expert...
> > > >
> > > > The cxl command will be used to control CXL devices, not ndctl. Nothing other
> > > > than sending commands to the CXL device are actually hooked in in any of the:
> > > > application, kernel. QEMU has minimal support which may need more and I will be
> > > > looking into that.
> > >
> > > In addition to what Ben said, the things that are added in the ndctl
> > > branch you built are 'libcxl', and 'cxl-cli'. You can run 'cxl list' to
> > > enumerate the cxl devices found, and libcxl has APIs to create and send
> > > a partial subset of mailbox commands.
> > >
> > > Eventually 'ndctl create-namespace' will be able to use a region coming
> > > from a CXL device, but that functionality is still some time away.
> > >
>
