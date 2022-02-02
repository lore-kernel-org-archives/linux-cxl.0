Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D9AC43219
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 15:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiBBPov (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbiBBPou (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 10:44:50 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0ACC06173B
        for <linux-cxl@vger.kernel.org>; Wed,  2 Feb 2022 07:44:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z5so18638154plg.8
        for <linux-cxl@vger.kernel.org>; Wed, 02 Feb 2022 07:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGLMWM6Y1bKurzXYC7D1UpkKTONcroCJv+sUS8+G3fk=;
        b=oAsuNoeuBakCdBEHynR3D8MON2hWZXsKI9XI297BBNUhha9c5YL8xp0RCdMb8JU+/k
         ieW+QU4GNQqS6tdyJcoU27SbO29Y0ANPws4KLSzMa/M3CSP8C0wZKBwczBLLw3gPnNAN
         Gl6cZyMGNMFWjboPOPGFZtz1LNlSqjmBOf55RkOfHZzI36rRUBekQHNylrwPdS6ljBg+
         fjpSn/M8F31lQorK+FtiHoJjVSPDQ6eewGwlZPXsUljURYxNzEbTZ1uLwVx57muEeyIY
         7mUbwW6n+qnN0pxVKKhvuFbQWfS1lylV5SAQJt8d1EDFzucGM5+CwnURCeX0Ni+iUl60
         4WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGLMWM6Y1bKurzXYC7D1UpkKTONcroCJv+sUS8+G3fk=;
        b=Ta2bpTcNVkrkaxrxphPj4AXUBd2aICkgRJph92ZzwUhKnRc3yZaQLaq4VXi4jT/HRy
         fNDW4P8RXInAyVw8mQy7ZTnIQFOAM3cAXtbw2+3+pX2/GIOoNz2KjhJj87B9W8nUNq6D
         GK/z+EfGpcVMuyrjYoyfKLRZK0JdhU1GiDmMoPLWEkKeWa2wagGUbIQzvLfy3C4mJS+v
         N9U5e/Icf+UHBFwjxobr/pg+kGUnxoNutkMl7VrL5Y9EmSUu1JS9WG5ZLu/n7/mCPqCX
         TrJfLMttx27devo2OIsm/Va9XFemnCT8DDwGzKYoRSNtGBz+lsJSlFsG6+J0PgwEqfKi
         kAGQ==
X-Gm-Message-State: AOAM530rccGAQHZ1LLOTXrDBmCXmt/A/kAMk4byZRGz4SRHMVVep54xX
        RQJk5mJC48fU4fnO/PpoEi5ki/UBKunHhvmXeO6ubA==
X-Google-Smtp-Source: ABdhPJyfNfM+gsqWl5W1Qo2NaPXgRGSdgmEDd2DqFNA9P0isGwV8K8W3Z3JrGGkyrmxZ/kz8+YCi0/483ncGEhKz54Y=
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr31615433pll.147.1643816689833;
 Wed, 02 Feb 2022 07:44:49 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131184126.00002a47@Huawei.com> <CAPcyv4iYpj7MH4kKMP57ouHb85GffEmhXPupq5i1mwJwzFXr0w@mail.gmail.com>
 <20220202094437.00003c03@Huawei.com>
In-Reply-To: <20220202094437.00003c03@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 2 Feb 2022 07:44:37 -0800
Message-ID: <CAPcyv4hwdMetDJ-+yL9-2rY92g2C4wWPqpRiQULaX_M6ZQPMtA@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 2, 2022 at 1:45 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 1 Feb 2022 15:57:10 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Mon, Jan 31, 2022 at 10:41 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Sun, 23 Jan 2022 16:31:24 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > While CXL memory targets will have their own memory target node,
> > > > individual memory devices may be affinitized like other PCI devices.
> > > > Emit that attribute for memdevs.
> > > >
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Hmm. Is this just duplicating what we can get from
> > > the PCI device?  It feels a bit like overkill to have it here
> > > as well.
> >
> > Not all cxl_memdevs are associated with PCI devices.
>
> Platform devices have numa nodes too...

So what's the harm in having a numa_node attribute local to the memdev?

Yes, userspace could carry complications like:

cat $(readlink -f /sys/bus/cxl/devices/mem0)/../numa_node

...but if you take that argument to its extreme, most "numa_node"
attributes in sysfs could be eliminated because userspace can keep
walking up the hierarchy to find the numa_node versus the kernel doing
it on behalf of userspace.
