Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58B5C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbiERQhr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiERQho (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:37:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB618DAE4
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:37:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n10so2587813pjh.5
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFzzwkIyc+aGWCfoOFgXEbTzquZc0NLq2qn3QopufHk=;
        b=xNWNS5oPG1OW/XDCeRhaG3cknxGFY/Bcp7Dvlml819eLAVM+Jy2cDHy7n8VMusYPYk
         Uz1XN487BJXE4RgtKbXxkeIsrSWTmazTRIGmV6fC3sqzLW1xTmqrcBTFobYG+zXsHN7i
         K5vxKUyB4059Bp2O9Cc8WMVHyMUfNRrPKmRXfpapXUyRIIy1KA+V/eY/XvKPUQBwLQjs
         DNiRC650fd1rRvxVIyuBRBpO7oRZLpr9Ok/HQg68VtFzj5wX5jtpuISQsdxP4KDS0LHH
         FiVU/rSEjjqqUIYmBPxaS5A9Cg/WtDSocrsO/eLNM2zpRAZEaEZTz+aJSY+1ibZds8cT
         ZnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFzzwkIyc+aGWCfoOFgXEbTzquZc0NLq2qn3QopufHk=;
        b=EHtJYPK1mf8M5KnqFvx+jvd2NQShmb1woZEJZJX13TSTEVR5S46YDN0WuFmG7WFVKk
         YcZ4YU6aLZkc+a5Bsy0dCefAhgmvnM5AG9OTgvf16ts8GuKuBEgFTYAW1bB1YsuMgjRl
         deiSUn6/1wY+XRuuQHma4E7oQGjztAFyUwdHH+mHcBqZxEtV06JyBh6hz7nXpDergTo2
         U5wUP4e8pznJLsusbs7JhGs3vWB8Qz/Ni8FGUNqJeKSdFbGYzBjt22xAjmwpAXT+Px1h
         Uwyg3FRYO3sm0DZtgfO94BA52V9NcfbgtvRX5SwOjHkObo/GIc2CPpKctc6RY+x4Y+D0
         d9QQ==
X-Gm-Message-State: AOAM532h2EI3g0XlpM801iUteZv2Ur1t0ahFRwaUFabyYAUZD/WtVdcv
        66fAuz4QOWUHzWFQvxYyvRPuCrbmylFDZ9C6N07DaQ==
X-Google-Smtp-Source: ABdhPJwtRwe/oovplnZ9EOMbW/nDZYAp8vi9EyYDK9JayYaqlL5aJ9w5eZ7MSaQ2yjHpveE6l9jTIHXPed0H4BuVdZs=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr435111pll.132.1652891854811; Wed, 18
 May 2022 09:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237928899.3832067.7236779148367594501.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220518172121.000001c0@Huawei.com>
In-Reply-To: <20220518172121.000001c0@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 09:37:24 -0700
Message-ID: <CAPcyv4jkY4txmuxhTk5oebf6yhbCzrJM5okdssz9HJrnqsgXYg@mail.gmail.com>
Subject: Re: [PATCH 06/14] cxl/pci: Move cxl_await_media_ready() to the core
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 18, 2022 at 9:21 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 12 May 2022 11:14:49 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Allow cxl_await_media_ready() to be mocked for testing purposes rather
> > than carrying the maintenance burden of an indirect function call in the
> > mainline driver.
> >
> > With the move cxl_await_media_ready() can no longer reuse the mailbox
> > timeout override, so add a media_ready_timeout module parameter to the
> > core to backfill.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/pci.c        |   48 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h          |    3 +--
> >  drivers/cxl/mem.c             |    2 +-
> >  drivers/cxl/pci.c             |   45 +-------------------------------------
> >  tools/testing/cxl/Kbuild      |    1 +
> >  tools/testing/cxl/test/mem.c  |    7 ------
> >  tools/testing/cxl/test/mock.c |   15 +++++++++++++
> >  7 files changed, 67 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c9a494d6976a..603945f49174 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -1,8 +1,11 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/io-64-nonatomic-lo-hi.h>
>
> Curiously I see the pending branch no longer has this include
> (which makes sense!)

It never had it before since there were no readq calls in core/pci.c
until this point.

> Otherwise looks fine to me.

Thanks!
