Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F84155A23
	for <linux-cxl@vger.kernel.org>; Fri, 28 Jun 2024 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575892; cv=none; b=nSd0clKxHS2KExoiDYnjxfilDVEKvgkGbFDmppmaE3uJmzTfvLLNUin6f1ideGVkY6sAeu5PKc08xn1uW93VIwrNiR4R4ZOic+OnQvEXeTzy89q1k3/c6by2I0co1E4A1CYVz/ovYtdsrpG/Ck5CnUefNUPHePRgQr+ImGlxwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575892; c=relaxed/simple;
	bh=DDjbsUx5JXQivbxcL4qIi2hwrDVhOe+DeC55wamNdZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvChPmCWV4KOse4K5BU3uyzr5AL2jOZdZisjCWhfk4ye0CF/PKB3MdW1wHMyWLCXs6Qj+RPKPLMrbQHJmPljhmqSESqw/n/xd4HUgI3CR7PUvtWLPcGmtJQO9400p2JZA5Bgs/EUf40lfMrNz7rCJU9VNkVfJ+2g5nGxMNc9z78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S43jrmTu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S43jrmTu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719575888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kEfstQABPqKvB1S1Gl8bwJoQoa3c+s2N0zFlX7e5uSE=;
	b=S43jrmTu03cqJ3Q5xX8cciPEe7OowXc57DcwZTpsq3hlu3cGzi5Atgql/JBCjqnOvGf7K4
	njs7el8n4RMLl67o0Ll9Ryagc5HqLsT4X0j5M7Ayecf5hcsd0W1fkK9swdxEmlYzLsHqz0
	Zi9ini1jEvW2M43ZrXS+6Au989UrOkM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Y2LzcTrJNSmuydLmvPXHVA-1; Fri, 28 Jun 2024 07:58:07 -0400
X-MC-Unique: Y2LzcTrJNSmuydLmvPXHVA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-363edcf12a3so425332f8f.3
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jun 2024 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575886; x=1720180686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEfstQABPqKvB1S1Gl8bwJoQoa3c+s2N0zFlX7e5uSE=;
        b=OfkQg8OfRe9m3Jr7drQsLDTPCxPJhfED2/K5gPVksLc0T9b0omEsqiN3fhx3mo00yB
         vfmSw2zW6fm63GkrOcYX6sqlB5TGZqQ21oOOqXaRNCZUsDhLqGsO1gZZ8VDzn7dOUtHO
         5fNpiY/54HG+DdnP87plV2JJINKRvcFTMdrvLJ7woZeDVtjH4zGgR/M9mI2yU067QtRC
         QS6ZO8chPWOpfSbRHLWUpULoWWJQeEfwi3NjPPEB0E5R1QFwZQzPZLdfA9ta6EyGMZzc
         3AxvebVRVv67m1N2StjIaI78+bTU0xHtj/0C3OmhJ7sTgWLd0Wlj2s8ICH3IJMxg0XgR
         XcUg==
X-Forwarded-Encrypted: i=1; AJvYcCUkoF4t1kKBbC8AoxCeD1TkKwX+j3ovoh5nfhcB/P7tOJ7z3e0tRmY2/oh2hD88Nn91qOK3ULi2rhBBXVDEQYgFGBrHlbpGJKT8
X-Gm-Message-State: AOJu0YwYvsRyCCUn4lZmBQVQI6BjXW4LUJlu5rvNdLkHGdU7XcostMJL
	MRopFsJkc8h6+1hMz3kgoey/H39vC7evju44waZljKJupDxxs1W8egY2HnWvq7NFQYGffcpCJQT
	t9eFCw2h5ChOUXiMQg/j98uD8dNEmY8PoQu+Qz8teDIszQHU4xteJGwxUSA==
X-Received: by 2002:a05:6000:1886:b0:366:e90f:3763 with SMTP id ffacd0b85a97d-366e90f38bfmr13864840f8f.8.1719575886271;
        Fri, 28 Jun 2024 04:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwbs7bpE3ojA+ickRy/M98hlMD9uB6cmDG5H5mROkctUFckzPhlywwpHrz4/d52B/f7ubDsg==
X-Received: by 2002:a05:6000:1886:b0:366:e90f:3763 with SMTP id ffacd0b85a97d-366e90f38bfmr13864816f8f.8.1719575885840;
        Fri, 28 Jun 2024 04:58:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9f9dsm2104409f8f.41.2024.06.28.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:58:05 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:58:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and
 use for acpi/gi
Message-ID: <20240628135804.12434f5e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-6-Jonathan.Cameron@huawei.com>
	<20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 15:09:12 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 20 Jun 2024 17:03:13 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Using a property allows us to hide the internal details of the PCI device
> > from the code to build a SRAT Generic Initiator Affinity Structure with
> > PCI Device Handle.
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > V3: New patch
> > ---
> >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> >  hw/pci/pci.c                     | 14 ++++++++++++++
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 73bafaaaea..34284359f0 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -9,6 +9,7 @@
> >  #include "hw/boards.h"
> >  #include "hw/pci/pci_device.h"
> >  #include "qemu/error-report.h"
> > +#include "qapi/error.h"
> >  
> >  typedef struct AcpiGenericInitiatorClass {
> >      ObjectClass parent_class;
> > @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >      MachineState *ms = MACHINE(qdev_get_machine());
> >      AcpiGenericInitiator *gi;
> >      GArray *table_data = opaque;
> > -    PCIDevice *pci_dev;
> > +    uint8_t bus, devfn;
> >      Object *o;
> >  
> >      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >          exit(1);
> >      }
> >  
> > -    pci_dev = PCI_DEVICE(o);
> > -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> > -                                     pci_bus_num(pci_get_bus(pci_dev)),
> > -                                     pci_dev->devfn);
> > +    bus = object_property_get_uint(o, "bus", &error_fatal);
> > +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> > +
> > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> >  
> >      return 0;
> >  }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 324c1302d2..b4b499b172 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >  static void pcibus_reset_hold(Object *obj, ResetType type);
> >  static bool pcie_has_upstream_port(PCIDevice *dev);
> >  
> > +static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
> > +                             void *opaque, Error **errp)
> > +{
> > +    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
> > +
> > +    visit_type_uint8(v, name, &bus, errp);
> > +}
> > +
> > +static const PropertyInfo prop_pci_bus = {
> > +    .name = "bus",  
> 
> /me confused,
> didn't we have 'bus' property for PCI devices already?
> 
> i.e. I can add PCI device like this
>   -device e1000,bus=pci.0,addr=0x6,...

to avoid confusion, I'd suggest to name it to 'busnr'
(or be more specific (primary|secondary)_busnr if applicable)

>   
> 
> > +    .get = prop_pci_bus_get,
> > +};
> > +
> >  static Property pci_props[] = {
> >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > +    { .name = "bus", .info = &prop_pci_bus },
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> >    
> 

