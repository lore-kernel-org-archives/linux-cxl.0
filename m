Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94FE147C74
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041673; cv=none; b=CoCOpyZ5U1GIiMj8v7EmqyW3U6aaAF+/cvu1Ysu1leQ/K4XCLFQZb/zEKyV1RtSUMLyKl4HC0qqtN3fvbH3kZm+9I+nFyiXwQq3g46OkFq8buUa11tTe+49lI4hmi916TKu0HoM5oviRMG+CCMfDIl/72EG70YeX2RpfUgySFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041673; c=relaxed/simple;
	bh=a5rpvrfkwW9FpwKmeVpauOTdiOGCWHF7Iqt9V9I2FsY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCN4ZaGJ1+/M7+diAZvU30iPhqOmNEcHPMqAWxo2AW5X2I9Uq/Qq0qxFmJz3V/3VXTpQsHxyg0UXh30CTXr3T/qlNISvw3rpgU6h3sRFZIu4ZbK2os3Hwx0FxDpGNvce2vVQtK1Lb2ael+IZk5h5E6DvDfrsmEOxZtAf2VU4iUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VyfKC0PBNz6K5sk;
	Tue, 11 Jun 2024 01:42:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EC8F81404F5;
	Tue, 11 Jun 2024 01:47:46 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 18:47:46 +0100
Date: Mon, 10 Jun 2024 18:47:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240610184745.00006683@huawei.com>
In-Reply-To: <20240606184716.00000708@Huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
	<20240606160653.27226def@imammedo.users.ipa.redhat.com>
	<20240606184716.00000708@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


Hi Igor,

Some code snippets below to try and see if I'm on the correct track
for what you had in mind.

> >   
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 78b80dcf08..f064753b67 100644
> > > --- a/hw/acpi/acpi_generic_initiator.c
> > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> > >          build_append_int_noprefix(table_data, 0, 12);
> > >      } else {
> > >          /* Device Handle - ACPI */
> > > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > > +        }
> > >          build_append_int_noprefix(table_data, handle->uid, 4);
> > >          build_append_int_noprefix(table_data, 0, 4);    
> > 
> > instead of open codding structure
> > 
> > it might be better to introduce helper in aml_build.c
> > something like 
> >   /* proper reference to spec as we do for other ACPI primitives */
> >   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
> >       assert(strlen(hid) ...
> >       for() {
> >             build_append_byte()
> >       }          
> >       ...
> > 
> > the same applies to "Device Handle - PCI" structure  
> 
> I'll look at moving that stuff and the affinity structure creation
> code themselves in there. I think they ended up in this file because
> of the other infrastructure needed to create these nodes and it
> will have felt natural to keep this together.
> 
> Putting it in aml_build.c will put it with similar code though
> which makes sense to me.

This all works out fine, though there is less reason to keep a
ACPI_GENERIC_NODE base under GENERIC_PORT and GENERIC_INITIATOR
so I may drop that and just have a small amount of code duplication.

> 
> > 
> > Also get rid of PCI deps in acpi_generic_initiator.c 
> > move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> > hw/acpi/pci.c  
> 
> Today it's used only for PCI devices, but that's partly an artifact
> of how we get to the root complex via the bus below it.
> 
> Spec wise, it's just as applicable to platform devices etc, but maybe
> we can move it to pci.c for now and move it out again if it gains other
> users. Or leave it in acpi_generic_initiator.c but have all the aml
> stuff in aml_build.c as you suggest. 
> 
> > file if it has to access PCI code/structures directly
> > (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)  
> 
> Maybe. I'll see what I can come up with.  This feels involved
> however so I'm more doubtful about this as a precursor.

This is a little messy and tricky to get the right level of generic.
For the bdf, were you thinking something along the lines of the following?

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d2..75366491b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);

+static void prop_pci_bdf_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint16_t bdf = pci_get_bdf(PCI_DEVICE(obj));
+
+    visit_type_uint16(v, name, &bdf, errp);
+}
+
+static const PropertyInfo prop_pci_bdf = {
+    .name = "bdf",
+    .get = prop_pci_bdf_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -85,6 +98,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    { .name = "bdf", .info = &prop_pci_bdf },
     DEFINE_PROP_END_OF_LIST()
 };


The other case is where I need to get the ACPI UID associate with a
root complex. Now that has to be matched to the appropriate HID and so
far the only one of those is ACPI0016 which is the HID for
TYPE_PXB_CXL_DEV. That happens to the bus number of the
TYPE_PXB_CXL_BUS but that connection should probably not be explicit
outside of the PXB specific code.

I can add a property like: 

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index f5431443b9..1c51f3f5b6 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -92,6 +92,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
     pbc->numa_node = pxb_bus_numa_node;
 }

+static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+
+    visit_type_uint32(v, name, &uid, errp);
+}
+
+static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
+{
+    pxb_bus_class_init(class, data);
+    object_class_property_add(class, "acpi_uid", "uint32",
+                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
+}
+
 static const TypeInfo pxb_bus_info = {
     .name          = TYPE_PXB_BUS,
     .parent        = TYPE_PCI_BUS,
@@ -110,7 +125,7 @@ static const TypeInfo pxb_cxl_bus_info = {
     .name          = TYPE_PXB_CXL_BUS,
     .parent        = TYPE_CXL_BUS,
     .instance_size = sizeof(PXBBus),
-    .class_init    = pxb_bus_class_init,
+    .class_init    = pxb_cxl_bus_class_init,
 };

 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,

and query it when setting up the generic port with

        const char *hid = "ACPI0016";
        uint32_t uid;

        if (gn->node >= ms->numa_state->num_nodes) {
            error_printf("%s: node %d is invalid.\n",
                         TYPE_ACPI_GENERIC_PORT, gn->node);
            exit(1);
        }

        o = object_resolve_path_type(gn->pci_dev, TYPE_PXB_CXL_BUS, NULL);
        if (!o) {
            error_printf("%s: device must be a CXL host bridge.\n",
                         TYPE_ACPI_GENERIC_PORT);
            exit(1);
        }

        uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
        build_srat_acpi_generic_port(table_data, gn->node, hid, uid);

        return 0;

Thanks,

Jonathan

> 
> > 
> > btw:
> > build_all_acpi_generic_initiators() name doesn't match what it's doing.
> > it composes only one initiator entry.  
> 
> I'll look at tidying up all the relevant naming.
> 
> Jonathan
> 
> >   
> > >      }    
> > 
> >   
> 
> 
> 

