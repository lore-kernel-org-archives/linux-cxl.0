Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32722C4742C
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Nov 2020 18:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4EE4206FB
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Nov 2020 18:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cnRi1TRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKKS1x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKKS1x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Nov 2020 13:27:53 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D239C0613D1
        for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2020 10:27:52 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id za3so4090767ejb.5
        for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2020 10:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaIQwQ+15TEIyZyj8/aGmJs71bDkEvM66klWaC5vlLw=;
        b=cnRi1TRg7jw+Q2T7s80k8pjxHp2E5efgzbSibQo+wp0XYHn6gCIhi3vNHWCxptg9Nz
         jGfzwu0NWVsuKRnP9w2nD9AnEdmLkkVNSjB3vDpMYog/W0vHnXhUzJxwGm1XUaHJvDMt
         a6AhEicgbyD1kVVvpqKJc4wSVXrHptK1B3U8WBilNceCSKVEhKmNjkUak68xGcMmygjV
         9x3OdkxyOqZ5x4cTKB3QUXAn1XFPJaFLEg/1FRP021/QuMG89u9neAGRG5y0mAD9D2u9
         mId9w4sM6GZFqJHiK0BfdgPyAvkCWLFrxs9XhsRj4XNwSEXWnbFndg8+Yes9F0MqPbpZ
         3W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaIQwQ+15TEIyZyj8/aGmJs71bDkEvM66klWaC5vlLw=;
        b=U0CbI3BXWJnHL1FYcHqXj5zdFHqJVKMFMSu/0Rl6dUDhyKPw0xH75JLnKu8h8kc6+0
         TUFu6Qzra2rVDzp1wqO0S+ET3QUogT7aclN4/4jSWqjARqfeWrRcDbOoiQ7PWHJRXKWG
         rqXOwUIvy4pOvXVtaDpfBFVMfa7U6gFxbGgxv8e3OQ6wgzqhpAzqdwM+V7gWNilYQXrQ
         Qv6DFcGyo7CcrTuZTkdozLl2z8geX8mKW5h23Rrjwq89utRyFB0wVUBCU8qnetS+Ce55
         zTc6qnUJip8o13G/VSFzfDkEUP+gkv8Bi/q9xHnNFs01cnK8auvJG2mOsNniA4n7/ev3
         E0Aw==
X-Gm-Message-State: AOAM532DrherJ6nSVDFsQu4V3PgEGFxPK6q/t3XiS4ozsqyFzIKI8ZKP
        lGgIdIvICf/d/PfILXXJ5yAPy9E9Aq2bYYARmhXOSg==
X-Google-Smtp-Source: ABdhPJzROlVJ4lA34wzyb9HvHhqu0mRf5kwgVaNxyAE7k7nKG3aTa/QRqzTSgMFmoZ8jVa9/01KcLJhtrdpoiTDHIQg=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr26103639ejb.472.1605119270879;
 Wed, 11 Nov 2020 10:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201111071231.GC7829@infradead.org>
 <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
In-Reply-To: <CAPcyv4iA_hNc=xdcbR-eb57W9o4br1BognSr5Sj4pAO3uMm69g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Nov 2020 10:27:38 -0800
Message-ID: <CAPcyv4g=pcai9FrKaGcAHtyfm=Lzzgh8xFyG6QLA4J6FPdy5yQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Nov 11, 2020 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > > +
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > > +             if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > > +                     return pos;
> > > +
> > > +             pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> >
> > Overly long lines again.
>
> I thought 100 is the new 80 these days?

Saw your clarification to Vishal, I had missed that. Will trim.
