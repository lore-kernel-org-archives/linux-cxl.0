Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3515C38A2D
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Oct 2022 20:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiJZULk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiJZULi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Oct 2022 16:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F1127BE3
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666815095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeIO3TvXxBNLJo8k9Zu03Bqp0yX7uTBWxx6wAWPOdts=;
        b=WC2T6C5tZIOt8lPW2BitvbU+mmOrIhwXOzOGqoEogmVOTJ/oqj4m2Jriz6jnx1K43eavGD
        JaxQznJVD75QTpi1vcH9srOPJyJEy+IWRnmPv5BiMLIKxLJ6wp2jZD6J/wbnK5+SPaMDgC
        7H9ETdAOw1be7rRqCZez8R/EMt3Moh0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-W2iHjQVGMbiMWiKS3n_zfA-1; Wed, 26 Oct 2022 16:11:34 -0400
X-MC-Unique: W2iHjQVGMbiMWiKS3n_zfA-1
Received: by mail-wr1-f72.google.com with SMTP id h26-20020adfaa9a000000b002364ad63bbcso6395808wrc.10
        for <linux-cxl@vger.kernel.org>; Wed, 26 Oct 2022 13:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeIO3TvXxBNLJo8k9Zu03Bqp0yX7uTBWxx6wAWPOdts=;
        b=6Yx0+mnti98VElmZRWQeHGB6cHFv3+5XRgWOaisbGjwyIypH7zs6U58aCkExoFR81/
         LexFd7c4IlHIO/fsxTBJ5AgJ63rJ+0IEirG0+JOD1sXGl1a9kFvaxTiQZD+pBOhiYXiS
         uIFp9JwdGh/DWkr6QgBoQVRZPfr6J0lEnl/aFJLv9dToIsqrRJmgxgBZ7I1BlrwNpr+J
         a1zcXssiErjKO4ERwAdoANZu2wOFJbQ6lRtlKOSV+927fnxYq/dPoZHZX038PYJPV4/L
         txAuCY3IO4CFd6jZOSba/IQjIB/ZhNBi/U/aXNjjuVPfFegS2zxPTU6NWJ81HEV1UV0K
         aVdw==
X-Gm-Message-State: ACrzQf36DvZuaEUkIRVy0MFxshBLjzVd5tFzxWYGF//uKnZmqC4mgq16
        Mnhg7qVC2L/l/PjOGHGsHejCoS5MTs6HxiQ1LYtG/S12uf88Lod8bRGeXvmn37COkmyBpRQY5eB
        GZtDJnQKnFZzuWAh0M84M
X-Received: by 2002:a05:600c:34d4:b0:3c6:f695:b5f8 with SMTP id d20-20020a05600c34d400b003c6f695b5f8mr3648433wmq.203.1666815093213;
        Wed, 26 Oct 2022 13:11:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6CS8Tr7wOvHoo39iV9b5DoLqex6rQUxR4kFpq4RgwYrklE7Gvb+z7MHd0rpAaqpyYi+4ECHA==
X-Received: by 2002:a05:600c:34d4:b0:3c6:f695:b5f8 with SMTP id d20-20020a05600c34d400b003c6f695b5f8mr3648426wmq.203.1666815092998;
        Wed, 26 Oct 2022 13:11:32 -0700 (PDT)
Received: from redhat.com ([2.52.15.7])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c304900b003cd9c26a0basm2474934wmh.40.2022.10.26.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:11:32 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:11:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Message-ID: <20221026161044-mutt-send-email-mst@kernel.org>
References: <20221006233702.18532-1-gregory.price@memverge.com>
 <20221026160545-mutt-send-email-mst@kernel.org>
 <BN6PR17MB312197C4CA958ED267BB576683309@BN6PR17MB3121.namprd17.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN6PR17MB312197C4CA958ED267BB576683309@BN6PR17MB3121.namprd17.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

He does but in the end he sends patches not pull requests.
I don't care really as long as someone will send it up.


On Wed, Oct 26, 2022 at 08:09:45PM +0000, Gregory Price wrote:
> I believe this was dropped from my line because Jonathan carried a similar commit on his branch.
> 
> Happy to push it up again as a separate commit if that is what you want.
> 
> Noted for the future on upstreams
> 
> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com> 
> Sent: Wednesday, October 26, 2022 4:06 PM
> To: Gregory Price <gourry.memverge@gmail.com>
> Cc: qemu-devel@nongnu.org; jonathan.cameron@huawei.com; linux-cxl@vger.kernel.org; alison.schofield@intel.com; dave@stgolabs.net; a.manzanares@samsung.com; bwidawsk@kernel.org; Gregory Price <gregory.price@memverge.com>
> Subject: Re: [PATCH 1/2] hw/cxl: set cxl-type3 device type to PCI_CLASS_MEMORY_CXL
> 
> On Thu, Oct 06, 2022 at 07:37:01PM -0400, Gregory Price wrote:
> > Current code sets to STORAGE_EXPRESS and then overrides it.
> > 
> > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> If you expect me to merge it you need to CC me.
> Also, do we need this separately from the series?
> 
> > ---
> >  hw/mem/cxl_type3.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c index 
> > ada2108fac..1837c1c83a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -146,7 +146,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> >      }
> >  
> >      pci_config_set_prog_interface(pci_conf, 0x10);
> > -    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
> >  
> >      pcie_endpoint_cap_init(pci_dev, 0x80);
> >      cxl_cstate->dvsec_offset = 0x100; @@ -335,7 +334,7 @@ static void 
> > ct3_class_init(ObjectClass *oc, void *data)
> >  
> >      pc->realize = ct3_realize;
> >      pc->exit = ct3_exit;
> > -    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> > +    pc->class_id = PCI_CLASS_MEMORY_CXL;
> >      pc->vendor_id = PCI_VENDOR_ID_INTEL;
> >      pc->device_id = 0xd93; /* LVF for now */
> >      pc->revision = 1;
> > --
> > 2.37.3
> > 
> > 

