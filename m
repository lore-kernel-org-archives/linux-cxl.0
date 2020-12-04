Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3716DC4361B
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Dec 2020 05:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D049F224F4
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Dec 2020 05:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLDFz5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Dec 2020 00:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgLDFz5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Dec 2020 00:55:57 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7449C061A52
        for <linux-cxl@vger.kernel.org>; Thu,  3 Dec 2020 21:55:16 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id bo9so6925262ejb.13
        for <linux-cxl@vger.kernel.org>; Thu, 03 Dec 2020 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DIoLkigUuznfdpJqxDjdyVPo16yJcn8VeLLf3HKKfVg=;
        b=pbc1yrtgx+wgsvpYgsLRbScGtqczaf0MaDPhFoVvvISZ+h8Zy5m0wpbSSEpqwJItqJ
         UvGqgtNanJD2reHF93w6+iTlGe5OBH3qXpnkh9s8HkCix6izgbLs6nnSMXxE1833mPr+
         RWh8c4Zj88RQsnRioL9WWiTjw2NAIltt7JnO553QWgP86tLASoFNlTVJMErR/F8bnYrq
         /rbSAa9iGgcoIJ7tYp7S1CREgCwmAf9tamY+Byvy3l7Y28GO8cRB/EMKVibGrguo5hsw
         uCKxC54U4vRQy/1QfX2UMuklH5w8xP3OSya1vmw10Ng89MPf1oQZAdZYKpC9IXwaTZYI
         ZVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DIoLkigUuznfdpJqxDjdyVPo16yJcn8VeLLf3HKKfVg=;
        b=KcxQWtPlAi4gcXw+KzRDv/iWq9iiioU0y1Pl0ojqrFQrYe8x2wfHN8L7CzqUfZeL7V
         mGMFM+eOfihf2/s0iQZBCeeCx5bFma7DQYj9fMMH0UzbYZrAvLD2px7MXV1K6dAp8Ch5
         UxCIvow6kyA/4zfcZP0B5L7+dhSELj/IodZrFLX8qlycqPHNp6meEc5B2+T1rlIJZSzb
         zlJBN1FPvnE26xJ5/p9yt4QqvqNgBbMFV3RXYJX0d75Xchag/58nY1fQDW+bbOTHgatx
         MNEAjswfpAL8Z5MhLlUvj0hjurQ/5jmUjhvpJABv6gv020+hmrR8jjpkV4Yf/G2dkHeG
         IIQQ==
X-Gm-Message-State: AOAM532zri5DuRzGCVxYB0sJao/ek4FggTatprHJt3UKsSJlQ9N+ekDv
        QhK1uV0S84bftMoLgySA0yjhxRJbEmcJO2Ts9a9gCA==
X-Google-Smtp-Source: ABdhPJw2TzrWyUsCRvLdNEwmuBMOzw873S9kH9iIgqr8MHImp46vGMCYz+KXcbSF3d9ywbs/waIdVzkz15siCXWeDFY=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr5743570ejk.323.1607061315701;
 Thu, 03 Dec 2020 21:55:15 -0800 (PST)
MIME-Version: 1.0
References: <A0F02678-46AD-4AC7-92C3-9BEF3B3284DE@avery-design.com>
In-Reply-To: <A0F02678-46AD-4AC7-92C3-9BEF3B3284DE@avery-design.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Dec 2020 21:55:11 -0800
Message-ID: <CAPcyv4gk5AcsOhzZEu57NWr9CBXQONyOkzXfSNZiFXP4Kj2G9g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/25] Introduce CXL 2.0 Emulation
To:     Chris Browy <cbrowy@avery-design.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

[ add linux-cxl for the Linux driver question ]


On Thu, Dec 3, 2020 at 9:10 PM Chris Browy <cbrowy@avery-design.com> wrote:
[..]

I'll let Ben address the other questions...

> 4. What are the userspace system APIs for targeting CXL HDM address domain?
>    Usually you can mmap a SPA if you know how to look it up.

tl;dr: /proc/iomem and sysfs

There are a lot of moving pieces to this question. Once a CXL.mem
device is mapped the driver will arrange for it to appear in
/proc/iomem. If it is persistent memory it will be accessed through a
/dev/pmem or /dev/dax device, and if it is volatile it will show up as
just another "System RAM" range. The System RAM range may end up with
a unique Linux NUMA node id. Alternatively, if the BIOS maps the
device then the BIOS will set up the EFI memory map + ACPI
SRAT/SLIT/HMAT for Linux to interpret.

Once something shows up in /proc/iomem it was traditionally accessible
via /dev/mem. These days though /dev/mem is slowly being deprecated
due to security (see CONFIG_LOCK_DOWN_KERNEL*) and stability (see
CONFIG_IO_STRICT_DEVMEM)  concerns, so depending on your kernel
configuration tools may not be able to use /dev/mem to map the SPA
directly and will need to go through the driver provided interface.

The driver needs to be able coordinate coherent HDM settings across
multiple devices in an interleave, all switches in the path, and the
root bridge(s). So I am expecting a sysfs interface similar to the
nvdimm-subsystem and device-dax-subsystem where there will be
sysfs-files to enumerate the mappings and a provisioning mechanism to
reconfigure HDMs with various interleave settings. For a flavor of
what this might look like see the description of NVDIMM "Region"
devices:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/nvdimm/nvdimm.rst#n469

The difference will be that unlike the nvdimm case where regions are
platform-firmware-defined and static, CXL regions are runtime dynamic.
