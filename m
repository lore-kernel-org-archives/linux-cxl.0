Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C815C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Nov 2022 13:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbiKQNuf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Nov 2022 08:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiKQNud (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Nov 2022 08:50:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DA31351
        for <linux-cxl@vger.kernel.org>; Thu, 17 Nov 2022 05:50:30 -0800 (PST)
Received: from frapeml500004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NCh7j5B0Gz6H7M1;
        Thu, 17 Nov 2022 21:48:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500004.china.huawei.com (7.182.85.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 14:50:27 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 17 Nov
 2022 13:50:27 +0000
Date:   Thu, 17 Nov 2022 13:50:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 0/9] cxl/pci: Add fundamental error handling
Message-ID: <20221117135026.00006422@Huawei.com>
In-Reply-To: <eb64ef4f-6680-8983-81cc-06c470422c50@intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <20221011151744.00005278@huawei.com>
        <1e4de3fa-4e80-cc99-7fbf-3f6669766648@intel.com>
        <20221011181915.000031a1@huawei.com>
        <20221019183012.00007201@huawei.com>
        <ae8330db-ab77-7952-e846-de7dc527890c@intel.com>
        <20221024170102.00000c4b@huawei.com>
        <20221103125851.00000ce9@huawei.com>
        <20221103132720.000051bb@huawei.com>
        <eb64ef4f-6680-8983-81cc-06c470422c50@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 16 Nov 2022 16:20:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 11/3/2022 6:27 AM, Jonathan Cameron wrote:
> > On Thu, 3 Nov 2022 12:58:51 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> >> On Mon, 24 Oct 2022 17:01:02 +0100
> >> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >>  
> >>> On Wed, 19 Oct 2022 10:38:13 -0700
> >>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>      
> >>>> On 10/19/2022 10:30 AM, Jonathan Cameron wrote:  
> >>>>> On Tue, 11 Oct 2022 18:19:15 +0100
> >>>>> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >>>>>         
> >>>>>> On Tue, 11 Oct 2022 08:18:34 -0700
> >>>>>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>>>>         
> >>>>>>> On 10/11/2022 7:17 AM, Jonathan Cameron wrote:  
> >>>>>>>> On Fri, 16 Sep 2022 16:10:53 -0700
> >>>>>>>> Dave Jiang <dave.jiang@intel.com> wrote:
> >>>>>>>>              
> >>>>>>>>> Series set to RFC since there's no means to test. Would like to get opinion
> >>>>>>>>> on whether going with using trace events as reporting mechanism is ok.
> >>>>>>>>>
> >>>>>>>>> Jonathan,
> >>>>>>>>> We currently don't have any ways to test AER events. Do you have any plans
> >>>>>>>>> to support AER events via QEMU emulation?  
> >>>>>>>> Sorry - missed this entirely as gotten a bit behind reading CXL emails.  
> >>>>> Hi Dave,
> >>>>>
> >>>>> Quick update.
> >>>>>
> >>>>> Working QEMU emulation - but needs some/lots of cleanup. Particularly fun was
> >>>>> figuring out why I wasn't getting messages past the upstream switch port.
> >>>>> Turned out the serial number ECAP was on top of the AER ECAP. Oops - thankfully
> >>>>> that patch isn't upstream yet.
> >>>>> Also QEMU AER rooting seems to be based on some older PCIE spec
> >>>>> so needed some tweaks to get the device to actually issue ERR_FATAL etc.
> >>>>>
> >>>>> Anyhow, should have something you can play with in a day or two.  
> >>>>
> >>>> Awesome! Thanks! :)  
> >>>
> >>> Took a little longer than expected..
> >>>
> >>> Anyhow, now at
> >>> https://gitlab.com/jic23/qemu/-/commits/cxl-2022-10-24
> >>>
> >>> That tree is carrying far too many things right now for it make much sense
> >>> to me to email this to qemu-devel - though I may pull
> >>> hw/pci/aer: Add missing routing for AER errors
> >>> out in advance as that's closing a spec different between QEMU emulation of AER
> >>> and what the PCI spec says.
> >>>
> >>> Hopefully set of out of tree patches will start to shrink soon - v9 of the DOE
> >>> patches have been on list for a week or so.
> >>>
> >>> Top patch includes a very short 'how to' in patch description.  Basically fire
> >>> up QMP: Add something like -qmp tcp:localhost:444,server=on,wait=off to your
> >>> qemu commandline and use commands like:
> >>>
> >>> { "execute": "qmp_capabilities" }
> >>> ...
> >>> { "execute": "cxl-inject-uncorrectable-error",
> >>>      "arguments": {
> >>>          "path": "/machine/peripheral/cxl-pmem0",
> >>>          "type": "cache-address-parity",
> >>>          "header": [ 3, 4]
> >>>      } }
> >>> ...
> >>> { "execute": "cxl-inject-correctable-error",
> >>>      "arguments": {
> >>>          "path": "/machine/peripheral/cxl-pmem0",
> >>>          "type": "physical",
> >>>          "header": [ 3, 4]
> >>>      } }
> >>>      
> >>
> >> So Dave reported that this wasn't working on x86 qemu machines.
> >>
> >> A fun bit of debugging later (I hate AML) and I think I have find the issue +
> >> have a hack to workaround it for now.
> >>
> >> So need some background.
> >> 1) CXL code is based on QEMU's pci expander bridge root bridge - there is a complex
> >>     bit of handling to create appropriate ACPI DSDT magic.
> >> 2) The CXL root port is based on pcie_root_port.c
> >> 3) Both CXL root port and pcie root port use traditional PCI interrupts, not MSI/MSIX
> >>     for their signaling.
> >> 4) Q35 machine uses an IOAPIC and the resulting PCI bus interrupt routing lands the
> >>     actual interrupt on line 23 for my particular configuration
> >> 5) The ACPI table says it's on line 11.
> >> 6) x86 code for creating the PRT has an informative comment...
> >> https://elixir.bootlin.com/qemu/latest/source/hw/i386/acpi-build.c#L697
> >>   * The main goal is to equaly distribute the interrupts
> >>   * over the 4 existing ACPI links (works only for i440fx).
> >>
> >> So the hack I'm running is below (note the UID thing is a separate bug that stops
> >> iasl from disassembling the DSDT due to a duplicate entry - I'll send out a fix
> >> for that shortly).
> >>
> >> There are a bunch of possible approaches to fix this if my identification of
> >> the issue is correct.
> >>
> >> 1) Clean equivalent of this hack that runs on appropriate machines only.
> >> 2) Use MSI instead. (ioh3420 root port takes this approach I think).  
> > 
> > This turned out to be trivial case of cut and pate.  So MSI support it is (mostly because it doesn't
> > involve fixing AML generation :)
> > 
> > Very lightly tested on one config of x86 machine and one of arm64.
> > I've not thought about this at all yet, so it's a direct copy of the ioh3420 with
> > appropriate renames for it being in the cxl_rp code.  
> 
> Hi Jonathan, do you have a qemu branch with the latest code? Maybe I'll 
> give it a try. Thanks.
> 

