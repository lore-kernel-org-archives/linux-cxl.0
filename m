Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D052158213
	for <linux-cxl@vger.kernel.org>; Fri, 28 Jun 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575734; cv=none; b=gHOKLUxZKR4yh8am3rsC+wQmZLaVrtmy3NR3oJZhRygRFxDx5dO2GhM9T+Eg5PMZaLdpCH7ZBnJPRBvlWoXpv1yHXJeAR6RuogOz2uV8XD+0mmadbOZP5q6fHH+EZOk74zY3Mv87r21HbAI4z15JljJI5MAGisU++P5yr96yQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575734; c=relaxed/simple;
	bh=+E6XSEAm/dPQ6chm2lKMyozB9QZ7HlWBqJjYmm896+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQB/OQ7wVQZXzFcMbMsVSnBiLjeH81I3/F7p5fbn/+G/yW9LYOcOUk7CIICYeP1+yXha9wfzc4Nu7+jrRxb3S1EkdQ8LwolD+sxvkkFKjlZy6VFmUfWKmwGFYJ1tsgczUr/Yi9HgyfC3bYpTnoEoA+kwxGGHuN5njCCSDJlpVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsCmVsgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsCmVsgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719575730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIdgxHEBhDpm1AmrQ07hyskJ/f/Dw+Jr6uTrIO5O4XI=;
	b=BsCmVsgS5j2obTyIqtgc05P7cg/cVyqJ5/UI3XwExRJ8LqepcLT9UtxgVE1Bbdds7l5h/H
	9xtEmoR+gi5x5O76xKnOIkVJ1IxN8Y1Zw2F0LfWCu6f9dF6gGso0VrcIwNv2a9sSiAWRSo
	T1CrOXOMs9BJXt+NtLqew1276LOQWBI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-6RA9f-ahMtqKbrqJVtJsdg-1; Fri, 28 Jun 2024 07:55:28 -0400
X-MC-Unique: 6RA9f-ahMtqKbrqJVtJsdg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec5e1ee629so5905241fa.0
        for <linux-cxl@vger.kernel.org>; Fri, 28 Jun 2024 04:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575727; x=1720180527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIdgxHEBhDpm1AmrQ07hyskJ/f/Dw+Jr6uTrIO5O4XI=;
        b=Sp/TfUwb3Bl7zbqR/ndyyyvBnm8ihgBnCsgJak/Wo/xmAerTM2WWfgIOGlSgdvWwT6
         nQoYhdV7UTXZPUukLwXcl9J6YjPYSWIUgg8gIl3NoCrox3LbiwjcfN6iz5hjj8mDOTun
         uc7iRe7mpv3qzVzE/A9c9Pp0+lkgV0Dt81++N/ry26zfhtB9sQhwHQzz9a95xZ3BAhBR
         TGOIDiTu5hOwDf0UW233YQgwmyHq6bLoA0NOLNu8H1pdOeqSnFP5enR+KnKld1t3v5Fe
         uz+PtsXcUC2sFaQRbQISepvlF/ahSHNuOUREiJf2NeqXKynNT/Tk64kCc1eOFEoRJ1sX
         oFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEVUaaBtc9oKz+wrCXwxRbgSWMPHWxuOOzDO4KzVSgJERlANgEVEmQNi+LBJr4CaulUY1ybCE4LqX3wY+RRI/1rHYVacip44lL
X-Gm-Message-State: AOJu0YzD2L4JHhApJJRE1y3R/t3rDIWLFxDayszEpRbBO4FlJc2v+kDH
	NUG3tOvQeIn3Uasoup79Us1wIfu0ffvNTbrI0WKCAsd974TRQU1eYYmah286kvLx0GqavJH2anz
	qvA1maHED/aBajLbCqHEAFUrxGv9Tt8iVgSYrQWS614dvcw57iPZLp7lJuA==
X-Received: by 2002:ac2:58c3:0:b0:52c:ec68:6165 with SMTP id 2adb3069b0e04-52cec6861e8mr8380574e87.33.1719575727332;
        Fri, 28 Jun 2024 04:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR4g586qIFOLmfhPhJ17znzEeUJZNpf05zPTnVrdOudzmojqCKmDvtnj2d7cZUyaUjvC6Rig==
X-Received: by 2002:ac2:58c3:0:b0:52c:ec68:6165 with SMTP id 2adb3069b0e04-52cec6861e8mr8380561e87.33.1719575726892;
        Fri, 28 Jun 2024 04:55:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0da004sm2094482f8f.45.2024.06.28.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:55:26 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:55:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL
 PXB
Message-ID: <20240628135525.0c131846@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627144614.00004358@Huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-8-Jonathan.Cameron@huawei.com>
	<20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
	<20240627144614.00004358@Huawei.com>
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

On Thu, 27 Jun 2024 14:46:14 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 27 Jun 2024 15:27:58 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 20 Jun 2024 17:03:15 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > This allows the ACPI SRAT Generic Port Affinity Structure
> > > creation to be independent of PCI internals. Note that
> > > the UID is currently the PCI bus number.
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > ---
> > > v3: New patch
> > > ---
> > >  hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > index 0411ad31ea..92d39b917a 100644
> > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > @@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
> > >      pbc->numa_node = pxb_bus_numa_node;
> > >  }
> > >  
> > > +static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
> > > +                             void *opaque, Error **errp)
> > > +{
> > > +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> > > +
> > > +    visit_type_uint32(v, name, &uid, errp);
> > > +}
> > > +
> > > +static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
> > > +{
> > > +    pxb_bus_class_init(class, data);
> > > +    object_class_property_add(class, "acpi_uid", "uint32",
> > > +                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
> > > +}
> > > +
> > >  static const TypeInfo pxb_bus_info = {
> > >      .name          = TYPE_PXB_BUS,
> > >      .parent        = TYPE_PCI_BUS,
> > > @@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
> > >      .name          = TYPE_PXB_CXL_BUS,
> > >      .parent        = TYPE_CXL_BUS,
> > >      .instance_size = sizeof(PXBBus),
> > > -    .class_init    = pxb_bus_class_init,
> > > +    .class_init    = pxb_cxl_bus_class_init,    
> > 
> > why it's CXL only, doesn't the same UID rules apply to other PCI buses?  
> 
> In principle, yes.  My nervousness is that we can only test anything
> using this infrastructure today with CXL root bridges.
> 
> So I was thinking we should keep it limited and broaden the scope
> if anyone ever cares.  I don't mind broadening it from the start though.

Then I'd use it everywhere and cleanup ACPI code to use it as well
just to be consistent.
 
> Jonathan
> 
> 
> > >  };
> > >  
> > >  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,    
> > 
> >   
> 

