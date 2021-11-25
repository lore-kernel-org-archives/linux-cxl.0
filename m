Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C17C433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 25 Nov 2021 00:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhKYAKp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Nov 2021 19:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbhKYAKo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Nov 2021 19:10:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE99C06173E
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 16:07:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so6324477pjb.2
        for <linux-cxl@vger.kernel.org>; Wed, 24 Nov 2021 16:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I8hR1KxT4wL35Zv30bY7/ny/CJuScUrd2M5h9luPJc=;
        b=rQP9g8WcqcSUgu+wVJPZyaqA72pyJcjJdOPxk6lR282+Sce1iTiGDMO324f+MjUTgP
         S7HAp/v5nC9Uz4MYwgppClUs0doJraLsEWbcqDRPF2vXe9SMdfIQ20NoVC3MW+kdOlz1
         kgcFOcaQS62OuaoWM/HMsFtkmgF5T3Yj0UjXUUwKcpVVhKSYbgjgC00OdbLtkoFpm3jh
         3pfyeY2wfMPN3CAOn1VAVx3EQnCV3NFFAnu50tfEZAKSZsEdJXa3lbKGJQdXUN2iavCJ
         HLnE5U7xfzLU39pIeSzg6wqhU7wDQzd8BsfdDwDGtQIxRbU8ATkl5z8yXKIzAayv0bqQ
         GFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I8hR1KxT4wL35Zv30bY7/ny/CJuScUrd2M5h9luPJc=;
        b=kbUN9OfC/HbotLIIRJ6ZOdKHuzO8x0xKBnYeV4YhMgpozgJ0L2Zc/KDCVXBlFrXYus
         9nX+NbnpjbF1Ix0IHj/l3lO9ceSUJgAWDO/X3AoL6N0evklda2N0o65dNGmz2jZdADri
         ZBscAAkE8GCHqN5OXQQ9XRiGuUbKJTQZyX9RHMZ4bCFsWb2434ibiJhvNqwo50gCv5Cu
         kheA4uNmQBBU9lTZDgaY27/l92cDPdv8Y2k9jHUh5hZHiP9RCobE4EpOUKkSO7ES1k2W
         OcEIIVf90goFbmfKv1p98KfFaFNUoIHUqCmQtWdxcH73RFvdMQErDTbn9PHia5Gp0AyS
         0DDA==
X-Gm-Message-State: AOAM530MGWXPBeeyTrdKzncvG4YaJ1SKaNY0VGg6jU7x1xEDN7RgvQm+
        JxnEz1cgoVLLopNKqS7T4I4rza8LicItgdaAp2MWCA==
X-Google-Smtp-Source: ABdhPJwIM1z+xHukqE41p1pECXF9iTVnQjwh+qZUXgG5v3RG+5vj3HBBsQUv9dCIIT0L/V7y+dATRLP6crENzk1EIYw=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr1473018pjb.220.1637798853373;
 Wed, 24 Nov 2021 16:07:33 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-13-ben.widawsky@intel.com> <20211122162039.000022c1@Huawei.com>
 <20211122193751.gipqgs5ap24dacm3@intel.com>
In-Reply-To: <20211122193751.gipqgs5ap24dacm3@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 16:07:23 -0800
Message-ID: <CAPcyv4gBmc+C4d1RExH5qB2qunhkkMRqNZwzz29gc-1uaJiM4A@mail.gmail.com>
Subject: Re: [PATCH 12/23] cxl: Introduce endpoint decoders
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 22, 2021 at 11:38 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-11-22 16:20:39, Jonathan Cameron wrote:
> > On Fri, 19 Nov 2021 16:02:39 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > Endpoints have decoders too. It is useful to share the same
> > > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > > targets), only the underlying physical medium. As a result, some special
> > > casing is needed.
> > >
> > > There is no functional change introduced yet as endpoints don't actually
> > > enumerate decoders yet.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > I'm not a fan of special values like using 0 here to indicate endpoint
> > device.  I'd rather see a base cxl_decode_alloc(..., bool ep)
> > and possibly wrappers for the non ep case and ep one.
> >
> > Jonathan
> >
>
> My inclination is the opposite. However, I think you and Dan both brought up
> something to this effect in the previous RFCs.
>
> Dan, do you have a preference here?

I was thinking something along the lines of what Jonathan wants,
explicit per-type APIs, but internal / private to the core can use
heuristics like nr_targets == 0 == endpoint.

So unexport cxl_decoder_alloc() and have separate:

cxl_root_decoder_alloc()
cxl_switch_decoder_alloc()
cxl_endpoint_decoder_alloc()

...apis that use a static cxl_decoder_alloc() internally. Probably
also wants a cxl_endpoint_decoder_add() that drops the need to pass a
NULL @target_map.
