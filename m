Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FFAC433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Mar 2022 14:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiCDO1Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Mar 2022 09:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiCDO1W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Mar 2022 09:27:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A291BAF22
        for <linux-cxl@vger.kernel.org>; Fri,  4 Mar 2022 06:26:33 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K999m1GS2z6H7cb;
        Fri,  4 Mar 2022 22:25:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Mar 2022 15:26:31 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 4 Mar
 2022 14:26:30 +0000
Date:   Fri, 4 Mar 2022 14:26:29 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
Subject: Re: [PATCH v6 22/43] hw/cxl/device: Implement get/set Label Storage
 Area (LSA)
Message-ID: <20220304142629.000044b0@huawei.com>
In-Reply-To: <20220304141618.00004e79@huawei.com>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
        <20220211120747.3074-23-Jonathan.Cameron@huawei.com>
        <87wnhck6oi.fsf@linaro.org>
        <20220304141618.00004e79@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 4 Mar 2022 14:16:18 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 02 Mar 2022 10:03:34 +0000
> Alex Bennée <alex.bennee@linaro.org> wrote:
> 
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> >   
> > > From: Ben Widawsky <ben.widawsky@intel.com>
> > >
> > > Implement get and set handlers for the Label Storage Area
> > > used to hold data describing persistent memory configuration
> > > so that it can be ensured it is seen in the same configuration
> > > after reboot.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---  
> 
> 
> > > +
> > > +static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
> > > +                                 CXLDeviceState *cxl_dstate,
> > > +                                 uint16_t *len)
> > > +{
> > > +    struct {
> > > +        uint32_t offset;
> > > +        uint32_t rsvd;
> > > +    } __attribute__((packed, __aligned__(8))) *set_lsa = (void *)cmd->payload;
> > > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > > +    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
> > > +    uint16_t plen = *len;
> > > +
> > > +    *len = 0;
> > > +    if (!plen) {
> > > +        return CXL_MBOX_SUCCESS;
> > > +    }
> > > +
> > > +    if (set_lsa->offset + plen > cvc->get_lsa_size(ct3d) + sizeof(*set_lsa)) {
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    cvc->set_lsa(ct3d, (void *)set_lsa + sizeof(*set_lsa),
> > > +                 plen - sizeof(*set_lsa), set_lsa->offset);    
> > 
> > All these sizeof's make me wonder if these structures should be public
> > with a #define? 
> > Failing that having
> > 
> >   const size_t lsa_len = sizeof(*set_lsa);  
> 
> The naming of such a variable is a bit complex and I think perhaps
> we are better off using a 0 length data[] element after the header
> and then offsetof() to compute the header length.
> 
> So (with the addition of some renames that hopefully make things clearer)
> something like (on top of changes as a result of earlier review comments):
> 
> @@ -357,12 +357,15 @@ static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
>                                   CXLDeviceState *cxl_dstate,
>                                   uint16_t *len)
>  {
> -    struct {
> +    struct set_lsa_pl {
>          uint32_t offset;
>          uint32_t rsvd;
> -    } QEMU_PACKED QEMU_ALIGNED(8) *set_lsa = (void *)cmd->payload;
> +        uint8_t data[];
> +    } QEMU_PACKED;
> +    struct set_lsa_pl *set_lsa_payload = (void *)cmd->payload;
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
> +    const size_t hdr_len = offsetof(struct set_lsa_pl, data);
>      uint16_t plen = *len;
> 
>      *len = 0;
> @@ -370,12 +373,12 @@ static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
>          return CXL_MBOX_SUCCESS;
>      }
> 
> -    if (set_lsa->offset + plen > cvc->get_lsa_size(ct3d) + sizeof(*set_lsa)) {
> +    if (set_lsa_payload->offset + plen > cvc->get_lsa_size(ct3d) + hdr_len) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
> +    plen -= hdr_len;
> 
> -    cvc->set_lsa(ct3d, (void *)set_lsa + sizeof(*set_lsa),
> -                 plen - sizeof(*set_lsa), set_lsa->offset);
> +    cvc->set_lsa(ct3d, set_lsa_payload->data, plen, set_lsa_payload->offset);
>      return CXL_MBOX_SUCCESS;
>  }
> 
> the aligned marker doesn't make much sense here as we are using
> cmd->payload directly so the compiler doesn't get to mess with the alignment
> anyway.  I've aligned markings from similar places in this patch and others. 

Turned out I was wrong on that - it's necessary in some places (not here)
to avoid the compiler thinking we might be taking addresses of unaligned
elements of a structure when we aren't.

This one is safe to remove however.

> 
> > 
> > and use that might make the flow a bit easier to scan. That said why
> > isn't set_lsa taking a type of *set_lsa instead of having void casts?  
> 
> We could do that, but I think the intent here is to separate the particular
> formatting of the set_lsa command from what it is doing which
> is basically a memcpy so needs an src, size and dst offset.
> 
> It's a bit messy that the size to be written is implicit so we have to
> extract it from the size of the command message accounting for the
> header.
> 
> Hopefully the above changes make that easier to follow?
> 
> Thanks,
> 
> Jonathan
> 
> 
> >   
> > > +    return CXL_MBOX_SUCCESS;
> > > +}
> > > +
> > >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> > > +#define IMMEDIATE_DATA_CHANGE (1 << 2)
> > >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > >  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> > >  
> > > @@ -350,6 +404,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
> > >          cmd_identify_memory_device, 0, 0 },
> > >      [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
> > >          cmd_ccls_get_partition_info, 0, 0 },
> > > +    [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 0, 0 },
> > > +    [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
> > > +        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
> > >  };
> > >  
> > >  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index b16262d3cc..b1ba4bf0de 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -8,6 +8,7 @@
> > >  #include "qapi/error.h"
> > >  #include "qemu/log.h"
> > >  #include "qemu/module.h"
> > > +#include "qemu/pmem.h"
> > >  #include "qemu/range.h"
> > >  #include "qemu/rcu.h"
> > >  #include "sysemu/hostmem.h"
> > > @@ -114,6 +115,11 @@ static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> > >      memory_region_set_enabled(mr, true);
> > >      host_memory_backend_set_mapped(ct3d->hostmem, true);
> > >      ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
> > > +
> > > +    if (!ct3d->lsa) {
> > > +        error_setg(errp, "lsa property must be set");
> > > +        return;
> > > +    }
> > >  }
> > >  
> > >  
> > > @@ -168,12 +174,58 @@ static Property ct3_props[] = {
> > >      DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
> > >      DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
> > >                       HostMemoryBackend *),
> > > +    DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> > > +                     HostMemoryBackend *),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >  
> > >  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
> > >  {
> > > -    return 0;
> > > +    MemoryRegion *mr;
> > > +
> > > +    mr = host_memory_backend_get_memory(ct3d->lsa);
> > > +    return memory_region_size(mr);
> > > +}
> > > +
> > > +static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
> > > +                                uint64_t offset)
> > > +{
> > > +    assert(offset + size <= memory_region_size(mr));
> > > +    assert(offset + size > offset);
> > > +}
> > > +
> > > +static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
> > > +                    uint64_t offset)
> > > +{
> > > +    MemoryRegion *mr;
> > > +    void *lsa;
> > > +
> > > +    mr = host_memory_backend_get_memory(ct3d->lsa);
> > > +    validate_lsa_access(mr, size, offset);
> > > +
> > > +    lsa = memory_region_get_ram_ptr(mr) + offset;
> > > +    memcpy(buf, lsa, size);
> > > +
> > > +    return size;
> > > +}
> > > +
> > > +static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> > > +                    uint64_t offset)
> > > +{
> > > +    MemoryRegion *mr;
> > > +    void *lsa;
> > > +
> > > +    mr = host_memory_backend_get_memory(ct3d->lsa);
> > > +    validate_lsa_access(mr, size, offset);
> > > +
> > > +    lsa = memory_region_get_ram_ptr(mr) + offset;
> > > +    memcpy(lsa, buf, size);
> > > +    memory_region_set_dirty(mr, offset, size);
> > > +
> > > +    /*
> > > +     * Just like the PMEM, if the guest is not allowed to exit gracefully, label
> > > +     * updates will get lost.
> > > +     */
> > >  }
> > >  
> > >  static void ct3_class_init(ObjectClass *oc, void *data)
> > > @@ -194,6 +246,8 @@ static void ct3_class_init(ObjectClass *oc, void *data)
> > >      device_class_set_props(dc, ct3_props);
> > >  
> > >      cvc->get_lsa_size = get_lsa_size;
> > > +    cvc->get_lsa = get_lsa;
> > > +    cvc->set_lsa = set_lsa;
> > >  }
> > >  
> > >  static const TypeInfo ct3d_info = {
> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > index ebb391153a..43908f161b 100644
> > > --- a/include/hw/cxl/cxl_device.h
> > > +++ b/include/hw/cxl/cxl_device.h
> > > @@ -257,6 +257,11 @@ struct CXLType3Class {
> > >  
> > >      /* public */
> > >      uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
> > > +
> > > +    uint64_t (*get_lsa)(CXLType3Dev *ct3d, void *buf, uint64_t size,
> > > +                        uint64_t offset);
> > > +    void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> > > +                    uint64_t offset);
> > >  };
> > >  
> > >  #endif    
> > 
> >   
> 

