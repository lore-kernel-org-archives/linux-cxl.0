Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3524EC433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 201B9610A3
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 18:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhIJSrw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbhIJSrv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 14:47:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95DC061574
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:46:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m21-20020a17090a859500b00197688449c4so2100709pjn.0
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTU/OxOBQzMOY5lZxzMBSA+uw9+bBSKTTEEGkzUKB7I=;
        b=RbEh/nY0rMcpIs7qtyeZ/5T9pbKKpW8p1zOGDopbk3ZVPtEieInLYLoqT3pIORBNou
         SiOs1CcHn3rWTMWz73artTkQ3xhJ/Rt14fmpQ+a6EvqZGRmSisKbRAg/lh2RjkdILtLR
         qQekpm8GWDqfHkjMvkRzrF8Wd/4YQZAqLedONrlLBq6iTxxnicyUIqQ/VAuu3YE7xaX0
         TippGXr3JCy633tD9eDXMuT78fVpzRehIL7bVy09qbz/LrHb44mpVhMyYbBCN2924arE
         A1H6q9EG3YuQoNqlu3TLT9qGLNg9/YumzTBEs1QYhu+VhmGbdB+w80Ki1Im73JIGVVyj
         p8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTU/OxOBQzMOY5lZxzMBSA+uw9+bBSKTTEEGkzUKB7I=;
        b=CRYXLENchLDPmMKbvf7Tzd+ndd2JP4ZXC4Xmc2Nxm5jSUtk8prqgIcscd7DtrBug5Y
         UOS9Cf96ve/XW4nSFJqkpr1tWKlCT7ckuuwWhHjutA//UmBqLNgmqhaQYvPSbhk+hqv+
         i6tPv+Fpqpr+tajhchR6frgtT/pS0hk8OLAHYg0/4s51ZVyEws4vy7qPh2wmDOcH9wUV
         +y21ioMwN3N5mFa7rlsEBBE7eR2nAouCIoNi2BDulkAHLsEUvene0xj7+KEXr2U4kYYX
         DD1rnaHSxsy7ahJBaTlqam1w+96fSslTDMCogLUe4kwYYqu931/uYJtvakvUV/CZmMs4
         rNOw==
X-Gm-Message-State: AOAM530nZ0OxmhnsS2tjSscR/4BniX7CtO/WZIAnjmB1K+BZx4mc0Rpi
        ri9ljrAdSmDat2oPR+9wguyxcUVOD9RGHKoN85XfxQ==
X-Google-Smtp-Source: ABdhPJwB9TgWypz0/g7xsRwNkNwbdD2iH8E0KoZmkzh9ZR9X1/J898p/QAYSaO0x2g/OWBH0jw3DVrwKEb4bPzRVry8=
X-Received: by 2002:a17:90b:513:: with SMTP id r19mr10753479pjz.93.1631299599819;
 Fri, 10 Sep 2021 11:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116438489.2460985.12407123882806203553.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210910105313.00006408@Huawei.com>
