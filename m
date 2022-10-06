Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F997C433FE
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Oct 2022 08:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJFIuP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Oct 2022 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiJFIuO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 6 Oct 2022 04:50:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A668C15FC9
        for <linux-cxl@vger.kernel.org>; Thu,  6 Oct 2022 01:50:11 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MjlSW0s9Tz67yt9;
        Thu,  6 Oct 2022 16:47:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 10:50:09 +0200
Received: from localhost (10.81.206.0) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 6 Oct
 2022 09:50:09 +0100
Date:   Thu, 6 Oct 2022 09:50:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gourry <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, Gourry <gregory.price@memverge.com>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH RFC] hw/cxl: type 3 devices can now present volatile or
 persistent memory
Message-ID: <20221006095007.00001271@huawei.com>
In-Reply-To: <20221006094557.000035ab@huawei.com>
References: <20221006000103.49542-1-gregory.price@memverge.com>
        <20221006094557.000035ab@huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.206.0]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 6 Oct 2022 09:45:57 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed,  5 Oct 2022 20:01:03 -0400
> Gourry <gourry.memverge@gmail.com> wrote:
> 
> > Type 3 devices were hard-coded to always present as persistent memory devices.
> > This patch adds the "is_pmem" attribute which can be used to instantiate
> > a device as either a pmem or vmem.  
> 
> Hi Gourry,
> 
> Great to see this.
> 
> Missing Signed-off by so we can't apply this (no developer certificate of
> origin)  Probably want your from address to match that and I've no idea
> if your fully name is Gourry (apologies if it is!)
> 
> +CC linux-cxl as most folks who will be interested in this hang out there
> and are more likely to noticed it than burried on qemu-devel.
> Also +CC some others who will be interested in this discussion.
> 
> Please also cc the listed CXL QEMU maintainers (myself and Ben W) - see
> MAINTAINERS
> 
I forgot to ask.  How are you testing this?

One of the blockers for volatile support was that we had no means to poke
it properly as the kernel doesn't yet support volatile capacity and
no one has done the relevant work in EDK2 or similar to do it before the kernel boots.
There has been some work on EDK2 support for ARM N2 FVPs from 
Saanta Pattanayak, but not upstream eyt.
https://lpc.events/event/16/contributions/1254/ 

Thanks,

Jonathan

