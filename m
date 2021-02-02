Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE5EC433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC03564F70
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbhBBQXn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 Feb 2021 11:23:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:53010 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234266AbhBBQVh (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Tue, 2 Feb 2021 11:21:37 -0500
IronPort-SDR: 07VH9I//2Xwr5SMRfBL+KraMbhSetj895sow3vPm8BfUsukqwj7G7QIc5bCroFR1e0+fGrRTsv
 aWAledDQ4ZCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177372607"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="177372607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:20:53 -0800
IronPort-SDR: FSWs9uCL2w32tPW7+1Z6rmAn7nKrnRcclUGnSTf6Y0nkO30BPL4922eHdivN/YQnYt4Ub4YRxD
 uTfuSv9C0JHQ==
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="372014869"
Received: from joship1x-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.131.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:20:52 -0800
Date:   Tue, 2 Feb 2021 08:20:49 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Subject: Re: [RFC PATCH v3 16/31] hw/pci: Plumb _UID through host bridges
Message-ID: <20210202162049.jage4z5xkrawjyce@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
 <20210202005948.241655-17-ben.widawsky@intel.com>
 <20210202150056.00003bec@Huawei.com>
 <20210202101504-mutt-send-email-mst@kernel.org>
 <20210202154257.zepdz74logmi52wn@intel.com>
 <20210202104540-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210202104540-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-02 10:51:55, Michael S. Tsirkin wrote:
> On Tue, Feb 02, 2021 at 07:42:57AM -0800, Ben Widawsky wrote:
> > Thanks for looking! Mixing comments to Jonathan and Michael..
> > 
> > On 21-02-02 10:24:43, Michael S. Tsirkin wrote:
> > > On Tue, Feb 02, 2021 at 03:00:56PM +0000, Jonathan Cameron wrote:
> > > > On Mon, 1 Feb 2021 16:59:33 -0800
> > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > 
> > > > > Currently, QEMU makes _UID equivalent to the bus number (_BBN). While
> > > > > there is nothing wrong with doing it this way, CXL spec has a heavy
> > > > > reliance on _UID to identify host bridges and there is no link to the
> > > > > bus number. Having a distinct UID solves two problems. The first is it
> > > > > gets us around the limitation of 256 (current max bus number).
> > > 
> > > Not sure I understand. You want more than 256 host bridges?
> > > 
> > 
> > I don't want more than 256 host bridges, but I want the ability to disaggregate
> > _UID and bus (_BBN). The reasoning is just to align with the spec where _UID is
> > used to identify a CXL host bridge which is unrelated (perhaps) to the bus
> > number.
> 
> Which spec is that?
> 

CXL spec
https://www.computeexpresslink.org/download-the-specification

The spec introduces a new ACPI table which links information about a host bridge
based on the _UID. The _UID is 4 bytes.

"In an ACPI compliant system, there shall be one instance of CXL Host Bridge
Device object in ACPI namespace (HID=”ACPI0016”) for every CHBS entry. The _UID
object under a CXL Host Bridge object, when evaluated, shall match the UID field
in the associated CHBS entry."

"CXL Host Bridge Unique ID. Used to associate a CHBS instance with CXL Host
Bridge instance. The value of this field shall match the output of _UID under
the associated CXL Host Bridge in ACPI namespace"


> > > > The
> > > > > second is it allows us to replicate hardware configurations where bus
> > > > > number and uid aren't equivalent.
> > > 
> > > A bit more data on when this needs to be the case?
> > > 
> > 
> > Doesn't *need* to be the case. I was making a concerted effort to allow full
> > spec flexibility, but I don't believe it to be necessary unless we want to
> > accurately emulate a real platform.
> > 
> > > > The latter has benefits for our
> > > > > development and debugging using QEMU.
> > > > > 
> > > > > The other way to do this would be to implement the expanded bus
> > > > > numbering, but having an explicit uid makes more sense when trying to
> > > > > replicate real hardware configurations.
> > > > > 
> > > > > The QEMU commandline to utilize this would be:
> > > > >   -device pxb-cxl,id=cxl.0,bus="pcie.0",bus_nr=1,uid=x
> > > > > 
> > > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > 
> > > However, if doing this how do we ensure UID is still unique?
> > > What do we do for cases where UID was not specified?
> > > One idea is to generate a string UID and just stick the bus #
> > > in there.
> > 
> > This is totally mishandled in the code currently. I like your idea though.
> > 
> > > 
> > > 
> > > > > --
> > > > > 
> > > > > I'm guessing this patch will be somewhat controversial. For early CXL
> > > > > work, this can be dropped without too much heartache.
> > > > 
> > > > Whilst I'm not personally against, this maybe best to drop for now as you
> > > > say.
> > > > 
> > 
> > I think it'd be good to understand from the PCIe experts if CXL matches in this
> > regard. If PCIe generally allows (and does in practice) _UID not matching _BBN,
> > perhaps this is an overall improvement to the code.
> 
> Well
> 
> 6.1.12 _UID (Unique ID)
> 	This object provides OSPM with a logical device ID that does not change across reboots. This object
> 	is optional, but is required when the device has no other way to report a persistent unique device ID.
> 	The _UID must be unique across all devices with either a common _HID or _CID. This is because a
> 	device needs to be uniquely identified to the OSPM, which may match on either a _HID or a _CID to
> 	identify the device. The uniqueness match must be true regardless of whether the OSPM uses the
> 	_HID or the _CID. OSPM typically uses the unique device ID to ensure that the device-specific
> 	information, such as network protocol binding information, is remembered for the device even if its
> 	relative location changes. For most integrated devices, this object contains a unique identifier.
> 	A _UID object evaluates to either a numeric value or a string.
> 
> 
> IOW _UID is there so guest can tell devices with identical HID/CID apart.
> 

Right, so it's pretty much the same thing. There's ancillary data about the CXL
host bridge that is identified by the _UID.

> 
> 
> 
> > > > > ---
> > > > >  hw/i386/acpi-build.c                |  3 ++-
> > > > >  hw/pci-bridge/pci_expander_bridge.c | 19 +++++++++++++++++++
> > > > >  hw/pci/pci.c                        | 11 +++++++++++
> > > > >  include/hw/pci/pci.h                |  1 +
> > > > >  include/hw/pci/pci_bus.h            |  1 +
> > > > >  5 files changed, 34 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > index cf6eb54c22..145a503e92 100644
> > > > > --- a/hw/i386/acpi-build.c
> > > > > +++ b/hw/i386/acpi-build.c
> > > > > @@ -1343,6 +1343,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > > > >          QLIST_FOREACH(bus, &bus->child, sibling) {
> > > > >              uint8_t bus_num = pci_bus_num(bus);
> > > > >              uint8_t numa_node = pci_bus_numa_node(bus);
> > > > > +            int32_t uid = pci_bus_uid(bus);
> > > > >  
> > > > >              /* look only for expander root buses */
> > > > >              if (!pci_bus_is_root(bus)) {
> > > > > @@ -1356,7 +1357,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> > > > >              scope = aml_scope("\\_SB");
> > > > >              dev = aml_device("PC%.02X", bus_num);
> > > > >              aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> > > > > -            init_pci_acpi(dev, bus_num, pci_bus_is_express(bus) ? PCIE : PCI);
> > > > > +            init_pci_acpi(dev, uid, pci_bus_is_express(bus) ? PCIE : PCI);
> > > > >  
> > > > >              if (numa_node != NUMA_NODE_UNASSIGNED) {
> > > > >                  aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
> > > > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > > > index b42592e1ff..5021b60435 100644
> > > > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > > > @@ -67,6 +67,7 @@ struct PXBDev {
> > > > >  
> > > > >      uint8_t bus_nr;
> > > > >      uint16_t numa_node;
> > > > > +    int32_t uid;
> > > > >  };
> > > > >  
> > > > >  static PXBDev *convert_to_pxb(PCIDevice *dev)
> > > 
> > > As long as we are doing this, do we want to support a string uid too?
> > > How about a 64 bit uid? Why not?
> > 
> > If generally the idea of the patch is welcome, I am happy to change it.
> 
> I am still not sure, let's figure out the motivation.
> 
> For example, grep for UID and you will find more cases
> like this. E.g. hw/pci-host/gpex-acpi.c
> 
> Do we care?

For my purposes, I do not.

> 
> 
> 
> > > 
> > > 
> > > > > @@ -98,12 +99,20 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
> > > > >      return pxb->numa_node;
> > > > >  }
> > > > >  
> > > > > +static int32_t pxb_bus_uid(PCIBus *bus)
> > > > > +{
> > > > > +    PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> > > > > +
> > > > > +    return pxb->uid;
> > > > > +}
> > > > > +
> > > > >  static void pxb_bus_class_init(ObjectClass *class, void *data)
> > > > >  {
> > > > >      PCIBusClass *pbc = PCI_BUS_CLASS(class);
> > > > >  
> > > > >      pbc->bus_num = pxb_bus_num;
> > > > >      pbc->numa_node = pxb_bus_numa_node;
> > > > > +    pbc->uid = pxb_bus_uid;
> > > > >  }
> > > > >  
> > > > >  static const TypeInfo pxb_bus_info = {
> > > > > @@ -329,6 +338,7 @@ static Property pxb_dev_properties[] = {
> > > > >      /* Note: 0 is not a legal PXB bus number. */
> > > > >      DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> > > > >      DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNASSIGNED),
> > > > > +    DEFINE_PROP_INT32("uid", PXBDev, uid, -1),
> > > > >      DEFINE_PROP_END_OF_LIST(),
> > > > >  };
> > > > >  
> > > > > @@ -400,12 +410,21 @@ static const TypeInfo pxb_pcie_dev_info = {
> > > > >  
> > > > >  static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
> > > > >  {
> > > > > +    PXBDev *pxb = convert_to_pxb(dev);
> > > > > +
> > > > >      /* A CXL PXB's parent bus is still PCIe */
> > > > >      if (!pci_bus_is_express(pci_get_bus(dev))) {
> > > > >          error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
> > > > >          return;
> > > > >      }
> > > > >  
> > > > > +    if (pxb->uid < 0) {
> > > > > +        error_setg(errp, "pxb-cxl devices must have a valid uid (0-2147483647)");
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    /* FIXME: Check that uid doesn't collide with UIDs of other host bridges */
> > > > > +
> > > > >      pxb_dev_realize_common(dev, CXL, errp);
> > > > >  }
> > > > >  
> > > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > > index adbe8aa260..bf019d91a0 100644
> > > > > --- a/hw/pci/pci.c
> > > > > +++ b/hw/pci/pci.c
> > > > > @@ -170,6 +170,11 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
> > > > >      return NUMA_NODE_UNASSIGNED;
> > > > >  }
> > > > >  
> > > > > +static int32_t pcibus_uid(PCIBus *bus)
> > > > > +{
> > > > > +    return -1;
> > > > > +}
> > > > > +
> > > > >  static void pci_bus_class_init(ObjectClass *klass, void *data)
> > > > >  {
> > > > >      BusClass *k = BUS_CLASS(klass);
> > > > > @@ -184,6 +189,7 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
> > > > >  
> > > > >      pbc->bus_num = pcibus_num;
> > > > >      pbc->numa_node = pcibus_numa_node;
> > > > > +    pbc->uid = pcibus_uid;
> > > > >  }
> > > > >  
> > > > >  static const TypeInfo pci_bus_info = {
> > > > > @@ -530,6 +536,11 @@ int pci_bus_numa_node(PCIBus *bus)
> > > > >      return PCI_BUS_GET_CLASS(bus)->numa_node(bus);
> > > > >  }
> > > > >  
> > > > > +int pci_bus_uid(PCIBus *bus)
> > > > > +{
> > > > > +    return PCI_BUS_GET_CLASS(bus)->uid(bus);
> > > > > +}
> > > > > +
> > > > >  static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
> > > > >                                   const VMStateField *field)
> > > > >  {
> > > > > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > > > > index bde3697bee..a46de48ccd 100644
> > > > > --- a/include/hw/pci/pci.h
> > > > > +++ b/include/hw/pci/pci.h
> > > > > @@ -463,6 +463,7 @@ static inline int pci_dev_bus_num(const PCIDevice *dev)
> > > > >  }
> > > > >  
> > > > >  int pci_bus_numa_node(PCIBus *bus);
> > > > > +int pci_bus_uid(PCIBus *bus);
> > > > >  void pci_for_each_device(PCIBus *bus, int bus_num,
> > > > >                           void (*fn)(PCIBus *bus, PCIDevice *d, void *opaque),
> > > > >                           void *opaque);
> > > > > diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> > > > > index eb94e7e85c..3c9fbc55bb 100644
> > > > > --- a/include/hw/pci/pci_bus.h
> > > > > +++ b/include/hw/pci/pci_bus.h
> > > > > @@ -17,6 +17,7 @@ struct PCIBusClass {
> > > > >  
> > > > >      int (*bus_num)(PCIBus *bus);
> > > > >      uint16_t (*numa_node)(PCIBus *bus);
> > > > > +    int32_t (*uid)(PCIBus *bus);
> > > > >  };
> > > > >  
> > > > >  enum PCIBusFlags {
> > > 
> 
