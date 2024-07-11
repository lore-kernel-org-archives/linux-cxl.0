Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303D158216
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jul 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712632; cv=none; b=R+hCVzQzY+N6sC00Po2jLUl7CCQmGdB1u/oCSfhRqaWQcKhqsFymFETCHcN5o41djVFSjCc1qon1aM8XUtIVRsuxvqfsbfWfFR3cz2+Scuq+lhDjjNIlXYw5rWyAqbKn3uom57aw+SG2oG4qxS/03+/fEKl481yCrA6MKNylqQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712632; c=relaxed/simple;
	bh=PrVemtHVSKbCe4Cz28RjwZD3IlgKuIUqUcUE0YGV3KY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCuTbX3uRdRozFARqRuksJ32wK9V9RdB+s6GrRvtLconST3n3XqWlugsAUV9zGYpuJRrrmzqWGTvgqZJG57noyiXYBi3tDkHgg9W4BlJEfvS9U6iJunOx9/xBd0oGewjDp+9t77zh6m802dnE4JC7kaWjaJdublb9n2J2gByI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WKf912ZYfz6H7X0;
	Thu, 11 Jul 2024 23:41:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E49151406AC;
	Thu, 11 Jul 2024 23:43:46 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 11 Jul
 2024 16:43:46 +0100
Date: Thu, 11 Jul 2024 16:43:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
	<linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v4 05/13] hw/pci: Add a busnr property to pci_props and
 use for acpi/gi
Message-ID: <20240711164345.00005952@Huawei.com>
In-Reply-To: <20240711142316.1150870e@imammedo.users.ipa.redhat.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
	<20240702131428.664859-6-Jonathan.Cameron@huawei.com>
	<20240711135331.6f0e4639@imammedo.users.ipa.redhat.com>
	<20240711142316.1150870e@imammedo.users.ipa.redhat.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 11 Jul 2024 14:23:16 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 11 Jul 2024 13:53:31 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Tue, 2 Jul 2024 14:14:10 +0100
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
> > > V4: Avoid confusion with device creation parameter bus but renaming to
> > >     busnr
> > > ---
> > >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> > >  hw/pci/pci.c                     | 14 ++++++++++++++
> > >  2 files changed, 20 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 73bafaaaea..f2711c91ef 100644
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
> > > +    bus = object_property_get_uint(o, "busnr", &error_fatal);
> > > +    devfn = object_property_get_uint(o, "addr", &error_fatal);    
> > 
> > devfn in PCI code is 32bit, while here it's declared as unit8_t,
> > which seems wrong.
> > It likely would work in case of PCIe root ports/switches where slot is 0,
> > but should quickly break elsewhere as soon as slot is more than 0.
> > 
> > If it's intentional, there should be fat comment here about why it this way
> > and an assert to catch silent cropping of the value.   
> 
> Ignore that, obviously the rest of the QEMU does not care about this downcast.
It's indeed odd that the storage is 32 bits.
> 
> Maybe add assert anyways to catch too big devfn returned,
> which unlikely to happen ever.

Will do. 
assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
with devfn locally as an int32_t and object_property_get_int()
to match with the type.

> 
> anyways:
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> >   
> > > +
> > > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> > >  
> > >      return 0;
> > >  }
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 50b86d5790..29d4852c21 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > >  static void pcibus_reset_hold(Object *obj, ResetType type);
> > >  static bool pcie_has_upstream_port(PCIDevice *dev);
> > >  
> > > +static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
> > > +                             void *opaque, Error **errp)
> > > +{
> > > +    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
> > > +
> > > +    visit_type_uint8(v, name, &busnr, errp);
> > > +}
> > > +
> > > +static const PropertyInfo prop_pci_busnr = {
> > > +    .name = "busnr",
> > > +    .get = prop_pci_busnr_get,
> > > +};
> > > +
> > >  static Property pci_props[] = {
> > >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > +    { .name = "busnr", .info = &prop_pci_busnr },
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >      
> >   
> 
> 

