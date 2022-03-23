Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA3C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Mar 2022 19:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbiCWTDw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245464AbiCWTDw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Mar 2022 15:03:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C6F67D24
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 12:02:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id c11so1885790pgu.11
        for <linux-cxl@vger.kernel.org>; Wed, 23 Mar 2022 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kpi6Bru51wib+Q7mll2W1z45QlW5CuUJN25dVIQdtk=;
        b=Vv0XJDHEHrvf0r11ZMW4pPf2FSGMZJITAu1Ib08fh+oLIYjsh2DK8CmtLLAthImPlr
         9ZD1SLNXoxhyWr+GBfFIrgQdmM38Lz9cm6b3ykhl+Hvx4sA94BHG8V9j9Oj7ERIYz8tF
         08aDWXMZbdk+ww0bc+Hchgd0aHQ+y4m3nHlIHtFkDpONSLeP4B5pNp3jweSD1OxZbyf/
         iQ4jq7OPQbOOaucz8yMyObTj628D4nN9Fz5alYqNlnvUSJRtsE7+I6qUQRJBBniKwvkq
         USAp3DFhqTtTmW1CGz/W/ta1RvXvH2JGgCnkPCz2cLZ5lnLTP+mPxiZoF8gBaYoSlD2N
         EeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kpi6Bru51wib+Q7mll2W1z45QlW5CuUJN25dVIQdtk=;
        b=xycAs8MmpyaJ99BHA9zd71/iJwK355c+gqALWCt4tioNvDPkQOLAXsojImyPWj7Bvy
         ujIp7SRV377fnqkSI6tsbRJynEi4qgw/wpQMS5Y6LBBedmHchqOa9FZs6zwMJAS1xivE
         7JMwauJhJEiIi1eqv9+rJCF2GoehQvbBP3kX8nn6z+EbPPyiINJUHz6gvCxzyNjxueFs
         BM8QzzDo8j6B+ikAego5I8Z9zF+pMyw86rh+ANEz9H7ZyY0/PGwBLQQlVAyi2MY5PycH
         mzHL+oLwTwueGhuVE3xj9kk0sIz+ZZIBLSEhZvywS9bn3uv5GBm7t8dL4pOcPrIxHTiu
         OfHA==
X-Gm-Message-State: AOAM532SSkDCv8/B2YMFqRvup1Udbt92plUn0bFX5uZQKFQey/26gh8D
        KrTc6UTMNKjR0gSB70un00+i6rox1LpBmt2DTNlL1Q==
X-Google-Smtp-Source: ABdhPJwHiOby50tUdaqkrMgU84SpJgL8lkC1Iq1tDt/6Ajx5cCBS8/CLAUlIPS0nOp4zjbBgVu621U0ET/d2eua1j5E=
X-Received: by 2002:a05:6a00:228f:b0:4fa:e4c9:7b3b with SMTP id
 f15-20020a056a00228f00b004fae4c97b3bmr929398pfe.61.1648062141890; Wed, 23 Mar
 2022 12:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220318213004.2287428-1-vishal.l.verma@intel.com>
 <20220318213004.2287428-3-vishal.l.verma@intel.com> <20220323004753.qkngm4yctprcgvoc@offworld>
 <86f0bc64bc2173f7c061a96a290b540b2710f614.camel@intel.com>
In-Reply-To: <86f0bc64bc2173f7c061a96a290b540b2710f614.camel@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 23 Mar 2022 12:02:14 -0700
Message-ID: <CAPcyv4hGmcye=YoiUUS-hu+Fhw8FHP6M6c75SRcTMm0WK4-tNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] acpi/pci_root: negotiate CXL _OSC
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "dave@stgolabs.net" <dave@stgolabs.net>, lkp <lkp@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 23, 2022 at 11:29 AM Verma, Vishal L
<vishal.l.verma@intel.com> wrote:
[..]
> > > -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 support)
> > > +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask,
> > > +                                           u32 support, u32 *cxl_mask,
> > > +                                           u32 cxl_support)
> > > {
> > >         u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
> > >         struct acpi_pci_root *root;
> > >         acpi_status status;
> > > -       u32 ctrl, capbuf[6];
> > > +       u32 ctrl, cxl_ctrl = 0, capbuf[OSC_CAPABILITY_DWORDS_MAX];
> >
> > ... which btw why is capbuf 6 in the previous patch and now 5 in this one?
> > Sorry if I missed anything obvious here, just seems odd.
>
> Oh, I just noticed patch 1 changes it to 6 in the first place (I
> thought it was just 6 even before this set), that is wrong. Previously,
> the PCI only _OSC had 3, and with CXL it becomes 5. I'll fix this up.

Yeah, my fault for making it 6 think I was confusing the DWORD numbers
as 0-based.

> > And also it's ugly to just add extra params to acpi_pci_osc_control_set()
> > and have callers do do:
> >
> > > +       status = acpi_pci_osc_control_set(handle, &control, support,
> > > +                                         &cxl_control, cxl_support);
> >
> > And this sort of thing happens all over the patch with struct acpi_pci_root.
> > So the whole handling of the _OSC state of support/control bits imo really
> > wants to be consolidated between CXL and non-CXL.
>
> I don't disagree :) - Any thoughts on what can be done to consolidate
> things further? This seemed like the lowest touch approach that kept
> existing PCI-only paths as-is.

That sounds like a follow-on cleanup opportunity to me, but we have
time since this series seems like v5.19 material given the merge
window is already open.
