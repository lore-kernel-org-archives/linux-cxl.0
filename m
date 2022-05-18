Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D60C433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 17:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbiERRHK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 May 2022 13:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240748AbiERRHJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 May 2022 13:07:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0AB5D5F8
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:07:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x143so2699769pfc.11
        for <linux-cxl@vger.kernel.org>; Wed, 18 May 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrClvgpSxFqISziY8Txw/xQB7v6ln85QRLtNVJrqsB0=;
        b=q8J8E1dbMY+B9UB2RDGFk39dSRNhHwy5xlx9/Ee0l+lMXlTcVgXsfbQpavuA7qNQBG
         ewoVAT/g/8pbbLgZM9iOKJwDIeBZ5W2DLPeX82jZisjIUhfrT78m/IQjjYSeFCO/QBqL
         RqcRs4jjYk5mu917ZXhrEuMXsVXmAsgJjepGNEltYpUbZgd1OW7QD8smbVyDwsOyOYhA
         Q1yxZBLU9C/PW6b62D/qkRsMCtkjA6V3OwFO/tj+ryvVKe/At39L9tJcDEQpF76Yqnt+
         5ID9yn6jgrA+26X9uE0Kq9E+E0/wrJ/RC/iPeuRcC0DICbRgZvmG5aQzLZZosAZiddNy
         14FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrClvgpSxFqISziY8Txw/xQB7v6ln85QRLtNVJrqsB0=;
        b=BumQjGMKP3BJqT5LEIo9HqOPRevhMqpGhSdjWgv6FLimXnwUQjf1cAyMlafV2Sw6QR
         lemZBXi7qu8JKLK/T6TXm0ssN7ALdrbqwDl0p4Cmcgw2ywsKeW3y2eAa3w9k7cpTddF5
         ipUtvsfOvNvtdjqjSiDgIz4Jj2WtnbumITtSryCU85MvcaIsHgpujjZ0I7OcAOnsHRPh
         CDbR0aoH++bd6W83sTcfkFm2Fbxh716aLklHt9abuaNS+NzILwCprsPTBdN3sUqHJPBK
         Sz4drBFujTHYlWfdkBuCT+2aYC3o/65QSIdiQbYxgYEycEoRNW9CfPxJ5x9qOHbbmDgj
         1Lcg==
X-Gm-Message-State: AOAM530qLMxxKhFSn9C9N4RerNQ8alNqqTyrVAyQiUxf3mbFV0jODoPD
        HHwYiqysd/3wsKgtgtu1NEjXNOxGxfzIsEPjVr8/fQ==
X-Google-Smtp-Source: ABdhPJyf5ZHO6cwW9w0qfCc7K+KlVmeUg8xySUmSD9Rss3+EEx14oQS/8eqGwWR+OXfiLkwfQ0pdhWtoxVJDcTcPHxQ=
X-Received: by 2002:a63:e648:0:b0:3f2:7ade:8f86 with SMTP id
 p8-20020a63e648000000b003f27ade8f86mr405863pgj.40.1652893628453; Wed, 18 May
 2022 10:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237930521.3832067.16931437806464317011.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220518174047.00007711@Huawei.com>
In-Reply-To: <20220518174047.00007711@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 May 2022 10:06:57 -0700
Message-ID: <CAPcyv4g-7aVgFtOJu-FE_6XHS9PHJBDigk_jQ=UTRs2sj1h3zg@mail.gmail.com>
Subject: Re: [PATCH 09/14] cxl/mem: Fix CXL DVSEC Range Sizing
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Ariel.Sibley@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, May 18, 2022 at 9:42 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 12 May 2022 11:15:05 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Per CXL 2.0 Section 8.1.3.8.4 "DVSEC CXL Range 1 Base Low" there is no
> > way to specify decode sizes smaller than 256M. Fix cxl_dvsec_ranges()
> > and cxl_hdm_decode_init() to account for that default decode range.
>
> This is effectively the same as the discussion on patch 14.
>
> My reading of the spec suggests that size can be 0 and that would mean
> no access is passed on to the hardware.  It's a rather odd corner case
> and would mean the device would only work with HDM decoders and might
> well fail some compliance tests (I haven't checked)
>
> It's not a corner case I care about...
>
> > Note, that this means that any BIOS implementation that sets mem_enable,
> > but not HDM Decoder Capability enable will cause the driver to fail to
> > attach. A later change validates the DVSEC ranges against platform CXL
> > decode (CXL CFMWS) to make a decision about overriding the default DVSEC
> > Range configuration.
>
> >
> > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/pci.c |   10 +++++++---
> >  drivers/cxl/mem.c      |   10 +---------
> >  2 files changed, 8 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index f3e59f8b6621..f1c0677a4f52 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -236,7 +236,12 @@ int cxl_dvsec_ranges(struct cxl_dev_state *cxlds,
> >               if (rc)
> >                       return rc;
> >
> > -             size = (u64)temp << 32;
> > +             /*
> > +              * Per CXL 2.0 Section 8.1.3.8.4 "DVSEC CXL Range 1 Base
> > +              * Low", the minimum decode size is 256MB
> > +              */
> > +             size = SZ_256M;
>
> This is not how I read the spec.  The match is base <= Addr < base + size.
> If size == 0 then there are no matches as base = base + size and so the
> right condition isn't met.  Maybe I'm missing something though...

That's how Ariel reads it too, so I'll just drop this as it doesn't
affect the logic all that much, and hopefully the spec gets cleaned up
to preclude the possibility of sub-256M sized devices.
