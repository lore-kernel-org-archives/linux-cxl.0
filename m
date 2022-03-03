Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0DEC433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Mar 2022 18:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiCCSIf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Mar 2022 13:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiCCSIe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Mar 2022 13:08:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA0432043
        for <linux-cxl@vger.kernel.org>; Thu,  3 Mar 2022 10:07:47 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8f7Y4kh0z67KX2;
        Fri,  4 Mar 2022 02:06:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 19:07:45 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Mar
 2022 18:07:45 +0000
Date:   Thu, 3 Mar 2022 18:07:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
CC:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v6 19/43] hw/cxl/device: Implement MMIO HDM decoding
 (8.2.5.12)
Message-ID: <20220303180743.00004627@Huawei.com>
In-Reply-To: <87a6e9le7r.fsf@linaro.org>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
        <20220211120747.3074-20-Jonathan.Cameron@huawei.com>
        <87a6e9le7r.fsf@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 01 Mar 2022 18:17:35 +0000
Alex Bennée <alex.bennee@linaro.org> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Ben Widawsky <ben.widawsky@intel.com>
> >
> > A device's volatile and persistent memory are known Host Defined Memory
> > (HDM) regions. The mechanism by which the device is programmed to claim
> > the addresses associated with those regions is through dedicated logic
> > known as the HDM decoder. In order to allow the OS to properly program
> > the HDMs, the HDM decoders must be modeled.
> >
> > There are two ways the HDM decoders can be implemented, the legacy
> > mechanism is through the PCIe DVSEC programming from CXL 1.1 (8.1.3.8),
> > and MMIO is found in 8.2.5.12 of the spec. For now, 8.1.3.8 is not
> > implemented.
> >
> > Much of CXL device logic is implemented in cxl-utils. The HDM decoder
> > however is implemented directly by the device implementation.
> > Whilst the implementation currently does no validity checks on the
> > encoder set up, future work will add sanity checking specific to
> > the type of cxl component.
> >
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/mem/cxl_type3.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index c4021d2434..da091157f2 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -61,6 +61,56 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >                                 REG_LOC_DVSEC_REVID, dvsec);
> >  }
> >  
> > +static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
> > +{
> > +    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
> > +    uint32_t *cache_mem = cregs->cache_mem_registers;
> > +
> > +    assert(which == 0);
> > +
> > +    /* TODO: Sanity checks that the decoder is possible */
> > +    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
> > +    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
> > +
> > +    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
> > +}
> > +
> > +static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> > +                           unsigned size)
> > +{
> > +    CXLComponentState *cxl_cstate = opaque;
> > +    ComponentRegisters *cregs = &cxl_cstate->crb;
> > +    CXLType3Dev *ct3d = container_of(cxl_cstate, CXLType3Dev, cxl_cstate);
> > +    uint32_t *cache_mem = cregs->cache_mem_registers;
> > +    bool should_commit = false;
> > +    int which_hdm = -1;
> > +
> > +    assert(size == 4);  
> 
> Maybe add:
> 
>       g_assert(offset <= (CXL2_COMPONENT_CM_REGION_SIZE >> 2));

offset is in bytes here, but agreed without the >> 2.
Could move this over to use a 4 byte step if you think that's a good idea.



For other comments changed as suggested.

Thanks,

Jonathan
