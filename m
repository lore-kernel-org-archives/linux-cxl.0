Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3AC001E0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 02:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjHKCek (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 22:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjHKCej (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 22:34:39 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD66C2D6A
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 19:34:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3490eacf4d5so5787695ab.0
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 19:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691721277; x=1692326077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7RczCAEfFlIDjbcm6CEP7Zo7Rw49GxpIvtdn+ukP/+o=;
        b=LEBN+RQzOrBJ3NTt+QN+ma1T54nWv94ArqaMwmmUy4hTYmtMcxOejO9GFC3MKGwxeF
         8/QLGL39sZuUkQB9ntY5ibxI2QOT4LX8JTKxL6UhjSufJT3WTQ/KjG1bypW+Hvce5jEI
         4Gvh8y2bLi/appa3A/DH3hQxmsHiN7wHFJ70zTHhap14kl4WzJZHpqTnVAOULZOXNQgo
         2lJ8EXG/sUI0AIM4qTldvPcvhSZhDDA+tZ2ukOwcOvmJVTOj0Pr3a/nCnqAtCq8uTaTC
         fxQVDLL1kOKnb8FixGBl7TFIAFvVPyFp8CG+IyREdD0qPBu0KNRtd7IXmXX70xnQnM39
         JSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691721277; x=1692326077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RczCAEfFlIDjbcm6CEP7Zo7Rw49GxpIvtdn+ukP/+o=;
        b=lupslkvVm5Hw8rh/oRPV0tss+HQNZ3AOSG9nfFmNUIPvdsqxnBECdOMPFyGeDY/ZVN
         n1dYUMwNE50cBXkUVRohX2frCu4gxW9FV4dFq4ujmydrgfpKA11mo+7daMWZZwoZ8Nk+
         5WautClY9DsQHNJ3Qdv8H2vOELo7rBTrkKDMm5Cx+lPPI9xPlEes3KxvR/Rb4YEgNjxZ
         GbScLR5h7har4uKktqD9GN5lnGJzBkiVHDLv9ClaLh1GiBJmbVHjdOw5aNSZuJ61F+Cw
         bb+UnOhSDXGqVN1fcnWcoXNlnmoi4nhQ6oVLTywntcHw5Ht0Fyw5cLZyPyxsaYQbQm8Y
         lS0Q==
X-Gm-Message-State: AOJu0Yy0d44B1FrisxBpswQWploSCU5/e3Oj6bjdkPyWw2WbFHM/g5QN
        4MTKrX2OLPnrflg5HWpiCRbJAyx7UuwqS30vDXo=
X-Google-Smtp-Source: AGHT+IGjdTEMWT5dDZzHB7sl1DeRZKElA98jt/FYICjlSj2Icg9K7JbNqm2/OqZ/qR3A9bAqoQ9sX0yTlVBXvRMDKC8=
X-Received: by 2002:a92:c5d0:0:b0:345:df7f:efc4 with SMTP id
 s16-20020a92c5d0000000b00345df7fefc4mr741425ilt.27.1691721277269; Thu, 10 Aug
 2023 19:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <20230810113512.00000516@Huawei.com>
In-Reply-To: <20230810113512.00000516@Huawei.com>
From:   Maverickk 78 <maverickk1778@gmail.com>
Date:   Fri, 11 Aug 2023 08:04:26 +0530
Message-ID: <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan,

> More generally for the flow that would bring the memory up as system ram
> you would typically need the bios to have done the CXL enumeration or
> a bunch of scripts in the kernel to have done it.  In general it can't
> be fully automated, because there are policy decisions to make on things like
> interleaving.

BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
create an entry
in the e820 table?

>
> I'm not aware of any open source BIOSs that do it yet.  So you have
> to rely on the same kernel paths as for persistent memory - manual configuration
> etc in the kernel.
>
Manual works with "cxl create regiton"  :)

On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 9 Aug 2023 04:21:47 +0530
> Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> > Hello,
> >
> > I am running qemu-system-x86_64
> >
> > qemu-system-x86_64 --version
> > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> >
> +Cc linux-cxl as the answer is more todo with linux than qemu.
>
> > qemu-system-x86_64 \
> > -m 2G,slots=4,maxmem=4G \
> > -smp 4 \
> > -machine type=q35,accel=kvm,cxl=on \
> > -enable-kvm \
> > -nographic \
> > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
>
> There are some problems upstream at the moment (probably not cxl related but
> I'm digging). So today I can't boot an x86 machine. (goody)
>
>
> More generally for the flow that would bring the memory up as system ram
> you would typically need the bios to have done the CXL enumeration or
> a bunch of scripts in the kernel to have done it.  In general it can't
> be fully automated, because there are policy decisions to make on things like
> interleaving.
>
> I'm not aware of any open source BIOSs that do it yet.  So you have
> to rely on the same kernel paths as for persistent memory - manual configuration
> etc in the kernel.
>
> There is support in ndctl for those enabling flows, so I'd look there
> for more information
>
> Jonathan
>
>
> >
> >
> > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > shows only 2G memory which is System RAM, it's not listing the CXL
> > memory.
> >
> > Do I need to pass any particular parameter in the kernel command line?
> >
> > Is there any documentation available? I followed the inputs provided in
> >
> > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> >
> > Is there any documentation/blog listed?
>
