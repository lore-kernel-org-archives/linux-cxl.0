Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D97C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Sep 2021 19:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF04D6112F
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Sep 2021 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbhIGTsT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhIGTsS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Sep 2021 15:48:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3247C061575
        for <linux-cxl@vger.kernel.org>; Tue,  7 Sep 2021 12:47:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jg16so502391ejc.1
        for <linux-cxl@vger.kernel.org>; Tue, 07 Sep 2021 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N9otEH3ER4+vClNTReF/OzEffgc/Rwc7xeZ8X4aJVGE=;
        b=T7Tx11t8FZiGm+i4WywmrqwjGcPyHyx2XDrAJs1Lj/2zHzDdhN5/UsG0diUJC6Ufoz
         0txtM/V3dAwdElDdSbxCE+/r1/aTJTSB0jY9PFEmvDflr151Iahw8BB6sZ79K9f7894b
         +lgmtKtrRHyltv9VueYGxvcjbIXVfD55pN3A98325mtrxCUncORxkOkMooR+v9qeH2Kd
         lH8QSn/ZK3vPUKutJDG2sMPZA0qyonWIrdKw+FMbfAQZSiOV1s6zmw+OhxmmyCfc6V+H
         bUEN5Uom114T+0M6CzMQtPDJQrpDpl+nt1inKln4suRlTHb7OvFy4RZdl9p/HA09BOvg
         gFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N9otEH3ER4+vClNTReF/OzEffgc/Rwc7xeZ8X4aJVGE=;
        b=aWLLPerCCke31O/+Sin4i8omJNa6BldEzExQJ0hFBf966OWu7eaaDIgK/tBTLRSDVu
         LjF5kosHmts/nnYVU6ZTWajZ142Iqlp37M73T8XlTnAJaK63Zo3qfSFOnOwidW+3pray
         bSeddaYN0/3XuJ6mYInzze6AUUdOh2TVhhMsfiIHh4BXJ4hYnPvgGGqSSMKuLtC85kUZ
         pqjWWnZ7lxB6O/mibTL75EeT9TT7ALycsJLnLD+9d1tbTwY4OPy2VRJVese+a3CVbIR5
         5f9kTXTOk+zd97ymerX9/RlIBOPML+KriifRYc8/mPIxGo6lNviHBhtEAk4m0kv8aOLg
         4Uag==
X-Gm-Message-State: AOAM533jPSKQcxOBEwZG2OiXXA0NJ/RlOGVxvlGkmr1lldY1Ni+QXPdJ
        jkY/LXIHJ4UBc2fS5Dxc1hjZhrOEmp1cJXCWWim1
X-Google-Smtp-Source: ABdhPJwE7ZwqYCa5aBojV9w+zCqMd845sudx0MG3jp2xq8CwHSDUX3VF+OrrUle3jgdjzPy8sxu96/CDDKqbPgZ1c2w=
X-Received: by 2002:a17:906:7208:: with SMTP id m8mr32611ejk.82.1631044030307;
 Tue, 07 Sep 2021 12:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163072204525.2250120.16615792476976546735.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHC9VhTNu8E9WkzUHbQC9xKK5U74L8oqetUtPXGX2RSofMcqgw@mail.gmail.com> <CAPcyv4gR+WbYf-dT0niT23UY8jZZVBXMk4R-1_0exPcbHrs=0Q@mail.gmail.com>
In-Reply-To: <CAPcyv4gR+WbYf-dT0niT23UY8jZZVBXMk4R-1_0exPcbHrs=0Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Sep 2021 15:46:59 -0400
Message-ID: <CAHC9VhTo-eV4oUF-ia67X-KK-qyB=M0xDv-=p0-xA-4=0BJ6uA@mail.gmail.com>
Subject: Re: [PATCH 2/6] cxl/pci: Fix lockdown level
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        stable <stable@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "Schofield, Alison" <alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 7, 2021 at 1:39 PM Dan Williams <dan.j.williams@intel.com> wrote:
> On Fri, Sep 3, 2021 at 8:57 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Sep 3, 2021 at 10:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > A proposed rework of security_locked_down() users identified that the
> > > cxl_pci driver was passing the wrong lockdown_reason. Update
> > > cxl_mem_raw_command_allowed() to fail raw command access when raw pci
> > > access is also disabled.
> > >
> > > Fixes: 13237183c735 ("cxl/mem: Add a "RAW" send command")
> > > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > Cc: Paul Moore <paul@paul-moore.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/pci.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Hi Dan,
> >
> > Thanks for fixing this up.  Would you mind if this was included in
> > Ondrej's patchset, or would you prefer to merge it via another tree
> > (e.g. cxl)?
>
> I was planning to merge this via the cxl tree for v5.15-rc1.

Okay, thanks.

-- 
paul moore
www.paul-moore.com
