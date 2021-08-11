Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08BFC4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E71160EB5
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 02:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhHKCPU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Aug 2021 22:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhHKCPU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Aug 2021 22:15:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE01C061765
        for <linux-cxl@vger.kernel.org>; Tue, 10 Aug 2021 19:14:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa17so1055651pjb.1
        for <linux-cxl@vger.kernel.org>; Tue, 10 Aug 2021 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWnWHK81cHSSSYNhV/ky18B/eWmiRGBwsPJhNQ9JxJE=;
        b=Slqkm9exTJPLJIB8INasB6dcy8ztieb/Zvsv0MN53EtTKQFaxdX9F9qkB/vPbdmkIc
         rslPhVpjQJJzVevKA4HyKSKCVSgSEaXJigY/VM4OwIVsjta3zauY54S/eTOGwxUEkIa6
         PKYNY6mXwWTKfsOAVHd7GtqeIArMFqPz1tzK3YXBd6G9M87JvhWuYtZj9xdhBBVi/Js4
         j/urKU31kDGmUKrWzmDH0+2sjVcW1aWDsiJYBfk8fO5tALajOpF7q+hDd3pb4xfuafVl
         ml7EEw8VEO0Kl5Do57UPwRO6UWmF90cPVcwYe/QbSYYt2qv9y3UrWOeC4L/gWGyGtHij
         qI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWnWHK81cHSSSYNhV/ky18B/eWmiRGBwsPJhNQ9JxJE=;
        b=hYVRt6Fnc1RGZH8YW6PF9jopen88iRVBT021CB3GN/ga4O6DzPO+rK8fUtetVAx54n
         iORz6K9Zmt4gBbAWaCSKMwX1GeGbMCnmes3vsC3aJlJSISuOlXTNDBxcwVUReWV9AyFV
         Qa8yqJZsQd7lMgUhWvYcOkXuoR/GT5tC4auC+Ovr2ItapN+u0YiA7XVLiziWo2e5Ktf6
         rk0ZfYDvtLScdY1x8VbYwrtr5Frta6AndWp6cgIvMPjzxmBJ2wja5jWKxkqiJQtIrPgO
         k7ulasrtqgtJawavaKeLNh6DhLDOM59L85e3dielWqCTpoH1LY7g4ZTH7QpwPLVhtyB1
         4lJQ==
X-Gm-Message-State: AOAM532Pp6EEKWXBhyPIeGrGsxqXvuyKPJJVJzLGMMqqO3l9zkqUzy88
        Gh0UMiI85B1SZk3mlOo7h+5lnFUcBelSm4CtqnT/5A==
X-Google-Smtp-Source: ABdhPJxjI3G1JliiDL5lb4M9JD0cysUnjBy+5+KeQRqMz2HrCacDSU7gc575kfwMcqnqF+Dz8nUUJEQofF8F16s++Es=
X-Received: by 2002:a62:5f81:0:b029:3c6:abad:345 with SMTP id
 t123-20020a625f810000b02903c6abad0345mr26549389pfb.31.1628648096952; Tue, 10
 Aug 2021 19:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854815819.1980150.14391324052281496748.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210810213459.5zpvfrvbo2rztwmc@intel.com> <CAPcyv4iXZpeahdDxyRLd7ACS6vpV+VA3-J3MiLQvvV2Q6asBFg@mail.gmail.com>
 <20210810220654.nztok7mxvjzaizhk@intel.com> <CAPcyv4iLLPR+yijKNHceEKM4+fKQ4i6r+ZLYH+_b-ao6tznHLQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iLLPR+yijKNHceEKM4+fKQ4i6r+ZLYH+_b-ao6tznHLQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 10 Aug 2021 19:14:45 -0700
Message-ID: <CAPcyv4jn-1V=nCdgOxFJF3bVJd13YpRxnLvjE_BbacJ7_Qmwhw@mail.gmail.com>
Subject: Re: [PATCH 17/23] cxl/mbox: Add exclusive kernel command support
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Aug 10, 2021 at 6:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > > > What's the concurrency this lock is trying to protect against?
> > >
> > > I can add a comment. It synchronizes against in-flight ioctl users to
> > > make sure that any requests have completed before the policy changes.
> > > I.e. do not allow userspace to race the nvdimm subsystem attaching to
> > > get a consistent state of the persistent memory configuration.
> > >
> >
> > Ah, so the expectation is that these things will be set not just on
> > probe/unregister()? I would assume an IOCTL couldn't happen while
> > probe/unregister is happening.
>
> The ioctl is going through the cxl_pci driver. That driver has
> finished probe and published the ioctl before this lockout can run in
> cxl_nvdimm_probe(), so it's entirely possible that label writing
> ioctls are in progress when cxl_nvdimm_probe() eventually fires.
>
> The current policy for /sys/bus/nd/devices/nmemX devices are that
> label writes are allowed as long as the nmemX device is not active in
> any region. I was thinking the CXL policy is coarser. Label writes via
> /sys/bus/cxl/devices/memX ioctls are disallowed as long as the bridge
> for that device into the nvdimm subsystem is active.

Oh, whoops, the mbox_mutex is not taken until we're deep inside
mbox_send. So this synchronization needs to move to the cxl_memdev
rwsem. Thanks for the nudge, I missed that.