> > 
> > Right now it is only possible to choose one or the other, but future
> > devices may present both (such as multi-logical devices with different
> > regions backed by different types of memory).  
> 
> Would it be possible to introduce this support in a fashion that allowed
> us to transition to devices presenting both without needing a change of
> interface?  With hindsight the memdev naming of the existing parameter is
> less than helpful, but one path to doing this would be to allow for
> an alternative memdev-volatile= parameter.  For now we can keep the patch
> small by only supporting either memdev or memdev-volatile
> 
> That way when we want to come along and add mixed devices later, we simply
> enable supporting the specification of two different memory backends.
> 
> The tricky bit then would be to support variable capacity (devices can
> support a region of memory which may be persistent or non persistent
> depending on settings - see Set Partition Info).
> 
> So my gut feeling is we may eventually allow all of:
> 
> 1) single memory backend for persistent or volatile.
> 2) two memory backends, covering a persistent region and a volatile region
>   (likely you may want actual non volatile backend for the persistent
>    region but not the volatile one).
> 3) single memory backend in which we can allow for the Set Partition Info stuff
>    to work.
> 
> As we move beyond just one backend that is presented as persistent we need
> to define the interface...
> 
> I can think of far too many options!  Let me lay out a few for comment.
> 
> A) Array of memory backends, separate control of configurable size
>    + starting persistent size, starting volatile size.
>    Default of one memory backend gives you current non-volatile only.
>    To get volatile only you provide one memory backend and set
>    persistent size to 0 and volatile size to size of memory backend.
> 
> B) Two memory backends, (later add some trickery around presented size)
>    memdev as defined is persistent memory (maybe we deprecate that interface
>    and make it memdev-persistent) memdev-volatile as volatile.
> 
>    Steps to add functionality.
>    1. Add your code to enable volatile but use 'which memdev is supplied' to
>       act as the flag.  For now supply both is an error.
>    2. Enable static volatile + non-volatile devices (both memdevs supplied).
>    3. (hackish) Add a control for amount of partionable capacity.  Cheat
>       and remove that capacity from both memdevs.  Changing partition just
>       messes without how much of each memdev is used.  We'd need to be a little
>       careful to ensure we wipe data etc.
> 
> You code mostly looks good to me so I think discussion here is going to be
> all about the interface and how we build one more suitable for the future!
> 
> Jonathan
> 
> 
> 
> 
> > ---
> >  docs/system/devices/cxl.rst    | 31 ++++++++++++++++---------
> >  hw/cxl/cxl-mailbox-utils.c     | 24 +++++++++++---------
> >  hw/mem/cxl_type3.c             | 10 +++++----
> >  include/hw/cxl/cxl_device.h    |  5 +++--
> >  tests/qtest/bios-tables-test.c |  8 +++----
> >  tests/qtest/cxl-test.c         | 41 ++++++++++++++++++++++++++++------
> >  6 files changed, 82 insertions(+), 37 deletions(-)
> > 
> > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> > index f25783a4ec..3a62d46e8a 100644
> > --- a/docs/system/devices/cxl.rst
> > +++ b/docs/system/devices/cxl.rst
> > @@ -300,7 +300,7 @@ Example topology involving a switch::
> >  
> >  Example command lines
> >  ---------------------
> > -A very simple setup with just one directly attached CXL Type 3 device::
> > +A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
> >  
> >    qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> >    ...
> > @@ -308,7 +308,18 @@ A very simple setup with just one directly attached CXL Type 3 device::
> >    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
> >    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > +  -device cxl-type3,bus=root_port13,pmem=true,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G  
> 
> Can't do this as it breaks any existing setup.  If a flag makes sense (I don't think
> it is flexible enough) then would need to be volatile so it not being present
> will correspond to false and current situation.
> 
> > +
> > +A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> > +
> > +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> > +  ...
> > +  -object memory-backend-ram,id=cxl-mem1,share=on,size=256M \
> > +  -object memory-backend-ram,id=cxl-lsa1,share=on,size=256M \
> > +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> > +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > +  -device cxl-type3,bus=root_port13,pmem=false,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> >  
> >  A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
> > @@ -328,13 +339,13 @@ the CXL Type3 device directly attached (no switches).::
> >    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> >    -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
> >    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> > -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> > +  -device cxl-type3,bus=root_port13,pmem=true,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> >    -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> > -  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> > +  -device cxl-type3,bus=root_port14,pmem=true,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> >    -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> > -  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> > +  -device cxl-type3,bus=root_port15,pmem=true,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> >    -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> > -  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> > +  -device cxl-type3,bus=root_port16,pmem=true,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
> >  
> >  An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> > @@ -354,13 +365,13 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> >    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
> >    -device cxl-upstream,bus=root_port0,id=us0 \
> >    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> > -  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
> > +  -device cxl-type3,bus=swport0,pmem=true,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
> >    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> > -  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
> > +  -device cxl-type3,bus=swport1,pmem=true,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
> >    -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> > -  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
> > +  -device cxl-type3,bus=swport2,pmem=true,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
> >    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> > -  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
> > +  -device cxl-type3,bus=swport3,pmem=true,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
> >    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> >  
> >  Kernel Configuration Options
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index bc1bb18844..3ed4dfeb69 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -138,7 +138,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> >      } QEMU_PACKED *fw_info;
> >      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> >  
> > -    if (cxl_dstate->pmem_size < (256 << 20)) {
> > +    if (cxl_dstate->mem_size < (256 << 20)) {  
> 
> Huh.  I wonder why this check is here in the first place? Looks very odd given why
> should we be checking the memory size in a firmware update based command.
> 
> Probably cut and paste error long ago. 
> 
> >          return CXL_MBOX_INTERNAL_ERROR;
> >      }
> >  
> > @@ -281,7 +281,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> >  
> >      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> >      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> > -    uint64_t size = cxl_dstate->pmem_size;
> > +    uint64_t size = cxl_dstate->mem_size;
> >  
> >      if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> >          return CXL_MBOX_INTERNAL_ERROR;
> > @@ -290,11 +290,13 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> >      id = (void *)cmd->payload;
> >      memset(id, 0, sizeof(*id));
> >  
> > -    /* PMEM only */
> > -    snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> > +    /* Version 0: PMEM Only.  Version 1: PMEM and VMEM */
> > +    snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 1);
> >  
> > -    id->total_capacity = size / (256 << 20);
> > -    id->persistent_capacity = size / (256 << 20);
> > +    size /= (256 << 20);
> > +    id->total_capacity = size;
> > +    id->persistent_capacity = ct3d->is_pmem ? size : 0;
> > +    id->volatile_capacity = ct3d->is_pmem ? 0 : size;
> >      id->lsa_size = cvc->get_lsa_size(ct3d);
> >  
> >      *len = sizeof(*id);
> > @@ -312,16 +314,18 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> >          uint64_t next_pmem;
> >      } QEMU_PACKED *part_info = (void *)cmd->payload;
> >      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> > -    uint64_t size = cxl_dstate->pmem_size;
> > +
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > +    uint64_t size = cxl_dstate->mem_size;
> >  
> >      if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> >          return CXL_MBOX_INTERNAL_ERROR;
> >      }
> >  
> > -    /* PMEM only */
> > -    part_info->active_vmem = 0;
> > +    size /= (256 << 20);
> > +    part_info->active_vmem = ct3d->is_pmem ? 0 : size;
> >      part_info->next_vmem = 0;
> > -    part_info->active_pmem = size / (256 << 20);
> > +    part_info->active_pmem = ct3d->is_pmem ? size : 0;
> >      part_info->next_pmem = 0;
> >  
> >      *len = sizeof(*part_info);
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index ada2108fac..18c5b9ff90 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -111,7 +111,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >          error_setg(errp, "memdev property must be set");
> >          return false;
> >      }
> > -    memory_region_set_nonvolatile(mr, true);
> > +    memory_region_set_nonvolatile(mr, ct3d->is_pmem);
> >      memory_region_set_enabled(mr, true);
> >      host_memory_backend_set_mapped(ct3d->hostmem, true);
> >  
> > @@ -123,7 +123,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >      address_space_init(&ct3d->hostmem_as, mr, name);
> >      g_free(name);
> >  
> > -    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
> > +    ct3d->cxl_dstate.mem_size = ct3d->hostmem->size;
> >  
> >      if (!ct3d->lsa) {
> >          error_setg(errp, "lsa property must be set");
> > @@ -271,6 +271,7 @@ static void ct3d_reset(DeviceState *dev)
> >  }
> >  
> >  static Property ct3_props[] = {
> > +    DEFINE_PROP_BOOL("pmem", CXLType3Dev, is_pmem, false),
> >      DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
> >                       HostMemoryBackend *),
> >      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
> > @@ -278,6 +279,7 @@ static Property ct3_props[] = {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > +
> >  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
> >  {
> >      MemoryRegion *mr;
> > @@ -338,10 +340,10 @@ static void ct3_class_init(ObjectClass *oc, void *data)
> >      pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> >      pc->vendor_id = PCI_VENDOR_ID_INTEL;
> >      pc->device_id = 0xd93; /* LVF for now */
> > -    pc->revision = 1;
> > +    pc->revision = 2;  
> Given the driver isn't checking this and your code change isn't breaking
> older versions I would not update the revision for this.
> 
> >  
> >      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> > -    dc->desc = "CXL PMEM Device (Type 3)";
> > +    dc->desc = "CXL Memory Device (Type 3)";
> >      dc->reset = ct3d_reset;
> >      device_class_set_props(dc, ct3_props);
> >  
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 1e141b6621..67fc65f047 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -117,8 +117,8 @@ typedef struct cxl_device_state {
> >          uint64_t host_set;
> >      } timestamp;
> >  
> > -    /* memory region for persistent memory, HDM */
> > -    uint64_t pmem_size;
> > +    /* memory region for persistent and volatile memory, HDM */
> > +    uint64_t mem_size;
> >  } CXLDeviceState;
> >  
> >  /* Initialize the register block for a device */
> > @@ -235,6 +235,7 @@ struct CXLType3Dev {
> >      PCIDevice parent_obj;
> >  
> >      /* Properties */
> > +    bool is_pmem;
> >      HostMemoryBackend *hostmem;
> >      HostMemoryBackend *lsa;
> >  
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 2ebeb530b2..40c392056d 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -1578,13 +1578,13 @@ static void test_acpi_q35_cxl(void)
> >                               " -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1"
> >                               " -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2"
> >                               " -device cxl-rp,port=0,bus=cxl.1,id=rp1,chassis=0,slot=2"
> > -                             " -device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1"
> > +                             " -device cxl-type3,bus=rp1,pmem=true,memdev=cxl-mem1,lsa=lsa1"
> >                               " -device cxl-rp,port=1,bus=cxl.1,id=rp2,chassis=0,slot=3"
> > -                             " -device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2"
> > +                             " -device cxl-type3,bus=rp2,pmem=true,memdev=cxl-mem2,lsa=lsa2"
> >                               " -device cxl-rp,port=0,bus=cxl.2,id=rp3,chassis=0,slot=5"
> > -                             " -device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3"
> > +                             " -device cxl-type3,bus=rp3,pmem=true,memdev=cxl-mem3,lsa=lsa3"
> >                               " -device cxl-rp,port=1,bus=cxl.2,id=rp4,chassis=0,slot=6"
> > -                             " -device cxl-type3,bus=rp4,memdev=cxl-mem4,lsa=lsa4"
> > +                             " -device cxl-type3,bus=rp4,pmem=true,memdev=cxl-mem4,lsa=lsa4"
> >                               " -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k,"
> >                               "cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.targets.1=cxl.2,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=8k",
> >                               tmp_path, tmp_path, tmp_path, tmp_path,
> > diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> > index cbe0fb549b..667e590c5f 100644
> > --- a/tests/qtest/cxl-test.c
> > +++ b/tests/qtest/cxl-test.c
> > @@ -31,27 +31,40 @@
> >  
> >  #define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> >                   "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> > -                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
> > +                 "-device cxl-type3,bus=rp0,pmem=false,memdev=cxl-mem0," \
> > +                  "lsa=lsa0,id=cxl-pmem0 "
> > +
> > +#define QEMU_T3DV "-object memory-backend-ram,id=cxl-mem0,size=256M " \
> > +                  "-object memory-backend-ram,id=lsa0,size=256M "    \
> > +                  "-device cxl-type3,bus=rp0,pmem=true,memdev=cxl-mem0," \
> > +                   "lsa=lsa0,id=cxl-pmem0 "
> > +
> >  
> >  #define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
> >                    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> > -                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> > +                  "-device cxl-type3,bus=rp0,pmem=true,memdev=cxl-mem0," \
> > +                   "lsa=lsa0,id=cxl-pmem0 " \
> >                    "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> >                    "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> > -                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
> > +                  "-device cxl-type3,bus=rp1,pmem=true,memdev=cxl-mem1," \
> > +                   "lsa=lsa1,id=cxl-pmem1 "
> >  
> >  #define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> >                    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> > -                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> > +                  "-device cxl-type3,bus=rp0,pmem=true,memdev=cxl-mem0," \
> > +                   "lsa=lsa0,id=cxl-pmem0 " \
> >                    "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> >                    "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> > -                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
> > +                  "-device cxl-type3,bus=rp1,pmem=true,memdev=cxl-mem1," \
> > +                   "lsa=lsa1,id=cxl-pmem1 " \
> >                    "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
> >                    "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
> > -                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
> > +                  "-device cxl-type3,bus=rp2,pmem=true,memdev=cxl-mem2," \
> > +                   "lsa=lsa2,id=cxl-pmem2 " \
> >                    "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
> >                    "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
> > -                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
> > +                  "-device cxl-type3,bus=rp3,pmem=true,memdev=cxl-mem3," \
> > +                   "lsa=lsa3,id=cxl-pmem3 "
> >  
> >  static void cxl_basic_hb(void)
> >  {
> > @@ -103,6 +116,19 @@ static void cxl_t3d(void)
> >      qtest_end();
> >  }
> >  
> > +static void cxl_t3d_vmem(void)
> > +{
> > +    g_autoptr(GString) cmdline = g_string_new(NULL);
> > +    g_autofree const char *tmpfs = NULL;
> > +
> > +    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> > +
> > +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3DV);
> > +
> > +    qtest_start(cmdline->str);
> > +    qtest_end();
> > +}
> > +
> >  static void cxl_1pxb_2rp_2t3d(void)
> >  {
> >      g_autoptr(GString) cmdline = g_string_new(NULL);
> > @@ -145,6 +171,7 @@ int main(int argc, char **argv)
> >      qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> >  #ifdef CONFIG_POSIX
> >      qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
> > +    qtest_add_func("/pci/cxl/type3_vmem_device", cxl_t3d_vmem);
> >      qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> >      qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
> >  #endif  
> 
> Great to see tests covered. Those often get forgotten.
> 
> Jonathan
> 

