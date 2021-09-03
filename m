Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818FDC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 03:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497AE61057
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 03:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhICD7d (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Sep 2021 23:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhICD7d (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Sep 2021 23:59:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C40C061575
        for <linux-cxl@vger.kernel.org>; Thu,  2 Sep 2021 20:58:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u6so3334932pfi.0
        for <linux-cxl@vger.kernel.org>; Thu, 02 Sep 2021 20:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wOalAePuAJnThsQpwJBROsDRanxKLhv6aAjQVKpLCk=;
        b=LS+dmgpAD636OwNI7DMrkDYpAhR1yT1A3WcKYbfo2x+uchmZNT4sEWaqsTJU6AeKVN
         ouvdDOYe0d+8ohickpONYg2BYV/uv3tckR8eszW9wGyRkr28nYA25Vc4oqXtAQrHMAjD
         e+tCOxpaHGTbry1srsJH0VR2PMijUHV2KAy5+KsxORGM9kEj6ftr5MVOU7S//QlLUGhr
         6dPK+K7jtqybJzipkadWrg/t7w2Fnc0LtuGrkmOedIfgmch/6+RaH7kEi/bEKzYG0+Em
         93vHzlKjrHotec9qCZkCTMcnbTNtBQOZuL7aBkYBJMNU7JHlwoFXNHaoMBVl9sCn+eOd
         Mz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wOalAePuAJnThsQpwJBROsDRanxKLhv6aAjQVKpLCk=;
        b=T3IrvtMLy3kEd1r+xaSPf4nPpWr5bBBBZyuC++IuxNfFaZKAR5hHBQ1ikrFDBwLFZI
         YKmSPfIhYrb7eWmwQDY5rYlTZC5IO8u2dMg62tgRol++xy3DyN6g+BXRgsCvWbmjy9iN
         vN1YkZWxQbLhouaQXqyNudSrl2bhc7FHmg6FyUKoe/1OBB/ZubXr9H/ScIdKK7hE/Nt/
         xWuGrQcxgrdUGaNBzqGMlj0w7SLR33XtKO5kKYEo1txm23iiq7tlXZGz/n5aBlSADAMn
         jLxeWFZAUnXbH4TEBiJ6lG+Z5lxKIbksqfy9T9rOKKAK3w23AvYkxMUsKS+i0QhVU/53
         pyBA==
X-Gm-Message-State: AOAM531ULBBsdHZcDG2FDPKpl+JtnyWXzlMdYCd0aolnaY5EOy1H0XeS
        qT0RQSiDCPrnGxVXuMVAlhvzO+x8SNADma2po8a4WQ==
X-Google-Smtp-Source: ABdhPJzGRoF8cOmILH2aN/M/bwig3fIeWC6Qc+Z0Gjm/st5g5Ld7mmbaGMDL7QVzHdH2bf7VLZvwE3mtAwMVRkYy7j0=
X-Received: by 2002:a65:47c6:: with SMTP id f6mr1686451pgs.450.1630641512751;
 Thu, 02 Sep 2021 20:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <162982112370.1124374.2020303588105269226.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162982119604.1124374.8364301519543316156.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210902173602.00000272@Huawei.com> <20210902174138.000064a7@Huawei.com>
In-Reply-To: <20210902174138.000064a7@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 2 Sep 2021 20:58:22 -0700
Message-ID: <CAPcyv4h8uB3fzQrCLdHa=-=15Km77A3KvoTeGEQpx2AL_zpRNw@mail.gmail.com>
Subject: Re: [PATCH v3 13/28] libnvdimm/label: Define CXL region labels
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 2, 2021 at 9:41 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 2 Sep 2021 17:36:02 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Tue, 24 Aug 2021 09:06:36 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > > Add a definition of the CXL 2.0 region label format. Note this is done
> > > as a separate patch to make the next patch that adds namespace label
> > > support easier to read.
> > >
> > > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > FWIW
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Oops. Just noticed something below that needs fixing, so keep
> that RB with the missing docs fixed.
>
> >
> > > ---
> > >  drivers/nvdimm/label.h |   30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >
> > > diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
> > > index 31f94fad7b92..76ecd0347dc2 100644
> > > --- a/drivers/nvdimm/label.h
> > > +++ b/drivers/nvdimm/label.h
> > > @@ -65,6 +65,36 @@ struct nd_namespace_index {
> > >     u8 free[];
> > >  };
> > >
> > > +/**
> > > + * struct cxl_region_label - CXL 2.0 Table 211
> > > + * @type: uuid identifying this label format (region)
> > > + * @uuid: uuid for the region this label describes
> > > + * @flags: NSLABEL_FLAG_UPDATING (all other flags reserved)
>
> nlabel docs missing here.
>
> > > + * @position: this label's position in the set
> > > + * @dpa: start address in device-local capacity for this label
> > > + * @rawsize: size of this label's contribution to region
> > > + * @hpa: mandatory system physical address to map this region
> > > + * @slot: slot id of this label in label area
> > > + * @ig: interleave granularity (1 << @ig) * 256 bytes
> > > + * @align: alignment in SZ_256M blocks
>
> Probably need to add docs for reserved to suppress warnings
> from the kernel-doc build (unless it's clever about things called reserved?)

Nope, it complains about @reserved not being documented.

There's some legacy kernel-doc escapes in this file, so I fix those up
in a separate patch before this one.
