Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE1194C9A
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495987; cv=none; b=TDSwLkYBVHbBnmgg5jaC/8iJvEs7PEKUi3Z6lwjxDkV62WpKWR3Px3R5unUVmlpajrPzEa3eyJE62mdytduI0yW20kO0KjVwXB5J7Dquze1B/ixYDQSEVlgBw21mskulOglbkrQ543IkXRxNtzKKUlQlSiMrfs/ZoCQNVyWZqlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495987; c=relaxed/simple;
	bh=VoEkfZj8dvApt+tUI3pvf8wyPV/jJ/GFZCTyQYOAKk0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVsVCwqYFWfQ/OkPSZxrdMGoqr9L0KEEvfaQed9NgTC7G7qqwQkk6Oew7HMVDQlPi+sN1SrQGuxAidnAOwt994m1gpriRVfxqbn+xmugxtJUzM8xoMmcna40zniO7JTncXKLqVdxOcXzqInYJ/5aQPLxknVWxMndKM/Lpe4Tq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W90DJ2jmKz6K8sf;
	Thu, 27 Jun 2024 21:44:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DD612140A08;
	Thu, 27 Jun 2024 21:46:15 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 27 Jun
 2024 14:46:15 +0100
Date: Thu, 27 Jun 2024 14:46:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
	<linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL
 PXB
Message-ID: <20240627144614.00004358@Huawei.com>
In-Reply-To: <20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-8-Jonathan.Cameron@huawei.com>
	<20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 27 Jun 2024 15:27:58 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Jun 2024 17:03:15 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > This allows the ACPI SRAT Generic Port Affinity Structure
> > creation to be independent of PCI internals. Note that
> > the UID is currently the PCI bus number.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > v3: New patch
> > ---
> >  hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > index 0411ad31ea..92d39b917a 100644
> > --- a/hw/pci-bridge/pci_expander_bridge.c
> > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > @@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
> >      pbc->numa_node = pxb_bus_numa_node;
> >  }
> >  
> > +static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
> > +                             void *opaque, Error **errp)
> > +{
> > +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> > +
> > +    visit_type_uint32(v, name, &uid, errp);
> > +}
> > +
> > +static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
> > +{
> > +    pxb_bus_class_init(class, data);
> > +    object_class_property_add(class, "acpi_uid", "uint32",
> > +                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
> > +}
> > +
> >  static const TypeInfo pxb_bus_info = {
> >      .name          = TYPE_PXB_BUS,
> >      .parent        = TYPE_PCI_BUS,
> > @@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
> >      .name          = TYPE_PXB_CXL_BUS,
> >      .parent        = TYPE_CXL_BUS,
> >      .instance_size = sizeof(PXBBus),
> > -    .class_init    = pxb_bus_class_init,
> > +    .class_init    = pxb_cxl_bus_class_init,  
> 
> why it's CXL only, doesn't the same UID rules apply to other PCI buses?

In principle, yes.  My nervousness is that we can only test anything
using this infrastructure today with CXL root bridges.

So I was thinking we should keep it limited and broaden the scope
if anyone ever cares.  I don't mind broadening it from the start though.

Jonathan


> >  };
> >  
> >  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,  
> 
> 

