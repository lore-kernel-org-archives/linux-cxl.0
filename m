Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B23AC433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Sep 2021 15:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA9061051
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Sep 2021 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhIGP7G (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhIGP7F (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Sep 2021 11:59:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C9C06175F
        for <linux-cxl@vger.kernel.org>; Tue,  7 Sep 2021 08:57:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x7so7588463pfa.8
        for <linux-cxl@vger.kernel.org>; Tue, 07 Sep 2021 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eeeG0Dps7JbDocH3TygyWjfVW5Um9ryVeIM7O18tPW4=;
        b=rYxGlvFdDtaTuEC/AsbxVNeQn8PI6ZF0b0c6mdZxyz0ZeUOQnrok5dpDKvT/FuoKVO
         DlDBPLSSDd/Poqj7+A2bQno41+PIaxZOAKPOTqKdj9kNsUHElJroePE0aQlyZBNWiAKN
         /mGyNLG4CwDK+rdWbRu81csRxJ7z0UXjfFJOWnSA4PW1oP6xNMdo40d4rNo9FEcMF+JQ
         68SH4fWO7cevIQH7LdRylEMWgvp76nmjWLd4um44rRvgcdZawJGzz5Dzi3/nJT957tjW
         CZL0jVBMKX8UzwV2etTjqOiPa8UsiulmMRKlL3lA/NJ2j+ijaJQeSgBPab1KJ2Rnkb08
         pwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eeeG0Dps7JbDocH3TygyWjfVW5Um9ryVeIM7O18tPW4=;
        b=SlZY9o+7zAihEqYnVPhY6jgpBtJ0Ry6GJR95W5tgqycn5HV+FEdRrs9Wix6QmdcsqD
         hlpxbNikAxJEhmbBjlCigXCHaiwJ7gTD2el22s0ygpF5NRqFDHmgtIW/YYSIhJTjznkD
         Accy9Xdml2RIJYqNgPt6sKcJ34rIb//pNguPa/k7w9luUXMf9LPuvP7VYWYoXiAxnFKF
         VtMJWQXBQvL8hd8jZFFtcr+mFm/yJ6zcEEM/tANo8/XhzwPvw/k39VRV+lnM+1FyCdW1
         G/KCbcrBYlsVRgGoX8PZ3qqEBKAx7NWDYHYHwBYqsENXmhPmIxIlmAmX13cAAsVgJDww
         epRw==
X-Gm-Message-State: AOAM530x5qiHUm4QMwxjugRN8XOwLi2lizmijYsCdOpB8r6u9NanaV/e
        zigyT59vQRZeoywlDNBWPv1Tz7/b5HmU+l5RES1iBw==
X-Google-Smtp-Source: ABdhPJyDCFqNgmxJ6V1x16+sVXHv5g2F5t0sUOXByAqBz9/Xjty38j66cZYvY2klkiYABa3huUronGHvjKuzdN9X5tw=
X-Received: by 2002:aa7:9255:0:b0:415:ba53:e6f5 with SMTP id
 21-20020aa79255000000b00415ba53e6f5mr11473890pfp.78.1631030278548; Tue, 07
 Sep 2021 08:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162982125348.1124374.17808192318402734926.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210903135243.000064ac@Huawei.com> <CAPcyv4ik1e4rvys5x66iD1+-M4G_NdsEcs24m2y3MYzhpYsrOA@mail.gmail.com>
 <20210906093207.00006766@Huawei.com>
In-Reply-To: <20210906093207.00006766@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 Sep 2021 08:57:47 -0700
Message-ID: <CAPcyv4ghCftjZOKXZ8vVUpEd2nNfDGS5yk+DWP+=9XYy3iWTdg@mail.gmail.com>
Subject: Re: [PATCH v3 24/28] tools/testing/cxl: Introduce a mocked-up CXL
 port hierarchy
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 6, 2021 at 1:32 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 3 Sep 2021 14:49:34 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Fri, Sep 3, 2021 at 5:53 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 24 Aug 2021 09:07:33 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > Create an environment for CXL plumbing unit tests. Especially when it
> > > > comes to an algorithm for HDM Decoder (Host-managed Device Memory
> > > > Decoder) programming, the availability of an in-kernel-tree emulation
> > > > environment for CXL configuration complexity and corner cases speeds
> > > > development and deters regressions.
> > > >
> > > > The approach taken mirrors what was done for tools/testing/nvdimm/. I.e.
> > > > an external module, cxl_test.ko built out of the tools/testing/cxl/
> > > > directory, provides mock implementations of kernel APIs and kernel
> > > > objects to simulate a real world device hierarchy.
> > > >
> > > > One feedback for the tools/testing/nvdimm/ proposal was "why not do this
> > > > in QEMU?". In fact, the CXL development community has developed a QEMU
> > > > model for CXL [1]. However, there are a few blocking issues that keep
> > > > QEMU from being a tight fit for topology + provisioning unit tests:
> > > >
> > > > 1/ The QEMU community has yet to show interest in merging any of this
> > > >    support that has had patches on the list since November 2020. So,
> > > >    testing CXL to date involves building custom QEMU with out-of-tree
> > > >    patches.
> > >
> > > That's a separate discussion I've been meaning to kick off. I'd like
> > > to get that moving because there are various things we can do there
> > > which can't necessarily be done with this approach or at least are easier
> > > done in QEMU. I'll raise it on the qemu list and drag a few people in
> > > who might be able to help us get things moving + help find solutions to
> > > the bits that we can't currently do.
> > >
> > > >
> > > > 2/ CXL mechanisms like cross-host-bridge interleave do not have a clear
> > > >    path to be emulated by QEMU without major infrastructure work. This
> > > >    is easier to achieve with the alloc_mock_res() approach taken in this
> > > >    patch to shortcut-define emulated system physical address ranges with
> > > >    interleave behavior.
> > > >
> > > > The QEMU enabling has been critical to get the driver off the ground,
> > > > and may still move forward, but it does not address the ongoing needs of
> > > > a regression testing environment and test driven development.
> > >
> > > Different purposes, so I would see having both as beneficial
> >
> > Oh certainly, especially because cxl_test skips all the PCI details.
> > This regression environment is mainly for user space ABI regressions
> > and the PCI agnostic machinery in the subsystem. I'd love for the QEMU
> > work to move forward.
> >
> > > (in principle - I haven't played with this yet :)
> >
> > I have wondered if having a version of DOE emulation in tools/testing/
> > makes regression testing those protocols easier, but again that's PCI
> > details where QEMU is more suitable.
>
> Maybe, but I'm not convinced yet.  Particularly as the protocol complexity
> that we are interested in can get pretty nasty and I'm not sure we want
> the pain of implementing that anywhere near the kernel (e.g. CMA with
> having to hook an SPDM implementation in).
>
> Could do discovery only I guess which would exercise the basics.
> >
> > >
> > > >
> > > > This patch adds an ACPI CXL Platform definition with emulated CXL
> > > > multi-ported host-bridges. A follow on patch adds emulated memory
> > > > expander devices.
> > > >
> > > > Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> > > > Link: https://lore.kernel.org/r/20210202005948.241655-1-ben.widawsky@intel.com [1]
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
>
> ...
>
>
> >
> > >
> > > > +     struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> > > >
> > > >       if (!bridge)
> > > >               return 0;
> > > > @@ -319,7 +316,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> > > >       struct acpi_cedt_chbs *chbs;
> > > >       struct cxl_port *root_port = arg;
> > > >       struct device *host = root_port->dev.parent;
> > > > -     struct acpi_device *bridge = to_cxl_host_bridge(match);
> > > > +     struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> > > >
> > > >       if (!bridge)
> > > >               return 0;
> > > > @@ -371,6 +368,17 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
> > > >       return 1;
> > > >  }
> > > >
> > > ...
> > >
> > >
> > > > diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
> > > > new file mode 100644
> > > > index 000000000000..4c8a493ace56
> > > > --- /dev/null
> > > > +++ b/tools/testing/cxl/mock_acpi.c
> > > > @@ -0,0 +1,109 @@
> > >
> > > > +static int match_add_root_port(struct pci_dev *pdev, void *data)
> > >
> > > Hmm. Nice not to duplicate this code, but I guess a bit tricky to
> > > work around.  Maybe a comment next to the 'main' version so we
> > > remember to update this one as well if it is changed?
> >
> > I'd like to think that the __mock annotation next to the real one is
> > the indication that a unit test might need updating. Sufficient?
>
> Agreed in general, but this particular function isn't annotated, the
> caller of it is, so people have to notice that to be aware there is
> a possible issue.  If the change is something local to this they might
> not notice.

The regression test will notice. Its primary function is to catch
regressions of this nature.


[..]
> > > why that size?  Should take window_size into account I think..
> >
> > This *is* the window size, but you're right if ->interleave_ways is
> > populated above and used here ->window_size can also be populated
> > there. Then all that is left to do is dynamically populate the
> > emulated ->base_hpa.
>
> Ok, so my confusion is that this code is alays using SZ_256M * ways
> rather than say SZ_512M * ways.
>
> Perhaps a define at the top of the file or even a module parameter
> to allow larger sizes?

I changed this to put the size in the table definition directly so it
can be edited there. The intent is for this size to be static / known
to the unit test in advance. I.e. unlike QEMU testing where the test
would need to be told of the configuration that was specified to the
VM.