https://gitlab.com/jic23/qemu/-/tree/cxl-2022-11-17

should work... (famous last words).

Jonathan



> > 
> > 
> >  From a5e85d90cb734fc1de81e0d99e443747348e65e7 Mon Sep 17 00:00:00 2001
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Date: Thu, 3 Nov 2022 13:10:24 +0000
> > Subject: [PATCH] hw: pci-bridge: cxl_root_port: Write up MSI
> > 
> > Done to avoid fixing ACPI rout description of traditional PCI interrupts on q35.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   hw/pci-bridge/cxl_root_port.c | 63 +++++++++++++++++++++++++++++++++++
> >   1 file changed, 63 insertions(+)
> > 
> > diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> > index 1a9363a6de..a7475c427e 100644
> > --- a/hw/pci-bridge/cxl_root_port.c
> > +++ b/hw/pci-bridge/cxl_root_port.c
> > @@ -22,6 +22,7 @@
> >   #include "qemu/range.h"
> >   #include "hw/pci/pci_bridge.h"
> >   #include "hw/pci/pcie_port.h"
> > +#include "hw/pci/msi.h"
> >   #include "hw/qdev-properties.h"
> >   #include "hw/sysbus.h"
> >   #include "qapi/error.h"
> > @@ -29,6 +30,10 @@
> >   
> >   #define CXL_ROOT_PORT_DID 0x7075
> >   
> > +#define CXL_RP_MSI_OFFSET               0x60
> > +#define CXL_RP_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
> > +#define CXL_RP_MSI_NR_VECTOR            2
> > +
> >   /* Copied from the gen root port which we derive */
> >   #define GEN_PCIE_ROOT_PORT_AER_OFFSET 0x100
> >   #define GEN_PCIE_ROOT_PORT_ACS_OFFSET \
> > @@ -36,6 +41,7 @@
> >   #define CXL_ROOT_PORT_DVSEC_OFFSET \
> >       (GEN_PCIE_ROOT_PORT_ACS_OFFSET + PCI_ACS_SIZEOF)
> >   
> > +
> >   typedef struct CXLRootPort {
> >       /*< private >*/
> >       PCIESlot parent_obj;
> > @@ -47,6 +53,50 @@ typedef struct CXLRootPort {
> >   #define TYPE_CXL_ROOT_PORT "cxl-rp"
> >   DECLARE_INSTANCE_CHECKER(CXLRootPort, CXL_ROOT_PORT, TYPE_CXL_ROOT_PORT)
> >   
> > +/*
> > + * If two MSI vector are allocated, Advanced Error Interrupt Message Number
> > + * is 1. otherwise 0.
> > + * 17.12.5.10 RPERRSTS,  32:27 bit Advanced Error Interrupt Message Number.
> > + */
> > +static uint8_t cxl_rp_aer_vector(const PCIDevice *d)
> > +{
> > +    switch (msi_nr_vectors_allocated(d)) {
> > +    case 1:
> > +        return 0;
> > +    case 2:
> > +        return 1;
> > +    case 4:
> > +    case 8:
> > +    case 16:
> > +    case 32:
> > +    default:
> > +        break;
> > +    }
> > +    abort();
> > +    return 0;
> > +}
> > +
> > +static int cxl_rp_interrupts_init(PCIDevice *d, Error **errp)
> > +{
> > +    int rc;
> > +
> > +    rc = msi_init(d, CXL_RP_MSI_OFFSET, CXL_RP_MSI_NR_VECTOR,
> > +                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_64BIT,
> > +                  CXL_RP_MSI_SUPPORTED_FLAGS & PCI_MSI_FLAGS_MASKBIT,
> > +                  errp);
> > +    if (rc < 0) {
> > +        assert(rc == -ENOTSUP);
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static void cxl_rp_interrupts_uninit(PCIDevice *d)
> > +{
> > +    msi_uninit(d);
> > +}
> > +
> > +
> >   static void latch_registers(CXLRootPort *crp)
> >   {
> >       uint32_t *reg_state = crp->cxl_cstate.crb.cache_mem_registers;
> > @@ -177,6 +227,15 @@ static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
> >       }
> >   }
> >   
> > +static void cxl_rp_aer_vector_update(PCIDevice *d)
> > +{
> > +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(d);
> > +
> > +    if (rpc->aer_vector) {
> > +        pcie_aer_root_set_vector(d, rpc->aer_vector(d));
> > +    }
> > +}
> > +
> >   static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
> >                                   int len)
> >   {
> > @@ -203,6 +262,7 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
> >           }
> >       }
> >       pci_bridge_write_config(d, address, val, len);
> > +    cxl_rp_aer_vector_update(d);
> >       pcie_cap_flr_write_config(d, address, val, len);
> >       pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
> >       pcie_aer_write_config(d, address, val, len);
> > @@ -229,6 +289,9 @@ static void cxl_root_port_class_init(ObjectClass *oc, void *data)
> >   
> >       rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
> >       rpc->acs_offset = GEN_PCIE_ROOT_PORT_ACS_OFFSET;
> > +    rpc->aer_vector = cxl_rp_aer_vector;
> > +    rpc->interrupts_init = cxl_rp_interrupts_init;
> > +    rpc->interrupts_uninit = cxl_rp_interrupts_uninit;
> >   
> >       dc->hotpluggable = false;
> >   }  

