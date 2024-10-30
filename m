Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C61EABA2
	for <linux-cxl@vger.kernel.org>; Wed, 30 Oct 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293456; cv=none; b=ixW+GNUpyLTKxTjf05qgd6Nq9U4CJmqHLthLLc/Febpp3+JgS9gEoVHD/95W2xsB3i1guGs3huHiZzQKBV0E9f+gNg/14KW43lHwqM5B1aC0iXnSmweo29plglyhoC1NO/vAWFQi2e7BShDU30R/RXQD6Z430QUINEdVoZdVJac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293456; c=relaxed/simple;
	bh=ReyTCjd36HdZXuvZN1s/5lYY3YbLkrKw6VAIXasDKe8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEFxwgfPOrWeCeaA3xIBkDSEZrh4a4eBOtLZ3/eX2NBcWoZVgpmO/ZtfvXQ+5dV0FoAzoziWgHePCUO+grH6Ynh1nTZ/xQjlZaqxxYwi/TqQPXUq0JSC/Q2wOPt/NAoQa3/c/4AzBJ4JI0Z4X99YvS4f2aaSQfW8mRJdNGYhdP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdnMF3zMnz6K5mp;
	Wed, 30 Oct 2024 21:01:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C130140B55;
	Wed, 30 Oct 2024 21:04:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 14:04:10 +0100
Date: Wed, 30 Oct 2024 13:04:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Fan Ni <nifan.cxl@gmail.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 2/6] hw/pci-bridge/cxl_upstream: Provide x-speed and
 x-width properties.
Message-ID: <20241030130408.000008cb@Huawei.com>
In-Reply-To: <ZyEPZyUMMo-Vlgpz@fan>
References: <20240916173518.1843023-1-Jonathan.Cameron@huawei.com>
	<20240916173518.1843023-3-Jonathan.Cameron@huawei.com>
	<ZyEPZyUMMo-Vlgpz@fan>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Oct 2024 09:37:59 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Mon, Sep 16, 2024 at 06:35:14PM +0100, Jonathan Cameron wrote:
> > Copied from gen_pcie_root_port.c
> > Drop the previous code that ensured a valid value in s->width, s->speed
> > as now a default is provided so this will always be set.
> > 
> > Note this changes the default settings but it is unlikely to have a negative
> > effect on software as will only affect ports with now downstream device.
> > All other ports will use the settings from that device.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/pci-bridge/cxl_downstream.c | 23 ++++++++++-------------
> >  1 file changed, 10 insertions(+), 13 deletions(-)
> > 
> > diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> > index 4b42984360..c347ac06f3 100644
> > --- a/hw/pci-bridge/cxl_downstream.c
> > +++ b/hw/pci-bridge/cxl_downstream.c
> > @@ -13,6 +13,8 @@
> >  #include "hw/pci/msi.h"
> >  #include "hw/pci/pcie.h"
> >  #include "hw/pci/pcie_port.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/qdev-properties-system.h"
> >  #include "hw/cxl/cxl.h"
> >  #include "qapi/error.h"
> >  
> > @@ -210,24 +212,20 @@ static void cxl_dsp_exitfn(PCIDevice *d)
> >      pci_bridge_exitfn(d);
> >  }
> >  
> > -static void cxl_dsp_instance_post_init(Object *obj)
> > -{
> > -    PCIESlot *s = PCIE_SLOT(obj);
> > -
> > -    if (!s->speed) {
> > -        s->speed = QEMU_PCI_EXP_LNK_2_5GT;
> > -    }
> > -
> > -    if (!s->width) {
> > -        s->width = QEMU_PCI_EXP_LNK_X1;
> > -    }
> > -}
> > +static Property cxl_dsp_props[] = {
> > +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> > +                                speed, PCIE_LINK_SPEED_64),
> > +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> > +                                width, PCIE_LINK_WIDTH_16),  
> 
> Not sure why. For the root port, we use PCIE_LINK_WIDTH_32, and here it is
> PCIE_LINK_WIDTH_16?

Random choice. There is no obvious default to choose.

I'm fine changing them to another choice if that makes more sense.

Jonathan


> 
> Fan
> 
> > +    DEFINE_PROP_END_OF_LIST()
> > +};
> >  
> >  static void cxl_dsp_class_init(ObjectClass *oc, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(oc);
> >      PCIDeviceClass *k = PCI_DEVICE_CLASS(oc);
> >  
> > +    device_class_set_props(dc, cxl_dsp_props);
> >      k->config_write = cxl_dsp_config_write;
> >      k->realize = cxl_dsp_realize;
> >      k->exit = cxl_dsp_exitfn;
> > @@ -243,7 +241,6 @@ static const TypeInfo cxl_dsp_info = {
> >      .name = TYPE_CXL_DSP,
> >      .instance_size = sizeof(CXLDownstreamPort),
> >      .parent = TYPE_PCIE_SLOT,
> > -    .instance_post_init = cxl_dsp_instance_post_init,
> >      .class_init = cxl_dsp_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> >          { INTERFACE_PCIE_DEVICE },
> > -- 
> > 2.43.0
> >   
> 

