Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F545C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Apr 2022 09:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbiDEJPw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244861AbiDEIwo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Apr 2022 04:52:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF53237DE
        for <linux-cxl@vger.kernel.org>; Tue,  5 Apr 2022 01:44:59 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXh2z4DRYz686y1;
        Tue,  5 Apr 2022 16:42:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 10:44:57 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 5 Apr
 2022 09:44:56 +0100
Date:   Tue, 5 Apr 2022 09:44:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tong Zhang <ztong0001@gmail.com>
CC:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?ISO-8859-1?Q?Benn?= =?ISO-8859-1?Q?=E9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v9 18/45] hw/cxl/device: Implement MMIO HDM decoding
 (8.2.5.12)
Message-ID: <20220405094454.00006ee7@Huawei.com>
In-Reply-To: <FC543734-8626-4F14-8449-E22969D18A7D@gmail.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
        <20220404151445.10955-19-Jonathan.Cameron@huawei.com>
        <FC543734-8626-4F14-8449-E22969D18A7D@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 4 Apr 2022 12:19:07 -0700
Tong Zhang <ztong0001@gmail.com> wrote:

> > On Apr 4, 2022, at 8:14 AM, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > 
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
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > ---
> > hw/mem/cxl_type3.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 55 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 329a6ea2a9..5c93fbbd9b 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c

...

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
> > +    g_assert(offset <= CXL2_COMPONENT_CM_REGION_SIZE);
> > +  
> 
> Looks like this will allow offset == CXL2_COMPONENT_CM_REGION_SIZE to pass the check, and cause a buffer overrun.
> Shouldn’t this be g_assert(offset< CXL2_COMPONENT_CM_REGION_SIZE)?

Good point.  Silly mistake.  I'll fix for v10.

> We also need to make sure (offset + 4<= CXL2_COMPONENT_CM_REGION_SIZE).

> Or maybe we just need offset +4 <= CXL2_COMPONENT_CM_REGION_SIZE here, if offset < CXL2_COMPONENT_CM_REGION_SIZE is already checked somewhere else.

I think we are fine without these two because in cxl-components-utils we
restrict the accesses to aligned only.

Jonathan


> 
> > +    switch (offset) {
> > +    case A_CXL_HDM_DECODER0_CTRL:
> > +        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> > +        which_hdm = 0;
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    stl_le_p((uint8_t *)cache_mem + offset, value);
> > +    if (should_commit) {
> > +        hdm_decoder_commit(ct3d, which_hdm);
> > +    }
> > +}

