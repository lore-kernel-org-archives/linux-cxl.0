Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B4BC001DE
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Aug 2023 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357971AbjHRFGQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Aug 2023 01:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357977AbjHRFGI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Aug 2023 01:06:08 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7814335BD
        for <linux-cxl@vger.kernel.org>; Thu, 17 Aug 2023 22:06:07 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso17427139f.3
        for <linux-cxl@vger.kernel.org>; Thu, 17 Aug 2023 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692335167; x=1692939967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NboQbtQRE5XDdhMnkEM71ABQBV691NoP08bDIdh5BUw=;
        b=LjzSKfzEf+EOM1nAfCjWlqmRO+D/qogIq2AMcQZRftaMiPmPPBiwQ8/G5LFvIFV21e
         34SSuQXwvPTMbhl/9gLwoOa0QlNlfg4qMYAs5K5uxJVy+0OwwffYS0yZ83DvzoD1S/Z0
         QxJpeqhDW0ch/8sDoje4YW55FB+lGAj8tMD9XpdEDOHWlCVtJHuLX/yIs1HUABJigv9t
         E4rrp0UWrJYWivuPzXfkoMytUeuDDnkaS+WEYisCtrbJPJInYcKZoz7xvXG5Zx1n/sYO
         itBrdoecDYd9UvUEmQmEdQf46d5tmrzOUHot2CaUgrebQibu2UlqAesdIj7aepnnHH5O
         LMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692335167; x=1692939967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NboQbtQRE5XDdhMnkEM71ABQBV691NoP08bDIdh5BUw=;
        b=dMz/ewnHe3XAKxwqeeeuyx2dHLmlx9rS/L5XccRkLTsQ8UAaL6zEnnOqtEPQ4i2UjL
         BAB6p2RaEEE7aiCNh1VbH79axXcXzfXHHFy1HlMZ96jbpK724bpDCibsI3oM+zpNxd3F
         oCgITGrKT7wBjLT67QUzyNEclMgomeiw5FpWIFIKcilxhtOzf5HcgFxn/ARz7ji30NrO
         h7Q98TB6+uGybW2xXCeYuWO61BApauZwq75EMNkSCzGg7troCyim/mK/6MPs3rej+CXY
         Y/k6qP0NSb81kVic4dqgqOUwHpgBSyRy/8hBjWOOsgnCeyjaec4BYLK6nLFVg8GY5w2b
         1Xww==
X-Gm-Message-State: AOJu0YyfVuH234dv86+7bK10f4lMrDV/Ih9tnD9bPesGmIYGg6l3rz2X
        0QZ5NxJ9zPyssjaOyzTkc+n4qUwZUWzmCRlYuDOw2THa
X-Google-Smtp-Source: AGHT+IEzTgQtlRE9ME3SFdyvKzpiw7CK/lAvGURrLFbtIgLbDE2hCAWegGqfz/NCGExhSY+l5AwL3a2CBK0p5BpKUL4=
X-Received: by 2002:a5e:8516:0:b0:790:aedd:3e81 with SMTP id
 i22-20020a5e8516000000b00790aedd3e81mr2027859ioj.8.1692335166798; Thu, 17 Aug
 2023 22:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <ZNURN6Zzf2hJfmt/@debian> <CALfBBTuRdwCcc-A88kMN7iub9BHx2xfFkfP8Lbrc+oSwfCS2nw@mail.gmail.com>
 <ZNZmbkx4A58CEl/i@debian>
In-Reply-To: <ZNZmbkx4A58CEl/i@debian>
From:   Maverickk 78 <maverickk1778@gmail.com>
Date:   Fri, 18 Aug 2023 10:35:55 +0530
Message-ID: <CALfBBTvQJ8-zpyNyt9zXzd22XoRu+seQkff8t5w_gZps+aNr9w@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To:     Fan Ni <fan.ni@gmx.us>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Fan

Awesome, thanks for the info!

On Fri, 11 Aug 2023 at 22:19, Fan Ni <fan.ni@gmx.us> wrote:
>
> On Fri, Aug 11, 2023 at 07:52:25AM +0530, Maverickk 78 wrote:
> > Thanks Fan,
> >
> > cxl create-region works like a charm :)
> >
> > Since this gets listed as "System Ram(kmem)", I guess the kernel
> > treats it as regular memory and
> > allocates it to the applications when needed?
> > or is there an extra effort needed to make it available for
> > applications on the host?
> >
>
> Yes. Once it is onlined, you can use it as regular memory.
> CXL memory will serve as a zero-CPU memory-only NUMA node.
> You can check it with numactl -H.
>
> To use the cxl memory with an app, you can use
> numactl --membind=numa_id app_name
> #numa_id is the dedicated numa node where cxl memory sits.
>
> One thing to notes, kvm will not work correctly with Qemu emulation when
> you try to use cxl memory for an application, so do not enable kvm.
>
> Fan
>
> > On Thu, 10 Aug 2023 at 22:03, Fan Ni <fan.ni@gmx.us> wrote:
> > >
> > > On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> > > > Hello,
> > > >
> > > > I am running qemu-system-x86_64
> > > >
> > > > qemu-system-x86_64 --version
> > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > >
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
> > > If I remember it correctly, for volatile cxl memory, we need to create a
> > > region and then it will be discovered as system memory and shows up.
> > >
> > > Try to create a region with "cxl create-region".
> > >
> > > Fan
> > > >
