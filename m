Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5633AC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A11461167
	for <linux-cxl@archiver.kernel.org>; Fri, 10 Sep 2021 12:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhIJM4s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233095AbhIJM4s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 10 Sep 2021 08:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631278536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+hqVVaMtmlu5vIIR42/tfkZcHE07Vsb/t2ZabEAuVn8=;
        b=Byv4GOEw5Dvjfv0ic1E575a3jckXwXRsMkHqPk6PwfMWqqBlSHqBb6A+TJv/Nqs2mc1/Ds
        kl3LejUJmkyh/SzahCQmHc1gItfituL52cvQVBKkudNPMEKyYGVIWFB+Yi9sUJrok2sRGx
        Uekq2jIUNOYTr3/bzh1hF3W7VdPDUsY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-IBgVGfT4PmmwSSdjLZGsNg-1; Fri, 10 Sep 2021 08:55:35 -0400
X-MC-Unique: IBgVGfT4PmmwSSdjLZGsNg-1
Received: by mail-yb1-f200.google.com with SMTP id d93-20020a25a366000000b0059fff274d9aso2270888ybi.4
        for <linux-cxl@vger.kernel.org>; Fri, 10 Sep 2021 05:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hqVVaMtmlu5vIIR42/tfkZcHE07Vsb/t2ZabEAuVn8=;
        b=f6OuxN9+J5kLbzXftpS9NXMBC6td2+IQ48srT7v+r6XhwolqwHqP7Cnk9W3k6pB5HJ
         c0swIhFYrZ1KPDR5azk7vBKzkeI3hHVdmfIVCP5QSH+i5E9d53Jm50cFSMnl2DPKd4lZ
         AaLhTY//fYW0h4tk6FfZUQl56GosZ4piiphwEZdOPkS+mImH5DqqINSlGElc2Q3jFZjl
         MzYYUnCr7KorjN3aOrp4snCMq5d/DcPUkKXch3pKh+nP1hn5PaHi04sCiB3T+9JV0os1
         YkSOp3EGE/8nmejKe96VxcioF0J3NX4wFFis9T+kIHWSgUV/ttru9EGOTPLJYOV/hdjn
         o+Pw==
X-Gm-Message-State: AOAM531UCk65FRrdpU3y4aMwQDoXndcZPj8yWmrqAyfvPvArOABxywwH
        odyG8J2Qc60bdiADrVhHNz0EndlcSLXQXQAR+F1UYUbYLv7FK5h0XHYuWtqW8biPOrc6liUDKFd
        0lkJmtLu5gGf3aLP7AdLGE05YjDgXZmiHUSjJ
X-Received: by 2002:a25:83:: with SMTP id 125mr2806863yba.467.1631278535034;
        Fri, 10 Sep 2021 05:55:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCqeqKoEN5LoT9Ez07Ke3w6l76GG7mOhpttL9gebeFK3ls7PtTmYrygK+0HgAjLEA/OhUktZ+UqwWqO3ZLu18=
X-Received: by 2002:a25:83:: with SMTP id 125mr2806831yba.467.1631278534790;
 Fri, 10 Sep 2021 05:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <163072203373.2250120.8373702699578427249.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163072204525.2250120.16615792476976546735.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAHC9VhTNu8E9WkzUHbQC9xKK5U74L8oqetUtPXGX2RSofMcqgw@mail.gmail.com>
 <CAPcyv4gR+WbYf-dT0niT23UY8jZZVBXMk4R-1_0exPcbHrs=0Q@mail.gmail.com> <CAHC9VhTo-eV4oUF-ia67X-KK-qyB=M0xDv-=p0-xA-4=0BJ6uA@mail.gmail.com>
In-Reply-To: <CAHC9VhTo-eV4oUF-ia67X-KK-qyB=M0xDv-=p0-xA-4=0BJ6uA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 10 Sep 2021 14:55:21 +0200
Message-ID: <CAFqZXNvSu2-nL8YEfKhEdT9csm1=nxecoo31FF+jgwyCVdjPMw@mail.gmail.com>
Subject: Re: [PATCH 2/6] cxl/pci: Fix lockdown level
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        stable <stable@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 7, 2021 at 9:47 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Sep 7, 2021 at 1:39 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Fri, Sep 3, 2021 at 8:57 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Fri, Sep 3, 2021 at 10:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > A proposed rework of security_locked_down() users identified that the
> > > > cxl_pci driver was passing the wrong lockdown_reason. Update
> > > > cxl_mem_raw_command_allowed() to fail raw command access when raw pci
> > > > access is also disabled.
> > > >
> > > > Fixes: 13237183c735 ("cxl/mem: Add a "RAW" send command")
> > > > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/cxl/pci.c |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Hi Dan,
> > >
> > > Thanks for fixing this up.  Would you mind if this was included in
> > > Ondrej's patchset, or would you prefer to merge it via another tree
> > > (e.g. cxl)?
> >
> > I was planning to merge this via the cxl tree for v5.15-rc1.
>
> Okay, thanks.

And I can see the patch is now in Linus' tree, so if Paul agrees I'll
rebase the patch on top of v5.15-rc1 once it's tagged and do one more
respin. There are a few other minor conflicts and one new
security_locked_down() call to cover, anyway.

Dan, is it okay if I preserve your Acked-by from the last version?
There will be no other change in the cxl area than rebasing on top of
this patch.

Thank you for taking care of the fix!

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