In-Reply-To: <20210910105313.00006408@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 11:46:29 -0700
Message-ID: <CAPcyv4izawiBPyDNe-yeijy9nF+Ehdu5vrSffPT_pWbQvG8xFA@mail.gmail.com>
Subject: Re: [PATCH v4 17/21] tools/testing/cxl: Introduce a mocked-up CXL
 port hierarchy
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 10, 2021 at 2:53 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 8 Sep 2021 22:13:04 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Create an environment for CXL plumbing unit tests. Especially when it
> > comes to an algorithm for HDM Decoder (Host-managed Device Memory
> > Decoder) programming, the availability of an in-kernel-tree emulation
> > environment for CXL configuration complexity and corner cases speeds
> > development and deters regressions.
> >
> > The approach taken mirrors what was done for tools/testing/nvdimm/. I.e.
> > an external module, cxl_test.ko built out of the tools/testing/cxl/
> > directory, provides mock implementations of kernel APIs and kernel
> > objects to simulate a real world device hierarchy.
> >
> > One feedback for the tools/testing/nvdimm/ proposal was "why not do this
> > in QEMU?". In fact, the CXL development community has developed a QEMU
> > model for CXL [1]. However, there are a few blocking issues that keep
> > QEMU from being a tight fit for topology + provisioning unit tests:
> >
> > 1/ The QEMU community has yet to show interest in merging any of this
> >    support that has had patches on the list since November 2020. So,
> >    testing CXL to date involves building custom QEMU with out-of-tree
> >    patches.
> >
> > 2/ CXL mechanisms like cross-host-bridge interleave do not have a clear
> >    path to be emulated by QEMU without major infrastructure work. This
> >    is easier to achieve with the alloc_mock_res() approach taken in this
> >    patch to shortcut-define emulated system physical address ranges with
> >    interleave behavior.
> >
> > The QEMU enabling has been critical to get the driver off the ground,
> > and may still move forward, but it does not address the ongoing needs of
> > a regression testing environment and test driven development.
> >
> > This patch adds an ACPI CXL Platform definition with emulated CXL
> > multi-ported host-bridges. A follow on patch adds emulated memory
> > expander devices.
> >
> > Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> > Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> > Link: https://lore.kernel.org/r/20210202005948.241655-1-ben.widawsky@intel.com [1]
> > Link: https://lore.kernel.org/r/162982125348.1124374.17808192318402734926.stgit@dwillia2-desk3.amr.corp.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> A trivial comment below, but I'm fine with leave that one change in here
> as it is only a very small amount of noise.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
>
> > ---
> >  drivers/cxl/acpi.c               |   40 ++-
> >  drivers/cxl/cxl.h                |   16 +
> >  tools/testing/cxl/Kbuild         |   36 +++
> >  tools/testing/cxl/config_check.c |   13 +
> >  tools/testing/cxl/mock_acpi.c    |  109 ++++++++
> >  tools/testing/cxl/test/Kbuild    |    6
> >  tools/testing/cxl/test/cxl.c     |  509 ++++++++++++++++++++++++++++++++++++++
> >  tools/testing/cxl/test/mock.c    |  171 +++++++++++++
> >  tools/testing/cxl/test/mock.h    |   27 ++
> >  9 files changed, 911 insertions(+), 16 deletions(-)
> >  create mode 100644 tools/testing/cxl/Kbuild
> >  create mode 100644 tools/testing/cxl/config_check.c
> >  create mode 100644 tools/testing/cxl/mock_acpi.c
> >  create mode 100644 tools/testing/cxl/test/Kbuild
> >  create mode 100644 tools/testing/cxl/test/cxl.c
> >  create mode 100644 tools/testing/cxl/test/mock.c
> >  create mode 100644 tools/testing/cxl/test/mock.h
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 54e9d4d2cf5f..d31a97218593 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -182,15 +182,7 @@ static resource_size_t get_chbcr(struct acpi_cedt_chbs *chbs)
> >       return IS_ERR(chbs) ? CXL_RESOURCE_NONE : chbs->base;
> >  }
> >
> > -struct cxl_walk_context {
> > -     struct device *dev;
> > -     struct pci_bus *root;
> > -     struct cxl_port *port;
> > -     int error;
> > -     int count;
> > -};
> > -
> > -static int match_add_root_ports(struct pci_dev *pdev, void *data)
> > +__mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> >  {
> >       struct cxl_walk_context *ctx = data;
> >       struct pci_bus *root_bus = ctx->root;
> > @@ -239,15 +231,18 @@ static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device
> >       return NULL;
> >  }
> >
> > -static struct acpi_device *to_cxl_host_bridge(struct device *dev)
> > +__mock struct acpi_device *to_cxl_host_bridge(struct device *host,
> > +                                           struct device *dev)
> >  {
> >       struct acpi_device *adev = to_acpi_device(dev);
> >
> >       if (!acpi_pci_find_root(adev->handle))
> >               return NULL;
> >
> > -     if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0)
> > +     if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0) {
> > +             dev_dbg(host, "found host bridge %s\n", dev_name(&adev->dev));
>
> I didn't call it out in the previous review, but technically unrelated to the
> rest of the patch even if useful.

I'll delete it. It was added during development to debug the mocking
code, but it should have moved to a separate patch, or been dropped.
