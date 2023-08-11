Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB5C001B0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 02:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjHKCWi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 22:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHKCWh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 22:22:37 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D12727
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 19:22:37 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34914684b62so5646725ab.3
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 19:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691720557; x=1692325357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XbbCx49wRpP4DxUXKnhwVZHka1TPFZPDIatFvbZ4Jug=;
        b=YEUdjllhtxycgD6IrlkShVoS8icFqsXRe9CcGz9/FpruV/EetUADiuAw/HHt3bgjVf
         SO/IeQCGMqVNj/KoRggxjNy9bNjFr/DWoAQLS6SsPrs27td/rRqxv6/Gu86ByYyw4KEY
         Y+L/Wq5HewHpPMROUFaiJFTyZhsqvknVdlqdpErpw35gF3oCd8I1IknxLDJxaoASM2RZ
         rWhuzTedKhrnVsvBDM5X9jAcirlxs4Ljl0KLl4gdUlIe84djSx023hDIpqYFP0Pygscn
         s0mLM2sMCZJ6wX1WoX0HBafa+F1cUnuEJL1VSrW51hMonHMB66x9ffeY8CcbdHieDiLb
         mCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691720557; x=1692325357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbbCx49wRpP4DxUXKnhwVZHka1TPFZPDIatFvbZ4Jug=;
        b=YIJNrPk5/O8DEZ7kviMszhr8iMxn9wtvNbRjQ2J+XhNCUBAgmPZn4El0AhCGabCRCA
         kvD2nykN/eXBCoGSW4bRcXVFADn6Rx1gIQNLdYaXUXHHeVByv2YUVmswER/5ivMe4Zzc
         MLZkaR35eHcTWu5aTyrOm9MOqvG//z1fk8NDEAJCB/hZCfXQHLggmvgzDcx3CazVTRFk
         uGPCBY+FVef1TEJxh5O18cHhUPbzjuX1Pdka8j70acSmR7ky34DFxGzrL7EvEYa5+tjk
         ACvxORVG8GiYpZunAJlNQE6va7ZOEIbt8KiO5f2v4QyXSc5koVoGX/qhGPr6PpQM6xJ4
         AG8Q==
X-Gm-Message-State: AOJu0YzBMcdbYUuwr/WizhbFCKRnn+aZu+HfYcWysespZLRS04qOm+9/
        SSqH0VCmbvJmoWo+9Pa+nBiCoICUhwtUSEf0X8Z/iWvO
X-Google-Smtp-Source: AGHT+IHjqUSZ3i7Fjwy9A3JxZl5rrWF0bAn3QNc5pbA8T/p6nOJcvtBFCa0gr2CX3ROLjxdbLWJXLubuKjQJeGm7MgI=
X-Received: by 2002:a05:6e02:1be2:b0:348:1a1d:79a5 with SMTP id
 y2-20020a056e021be200b003481a1d79a5mr773169ilv.15.1691720556754; Thu, 10 Aug
 2023 19:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <ZNURN6Zzf2hJfmt/@debian>
In-Reply-To: <ZNURN6Zzf2hJfmt/@debian>
From:   Maverickk 78 <maverickk1778@gmail.com>
Date:   Fri, 11 Aug 2023 07:52:25 +0530
Message-ID: <CALfBBTuRdwCcc-A88kMN7iub9BHx2xfFkfP8Lbrc+oSwfCS2nw@mail.gmail.com>
Subject: Re: CXL volatile memory is not listed
To:     Fan Ni <fan.ni@gmx.us>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thanks Fan,

cxl create-region works like a charm :)

Since this gets listed as "System Ram(kmem)", I guess the kernel
treats it as regular memory and
allocates it to the applications when needed?
or is there an extra effort needed to make it available for
applications on the host?

On Thu, 10 Aug 2023 at 22:03, Fan Ni <fan.ni@gmx.us> wrote:
>
> On Wed, Aug 09, 2023 at 04:21:47AM +0530, Maverickk 78 wrote:
> > Hello,
> >
> > I am running qemu-system-x86_64
> >
> > qemu-system-x86_64 --version
> > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> >
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
> If I remember it correctly, for volatile cxl memory, we need to create a
> region and then it will be discovered as system memory and shows up.
>
> Try to create a region with "cxl create-region".
>
> Fan
> >
