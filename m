Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE48C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 29 Nov 2021 23:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhK3ACv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhK3ACu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 29 Nov 2021 19:02:50 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79CC061714
        for <linux-cxl@vger.kernel.org>; Mon, 29 Nov 2021 15:59:31 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so13460754plr.11
        for <linux-cxl@vger.kernel.org>; Mon, 29 Nov 2021 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVud84N7PFXNM8ZBCCXnUAxJGbiyrlJpPCMfl3wy0EU=;
        b=0zi43r+fQPLslbbMV8E5JuflI4iCrgTR7UjJZ1OLSjl5z8mLXAaqgZkxYCd8d0hQUe
         JZfjGEDDhRHWv8jGHalayouM8uT82vxtc0Ya7k3NQoL1kSeTj+z3S4vYfOdh74Pke2i1
         E6mN51wsxoRUhVSMNkkoIakGb1+RIKZLqDb6a5D16OO98RIH1DIWiY3hL2/XEnkwZPmu
         660gwsC+GnOhwTaGyR/fsI2AvVFcEmILALJWPEf8pT6/r1seBcqTdubRM6JfVZjbhsNT
         P1pKVW5BjE7UQuuCBSD5ltz61zNB5DhJxn/crt5OX0zl2AILYJ5CIcEcM9KVfb9L3jRA
         QNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVud84N7PFXNM8ZBCCXnUAxJGbiyrlJpPCMfl3wy0EU=;
        b=L7rcLKtg5HqkgbjfUZRu4q/Jjq2Tf74MzAwUymJh5isRbGAtKBR2eLaZV13OH5YUXh
         3qv5tbYoR9memYg8wZTc755pDNyrMGWKzkzCAs5dbukN+tXr9jTgJaTGpk8y1ByiYKuB
         3IfLD2wKsSrRmnJHFt0kiSRmBitXtFPoQ3Q5esjrv2rhK2NkjBBHyJnVdfpdIKe9YqUK
         DSQ5Wt7sDFhibO4oVgx3LljIJgq6Y/A9mxc11NxlL1bYudcQsJY/lR0JLxO86HRwbRvX
         N8G/+pxNMvCOTifZmjOSGIh0mvBDImsZSovOG1Opc4JosOgqLND2D5LxB7K0W5QiEXzo
         xHrA==
X-Gm-Message-State: AOAM533XvdOkqr+MAx3ohYzSgPIsT07+nXVPHha1ivmjtqABOUbOhvjc
        AIrHAzcdO15h7mAKSYDYEaYmkCLc0oYCN8CK2zfU+A==
X-Google-Smtp-Source: ABdhPJxoo7r8JFP5RzAnpOVLJbgpsZP08BDQPiDI0GRUCuURdh1CZ+ooawd4e2PQqdQDjrIEobApRdn7P15oRFSJ1Hk=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr62904030plb.4.1638230370969; Mon, 29
 Nov 2021 15:59:30 -0800 (PST)
MIME-Version: 1.0
References: <20211117122335.00000b35@Huawei.com> <20211117221536.GA1778765@bhelgaas>
 <20211119064830.GA15425@lst.de> <CAPcyv4g+=fkMyzoKtRbJfFyM=hq3B=RMJotNWyGoJDZk0d38uQ@mail.gmail.com>
In-Reply-To: <CAPcyv4g+=fkMyzoKtRbJfFyM=hq3B=RMJotNWyGoJDZk0d38uQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Nov 2021 15:59:25 -0800
Message-ID: <CAPcyv4gYBpx6Anw__gW-3xZfbcTaVv5eUR6wuxt_Ert1N6hDZA@mail.gmail.com>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 29, 2021 at 3:37 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Nov 18, 2021 at 10:48 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Nov 17, 2021 at 04:15:36PM -0600, Bjorn Helgaas wrote:
> > > > Agreed though how it all gets tied together isn't totally clear
> > > > to me yet. The messy bit is interrupts given I don't think we have
> > > > a model for enabling those anywhere other than in individual PCI drivers.
> > >
> > > Ah.  Yeah, that is a little messy.  The only real precedent where the
> > > PCI core and a driver might need to coordinate on interrupts is the
> > > portdrv.  So far we've pretended that bridges do not have
> > > device-specific functionality that might require interrupts.  I don't
> > > think that's actually true, but we haven't integrated drivers for the
> > > tuning, performance monitoring, and similar features that bridges may
> > > have.  Yet.
> >
> > And portdrv really is conceptually part of the core PCI core, and
> > should eventually be fully integrated..
>
> What does a fully integrated portdrv look like? DOE enabling could
> follow a similar model.
>
> >
> > > In any case, I think the argument that DOE capabilities are not
> > > CXL-specific still holds.
> >
> > Agreed.
>
> I don't think anyone is arguing that DOE is something CXL specific.
> The enabling belongs only in drivers/pci/ as a DOE core, and then that
> core is referenced by any other random PCI driver that needs to
> interact with a DOE.
>
> The question is what does that DOE core look like? A Linux device
> representing the DOE capability and a common driver for the
> data-transfer seems a reasonable abstraction to me and that's what
> Auxiliary Bus offers.

I will also add that this is not just an argument to use a
device+driver organization for its own sake, it also allows for an
idiomatic ABI for determining when the kernel is using a device
capability vs when userspace is using it. For example,
IO_STRICT_DEVMEM currently locks out userspace MMIO when a kernel
driver is attached to a device. I see a need for a similar policy to
lock out userspace from configuration writes to the DOE while the
kernel is using the DOE. If userspace wants / needs access returned to
it then it can force unbind just that one DOE aux-driver rather than
unbind the driver for the entire device if DOE was just a library that
all drivers linked against.

DOE negotiates security features like SPDM and IDE. I think it is
important for the kernel to be able to control access to DOE instances
even though it has not cared about protecting itself from userspace
initiated configuration writes in the past.
