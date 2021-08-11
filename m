Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB8C4338F
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B18BC60FA0
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Aug 2021 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhHKRMc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhHKRMb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Aug 2021 13:12:31 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9E8C061765
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 10:12:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f3so3533282plg.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Aug 2021 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44EB28BqXWb45mtNVakmFg+Q/8HsN6OutZwK2qosZrY=;
        b=V5bEga3weH5iXN0+6m/3RIIXJrnX4WuBAEsmQHXSTnuUX937TUVR53kA0zCPt0KhHl
         +f64c7tlD2nFoiXB3cacHMv+1FzmI3NOujecIl7K307e5eP7mUDj04p20j9FlmY5G7af
         Gyfba9+EJ5WyF3IvZEhoRVN4v4o/MNAdi9K/8+bf3tNq8BBbATwsBvNCcWedTE5E4PMQ
         EUtfbmHYzZzgOgOsX37kR+ORfDGJ3D4BQVdrYlCm/cxTUYLz72EYO9Dx/pjmWrGWyjC8
         gYmBmrHThP3XxKQ+MLQVnvX3UVqyzZCtfPnvj3E0mJTHmoKxHfkPkgyde6eFG/occr42
         ADGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44EB28BqXWb45mtNVakmFg+Q/8HsN6OutZwK2qosZrY=;
        b=Axjpf9EDzVP3k7TGmwBqivJ72gtMnQgvptQxdCi9UvMtJtw8023gGYVFolwsdHOR1c
         L9u/MwNV6pEAqhGA/JSxQntOCEEo5do26V+OijnmBCx1mX7tudaLGCC28QX97EoCvxBJ
         Kxf5auECfWsph1C3eVnqKQ3quffUVHWB3oZPGvICmeJVz7N5Nf2HHeY28NegOQFf/mJh
         VqZOobtcksOmBqGi1kH4w2l7aesce/fwhUdj+TyIsucerFRjui18S22Ed3z0dLiX+Vp9
         1yHIH97eqZytGIZhwGggoA7FOaF0IfIuXpPeo+MC3YNbusVcNgQqMOgLdCjQoh7Ov/+A
         pLSA==
X-Gm-Message-State: AOAM531mkI41gvMCMoB8MLfStRXCRaIq4rfFFLme57Jg5++VQRWHmOsw
        KTFuYulMuKAUU+/M1I+XifvUrDs0vrCsneiPe+BC2A==
X-Google-Smtp-Source: ABdhPJyJacMjrBjaocEKx5Q7iiTD/wBb+WPl3GaZUppaXpwcBKjAWNHWdXZ+6oqr87hnuAlGYuXo4H2NAH/KcirrT9M=
X-Received: by 2002:a17:903:22c6:b029:12c:8da8:fd49 with SMTP id
 y6-20020a17090322c6b029012c8da8fd49mr4921720plg.79.1628701927276; Wed, 11 Aug
 2021 10:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <162854806653.1980150.3354618413963083778.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162854812073.1980150.8157116233571368158.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YROE48iCZNFaDcSo@smile.fi.intel.com> <YRQB9Yvh3tmT9An4@smile.fi.intel.com>
In-Reply-To: <YRQB9Yvh3tmT9An4@smile.fi.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 11 Aug 2021 10:11:56 -0700
Message-ID: <CAPcyv4jOEfi=RJTeOFTbvkBB+Khfzi5QirrhPxeM4J2bQXRYiQ@mail.gmail.com>
Subject: Re: [PATCH 10/23] libnvdimm/labels: Add uuid helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 11, 2021 at 9:59 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Aug 11, 2021 at 11:05:55AM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 09, 2021 at 03:28:40PM -0700, Dan Williams wrote:
> > > In preparation for CXL labels that move the uuid to a different offset
> > > in the label, add nsl_{ref,get,validate}_uuid(). These helpers use the
> > > proper uuid_t type. That type definition predated the libnvdimm
> > > subsystem, so now is as a good a time as any to convert all the uuid
> > > handling in the subsystem to uuid_t to match the helpers.
> > >
> > > As for the whitespace changes, all new code is clang-format compliant.
> >
> > Thanks, looks good to me!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Sorry, I'm in doubt this Rb stays. See below.
>
> ...
>
> > >  struct btt_sb {
> > >     u8 signature[BTT_SIG_LEN];
> > > -   u8 uuid[16];
> > > -   u8 parent_uuid[16];
> > > +   uuid_t uuid;
> > > +   uuid_t parent_uuid;
>
> uuid_t type is internal to the kernel. This seems to be an ABI?

No, it's not a user ABI, this is an on-disk metadata structure. uuid_t
is approprirate.

>
> > >     __le32 flags;
> > >     __le16 version_major;
> > >     __le16 version_minor;
>
> ...
>
> > >  struct nd_namespace_label {
> > > -   u8 uuid[NSLABEL_UUID_LEN];
> > > +   uuid_t uuid;
>
> So seems this.
>
> > >     u8 name[NSLABEL_NAME_LEN];
> > >     __le32 flags;
> > >     __le16 nlabel;
>
> ...
>
> I'm not familiar with FS stuff, but looks to me like unwanted changes.
> In such cases you have to use export/import APIs. otherwise you make the type
> carved in stone without even knowing that it's part of an ABI or some hardware
> / firmware interfaces.

Can you clarify the concern? Carving the intent that these 16-bytes
are meant to be treated as UUID in stone is deliberate.
