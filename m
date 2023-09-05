Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BBECA0FFA
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Sep 2023 16:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbjIEQYK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353994AbjIEJDp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Sep 2023 05:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E8ABF
        for <linux-cxl@vger.kernel.org>; Tue,  5 Sep 2023 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693904575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ISCJw3a4nE7Oy0bGsYEJtXPHTQW8rqSf6hMib2Lt9no=;
        b=C50k+/594HVPKJdC4SmxtYMDBuBBPW1TExYFpceOvcUX1gXOzBqRkTjATw4hSqPjTlaavl
        +hc1r+N+3HQRh12cUKKXsXYc8q8kMIaZaE2fP9rjLpYkvAYIOcWQnO5GKUK6xI+FjeZiZl
        4iuvwHMS6L4GbmtP4cj8E5dhiliDT+M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-B_YxHvRrM12r5Pf3zzsZ0w-1; Tue, 05 Sep 2023 05:02:54 -0400
X-MC-Unique: B_YxHvRrM12r5Pf3zzsZ0w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-500a675a034so2369957e87.1
        for <linux-cxl@vger.kernel.org>; Tue, 05 Sep 2023 02:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693904572; x=1694509372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISCJw3a4nE7Oy0bGsYEJtXPHTQW8rqSf6hMib2Lt9no=;
        b=WK6jsiNbHpzpAzT8K9uFJzI5aulVFLWo9u26MT/mCdmkg6Bzc2sMOHvN4r170EMvln
         yVUOazw4SodV9DUbwHUwIqAg0BzO4gWUjiIkB/apB5DJZR+xrPWKxJEk/zERO/ekWPUG
         J6xXk8Yo8IPqQkQxLjLQqmrgQG1OaO/qboCkzeQpQB92z3A2M+za2E3aLnEuGDcjUCYt
         lTZFJdZtOQ5IFRjfuksR5aILerFmd17pPmmgokKRT/YDFy91jnQ2Us3QhejKYV/+3/hP
         xohs9d4qhrpV2egwBHTQz0dJXg9bj78m8qRoQhs7qShRptMxmDqUHXAdLenpak5Jswvs
         nlJg==
X-Gm-Message-State: AOJu0Yz+lDwvXWTHdmjS7sqeX+D8DTYwB6mz16PR7AX0bWAX6wDjmJ9g
        E1sbhnQgzkXYqKvjU5fgNJ0a3msqXl9oIgKWarUNf6QcHCUi95mrqiTuVLl7zopDv2LNOWHJeVL
        drCGEEkPq9hGDB75y950f
X-Received: by 2002:a05:6512:3c9e:b0:500:c2d7:3ab4 with SMTP id h30-20020a0565123c9e00b00500c2d73ab4mr9606738lfv.8.1693904572556;
        Tue, 05 Sep 2023 02:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/9dQHVayD7xesewN/YbshyUMTnNpJKHVUrl3DJF98fIhjAByGAxJJLxlRcuurtPLbd+cfLg==
X-Received: by 2002:a05:6512:3c9e:b0:500:c2d7:3ab4 with SMTP id h30-20020a0565123c9e00b00500c2d73ab4mr9606721lfv.8.1693904572214;
        Tue, 05 Sep 2023 02:02:52 -0700 (PDT)
Received: from redhat.com ([2.52.23.134])
        by smtp.gmail.com with ESMTPSA id i19-20020a056402055300b005233609e39dsm6932710edx.30.2023.09.05.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:02:51 -0700 (PDT)
Date:   Tue, 5 Sep 2023 05:02:47 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Message-ID: <20230905045849-mutt-send-email-mst@kernel.org>
References: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
 <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
MIME-Version: 1.0
In-Reply-To: <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Sep 05, 2023 at 10:48:54AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Jonathan,
> 
> On 4/9/23 19:57, Jonathan Cameron wrote:
> > Will be needed so there is a defined serial number for
> > information queries via the Switch CCI.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > No ordering dependencies wrt to other CXL patch sets.
> > 
> > Whilst we 'need' it for the Switch CCI set it is valid without
> > it and aligns with existing EP serial number support. Seems sensible
> > to upstream this first and reduce my out of tree backlog a little!
> > 
> >   hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> > index 2b9cf0cc97..15c4d84a56 100644
> > --- a/hw/pci-bridge/cxl_upstream.c
> > +++ b/hw/pci-bridge/cxl_upstream.c
> > @@ -14,6 +14,11 @@
> >   #include "hw/pci/msi.h"
> >   #include "hw/pci/pcie.h"
> >   #include "hw/pci/pcie_port.h"
> > +/*
> > + * Null value of all Fs suggested by IEEE RA guidelines for use of
> > + * EU, OUI and CID
> > + */
> > +#define UI64_NULL (~0ULL)
> 
> Already defined in hw/mem/cxl_type3.c, can we move it to some common
> CXL header? Or include/qemu/units.h?

not the last one I think - this is a cxl specific hack to detect that
user has changed the property.


I think we really should have a variant of DEFINE_PROP_XXX that sets a
flag allowing us to detect whether a property has been set manually.
This would be a generalization of DEFINE_PROP_ON_OFF_AUTO.


> >   #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
> > @@ -30,6 +35,7 @@ typedef struct CXLUpstreamPort {
> >       /*< public >*/
> >       CXLComponentState cxl_cstate;
> >       DOECap doe_cdat;
> > +    uint64_t sn;
> >   } CXLUpstreamPort;
> >   CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
> > @@ -326,8 +332,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
> >       if (rc) {
> >           goto err_cap;
> >       }
> > -
> > -    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> > +    if (usp->sn != UI64_NULL) {
> > +        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_DVSEC_OFFSET, usp->sn);
> > +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET + 0x0c;
> 
> Could it be clearer to have:
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> @@ -23,2 +23,2 @@
> -#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
> -    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
> +#define CXL_UPSTREAM_PORT_DVSEC_OFFSET(offset) \
> +    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF + offset)
> 
> ?
> 
> > +    } else {
> > +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> > +    }
> >       cxl_cstate->pdev = d;
> >       build_dvsecs(cxl_cstate);
> >       cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
> > @@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
> >   }
> >   static Property cxl_upstream_props[] = {
> > +    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
> >       DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
> >       DEFINE_PROP_END_OF_LIST()
> >   };

