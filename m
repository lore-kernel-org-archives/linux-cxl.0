Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF029C433ED
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Apr 2021 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5CA613B6
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Apr 2021 00:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbhDNATJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Apr 2021 20:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237765AbhDNATH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Apr 2021 20:19:07 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBC6C06138C
        for <linux-cxl@vger.kernel.org>; Tue, 13 Apr 2021 17:18:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d21so1415736edv.9
        for <linux-cxl@vger.kernel.org>; Tue, 13 Apr 2021 17:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPI7jDQhOaLsdgoyODIak4daTWQPVquNlAIVjshUjX0=;
        b=ggHj9xzgiR4DK+Fy5LpeNQpZt9RCpTy9FWlCIRBv3+oZAIIO3QDp8pcdYPpv6G5OcI
         v0E0pq9oMPx8udX8S87hsHt2uELmR3pHnuPQNJJXf33/zS1GDESpGSjX5bjXg11fSuOG
         HU7cBM0fA/j/nYgzNCiRnN9JhRR5gTz8rsky4TxgwmpTp1f3mUaFu1CinQQsqtrTQX9A
         akSIrHOMF+4MNIqBlCKvS08fKlwV67SBVFW0lUELzVfoP4vw/OYvsnNYsHIpsrcTtacD
         LOieO7ygeOGSibHvAV39Gz5l5MnTj0Iv5RCrgWDn5MCDzRi537BwTCc42JLOg0pbil/m
         jPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPI7jDQhOaLsdgoyODIak4daTWQPVquNlAIVjshUjX0=;
        b=YDt8crCvv/Lo9PvXAEUq8EXln4cFDCIrX4Mbt902u2vsJnKGtjnsTkRKUpbZe6K0Jl
         npPoZ2M+s88H0bmfIgnr+rBgInWQFsOL1P/mOqPIs9m8os5ukzewWJLemGwaHekVJAdq
         u2mOncMk7z8YRNY0p6mOSWibmxztgQDIqNmOQvPH+njoKIZGs8p0fcp+GFILb7P2ftTR
         PROPNyllBMPNKMLDbFH0acpbXb1dXIRE7OdKXZv8nf1NnBWkWX+OjYSszfZa4cW9DR6i
         3Prlq5zYtWdXSf8jOsUGpBK1u8ROXOhQxdtQLYeX0d59rU/PQThtjJYhLGoYhkZ9hdhg
         cBTQ==
X-Gm-Message-State: AOAM530G6cmgr3hmYVU8NZ9MtGGmbx81hKOS9prkAOcof1Aa6V5xe7EP
        biWC/QYd2sYi6bgAD73htSVu/wusTO6w7F6mInDlpHGaWU0=
X-Google-Smtp-Source: ABdhPJw11vKjxLMHXeF0A+YJX5dBT5wKsozV/YUcKeX92UJ9vz2xcGop+8tt8w0BdEJyVGnvjIdgQYDu0h2EcyKcelg=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr34093851edu.300.1618359524532;
 Tue, 13 Apr 2021 17:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728744762.2474040.11009693084215696415.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210406173845.00000bec@Huawei.com>
In-Reply-To: <20210406173845.00000bec@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 13 Apr 2021 17:18:41 -0700
Message-ID: <CAPcyv4h4z9Y_Zbzk_jiZXs6+gPAbdw0UJHW5NvTaM2ZcvJ6ftw@mail.gmail.com>
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

On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 1 Apr 2021 07:30:47 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for sharing cxl.h with other generic CXL consumers,
> > move / consolidate some of the memory device specifics to mem.h.
> >
> > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Hi Dan,
>
> Would be good to see something in this patch description saying
> why you chose to have mem.h rather than push the defines down
> into mem.c (which from the current code + patch set looks like
> the more logical thing to do).

The main motivation was least privilege access to memory-device
details, so they had to move out of cxl.h. As to why move them in to a
new mem.h instead of piling more into mem.c that's just a personal
organizational style choice to aid review. I tend to go to headers
first and read data structure definitions before reading the
implementation, and having that all in one place is cleaner than
interspersed with implementation details in the C code. It's all still
private to drivers/cxl/ so I don't see any "least privilege" concerns
with moving it there.

Does that satisfy your concern?

If yes, I'll add the above to v3.

> As a side note, docs for struct cxl_mem need a fix as they cover
> enabled_commands which at somepoint got shortened to enabled_cmds

Thanks, will fix.
