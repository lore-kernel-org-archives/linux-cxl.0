Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA5C433F5
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 01:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB4A60724
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Nov 2021 01:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhKBB7L (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBB7K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Nov 2021 21:59:10 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33E6C061714
        for <linux-cxl@vger.kernel.org>; Mon,  1 Nov 2021 18:56:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r28so18834081pga.0
        for <linux-cxl@vger.kernel.org>; Mon, 01 Nov 2021 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2QRbeVNhDS/gP/mCB4CR8qFExHeNct0pebtAyXtOH48=;
        b=pWVQkpLY5veh2xka9sB+/4tHYujRYzYkHd8nhPs3djSzh1GiCdcQo81QVG2ChzKToh
         W4DTwrK+L5B/4kLpybABAvVafigK+pVf3Yct5T2P/2vVPGv3d90ZP/I8ydpFt123M5PT
         ftR4N53imqIM6oM21zs32jboa0Ado1XuyGvCblwYixQ7779oZD8sepUZfCsU87n/8UNj
         3hmzBEMFHaSzSBVYioAhke49nJpX4sZ2wgj2+GGnrFetOlIw9uj10w0pLNLnY7VInWkT
         MWQ7q/6WIU5MsNSnEyhJXrUEQh4vN0gJrjLZMpXLfNnDypzXr1R/Q6PASVXukcp2gtjR
         zFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2QRbeVNhDS/gP/mCB4CR8qFExHeNct0pebtAyXtOH48=;
        b=4u4udTSJsSU+rSu8s9We8JVKqmCL71fhivQALyBzskmK+69fRRoS1NtEKvKqv5lO5x
         1/pRq/MuKTIww+KqN6T39tY3jnMCq/M3K0ajqxMHTLQ3JLRgZx83YgsAPZbYn7j/Uetu
         Whfo9bHFQK9jkZWPlyFOmbnpCmfvmKfkxl8v4JpggPnkvR3Wy3I3czgHi1TK/RkBqwU/
         rXdT+KLZ3PI7jeKi2EJuT/ufnwuAu6hKRDDqZCRShOUKH/3CVT2kUkTBH7g1pzY+/knb
         BAalc2Lz2Ixi110WvR7//4tv7ocknVNUcsgz0iDsRxYPLlQFBea2/SKxaJRSXkd/V+/U
         fz1w==
X-Gm-Message-State: AOAM5302l+67rmZxnFZBoQXyUCEOJS7yWaxHoJDPFNjIrG9ZaYRpe334
        TMqFYeHZuFrl8x6oGSSVfl+dPC9bFI0LVmealjvqgA==
X-Google-Smtp-Source: ABdhPJzAdj8NB98HOZ++K0xwgbKCYr7sIafj2XaDGo4GZvvApBwOdJX21YXKeAPaic1zI3GSKB8/b7YtUxFqQC3NbSk=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr11771893pgd.377.1635818196079;
 Mon, 01 Nov 2021 18:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
 <20211022183709.1199701-12-ben.widawsky@intel.com> <CAPcyv4jm3Hp_XYkQiNYvwhF-S6-3k4qvs-a=4zS1YKukne1dnQ@mail.gmail.com>
 <20211101185602.apavn3je3nqbasx3@intel.com> <20211101214538.pn2ifizia4vkyeub@intel.com>
In-Reply-To: <20211101214538.pn2ifizia4vkyeub@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 18:56:25 -0700
Message-ID: <CAPcyv4jKrtRuU+HK=GrQhpxjJfkh0JTGQ9YSvYzwtYFoVUZXiA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 11/28] cxl/acpi: Rescan bus at probe completion
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 1, 2021 at 2:45 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-01 11:56:02, Ben Widawsky wrote:
> > On 21-10-31 12:25:32, Dan Williams wrote:
> > > On Fri, Oct 22, 2021 at 11:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > Ensure that devices being probed before cxl_acpi has completed will get
> > > > a second chance.
> > >
> > > I think this is at the wrong level... more below.
> > > >
> > > > CXL drivers are brought up through two enumerable, asynchronous
> > > > mechanism. The leaf nodes in the CXL topology, endpoints, are enumerated
> > > > via PCI headers. The root node's enumeration is platform specific. The
> > > > current defacto mechanism for enumerating the root node is through the
> > > > presence of an ACPI device, ACPI0017.
> > > >
> > > > The primary job of a cxl_mem driver is to determine if CXL.mem traffic
> > > > can be routed to/from the PCIe device that it is being probed. A
> > > > prerequisite in this determination is that all CXL components in the
> > > > path from root to leaf are capable of routing CXL.mem traffic. If the
> > > > cxl_mem driver is probed before cxl_acpi is complete the driver will be
> > > > unable to make this determination. To address this, cxl_acpi (or in the
> > > > future, another platform specific driver) will rescan all devices to
> > > > make sure the ordering is correct.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  drivers/cxl/acpi.c | 20 +++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index 625c5d95b83f..1cc3a74c16bd 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -451,6 +451,14 @@ static u32 cedt_instance(struct platform_device *pdev)
> > > >         return U32_MAX;
> > > >  }
> > > >
> > > > +static void bus_rescan(struct work_struct *work)
> > > > +{
> > > > +       if (bus_rescan_devices(&cxl_bus_type))
> > > > +               pr_err("Failed to rescan CXL bus\n");
> > > > +}
> > > > +
> > > > +static DECLARE_WORK(deferred_bus_rescan, bus_rescan);
> > > > +
> > > >  static int cxl_acpi_probe(struct platform_device *pdev)
> > > >  {
> > > >         int rc;
> > > > @@ -484,9 +492,19 @@ static int cxl_acpi_probe(struct platform_device *pdev)
> > > >         if (rc)
> > > >                 goto out;
> > > >
> > > > -       if (IS_ENABLED(CONFIG_CXL_PMEM))
> > > > +       if (IS_ENABLED(CONFIG_CXL_PMEM)) {
> > > >                 rc = device_for_each_child(&root_port->dev, root_port,
> > > >                                            add_root_nvdimm_bridge);
> > > > +               if (rc)
> > > > +                       goto out;
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * While ACPI is scanning hostbridge ports, switches and memory devices
> > > > +        * may have been probed. Those devices will need to know whether the
> > > > +        * hostbridge is CXL capable.
> > > > +        */
> > > > +       schedule_work(&deferred_bus_rescan);
> > >
> > > I think this belongs in port driver similar to the one in
> > > drivers/cxl/pmem.c, because any port online event might mean that a
> > > downstream port can now attach to the port driver. I prefer a local
> > > ordered workqueue via queue_work() rather than the global unordered
> > > workqueue primarily because it can be flushed without getting
> > > entangled with other random work in the system, but also because the
> > > ordered property is useful for comprehended hierarchical topology
> > > events.
> >
> > Makes sense. I was trying to limit the number of rescans that took place and I
> > believe I convinced myself that the current patch does work properly. However,
> > architecturally it makes more sense for the port driver to own this and
> > realistically I assume many rescans will coalesce.
> >
>
> Oh. I assume you want this rolled into (cxl/port: Introduce a port driver),
> correct?

Yeah, otherwise the port driver is broken, right?
