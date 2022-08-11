Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096B8C25B07
	for <linux-cxl@archiver.kernel.org>; Thu, 11 Aug 2022 03:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiHKDKv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 10 Aug 2022 23:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiHKDKt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 10 Aug 2022 23:10:49 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D5DBBE
        for <linux-cxl@vger.kernel.org>; Wed, 10 Aug 2022 20:10:48 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 66so17111012vse.4
        for <linux-cxl@vger.kernel.org>; Wed, 10 Aug 2022 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D2IQtNqdvpHvUz00qnqtMiN66yM6U3oxqDqZn/rUVOc=;
        b=hVfhhHoFyE3kJYQLKXDo4wKABkom9XmpMH79W/cRq+Hp3VLCxArg3zNftdTM+ZGwAL
         Jy0XcJIoX0I0TZrBT1qA6h+mhJTro/ARNNyqgijww7CnZPAjATV6wsmcWXS2gpzKu+S3
         xw+qfxcIxF4ELDsfVoOfB7hacSTuNjOOls2J3aVNot/2AYBe/BLujFZwQqVDOyOA/6SE
         V3JhyLvqrI8kKih40V2PuWyjI3GlzUxJg6567McXXuuS4PxlQmZDW5A+z4+eoM8YsGPr
         0G7zVA5B3CdywtrMI9/2WvScoF6iE+bBAYUlEymoFwFWthd6qYHPvoIrxDWM1/W94Isa
         wTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D2IQtNqdvpHvUz00qnqtMiN66yM6U3oxqDqZn/rUVOc=;
        b=y/pGoBsWLaxAlwXZtBzQYJDnZZrrqaFXj8Tyb97mM/k9ecEp5qAbzwLNwXt3wkyCfQ
         3frkrn7wDcfXqPAwebIxSctrcw7FVn2cwWWBvuFGU5VjxJ0u3X8tOsh8Sf0wszJyja/y
         NxL+L+XaPSRmrlUWTqmfJ/oGdUkN4PFOrp3YZqlwVZUTEVtc7XjWmjUkgq6mX7JDEpSr
         pmAR2H5TdfuY7W+xPYSZQDQyiO9XHvDRz/MHSP5ATSBPpkoN2JDBVOTeori9gkptTjXp
         UbHxg5JVLS8zoRwdfS9QykOiBfmrqc79XS+AiaoZl9c0WnT1tRBd1eq6Gnw9WwRYBmQg
         sr8A==
X-Gm-Message-State: ACgBeo1glnxqWPnp1E49SmDU5uop4fW6IdxSx9dU85T/i+ErhjHOjzul
        wZL2pnZZNcq8q/ZYglK212Sr6Q8BPEgCOO5QfUbgMJAv
X-Google-Smtp-Source: AA6agR60zVuJ8orJamY9BzWU/uAQ2mKsQvNHAlDnOTNLyXiKUoeA5zMmM3WQFai91hVTHJjFsvsG0E07kWHRMY1e2IA=
X-Received: by 2002:a67:eada:0:b0:388:95b5:886f with SMTP id
 s26-20020a67eada000000b0038895b5886fmr10695438vso.10.1660187447364; Wed, 10
 Aug 2022 20:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <62f132aee401b_1b3c294c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAGr_yG389Bm_NL8CLgo_ZkGd4staocNENbtb-ULVA5vh_ywmcw@mail.gmail.com> <62f27a8e9acb6_1f18b294e2@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62f27a8e9acb6_1f18b294e2@dwillia2-xfh.jf.intel.com.notmuch>
From:   Bobo WL <lmw.bobo@gmail.com>
Date:   Thu, 11 Aug 2022 11:10:34 +0800
Message-ID: <CAGr_yG2_qpDbzB9KxP=yD=PYvjOxCckT5nCv=M53GgENNJTW-A@mail.gmail.com>
Subject: Re: [BUG] cxl can not create region
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 9, 2022 at 11:17 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Bobo WL wrote:
> > Hi Dan,
> >
> > Thanks for your reply!
> >
> > On Mon, Aug 8, 2022 at 11:58 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > What is the output of:
> > >
> > >     cxl list -MDTu -d decoder0.0
> > >
> > > ...? It might be the case that mem1 cannot be mapped by decoder0.0, or
> > > at least not in the specified order, or that validation check is broken.
> >
> > Command "cxl list -MDTu -d decoder0.0" output:
>
> Thanks for this, I think I know the problem, but will try some
> experiments with cxl_test first.
>
> Did the commit_store() crash stop reproducing with latest cxl/preview
> branch?

No, still hitting this bug if don't add extra HB device in qemu
