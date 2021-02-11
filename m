Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B279CC433DB
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 20:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDB264DD5
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Feb 2021 20:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhBKUlj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Feb 2021 15:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhBKUlh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Feb 2021 15:41:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E91C0613D6
        for <linux-cxl@vger.kernel.org>; Thu, 11 Feb 2021 12:40:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y8so8363174ede.6
        for <linux-cxl@vger.kernel.org>; Thu, 11 Feb 2021 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o+MkWSBkvC/UMwT/VgZJGycfyB5NFr4bsCioBd7cfA4=;
        b=coyflfwbCdbsJ3zzo0z6wSKT59iLTCQVdnZtGrbaNG8QIdR39uPo9V6tfCTRydcisL
         4k5JGnBJW2bwe/Y98Ay8kKjlpA7C1M7t5HKlvHlD2W0hs4hkrrX9jMaaFPooSlzZaqeb
         qnbKvbKvtFMP2Gcb2JhAqzQcRwHeCtf4BKRWIpIIHZen8wJEdzLIzoQePkCym3WVdGd/
         8amklPn5Y1DQDOGZ65J3q4g6AmlJfZBY5cUKedCA145v+34ax7wnmlls4kKFRLPdURDS
         HwZMs0P9MDREJORNNWoZRXavVtngNRUPbTJE6VBjR5mURUsu/qMEf25CUKIaBzJwIfJh
         67gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o+MkWSBkvC/UMwT/VgZJGycfyB5NFr4bsCioBd7cfA4=;
        b=DIrEbyXyxB7fakwLENdIlCFPun7Wrn7xNrjN8CsxX+VwvOEp5yxnCXP7bDr5uf3ZoY
         dJB6272+67/6qZ62o1Ou84188Bsi90VchJFDx4EfUX8PFV4m0dfd5ieYe9sA7gwazn8y
         SDNXblkYOCcxu5f9xusCe9O2VRNUX+n5ohgJfXBZHJjDG+SYpT8c7/qSfIdY/zfzXwC/
         bNrhHBdGLYNg60xMTQt9/v8TD0SaJJx2jiZre8otnAOqOpF039uSLExPjETNOWw+Dkst
         geGCOIvHEwNhwuBKxMJFOAeAuSnEqWoTV0eEP2sKsKB8oPnCrq1IEZwYgNoH6qfr0Mtx
         vYdg==
X-Gm-Message-State: AOAM533EzwDrfLFRYBQfPFFWnggUNI0XF5bE8cQ/aeRpKz5UEJ3Hj8eg
        AeTLHZotRLrnpU0G6lUaTmG+pO0STeNdm67qzCn1UA==
X-Google-Smtp-Source: ABdhPJwUwoQIw5/TCL2CLB2ZlTQ8uewrH9tgE5Yw4rRMQ6jMgq9i5WT/KqL+JKgKKFkIg69ICnqn7QI9yjjwV0IjT0U=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr9870835edc.97.1613076055992;
 Thu, 11 Feb 2021 12:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20210210000259.635748-1-ben.widawsky@intel.com>
 <20210210000259.635748-4-ben.widawsky@intel.com> <20210210181725.00007865@Huawei.com>
 <20210211101746.00005e8c@Huawei.com>
In-Reply-To: <20210211101746.00005e8c@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Feb 2021 12:40:45 -0800
Message-ID: <CAPcyv4hgzv7B7sv85A3No-bAgeADqfrhRySBrQBx43HVEMfnzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] cxl/mem: Register CXL memX devices
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Feb 11, 2021 at 2:19 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 10 Feb 2021 18:17:25 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 9 Feb 2021 16:02:54 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > Create the /sys/bus/cxl hierarchy to enumerate:
> > >
> > > * Memory Devices (per-endpoint control devices)
> > >
> > > * Memory Address Space Devices (platform address ranges with
> > >   interleaving, performance, and persistence attributes)
> > >
> > > * Memory Regions (active provisioned memory from an address space device
> > >   that is in use as System RAM or delegated to libnvdimm as Persistent
> > >   Memory regions).
> > >
> > > For now, only the per-endpoint control devices are registered on the
> > > 'cxl' bus. However, going forward it will provide a mechanism to
> > > coordinate cross-device interleave.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > One stray header, and a request for a tiny bit of reordering to
> > make it easier to chase through creation and destruction.
> >
> > Either way with the header move to earlier patch I'm fine with this one.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Actually thinking more on this, what is the justification for the
> complexity + overhead of a percpu_refcount vs a refcount

A typical refcount does not have the block and drain semantics of a
percpu_ref. I'm planning to circle back and make this a first class
facility of the cdev interface borrowing the debugfs approach [1], but
for now percpu_ref fits the bill locally.

> I don't think this is a high enough performance path for it to matter.
> Perhaps I'm missing a usecase where it does?

It's less about percpu_ref performance and more about the
percpu_ref_tryget_live() facility.

[1]: http://lore.kernel.org/r/CAPcyv4jEYPsyh0bhbtKGRbK3bgp=_+=2rjx4X0gLi5-25VvDyg@mail.gmail.com
