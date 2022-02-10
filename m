Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333DEC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Feb 2022 02:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiBJCAS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:00:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiBJB7c (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 20:59:32 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23AA2BB3F
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 17:55:22 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id l19so1773431pfu.2
        for <linux-cxl@vger.kernel.org>; Wed, 09 Feb 2022 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FaKrAwHGLtXL2cSsiJLi4qyTyQTOyOPZJGloEpo5bqI=;
        b=yiQyFhU19IKFZP4pZdKQijW+lcfxY0YvW4Mrm9CFDybeehplu60jXzqD3X9QoRc9Cu
         8BXB/5xAaSYDkgluYFUSHoK9UcvplOQ1iB+mAQhgekJ8jvgzIkRiR6UyAXVQOp5JKBgR
         041Axi+OjBR0Q7ekpW7p9qVYdbZ9OqjsMmRM3j/mfUF0K9BV618ARPGvnJZLYtvrYXE6
         k8mLQC9bMjVTE8NRHHOO0jDudyt5OJI7169i4KhBSqRgM7xU4BgoyDZ4YhVc2MPx/CLD
         s1KR5MiCak1xCI6ZKKOd7o4He6hfz/zyjphfZZZ2/qx4AfZWRM3+Bn77Z1h2qaL9LyWh
         eKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FaKrAwHGLtXL2cSsiJLi4qyTyQTOyOPZJGloEpo5bqI=;
        b=XOB/d0smz+obs1qIR0H2lhd8Wm1WD6GTBZzIOOADKwA1wnllvT82q0WXy4SpAYDx1J
         Z+djEvk/oaUuPxldHO+prqV4oYOGCLZxZC48JUEjARt3+/W0QCdWM04ft/LYoDhmNo5T
         XZ+oqnB4qYKkVd42hoJ+lJpin6eJyv3zn+ACc7Wq9k/A87VKmxjG55sFrI/JrCLVH08n
         Q9GTU7pkhMCcgh/3oinsA7+/u3CNY12/FgaLgGtcHxmoMHbrU4qXCMmNoPqcIgf6skip
         HNSnpAl7le1ICX52aMVMFjPf5Ws4aAaUUkz1xpiDu+YRU8H7UriNzm0qalbFS/0TPety
         YDJA==
X-Gm-Message-State: AOAM531eHnvVuGiOEiXGRw8GPMbSur/P0o4vNypQOoG+yEpGrL5AFx8j
        tXRBUT5vTEmLqTzWvFEgfdB3KMdBacDiGfntdza5Sw==
X-Google-Smtp-Source: ABdhPJxCG8t+LcSqKHwT+XSUrKgS+tI0PWxO1sqi7kQwRGZfah9rLEIetw7lNZ3YWiM68BdUK07pbYgc1H/jPmvjP6g=
X-Received: by 2002:a62:e907:: with SMTP id j7mr5391741pfh.3.1644458122420;
 Wed, 09 Feb 2022 17:55:22 -0800 (PST)
MIME-Version: 1.0
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298564631.3021641.5552442288217413180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220210011046.GA956428@alison-desk>
In-Reply-To: <20220210011046.GA956428@alison-desk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Feb 2022 17:55:11 -0800
Message-ID: <CAPcyv4jPChp0XK0oWU4ZQMBohr1e=cNXqvE_G34ZaWkn+Y19-A@mail.gmail.com>
Subject: Re: [ndctl PATCH 26/37] cxl/memdev: Add serial support for
 memdev-related commands
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Feb 9, 2022 at 5:06 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Sun, Jan 23, 2022 at 04:54:06PM -0800, Dan Williams wrote:
> > Allow for a "-s, --serial" option to turn the argument list into serial
> > identifiers.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  Documentation/cxl/memdev-option.txt |    5 ++++
> >  Documentation/cxl/meson.build       |    4 ++-
> >  cxl/memdev.c                        |   45 ++++++++++++++++++++++++++---------
> >  3 files changed, 41 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/cxl/memdev-option.txt b/Documentation/cxl/memdev-option.txt
> > index e7785827ab4c..64348bed1791 100644
> > --- a/Documentation/cxl/memdev-option.txt
> > +++ b/Documentation/cxl/memdev-option.txt
> > @@ -2,3 +2,8 @@
> >  A 'memX' device name, or a memdev id number. Restrict the operation to
> >  the specified memdev(s). The keyword 'all' can be specified to indicate
> >  the lack of any restriction.
> > +
> > +-S::
> > +--serial::
> > +     Rather an a memdev id number, interpret the <memdev> argument(s)
>
> Rather 'than'
>
> That's all :)

Appreciate it, thanks!
