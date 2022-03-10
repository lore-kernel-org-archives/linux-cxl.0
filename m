Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B46C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Mar 2022 04:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbiCJEJz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Mar 2022 23:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCJEJy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Mar 2022 23:09:54 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CB10EC6B
        for <linux-cxl@vger.kernel.org>; Wed,  9 Mar 2022 20:08:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z15so4052511pfe.7
        for <linux-cxl@vger.kernel.org>; Wed, 09 Mar 2022 20:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqToSLq1SUyk2Y3JI0yt1XyMXYlHdKXdzvRi+KrsnXE=;
        b=MfVbkFMmHV850mNu3abpIQMQS4U5DzbjClrYRF+wzyHLHM4qJrkkOLAmTH7O3kKINZ
         HcD2Wn4iCOe70caRGULzt6YKSeqXNUV5hhDqtETitjEU+1YfYvln7mEjyndk/ATwTdrj
         zWDxgJBHTXqOhMM3qLDTuh0eQ4c7jH2dfvvFntr0QHX33eFfOIdfAoM5+W3niKyNlQzL
         dygskK9cwuIfSS1u7Ak8XM5yR2KjVpOC+JD34YscdDpMCHWCGtSmCvnb9AenDXCkdnuK
         2fw5+kNMAjgeXlNbmvacnGR8cBrre+1lfrUSMcWYBNVR0+WBWib/Zkkk5plT343ToP1M
         t1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqToSLq1SUyk2Y3JI0yt1XyMXYlHdKXdzvRi+KrsnXE=;
        b=yqyrCW+jdpWmW115UOG4n49U9OzJ3CmD3Y7UW4NnhDXIKlVL1zNm0Aain1+9wAoLCa
         jSbjx1Em4WmoWtZvUELdtJSKxD5FDJ7KiDHjuK44EzkG0lDj3oeDBjDV36fdbF4w8BNv
         +E0yB802KRRYF2XvQe2Tan1xLkT4jj07fB7+TK9lknSks2REzwqVvm0ziuqGFNb32A2T
         Ifq3gj+nz8Tt9bFv4PQ2FkgowR9hrrkCd0yhvWlwAiRhUUoRjvP+BNGizkHO5hd55V2z
         VygjncJEciLmw6ZJaHnrm8Eyb3t2uHRITIxjuKNDhfGygBuwrMAro53jWrxkz76ZK2/b
         FYeQ==
X-Gm-Message-State: AOAM53178WlrDz/ZPqNVYdfh5P2z1AkqlBePN41sU5CjEovpeWI7+Fax
        n1z51tEK3NnYo07ebsVnPT1Nm9fKscbU1SCdmE44YQ==
X-Google-Smtp-Source: ABdhPJzyZl/HZFJ4W5wvzu82e8lJumsJS2ovk+12eegcKrw+mvv/OWROOu8cpWzIbkqbbjDZGgHjQHE7U+QNtIkWVrQ=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr2878100pfu.3.1646885334033; Wed, 09 Mar
 2022 20:08:54 -0800 (PST)
MIME-Version: 1.0
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164610295699.2682974.3646198829625502263.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220309183323.00000048@Huawei.com>
In-Reply-To: <20220309183323.00000048@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 20:08:43 -0800
Message-ID: <CAPcyv4iv1Rvh6XuJb44JTLciUj_Ai__RWikP4YYYgC=SUCARnQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] cxl/core: Introduce cxl_set_lock_class()
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Mar 9, 2022 at 10:33 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 28 Feb 2022 18:49:17 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Update CONFIG_PROVE_CXL_LOCKING to use the common device-core helpers
> > for device_lock validation.
> >
> > When CONFIG_PROVE_LOCKING is enabled and device_set_lock_class() is
> > passed a non-zero lock class the core acquires the 'struct device'
> > @lockdep_mutex everywhere it acquires the device_lock. Where
> > lockdep_mutex does not skip lockdep validation like device_lock.
> >
> > cxl_set_lock_class() wraps device_set_lock_class() as to not collide
> > with other subsystems that may also support this lockdep validation
> > scheme. See the 'choice' for the various CONFIG_PROVE_$SUBSYS_LOCKING
> > options in lib/Kconfig.debug.
> >
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> One query inline - otherwise looks good to me.
>
> > ---
>
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index b1a4ba622739..f0a821de94cf 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -476,6 +476,7 @@ int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *cxlr)
> >       if (rc)
> >               goto err;
> >
> > +     cxl_set_lock_class(dev);
>
> I didn't see a cxl_lock_class for regions. Or is this meant to use
> the ANON_LOCK?

Oh, yes, first I need to rebase this set before the region series
which is going through a major revision. Second, I expect that the
region lock_class may end up needing to nest inside the decoder lock
class in order to facilitate decoders disconnecting themselves from
regions if a memdev goes through ->remove() while an associated region
is active.

This series was motivated by wanting to validate the locking of the
region creation sysfs-ABI versus device removal events.
