Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E3AC433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Apr 2021 00:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360AB6128E
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Apr 2021 00:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348832AbhDNAnD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Apr 2021 20:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbhDNAnC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Apr 2021 20:43:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E08DC061574
        for <linux-cxl@vger.kernel.org>; Tue, 13 Apr 2021 17:42:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f8so21558073edd.11
        for <linux-cxl@vger.kernel.org>; Tue, 13 Apr 2021 17:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0/LF5DvnJRfIsal2eM96sTYXDhf7ujpklsSaSTIhCQ=;
        b=CNJ4765pxcQst3JPb+keJePZ0HFK55PaPj2fLwYDS8pSubS6w9mb52dlvO7uhUesC/
         0i2SgQASheLanq9zIYXbCdUex+W0wr2QB9JmhvaAFrcxgg0cz8g20yptXvt7TYuk1kiY
         aISidfsijHZe5TA7FbhIlEyU+D45ILGqxmoZmFfg/4EeJO6UWni+N2alXO/LLgkfPVzF
         sNvcIC7dG+/yneHoloul/QAv3McILDmeTVXxHI5XvETVQVOwdTP/CxkiNrXlvogmoFw3
         m4j/mQhik0wC3P0eW1XqpvX0PNTe1gLw1e2Izjrqv3zmJt8qccPVHI2s0yXFh3M4PyiB
         1ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0/LF5DvnJRfIsal2eM96sTYXDhf7ujpklsSaSTIhCQ=;
        b=VAhiKw+ftb/c8+u3nk4cgOSdjN0sNgh9WosNIINLvBjdtm1v6zYUrkHxvS9gU6ws6A
         cLfe7HniPFRpjTNGpdG2QX4zct82K0PZmvrAr8fajx+8l1+PWBR0rWAku5TIMesfk+//
         wshIVx7K0s+m/PuCzGBlDGDfbJ+dLsgaPWICEEiiWJ1G6ZnRNxURyp8R69d/NJgD4ia6
         7cGFspEB92AQYV75dc/VAVy0wmWNrCMCEKmm/zWLmye5e+eGFNRs4F9Jcpxc232AzloF
         FtQbhesUx/tXeJeZPH0b03gcnlag/DU7BK9t3ZP4jub67ricM80u/wvElljfwHAQjgB1
         qaNg==
X-Gm-Message-State: AOAM5338jYeiMjpuN/5Ro+D7DQF0v3KmJeFoQU8xWZzgBXIirCxzhQQj
        wSUPnphKKn6uZISUtUSCQSrnI634azzXyFE4yb891wwP9u4=
X-Google-Smtp-Source: ABdhPJyXxaS9ws5JexMsQ9jpzAyjNPpLzva4YKcYyK5ySXxW+uZ/4BpxgjZQotc3a2CNdcE9b5jHRf+QaYIK7FM1jAQ=
X-Received: by 2002:a05:6402:30ae:: with SMTP id df14mr37499178edb.97.1618360960988;
 Tue, 13 Apr 2021 17:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728744762.2474040.11009693084215696415.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210406173845.00000bec@Huawei.com> <CAPcyv4h4z9Y_Zbzk_jiZXs6+gPAbdw0UJHW5NvTaM2ZcvJ6ftw@mail.gmail.com>
In-Reply-To: <CAPcyv4h4z9Y_Zbzk_jiZXs6+gPAbdw0UJHW5NvTaM2ZcvJ6ftw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Apr 2021 17:42:37 -0700
Message-ID: <CAPcyv4iueMDPxcEuLg=NKydkRL+xmEn-udHjKYB493iTQShaAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] cxl/mem: Move some definitions to mem.h
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Apr 13, 2021 at 5:18 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 1 Apr 2021 07:30:47 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > In preparation for sharing cxl.h with other generic CXL consumers,
> > > move / consolidate some of the memory device specifics to mem.h.
> > >
> > > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> >
> > Hi Dan,
> >
> > Would be good to see something in this patch description saying
> > why you chose to have mem.h rather than push the defines down
> > into mem.c (which from the current code + patch set looks like
> > the more logical thing to do).
>
> The main motivation was least privilege access to memory-device
> details, so they had to move out of cxl.h. As to why move them in to a
> new mem.h instead of piling more into mem.c that's just a personal
> organizational style choice to aid review. I tend to go to headers
> first and read data structure definitions before reading the
> implementation, and having that all in one place is cleaner than
> interspersed with implementation details in the C code. It's all still
> private to drivers/cxl/ so I don't see any "least privilege" concerns
> with moving it there.
>
> Does that satisfy your concern?
>
> If yes, I'll add the above to v3.

Oh, another thing it helps is the information content of diffstats to
distinguish definition changes from implementation development.
