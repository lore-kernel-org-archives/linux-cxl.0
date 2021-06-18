Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD8AC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41863610A7
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 16:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhFRQlv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhFRQlv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 12:41:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F3C061574
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jun 2021 09:39:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so6196807pjn.1
        for <linux-cxl@vger.kernel.org>; Fri, 18 Jun 2021 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbXL1o1KiFHAokuqAE2Kq/N8gm+0QDG1BrnHNYMeQws=;
        b=OudMrNmDPg0NBI4ABVQwcXegaUknrkWMK3v3H1gK0xOsPSLcLmEHGHmdUQxPc8Gw5j
         9kUmIKlD1NP3iD580qb4ctTbtkGiQqLAhVxroaGt7ioqW4iXBsnYNQzmZKLlD+Uvrk1v
         O8jn8rED6oAbyBjkGdiGtKqt7JIlLJ/Z1UrsjOw3V8IoPNABN+gydNdax46PEdshl4tb
         3pWVH+Ye3xW1TrLIGmqYNfsSM6z73VmqEIPz++EnjepZtPONzgHmUg41gVEnEX9p57Q0
         URjfmoJsSz7DxPpN/70U+2E5SGD+8+quRZmtubyM3DgCuFmLqIp5C9u5acr2n7bqYriT
         zRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbXL1o1KiFHAokuqAE2Kq/N8gm+0QDG1BrnHNYMeQws=;
        b=HG+sHBCtTTJBjguTVpf5/ntgGdXLT/E3opraBMCj8OeOcvR6QMjy1UEUjQLBmIvv4I
         gFhLMttkrJKMJiczylIVrV0AmuabTkYEFpu67LiIOCXE8uDpbY3XdhYj+RF6zsZhjvrU
         Y0PSlxEdpsMtqSexJH1xezm4ssvpToRjXZOhLF3QacfT6xVNFyQVbYBX4D29EnOfZnWu
         iP+ZneUdj7dgSYg0hmJfXvmZbLPXwBIG+lg5Kt+gKfRC3aoaI93J+HV2YhYa0HdJZwFQ
         ENZpTc5toptbcyuQL05dynnfp5jnJsFJjJrLjDuW9YskXgblDR4hgM6FgXG/oXzXmXgT
         ExDw==
X-Gm-Message-State: AOAM531dk0sDtc9DuiXmpWCOVVtattp6zryN74UNVR+VnWejLzPX+Vc7
        8NXpTZDr5fMu6d41LJkqvGztJgWJ6rqdMJlbyABu2IAhdULw2A==
X-Google-Smtp-Source: ABdhPJwt9wffD1MjNYVoHOLXrxFFk4mFODfOnF+SPdbT8sTte3Q0HddtrIrA9UCHPJ7ocyahdmApGOgZ9YyiNaKQ3B0=
X-Received: by 2002:a17:902:f1c2:b029:11f:c496:cc4 with SMTP id
 e2-20020a170902f1c2b029011fc4960cc4mr5432684plc.27.1624034381160; Fri, 18 Jun
 2021 09:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210617173655.430424-1-ben.widawsky@intel.com>
 <20210617173655.430424-2-ben.widawsky@intel.com> <20210618101311.00005f78@Huawei.com>
 <20210618150749.eo433cjs4rpilayy@intel.com>
In-Reply-To: <20210618150749.eo433cjs4rpilayy@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Jun 2021 09:39:30 -0700
Message-ID: <CAPcyv4iF1m+xGMaph+K8VJ0+tCvUML9-pUuAWymXoOrvY1jV1w@mail.gmail.com>
Subject: Re: [PATCH 1/6] cxl/region: Add region creation ABI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jun 18, 2021 at 8:08 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
[..]
> > It's a bit horrible, but maybe a more intuitive interface would be to make the
> > targetX visibility dynamic and hence make interleave an attribute of the region?
> >
> > sysfs_update_group() is rarely used, but I think the intent is to support
> > this sort of case.
> >
> > I've not fully thought through the effects of that though so might
> > well be missing something.
>
> I really would have liked something dynamic like you described. I searched for
> other drivers that this without much luck. I'm relatively unfamiliar with a lot
> of the device model machinery in Linux. Dan, are you familiar with this, is it
> feasible? If it sounds reasonable I can spend some more time figuring out how to
> do it.

I would prefer not to go the sysfs_update_group() route. That tends to
make it harder for tooling to reason about the arrival of attributes
relative to KOBJ_ADD events.

That said "create" may indeed be too generic an attribute to reason
about what it does. We could make all the setup parameters that do not
involve targets their own attribute group and then have a trigger
attribute that adds the next region device. Something like:

decoderX.Y/setup_region/uuid
decoderX.Y/setup_region/size
decoderX.Y/setup_region/interleave
decoderX.Y/setup_region/commit

...and then @commit atomically adds the region and clears the
parameters for the next setup?

Alternatively, renaming create to something like add_interleave sounds
ok to me too... trying to approach the border with configfs without
crossing over.
