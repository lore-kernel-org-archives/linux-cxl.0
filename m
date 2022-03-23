Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B81C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Mar 2022 20:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiCWUld (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbiCWUlc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 16:41:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3506E8BF46
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 13:40:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4so2874329pjh.2
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=joaiPi82mBm5ydpjd+lSBaTz0Xb4/xDRfIZaQDGqVyI=;
        b=BbVLZa2jS0qTk7ys5RPPQ9Cq3/eIL++KpUJE2ooJuHAwY81hX2hFxen/BzhW2ITBQC
         xzDb97S+s/BwYPL/C1QPEiOYv68gPHxgi/OKqsYYEfZjhzbu4xJVpF6WXm+Y3rw8QX+p
         1C6MY1MJIgK7P/auX21rKnngUv7n2W6Lkp8UYyn6UUO7ZP2XLAIojCdleiE4JxCgRJUI
         OTdJ6M+Vte5DuOB7QBAapim7XGWx0OQBgoDJzcH24TY1jcwJjkkRswW6DRppZdz61NWL
         RyVr6oFYOQT473wNbuXc5RSzz0SlCnlsyZ76OXQ3db6UX1gpIDgvWwywPe7FdbJgv9Co
         +O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=joaiPi82mBm5ydpjd+lSBaTz0Xb4/xDRfIZaQDGqVyI=;
        b=Xqnmo4xPuvDJOpA+qzkaYpu2NgooFikiOMjil+0CAUxiohV/I3ZomOZb5cxTWhGpoK
         hVqGpC6F7+sYtfCs9Fm+OBL6P7/l8GmF9SgvTgNlHW499Mdb/jP4LYDsLp+tCoJcyQua
         vSHFFzsczYgP9UZQJbK3M+hJqvnV22cCJlMmfhUuTvlAFArY/g2fCBgLUlpoGDZN17bC
         9FkiviWq1Zsk4fnTQlC5cSBlYoPpjEAmDAQsaddpjuzHiJD7i5vPmO0dlTWaw/0qeAo2
         uP5LaxB/r9/pYg3mR8EjyVd4Aw28S/Cln4I7xyrDy4pKNcEwqPvvWWCWGahvyZXoBgL6
         +1fQ==
X-Gm-Message-State: AOAM5305KwzBG6jItNAj2BA3Ou2ll/zKz2I8fO/ifJWIHKkwE6ATnyyW
        G/oPzxAdxinci9IsiSh4vnjItN5uvwp8SYFxJaveCnbLtf8=
X-Google-Smtp-Source: ABdhPJzOvC4uT3Sm8xOvJVvlftlVpR9jhvGsfNcyBHbOyh8PLo56Ig00CJc523O4ahhmY7LAlQF3WTemYE+ZAu/jZUQ=
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id
 q13-20020a17090a430d00b001bcf3408096mr1736190pjg.93.1648068001760; Wed, 23
 Mar 2022 13:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
 <20220318213004.2287428-2-vishal.l.verma@intel.com> <CAJZ5v0j42Fd4X=GEHDMS6_bxcaT8ncU5vh6+pUjCGhGrD9U0vA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j42Fd4X=GEHDMS6_bxcaT8ncU5vh6+pUjCGhGrD9U0vA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Mar 2022 13:39:54 -0700
Message-ID: <CAPcyv4h4djKTZLmTQsiCsyKUfzBd_KXEfCo9AoRSJasLo+Ac0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 23, 2022 at 12:24 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Mar 18, 2022 at 10:30 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
> >
> > From: Dan Williams <dan.j.williams@intel.com>
> >
> > Rather than pass a boolean flag alongside @root to all the helper
> > functions that need to consider PCIe specifics, add is_pcie() and
> > is_cxl() helper functions to check the flavor of @root. This also
> > allows for dynamic fallback to PCIe _OSC in cases where an attempt to
> > use CXL _OXC fails. This can happen on CXL 1.1 platforms that publish
> > ACPI0016 devices to indicate CXL host bridges, but do not publish the
> > optional CXL _OSC method. CXL _OSC is mandatory for CXL 2.0 hosts.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Robert Moore <robert.moore@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  include/acpi/acpi_bus.h |  1 +
> >  drivers/acpi/pci_root.c | 62 +++++++++++++++++++++++++++++++----------
> >  2 files changed, 48 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index ca88c4706f2b..768ef1584055 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -585,6 +585,7 @@ struct acpi_pci_root {
> >         struct acpi_device * device;
> >         struct pci_bus *bus;
> >         u16 segment;
> > +       bool cxl_osc_disable;
> >         struct resource secondary;      /* downstream bus range */
> >
> >         u32 osc_support_set;    /* _OSC state of support bits */
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index b76db99cced3..2d834504096b 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> > @@ -170,20 +170,47 @@ static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
> >                         ARRAY_SIZE(pci_osc_control_bit));
> >  }
> >
> > -static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> > +static bool is_pcie(struct acpi_pci_root *root)
> > +{
> > +       return strcmp(acpi_device_hid(root->device), "PNP0A08") == 0;
> > +}
> >
> > -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> > +static bool is_cxl(struct acpi_pci_root *root)
> > +{
> > +       if (root->cxl_osc_disable)
> > +               return false;
> > +       return strcmp(acpi_device_hid(root->device), "ACPI0016") == 0;
>
> One more thing.
>
> This will cause the device ID matching to take place every time
> is_cxl() is called which seems a bit excessive to me (and the same
> applies to the PCIe counterpart).
>
> IMV it would make sense to have a "bridge_type" field instead of
> cxl_osc_disable in acpi_pci_root and use that for all of the checks.
>
> Moreover, IIUC every CXL bridge is also a PCIe one, so the
> "bridge_type" could be say 1 for PCIe and 2 for CXL and checks like
> "bridge_type >= PCIe" would cover both these types then.

Sounds good, I like it.
