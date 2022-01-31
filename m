Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF3C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Jan 2022 23:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiAaXbb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiAaXba (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Jan 2022 18:31:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B5C06173B
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 15:31:30 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c194so1717993pfb.12
        for <linux-cxl@vger.kernel.org>; Mon, 31 Jan 2022 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6tEMYobP7+G4jgA5hVF3vhoENh1fbXIUfhfOrDsbEg=;
        b=1aEb90z5eqGyOxcarrvJThvqXMyh8ALG56+4thL0dF+8CIPbqWAnk7IVMQlCU1M3Qp
         pjsoLfrZo+4J0VYeoWqbb9GEqp+VdZmvSFvQ5oDfE+ijMUGeg5uIeiJBcDZsv8rcIo9n
         N8eqUDUOIhZIle12u9t7K9eC2xRerq9LX/tA4bD4Iu3xp0woty3u4eil+xbo2zLj4nBa
         SuhiGNsan/KgHqKqiTJMP+enjOopH3wqG81fQv3eIzccQJl1/Yz637I0qFrrVmpC6qYc
         MN41vR5ymojqwhYMI0N7vvV99LcIMJRbACq2HhaMggktsTZpIqNFP+k2RcQsZhkB5Nst
         013A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6tEMYobP7+G4jgA5hVF3vhoENh1fbXIUfhfOrDsbEg=;
        b=aPRE9FiITQpwYjIJ1ygtLXafhY16Y/0CbQLkmN0o959f8IPphrQxI0SkV1j2MiHF++
         USjcNcKm9VX4/NKztCEd9Yq+te5UyEWSpvufrSxcK4YWjEnyzoQyb6+k+Avu5PFJt6yI
         vKoODiF0KmhJT32y72SO8VVgumDBjGZMvZBm914+atGjEkTnuk4h5JgmVRYsW+iPmBtm
         nhrHzmzGT8+nKXUaG5AQ5s5EbWvgeqcyAaLb0wGGHlHT33Q2ThxgUsRA5dwSkMB/welN
         qMGu5D3EfeXZNlFLu5iDJqsJuEGX5/N6WzhkuIt8/NByKvHzi3et5aNbwyArztkgl0aU
         eM+g==
X-Gm-Message-State: AOAM533r43M5Pyy6LYW7YsrqydtfS4HoNV2az4fzbrIkw1baid7R5R9r
        rhDxzZnf6X7oIwptxiuUED084i/s0M7LnBnZD46ngQ==
X-Google-Smtp-Source: ABdhPJx0H6KJhvBY/aAzniN8BZM2cYXpwW59Ub1gGMlKc9Vx4sLVb4Q4obNYuwyLveRbjpENPuLJYBiDEj+cdEsL3ho=
X-Received: by 2002:a63:85c6:: with SMTP id u189mr18348635pgd.437.1643671890007;
 Mon, 31 Jan 2022 15:31:30 -0800 (PST)
MIME-Version: 1.0
References: <164298420439.3018233.5113217660229718675.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164316562430.3437160.122223070771602475.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131155934.000064ac@Huawei.com>
In-Reply-To: <20220131155934.000064ac@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 15:31:22 -0800
Message-ID: <CAPcyv4irL1aT_xEWFaM=0YZz8U99qK6TeyAQxWyKriom4uzCBQ@mail.gmail.com>
Subject: Re: [PATCH v4 16/40] cxl/core/port: Use dedicated lock for decoder
 target list
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 31, 2022 at 7:59 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 25 Jan 2022 18:54:36 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Lockdep reports:
> >
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  5.16.0-rc1+ #142 Tainted: G           OE
> >  ------------------------------------------------------
> >  cxl/1220 is trying to acquire lock:
> >  ffff979b85475460 (kn->active#144){++++}-{0:0}, at: __kernfs_remove+0x1ab/0x1e0
> >
> >  but task is already holding lock:
> >  ffff979b87ab38e8 (&dev->lockdep_mutex#2/4){+.+.}-{3:3}, at: cxl_remove_ep+0x50c/0x5c0 [cxl_core]
> >
> > ...where cxl_remove_ep() is a helper that wants to delete ports while
> > holding a lock on the host device for that port. That sets up a lockdep
> > violation whereby target_list_show() can not rely holding the decoder's
> > device lock while walking the target_list. Switch to a dedicated seqlock
> > for this purpose.
> >
> > Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Suggested additional tidy up inline.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changes in v4:
> > - Fix missing unlock in error exit case (Ben)
> >
> >  drivers/cxl/core/port.c |   30 ++++++++++++++++++++++++------
> >  drivers/cxl/cxl.h       |    2 ++
> >  2 files changed, 26 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index f58b2d502ac8..5188d47180f1 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -104,14 +104,11 @@ static ssize_t target_type_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(target_type);
> >
> > -static ssize_t target_list_show(struct device *dev,
> > -                            struct device_attribute *attr, char *buf)
> > +static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
> >  {
> > -     struct cxl_decoder *cxld = to_cxl_decoder(dev);
> >       ssize_t offset = 0;
> >       int i, rc = 0;
> >
> > -     cxl_device_lock(dev);
> >       for (i = 0; i < cxld->interleave_ways; i++) {
> >               struct cxl_dport *dport = cxld->target[i];
> >               struct cxl_dport *next = NULL;
> > @@ -127,10 +124,28 @@ static ssize_t target_list_show(struct device *dev,
> >                       break;
> >               offset += rc;
> >       }
> > -     cxl_device_unlock(dev);
> >
> >       if (rc < 0)
> >               return rc;
>
> Now you don't have a lock to unlock above, the only path that can
> hit this if (rc < 0) is an if (rc < 0) in the for loop.
> Perhaps just return directly there.

Yeah, looks good.
