Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8668BC433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 16:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiERQwR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240464AbiERQwQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 12:52:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1255210FE1
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:52:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c14so2699367pfn.2
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 09:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d6T6Mwy6p5rh1A/s3Kc5duBlOgAG0axcZfxqO1lb2G4=;
        b=WorHFFG5qi9ErjU+Bx18E+bRXwk3jizZvoQ9f3YgJGmFlTS43I/Je5X1tUDX17+ndb
         g/uv9TpzxRHHSiEsj/sri8LcUTm4twIGnpOXZ9CpDzEC1BeQRA/p03cuGXFB27QBGCaU
         5u35dD4uWiunxcakyNGocLt4WGBqar1cVYS7cLL31UgGdOPrhIO3T23rdaEuuwVGtNvx
         o1ppESh81Z+UlI8DfilJ92rRsJ9MRWd8CKRTf294HoNoUhks/oRhkQWWLd3g3qPExxbu
         ukLl/QO3DcrsO6CI/+FhO7XI5xSJUMXExtC0Shj5sNRSSO44SIDjb4l4xB9zTjCeLkFw
         A68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d6T6Mwy6p5rh1A/s3Kc5duBlOgAG0axcZfxqO1lb2G4=;
        b=aNd4JEbvggITpQRSfFfcBOr0wNQ/kN3tVsW6qrYRJ15VhVz6AjncwveiEQoI6BrIRq
         lPplD4t+MfQ21QGtc4tSWio0NcbnzRKyMiadLnokifziowcTpDK5nDkyARQQDrLg3Aru
         4lzpZk8hjvMOZtl5tLsyscUJqqwq5eaC60KuejxBjVM34awP4J8IHQj7H+H1cyOT8FH7
         f0zih99yYqF0oVfMWkhVTqbmUV+PVk25MxS9wbZOv5rYcP7CiDQSqoYvcpcZqe827sWs
         zwHKbmB7nL4WnGX2FzxTRwOYfUnBqIVfRSZtxkOGYqrib8NThXSPF1XHcKQ9rw+yjF+k
         PvuQ==
X-Gm-Message-State: AOAM533hZXQrl7oocLEWM8h2wYiSOmowAF+F41/SRcGpFhvm9JKh+TaH
        KCe4wc/T5MN/NMkvNy/MMNm5KeDYLqiHHJHQEUNvlA==
X-Google-Smtp-Source: ABdhPJzb5oL4Opmzl4/6/3A4uKouY9cuw/qRncHYX8YkGo05HpXA1OS3rvDUFX7ZHwSnGnzkM37So2IMmbJtH34vRec=
X-Received: by 2002:a62:a105:0:b0:50d:c97b:3084 with SMTP id
 b5-20020a62a105000000b0050dc97b3084mr243703pff.61.1652892734548; Wed, 18 May
 2022 09:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237929461.3832067.8402587124652027178.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220518173159.00002e92@Huawei.com>
In-Reply-To: <20220518173159.00002e92@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 09:52:03 -0700
Message-ID: <CAPcyv4i1qCkZoyPUubzy2BUZMg74tNNzzP7D3P-BPJKHncB1GQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] cxl/mem: Consolidate CXL DVSEC Range enumeration in
 the core
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 18, 2022 at 9:37 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 12 May 2022 11:14:54 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > In preparation for fixing the setting of the 'mem_enabled' bit in CXL
> > DVSEC Control register, move all CXL DVSEC range enumeration into the
> > same source file.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Comment inline but not something to necessarily do anything about as
> it's a transient thing mid series.
>
> > ---
> >  drivers/cxl/core/pci.c        |  129 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h          |    1
> >  drivers/cxl/cxlpci.h          |    4 +
> >  drivers/cxl/mem.c             |   14 ++--
> >  drivers/cxl/pci.c             |  135 -----------------------------------------
> >  tools/testing/cxl/Kbuild      |    1
> >  tools/testing/cxl/test/mem.c  |   10 ---
> >  tools/testing/cxl/test/mock.c |   16 +++++
> >  8 files changed, 158 insertions(+), 152 deletions(-)
> >
>
> ...
>
>
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 8c3a1c85a7ae..0cfbde134fc7 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -58,18 +58,15 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
> >   * decoders, or if it can not be determined if DVSEC Ranges are in use.
> >   * Otherwise, returns true.
> >   */
> > -__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
> > +__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
> > +                             struct cxl_endpoint_dvsec_info *info)
>
> Seems a little over the top to bring in info just to get to info->ranges.
> Mind you you get rid of it again later so it's just temporary ugly.

Yes, just a little ugliness to get through the impedance barrier to a
more pretty state.

> >  {
> > -     struct cxl_endpoint_dvsec_info *info = &cxlds->info;
> >       struct cxl_register_map map;
> >       struct cxl_component_reg_map *cmap = &map.component_map;
> >       bool global_enable, retval = false;
> >       void __iomem *crb;
> >       u32 global_ctrl;
> >
> > -     if (info->ranges < 0)
> > -             return false;
> > -
> >       /* map hdm decoder */
> >       crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
