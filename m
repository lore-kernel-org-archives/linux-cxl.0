Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99604126F1E
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849576; cv=none; b=Ti17OmjRAEUjkKc7oucEiUDATQF1Sm942gKsYxA4AKCKnDunZ29jCFQvMNlTl5PAtBxB41TXLm/4ttqY8L+PMzZGQlMNMKYE+910PKe5VemS2aulGfQD2JUTzhomkY8/m5AMC+YpsTbKPC+7OwqUlM5011WLpOuf3RrUuj9BZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849576; c=relaxed/simple;
	bh=wKBImBZq2LrLwv/DkBDIr61NrgRgVQXQ54cTWDbZPes=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mh3XKdklm8O/Gu7QILRnyERd4urp8hxWVuG0WPq6cP+DXkXUrKtL/NLYKikcbEgB/50/L5qTa2J3m8UHasNKbnpcFcrfum9uHBCv/vmcxqzKBxHqVlsbVA3VhSynR+U1Jmg7MFgKl64cpw4BNt6DOxLl1P2imj5GV/ATf5OZQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCW141DR0z6K62D;
	Mon,  1 Jul 2024 23:58:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D7CDE140B63;
	Mon,  1 Jul 2024 23:59:29 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 16:59:29 +0100
Date: Mon, 1 Jul 2024 16:59:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
	<linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and
 use for acpi/gi
Message-ID: <20240701165928.00006213@Huawei.com>
In-Reply-To: <20240628135804.12434f5e@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-6-Jonathan.Cameron@huawei.com>
	<20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
	<20240628135804.12434f5e@imammedo.users.ipa.redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 28 Jun 2024 13:58:04 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 27 Jun 2024 15:09:12 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 20 Jun 2024 17:03:13 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > Using a property allows us to hide the internal details of the PCI device
> > > from the code to build a SRAT Generic Initiator Affinity Structure with
> > > PCI Device Handle.
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > ---
> > > V3: New patch
> > > ---
> > >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> > >  hw/pci/pci.c                     | 14 ++++++++++++++
> > >  2 files changed, 20 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 73bafaaaea..34284359f0 100644
> > > --- a/hw/acpi/acpi_generic_initiator.c
> > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > @@ -9,6 +9,7 @@
> > >  #include "hw/boards.h"
> > >  #include "hw/pci/pci_device.h"
> > >  #include "qemu/error-report.h"
> > > +#include "qapi/error.h"
> > >  
> > >  typedef struct AcpiGenericInitiatorClass {
> > >      ObjectClass parent_class;
> > > @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> > >      MachineState *ms = MACHINE(qdev_get_machine());
> > >      AcpiGenericInitiator *gi;
> > >      GArray *table_data = opaque;
> > > -    PCIDevice *pci_dev;
> > > +    uint8_t bus, devfn;
> > >      Object *o;
> > >  
> > >      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > > @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> > >          exit(1);
> > >      }
> > >  
> > > -    pci_dev = PCI_DEVICE(o);
> > > -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> > > -                                     pci_bus_num(pci_get_bus(pci_dev)),
> > > -                                     pci_dev->devfn);
> > > +    bus = object_property_get_uint(o, "bus", &error_fatal);
> > > +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> > > +
> > > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> > >  
> > >      return 0;
> > >  }
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 324c1302d2..b4b499b172 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > >  static void pcibus_reset_hold(Object *obj, ResetType type);
> > >  static bool pcie_has_upstream_port(PCIDevice *dev);
> > >  
> > > +static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
> > > +                             void *opaque, Error **errp)
> > > +{
> > > +    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
> > > +
> > > +    visit_type_uint8(v, name, &bus, errp);
> > > +}
> > > +
> > > +static const PropertyInfo prop_pci_bus = {
> > > +    .name = "bus",    
> > 
> > /me confused,
> > didn't we have 'bus' property for PCI devices already?
> > 
> > i.e. I can add PCI device like this
> >   -device e1000,bus=pci.0,addr=0x6,...  
> 
> to avoid confusion, I'd suggest to name it to 'busnr'
> (or be more specific (primary|secondary)_busnr if applicable)
For generic initiators we are always dealing with an EP so I think
busnr alone is appropriate. If we need similar for bridges we
can add that later.


> 
> >   
> >   
> > > +    .get = prop_pci_bus_get,
> > > +};
> > > +
> > >  static Property pci_props[] = {
> > >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > +    { .name = "bus", .info = &prop_pci_bus },
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >      
> >   
> 
> 

