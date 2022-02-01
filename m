Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E81C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Feb 2022 22:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbiBAWY6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Feb 2022 17:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiBAWY6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Feb 2022 17:24:58 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A576C06173B
        for <linux-cxl@vger.kernel.org>; Tue,  1 Feb 2022 14:24:58 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z131so16636448pgz.12
        for <linux-cxl@vger.kernel.org>; Tue, 01 Feb 2022 14:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u2EiycHzHs1b2F0/iUOQ5xWejurFd89dED1f6mm35uU=;
        b=Y0sGYPzdHJHWs/JbjpkQqTUt5gZlw5M1EoAw2VCHVnpy4C8y8DiEYyXlYCBQdlxmSu
         adcAvLvEfHcEoTBXYXNvloavzagYMZp8M6InndBAYrNCgogFr2RlS4bq9bUYqwcQMAW8
         McrP08GZRkUZm0ZyBltFlqcHvImGOojGi8MBpz4622WPOyXvkN8JM3bZ0q9O+QBx9dZW
         Wf3aBKhd2/E9HgPnIuFon6fdVkHIpctaeUgWs2UF/N55V+Ot0GqKd8EvHILBGPiNaqlI
         a1ccCsnmFN2MTcFf5QsNTrave0mukNCYHR7wvvoqLrNa1+4xbkjWYlhQYukUAt+A3r10
         8W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u2EiycHzHs1b2F0/iUOQ5xWejurFd89dED1f6mm35uU=;
        b=JJSuAvWvx9g08aOIzq8xwm+GexjgfrW59jNbwzg4sfKhoDBFa5v8Vj9ACpEJ6WG/y4
         2BtQLs1CIHNmxQl1Mfu7CKaeaOpIFlYABNlxJjOO9zqdIbq6gsu80YnplV9uGQq+P9AG
         X2dLhYRZQyg28zjWQ4Fisa1PvFrsK4B4kuS3yANpb7wesEFSDWLMnIwt/9tvnjjTyx+v
         +hLCzorzjcsqPnXmGSVbr262E+pYVfVOY+rs2QHzgrsBHK+cQQm+rX59VzNwKgs2iudv
         vXptcb5p1qMg5LGJlD1WI0n4L0p0aLM86QZxKCltWnCerSt0m5VussQVCaA41P1z736z
         h/mw==
X-Gm-Message-State: AOAM530JPZQnfhwQQVOFcHyzP3Z92zOa+OtPem7DZo2TzGObCEfxoLPu
        muxzRf0kNEQWKtoYR+dn7ecXNDoTcrAsPqMylv4c7g==
X-Google-Smtp-Source: ABdhPJwTDsUmAvr06z8oPX9E1R3lrXOzRtesNHE2KuqBx7W0JHyBi+Kv07nLiKYh4+e2w4FdOlqvPRpyYYDAbwHQN1g=
X-Received: by 2002:a63:550f:: with SMTP id j15mr22088163pgb.40.1643754298047;
 Tue, 01 Feb 2022 14:24:58 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298426273.3018233.9302136088649279124.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131181924.00006c57@Huawei.com> <20220201152410.36jvdmmpcqi3lhdw@intel.com>
 <CAPcyv4iyRKfviJNtHP=wsqRtppDb+BrmhNeum+ZcyBAJ5VSPtA@mail.gmail.com>
 <20220201221114.25ivh5ubptd7kauk@intel.com> <CAPcyv4hYSm+q1RYnrdNvr_dXsU-OZ-v94RRvNGtr5-wtHc97=w@mail.gmail.com>
 <20220201222042.hv2xipmuous7s7qh@intel.com>
In-Reply-To: <20220201222042.hv2xipmuous7s7qh@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 14:24:51 -0800
Message-ID: <CAPcyv4hhOa8hRdy3R8oiuw9Whfke-s67KfvcazP4VFuhuXCtsQ@mail.gmail.com>
Subject: Re: [PATCH v3 27/40] cxl/pci: Cache device DVSEC offset
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 1, 2022 at 2:20 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-02-01 14:15:22, Dan Williams wrote:
> > On Tue, Feb 1, 2022 at 2:11 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >
> > > On 22-02-01 13:41:50, Dan Williams wrote:
> > > > On Tue, Feb 1, 2022 at 7:24 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >
> > > > > On 22-01-31 18:19:24, Jonathan Cameron wrote:
> > > > > > On Sun, 23 Jan 2022 16:31:02 -0800
> > > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > > >
> > > > > > > From: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > >
> > > > > > > The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
> > > > > > > be implemented by CXL 2.0 endpoint devices. Since the information
> > > > > > > contained within this DVSEC will be critically important, it makes sense
> > > > > > > to find the value early, and error out if it cannot be found.
> > > > > > >
> > > > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > > > Guess the logic makes sense about checking this early though my cynical
> > > > > > mind says, that if someone is putting in devices that claim to be
> > > > > > CXL ones and this isn't there it is there own problem if they
> > > > > > kernel wastes effort bringing the driver up only to find later
> > > > > > it can't finish doing so...
> > > > >
> > > > > I don't remember if Dan and I discussed actually failing to bind this early if
> > > > > the DVSEC isn't there.
> > > >
> > > > On second look, the error message does not make sense because there is
> > > > "no functionality" not "limited functionality" as a result of this
> > > > failure because the cxl_pci driver just gives up. This failure should
> > > > be limited to cxl_mem, not cxl_pci as there might still be value in
> > > > accessing the mailbox on this device.
> > > >
> > > > > I think the concern is less about wasted effort and more
> > > > > about the inability to determine if the device is actively decoding something
> > > > > and then having the kernel driver tear that out when it takes over the decoder
> > > > > resources. This was specifically targeted toward the DVSEC range registers
> > > > > (obviously things would fail later if we couldn't find the MMIO).
> > > >
> > > > If there is no CXL DVSEC then cxl_mem should fail, that's it.
> > > >
> > >
> > > If there is no CXL DVSEC we have no way to find the device's MMIO. You need the
> > > register locator dvsec. Not sure how you intend to do anything with the device
> > > at that point, but if you see something I don't, then by all means, change it.
> >
> > I see:
> >
> > pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
> >
> > ...and:
> >
> > pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, CXL_DVSEC_REG_LOCATOR);
> >
> > ...aren't they independent?
>
> My mistake. I was thinking of a different patch, "cxl/pci: Retrieve CXL DVSEC
> memory info". You're correct, they are independent (both mandatory for type 3
> devices).
>
> However, Jonathan was the one who originally suggested it. I had it as a warn
> originally.
> https://lore.kernel.org/linux-cxl/20211122223430.gvkwj3yeckriffes@intel.com/

At least to the concern of "nothing" working without the base CXL
DVSEC the cxl_mem driver failing to attach catches that case.
Otherwise a device that only implements the mailbox seems not outside
the realm of possibility. Jonathan?
