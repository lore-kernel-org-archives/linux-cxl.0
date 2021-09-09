Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9525DC433F5
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F2461108
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Sep 2021 18:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237451AbhIISv0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbhIISvY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Sep 2021 14:51:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF3C061756
        for <linux-cxl@vger.kernel.org>; Thu,  9 Sep 2021 11:50:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id e7so2741749pgk.2
        for <linux-cxl@vger.kernel.org>; Thu, 09 Sep 2021 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p2+KUFUok6SA2jcR9Vhb080u3BolVjtOcgcauFbFl0Q=;
        b=zlnbe4R4Aaz0PEElFoIcunGsJQH/qILZd5fa1zy1Jc6lz3m1W3gYiYUpOZxI4fhUgD
         lBWp1XysCW6KBsoUXv2Hh6u4K771xjd5+yvUSRt+VlwdylQmjg7YUf+y2d+GF1n0khgR
         F0e1NXdV0NeOisPm+5yICNMnL1kDvUvWJr97UVtxrbkqrvtwGv1w36ktvbKm8BBebJw0
         oXrEkTB+zSum4ySYd6XrsPC8LOBuvooSItcjlCXX1fFQ2MUngoI42OKM4QwZfH0fKmHm
         ALxB+TeJ9KpoWbUX3PJcgv3xj5/toqJrl7fW8CM8MK6qMJmNX+dKQ15JgUpUXoQk/W1r
         Gg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p2+KUFUok6SA2jcR9Vhb080u3BolVjtOcgcauFbFl0Q=;
        b=nmFXGPzHsZRhSn2FwYAY2G44B5MuGyL0XtxP8DMvnJw+BDt46ABAzidf6eEaUyePFM
         esf+ljSaQFjQ4hB13nUCZUvLKFxw3CS5B0S1M08PyENShgPSUPtwDU2RYQrEn68aUC+h
         77cQHFBQIdNc/om9Sbp7zJdukiYI72133lGy13tQ76SG0hLz53gX8F22dJ9+1hhkRCFw
         UvTnXtC+Zwy/tXH4wsAz+nzspWNy2nDd2Q1b1BQURj8myv9Sn195VHzI96F1NybU5ZyE
         2jRw/8aDiTLR93m6jsQI1Wg90XKCutYkefaodxw6hkN4ZRoePGiuqMAgY5MU57Npglz7
         fq9g==
X-Gm-Message-State: AOAM530nZzENy+OBpmkN9H6ZDuXmR2eylby8yD3TmkYa+S78vK9MewWj
        S45dK1uXsAM4bDPmkzuHGewy9x0gUziCP5/XerlUHw==
X-Google-Smtp-Source: ABdhPJyRdOmtPd0s2xFWVDE0piNkTvJbP57DLCVwte6ikcKvurNHKJMruC52a1h0Sg4Su8mt3wDLlIhQjK3qXce1sao=
X-Received: by 2002:a63:3545:: with SMTP id c66mr3863167pga.377.1631213412732;
 Thu, 09 Sep 2021 11:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <163116429183.2460985.5040982981112374615.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163116435233.2460985.16197340449713287180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210909164125.ttvptq6eiiirvnnp@intel.com>
In-Reply-To: <20210909164125.ttvptq6eiiirvnnp@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Sep 2021 11:50:01 -0700
Message-ID: <CAPcyv4hH7=cbnpz9dcKFEByqZkVxJVXpuks4g_63VguisDdPPw@mail.gmail.com>
Subject: Re: [PATCH v4 11/21] cxl/mbox: Move mailbox and other non-PCI
 specific infrastructure to the core
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 9, 2021 at 9:41 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-09-08 22:12:32, Dan Williams wrote:
> > Now that the internals of mailbox operations are abstracted from the PCI
> > specifics a bulk of infrastructure can move to the core.
> >
> > The CXL_PMEM driver intends to proxy LIBNVDIMM UAPI and driver requests
> > to the equivalent functionality provided by the CXL hardware mailbox
> > interface. In support of that intent move the mailbox implementation to
> > a shared location for the CXL_PCI driver native IOCTL path and CXL_PMEM
> > nvdimm command proxy path to share.
> >
> > A unit test framework seeks to implement a unit test backend transport
> > for mailbox commands to communicate mocked up payloads. It can reuse all
> > of the mailbox infrastructure minus the PCI specifics, so that also gets
> > moved to the core.
> >
> > Finally with the mailbox infrastructure and ioctl handling being
> > transport generic there is no longer any need to pass file
> > file_operations to devm_cxl_add_memdev(). That allows all the ioctl
> > boilerplate to move into the core for unit test reuse.
> >
> > No functional change intended, just code movement.
>
> At some point, I think some of the comments and kernel docs need updating since
> the target is no longer exclusively memory devices. Perhaps you do this in later
> patches....

I would wait to rework comments when/if it becomes clear that a
non-memory-device driver wants to reuse the mailbox core. I do not see
any indications that the comments are currently broken, do you?

[..]
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 036a3c8106b4..c85b7fbad02d 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -14,7 +14,15 @@ static inline void unregister_cxl_dev(void *dev)
> >       device_unregister(dev);
> >  }
> >
> > +struct cxl_send_command;
> > +struct cxl_mem_query_commands;
> > +int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > +               struct cxl_mem_query_commands __user *q);
> > +int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
> > +
> >  int cxl_memdev_init(void);
> >  void cxl_memdev_exit(void);
> > +void cxl_mbox_init(void);
> > +void cxl_mbox_exit(void);
>
> cxl_mbox_fini()?

The idiomatic kernel module shutdown function is suffixed _exit().

[..]
