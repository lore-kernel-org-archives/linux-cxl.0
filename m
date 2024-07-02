Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94211158A3D
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916892; cv=none; b=ukFphktZqlXUFT8GYunyNpvxCl506MQcjbATpYpZljR7dwo1tPpJnb8prY1s40iKRlU+AGhTfmG/NlQq/f1OYplB2k82/ocl9ODPxDzKg+nJ6lAFlI0Y1kbzCNeXFviKm6umHjBiNGc7v4Y+eAKbvBEJ0qSrGhcddlRiwo1c078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916892; c=relaxed/simple;
	bh=LmT9Eb+ozuhoEyP7wcruTpYdqn5ULwIXAKE/jZATVjc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmtkDAmacn+yFS4FKECdkQzkDLHe1MpNefTbNDsg8LGCVCsYU+pIWfmIff30mOjYLxJUbstR5SNHT5RWlMOlFOIKxLH9lpovnIZW38FGyxNWGr4aMbJEz9HZ9u6CqYZWqCEq8/WcysullT6GmkqN8FqJyemi5yqRBHCtq8teCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCztV1jKdz6K9DM;
	Tue,  2 Jul 2024 18:39:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 541B4140680;
	Tue,  2 Jul 2024 18:41:21 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 11:41:20 +0100
Date: Tue, 2 Jul 2024 11:41:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>, <linuxarm@huawei.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<linux-cxl@vger.kernel.org>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: Re: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL
 PXB
Message-ID: <20240702113826.00003a66@huawei.com>
In-Reply-To: <20240701185203.00006159@Huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-8-Jonathan.Cameron@huawei.com>
	<20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
	<20240627144614.00004358@Huawei.com>
	<20240628135525.0c131846@imammedo.users.ipa.redhat.com>
	<20240701185203.00006159@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 1 Jul 2024 18:52:03 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 28 Jun 2024 13:55:25 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 27 Jun 2024 14:46:14 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Thu, 27 Jun 2024 15:27:58 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >     
> > > > On Thu, 20 Jun 2024 17:03:15 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >       
> > > > > This allows the ACPI SRAT Generic Port Affinity Structure
> > > > > creation to be independent of PCI internals. Note that
> > > > > the UID is currently the PCI bus number.
> > > > > 
> > > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > 
> > > > > ---
> > > > > v3: New patch
> > > > > ---
> > > > >  hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
> > > > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > > > index 0411ad31ea..92d39b917a 100644
> > > > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > > > @@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
> > > > >      pbc->numa_node = pxb_bus_numa_node;
> > > > >  }
> > > > >  
> > > > > +static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
> > > > > +                             void *opaque, Error **errp)
> > > > > +{
> > > > > +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> > > > > +
> > > > > +    visit_type_uint32(v, name, &uid, errp);
> > > > > +}
> > > > > +
> > > > > +static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
> > > > > +{
> > > > > +    pxb_bus_class_init(class, data);
> > > > > +    object_class_property_add(class, "acpi_uid", "uint32",
> > > > > +                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
> > > > > +}
> > > > > +
> > > > >  static const TypeInfo pxb_bus_info = {
> > > > >      .name          = TYPE_PXB_BUS,
> > > > >      .parent        = TYPE_PCI_BUS,
> > > > > @@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
> > > > >      .name          = TYPE_PXB_CXL_BUS,
> > > > >      .parent        = TYPE_CXL_BUS,
> > > > >      .instance_size = sizeof(PXBBus),
> > > > > -    .class_init    = pxb_bus_class_init,
> > > > > +    .class_init    = pxb_cxl_bus_class_init,        
> > > > 
> > > > why it's CXL only, doesn't the same UID rules apply to other PCI buses?      
> > > 
> > > In principle, yes.  My nervousness is that we can only test anything
> > > using this infrastructure today with CXL root bridges.
> > > 
> > > So I was thinking we should keep it limited and broaden the scope
> > > if anyone ever cares.  I don't mind broadening it from the start though.    
> > 
> > Then I'd use it everywhere and cleanup ACPI code to use it as well
> > just to be consistent.  
> That is easy to do for all the TYPE_PXB_BUS types and they have separate
> handling in the various ACPI table builds from other host bridgesn anyway.
> 
> Ultimately it might be nice to do for the host bridges in general but
> that needs to be separate I think as there isn't a simple common
> ancestor to use.  For at least some cases (gpex-acpi.c) it's hard
> coded as 0 directly with no look up at all.
Also worth noting that we could take the approach of not using pci internals
in ACPI building further and deal with things like numa nodes.
I don't mind doing that in the longer term, but I don't want that to be
a dependency for this series.

Jonathan

> 
> Jonathan
> 
> >    
> > > Jonathan
> > > 
> > >     
> > > > >  };
> > > > >  
> > > > >  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,        
> > > > 
> > > >       
> > >     
> > 
> >   
> 
> 
> 

