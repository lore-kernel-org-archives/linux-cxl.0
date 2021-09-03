Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2570C433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F26260E93
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 17:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhICRwd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhICRwc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 13:52:32 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F045C061575
        for <linux-cxl@vger.kernel.org>; Fri,  3 Sep 2021 10:51:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x19so103293pfu.4
        for <linux-cxl@vger.kernel.org>; Fri, 03 Sep 2021 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B42gsDWG6sRhF8u1dVxsiIOrQG1CZU86y4GnMNNM3og=;
        b=UYqUXm1HSA1fkpMppgozipb6YR2uES6VTVF5TnR2wMBh/4PelrdClptrhHH1zPHsOT
         lH+D9eXX32ZBO1/kzrFQkw77zY/tym2SEtuTSfarEUFvG5PTZNOr6U78OS7T8mYDDaLY
         T+YA/DzVdydXqRJe9af8jMHvD9ABvn9LgKUzyyJZU21kZjt2tantYVyCm4rzBYd3deEY
         S197O+deImOUEMM+fSeHu0Wz3U3Gr4BVsdEW+Xzo8a2TLsIbPGggocA7mg5/HzraXtrZ
         bJsK7v4cg52VwnVKL0VRjkJ1LbGXaV1mMzgXnPB4pZ4iH0iZsKypmrsvWgIeO6KQ5s9m
         RaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B42gsDWG6sRhF8u1dVxsiIOrQG1CZU86y4GnMNNM3og=;
        b=c84ySRkw6Sk+hklXx2qF5+J6BxK12BApT76ScBdUrNn5QtbFaBEmfFuzNn6A5M4cFJ
         DT5RJclp9aYKIYlpo+PqjorpP6gV+uAd5h7wVmlDNr3CApjZYplXALT2HUqGZA/DyXhn
         zRdLtJIAEdZGxWe/u3pOOy81GFkP7UvjBRBWaZE8P8kf/v1zPMs11Ra8UQgrqEN7oxbn
         xmFY3njFU2YKU1+KKzSl3zki8KUt9rMCAQKesI/cS1q3p0EhdObDv0OhuC9pBUt0zaJA
         LwYUKcLVSEmaLqRopdBJ+G2P692iVGdMLdgyxGCgEhDUWh3L/ZxDMHpHYgwXRn36/kQ2
         lWNg==
X-Gm-Message-State: AOAM532hoo93YaI9nA0uC6A2vM/+OVkAVOAbsXx5IiH1Sg8IqaZZUfoU
        x7HEJSmsXBUk0CMI+qj5ySeVAqo+N1XM2x+XDqpPPq34XMg=
X-Google-Smtp-Source: ABdhPJxYQ+JeD0UWwnT9Y+SgxEhqvpnfZFxl0ACPyfhDVFtvfy9H+6vYmp7vGBqhsMV2trnrjcdOLrBywa+McZUGK/A=
X-Received: by 2002:a63:1262:: with SMTP id 34mr209923pgs.356.1630691491989;
 Fri, 03 Sep 2021 10:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162982124835.1124374.16212896894542743429.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210902193031.000035b4@Huawei.com>
In-Reply-To: <20210902193031.000035b4@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Sep 2021 10:51:21 -0700
Message-ID: <CAPcyv4hocfkjizFD=153+OeKYR1-UfhG1k8qYEqnFWPMW4oMqw@mail.gmail.com>
Subject: Re: [PATCH v3 23/28] cxl/acpi: Do not add DSDT disabled ACPI0016 host
 bridge ports
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        stable <stable@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 2, 2021 at 11:30 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 24 Aug 2021 09:07:28 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > During CXL ACPI probe, host bridge ports are discovered by scanning
> > the ACPI0017 root port for ACPI0016 host bridge devices. The scan
> > matches on the hardware id of "ACPI0016". An issue occurs when an
> > ACPI0016 device is defined in the DSDT yet disabled on the platform.
> > Attempts by the cxl_acpi driver to add host bridge ports using a
> > disabled device fails, and the entire cxl_acpi probe fails.
> >
> > The DSDT table includes an _STA method that sets the status and the
> > ACPI subsystem has checks available to examine it. One such check is
> > in the acpi_pci_find_root() path. Move the call to acpi_pci_find_root()
> > to the matching function to prevent this issue when adding either
> > upstream or downstream ports.
> You could mention that has the side effect that the existing
> call in add_host_bridge_uport() is now guarantee not to fail so
> can be moved closer to where it is used.  That chunk had
> me briefly confused.
>
> >
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> I'd imagine we want to get this in an early rc so perhaps pull out of
> this series.

I'm going to keep it in this series because it causes merge conflicts
for what follows, but I'll merge it independently of the follow-on
reworks which may need to wait another cycle.

>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>
> > ---
> >  drivers/cxl/acpi.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 8ae89273f58e..2d8f1ec1abff 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -243,6 +243,9 @@ static struct acpi_device *to_cxl_host_bridge(struct device *dev)
> >  {
> >       struct acpi_device *adev = to_acpi_device(dev);
> >
> > +     if (!acpi_pci_find_root(adev->handle))
> > +             return NULL;
> > +
> >       if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0)
> >               return adev;
> >       return NULL;
> > @@ -266,10 +269,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       if (!bridge)
> >               return 0;
> >
> > -     pci_root = acpi_pci_find_root(bridge->handle);
> > -     if (!pci_root)
> > -             return -ENXIO;
> > -
> >       dport = find_dport_by_dev(root_port, match);
> >       if (!dport) {
> >               dev_dbg(host, "host bridge expected and not found\n");
> > @@ -282,6 +281,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >               return PTR_ERR(port);
> >       dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> >
> > +     pci_root = acpi_pci_find_root(bridge->handle);
> >       ctx = (struct cxl_walk_context){
> >               .dev = host,
> >               .root = pci_root->bus,
> >
>
>
