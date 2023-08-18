Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB8C71136
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Aug 2023 05:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357449AbjHRFWg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Aug 2023 01:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357997AbjHRFVc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Aug 2023 01:21:32 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AFA49FF
        for <linux-cxl@vger.kernel.org>; Thu, 17 Aug 2023 22:20:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-790970a8706so18126339f.2
        for <linux-cxl@vger.kernel.org>; Thu, 17 Aug 2023 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692335926; x=1692940726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JK+gBhk7ou2vM8OJCNjC7ow3npc46slZN3uDwrJ33U8=;
        b=M/wbtaAA0yxSO/92hYgcrte3WLiq90mtzLpuT2dSafTCaQQAXAdYl4EFNDOJ4FzpKs
         D5ihTLwHLX2HyLdGMU/hECD3rZQiIl7RgFTgkOlhr+d31fMi//8PgYQZRfjISz8Q51Nh
         CfX9dGPifirF6Iv3mCrTgMzNeZ6HmgZs986BlEXfuNmZZ4h+9vzvUbpFGsXeWUJyyoFC
         aBLwx5OCzCfPFmR9rg7MGkR8KOCpNh8YTiD5i+xeZNEd1t3lbDEBROliO5dYMp5r7Vwf
         JEN760aIrq8tjk9ohEfEkTW3BP6ODjoX64ioYUBnIGt7VAIr7oHi+3QEPNwadH9JYrrn
         nY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692335926; x=1692940726;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JK+gBhk7ou2vM8OJCNjC7ow3npc46slZN3uDwrJ33U8=;
        b=c77f0jVYq18Sucut7cAvJ3NQV6WHX0C1hWQP7K80OEv1/AFfz/TwDrNEbZ5lAxNkZl
         N/jmoS3INcR8PuGng3fdXAj6XZ/YUiK0g3EkV+OK1rIlYJU9Lzs9VAK2N9MzeLEg60Ny
         advLgsvcMEtDDzJ8/Xk4zeo6XrR1rQ4/d+e374DifByFoS4mNVRByFS0+EmYRoSbani8
         n03EDoHvbhMAKlP+jyLKyLGb0qrtTVCuur0YnvhDl6f6CAi7gChUjfzc56mVx3pjC1+G
         iTrVbpPoqJYCv7L6chY9kFm+omK7OK7Jo+yoeVpm3NgU2yZzCT0KW5MVUK9HwBdRTbJB
         4c0g==
X-Gm-Message-State: AOJu0YyGMFwygvpk59hMWjzOq+Dbvx9VLnn1haWSH1/VHn5LK5rtRtFJ
        Gt/1LBBJWQ5CtlEJ49QuSH7ysDmuu4lxws9+3WSVr7eQFdM=
X-Google-Smtp-Source: AGHT+IEjKTA8YlfWuuFj1c3pLILaXVZg8U9xsCvi+zdw25t8MAf7/uLYvNBu1iEb+FXIGHL0omy4dh4eYefjZg0ccMI=
X-Received: by 2002:a6b:701a:0:b0:791:1028:2dcf with SMTP id
 l26-20020a6b701a000000b0079110282dcfmr1894092ioc.10.1692335925901; Thu, 17
 Aug 2023 22:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <20230810113512.00000516@Huawei.com> <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
 <20230811145458.000029c7@Huawei.com>
In-Reply-To: <20230811145458.000029c7@Huawei.com>
From:   Maverickk 78 <maverickk1778@gmail.com>
Date:   Fri, 18 Aug 2023 10:48:35 +0530
Message-ID: <CALfBBTsMLP8_eTfmFt5mB+ywF1D0WTR7m=PBqUVzhhvcwC+zYA@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

The use case of CXL switch will always need some sort of management
agent + FM configuring the available CXL memory connected.

In most cases it would be bmc controller configuring MLD/MHD's to
host, and in very rare scenarios it may be one of the host interacting
with FM firmware inside the switch which would do the trick.

Another use case is static hardcoding between CXL memory & host in
built in cxl switch

There is no scenario where one of the host BIOS can push the select
CXL memory to itself.


Is my understanding correct?



On Fri, 11 Aug 2023 at 19:25, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 11 Aug 2023 08:04:26 +0530
> Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> > Jonathan,
> >
> > > More generally for the flow that would bring the memory up as system ram
> > > you would typically need the bios to have done the CXL enumeration or
> > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > be fully automated, because there are policy decisions to make on things like
> > > interleaving.
> >
> > BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
> > create an entry
> > in the e820 table?
> On intel platforms 'maybe' :)  I know how it works on those that just
> use the nice standard EFI tables - less familiar with the e820 stuff :)
>
> CEDT says where to find the the various bits of system related CXL stuff.
> Nothing in there on the configuration that should be used such as interleaving
> as that depends on what the administrator wants. Or on what the BIOS has
> decided the users should have.
>
> >
> > >
> > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > etc in the kernel.
> > >
> > Manual works with "cxl create regiton"  :)
> Great.
>
> Jonathan
>
> >
> > On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 9 Aug 2023 04:21:47 +0530
> > > Maverickk 78 <maverickk1778@gmail.com> wrote:
> > >
> > > > Hello,
> > > >
> > > > I am running qemu-system-x86_64
> > > >
> > > > qemu-system-x86_64 --version
> > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > >
> > > +Cc linux-cxl as the answer is more todo with linux than qemu.
> > >
> > > > qemu-system-x86_64 \
> > > > -m 2G,slots=4,maxmem=4G \
> > > > -smp 4 \
> > > > -machine type=q35,accel=kvm,cxl=on \
> > > > -enable-kvm \
> > > > -nographic \
> > > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > > > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > > > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> > >
> > > There are some problems upstream at the moment (probably not cxl related but
> > > I'm digging). So today I can't boot an x86 machine. (goody)
> > >
> > >
> > > More generally for the flow that would bring the memory up as system ram
> > > you would typically need the bios to have done the CXL enumeration or
> > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > be fully automated, because there are policy decisions to make on things like
> > > interleaving.
> > >
> > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > etc in the kernel.
> > >
> > > There is support in ndctl for those enabling flows, so I'd look there
> > > for more information
> > >
> > > Jonathan
> > >
> > >
> > > >
> > > >
> > > > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > > > shows only 2G memory which is System RAM, it's not listing the CXL
> > > > memory.
> > > >
> > > > Do I need to pass any particular parameter in the kernel command line?
> > > >
> > > > Is there any documentation available? I followed the inputs provided in
> > > >
> > > > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> > > >
> > > > Is there any documentation/blog listed?
> > >
>
