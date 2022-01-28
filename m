Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C18C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Jan 2022 16:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349970AbiA1QMW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349962AbiA1QMS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Jan 2022 11:12:18 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D7C061714
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 08:12:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a8so6535534pfa.6
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jan 2022 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4XDP4FOeGqahS7Rn4xuF3+f8E2dTa8FQY96aPdzW5WA=;
        b=Ai2ZkES64gkX3KJkf3p8Zv7oKXF/FScWI7VZwiSmF/Yk+kCTEhz9ar/HVEPkG07Ubh
         BQ6EWUkOKCOwAjEQPDUg281RnxCgIwktC0xf2jXntXoYN/9PIrSYCesEG5BmZBx89QQz
         VxcCC00R6aYq95PhDSQKsr+02oxKF9yywKEX8pYBQpFsnknE3vSFQee7Lj7i9O6HKZDK
         6RbmC6Hp1UTahFpV8P/X2QxAYiBOIYPqj1uPQcEDAoVFAZQqGk9tqBEJ/CbhswGoCVp/
         /ebBxlaeUoWCKJ8gWw+Q0pwlJySI8gJ24nA1aUQ8Z6CLKSwNwzcn7fLXmpph2XwSw0se
         h2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4XDP4FOeGqahS7Rn4xuF3+f8E2dTa8FQY96aPdzW5WA=;
        b=aUm5Fyqy8fzbrRlU1MKzPeF9w0sNeTgOnH+QuRlDoRdi6nwou4gXkfKXvlfzoNDA87
         dq+b3Q/I069tujRYtz0zIgVE75rh0UgVTfOL/1T9FuJ3v0A/90ApB/f2flXB4KK0boRF
         lix8IDTpl7QVnRbE3jENjmzf3WpHi80gV29K/yH85Ao7HKkmL9VQyi8Kqea6mqO2Lbni
         f4Yc0+1h2keJWpHKflH17TEid8pqkpE0bLolcE1uMABK+5a/tMvBNT8UQMzZ3PzbWxa2
         JmQYhhNoi5ABg/9pEWMa3agNqgQzKqSqVSfGz7MXlEWr3GW3aXdBP4TsnM7TVK3gnYmm
         YOWw==
X-Gm-Message-State: AOAM530laBM/FrcdJMzH2M35Gy4yVOpm0dMVu6KVlm4OyZHT7x+Umu83
        6Gn3CoNKvhaHfRN4nfedI0Gz6lW+KtyIzdjDtRHq4g==
X-Google-Smtp-Source: ABdhPJyhm+TKPFClKDdTUZrdV6Ju4KMi0dCtjFwY9qSH7mSedbj4buJx+/jlarX+qYvDNtg1KbNZc76IaDq0reL32ok=
X-Received: by 2002:a05:6a00:1508:: with SMTP id q8mr8649754pfu.3.1643386338161;
 Fri, 28 Jan 2022 08:12:18 -0800 (PST)
MIME-Version: 1.0
References: <07cedbe6-00ab-52fc-9475-c8d7120f5a95@jagalactic.com>
 <0100017e9c54d4e0-c1f1a7db-e2ab-4552-a7eb-8e4b56cd9528-000000@email.amazonses.com>
 <02c601d813fc$a8744c70$f95ce550$@montage-tech.com> <CAPcyv4hWcxoEw=umN=0xDe4Ychfxe6GysYOBcxK6oHLEDhz1iw@mail.gmail.com>
 <20220128102458.00006063@Huawei.com>
In-Reply-To: <20220128102458.00006063@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jan 2022 08:12:08 -0800
Message-ID: <CAPcyv4jfObmFdUnumYzYNO-EMXGriutDDodwNZaDyLjHBDiWcg@mail.gmail.com>
Subject: Re: Should bios always mark CXL DRAM as EFI_MEMORY_SP?
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Li Qiang (Johnny Li)" <johnny.li@montage-tech.com>,
        John Groves <john@jagalactic.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        John Groves <JGroves@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 28, 2022 at 2:25 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 27 Jan 2022 21:28:40 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Thu, Jan 27, 2022 at 8:12 PM Li Qiang (Johnny Li)
> > <johnny.li@montage-tech.com> wrote:
> > >
> > > I think BIOS should follow CDAT spec v1.01 Device Scoped EFI Memory T=
ype Structure (DSEMTS) structure
> > >
> > > In Table 8 Device Scoped EFI Memory Type Structure, field EFI Memory =
Type and Attribute has below definition
> > >   0 =E2=80=93 EfiConventionalMemory
> > >   1 - EfiConventionalMemory Type with EFI_MEMORY_SP Attribute
> > >   2 =E2=80=93 EfiReservedMemoryType
> > >   3-255 =E2=80=93 Reserved encoding
> > >   The memory attribute EFI_MEMORY_NV may be inferred from NonVolatile=
 flag in DSMAS.
> > >   Memory types other than EfiConventionalMemory and EfiReservedMemory=
Type are not permitted.
> >
> > Definitely BIOS should follow CDAT for the type, but it's not so clear
> > to me the same can be said about the attribute. I think the bigger
> > question is when should devices claim to be EFI_MEMORY_SP, and when
> > should BIOS apply EFI_MEMORY_SP regardless of what the device
> > advertises. EFI_MEMORY_SP is a claim about usage that the memory is
> > either too high performance or too low performance to be added to the
> > general memory pool by default. That's not a decision that a device
> > necessarily knows how to make on its own. The platform BIOS might have
> > a better chance to know intended application the system was built. The
> > OS kernel is somewhat blind to usage but OS policy can do the last
> > mile tuning of how much if any memory of a given performance class
> > should be set aside for exclusive access.
>
> I'd add another spin based on where EFI_MEMORY_SP originally came from,
> though it's not relevant to memory only devices which I think is what
> is being discussed here.
>
> For some devices the memory will work fine as general purpose RAM, but
> it was put there with an intended use.  Typically something like DDR
> attached to a GPU or other accelerator.  Might be nice and quick for
> general use, but it's even quicker if the GPU is using it :)
>
> Again, how much to reserve for what usecase is an OS policy decision
> hence the hint from the attribute.  Neither the device nor the
> bios can know the answer as it depends on what is actually being run
> in the OS.

I agree this was one of the original motivations, but every time I
talk to a GPU developer and bring up the case of the OS taking a page,
and pinning it indefinitely, they balk. So I think this case is
covered by setting the type to EfiReservedMemory (hard-reserved) and
the GPU driver owns the policy about giving the memory to the OS
general pool, if ever.
