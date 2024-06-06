Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73421FAA
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696043; cv=none; b=sN2XSLxbrnRSpzwqGGEOPkaZNyOb/zd+az0AGF3lIuhbi5+0BNfLoHPnQ0mI1nTiPNeNmJYnpcBwIIKZOXVrl8VxpQzuLGbi95NvufQXh5RNyQQhS/O9n0gk8DehWKYI6Y5+hrCUFqwrmghzYBUFmaObkeVT4SQe8uQ6wTYEtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696043; c=relaxed/simple;
	bh=kmRt9BpAOrgksvF9ZFQuIPsSRKEg4QejMgO3bD3QpGs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAaBw3CHhkZLgUvdmJjovYiysNk8kMvo2KBOXMPZt2G16X9o79YhDWV+N4ujhTV+mJ9fjo9ZSCUUt12/YQyVFg1f/5Qd0H8DlJXI/ZtU2x5g0yMdms7TNs32exhhodOjBT5bLRzxTLRYiJ+Clp6irGTLQNHWdz7JwSpIn4sUdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwBW40PTzz6J9cl;
	Fri,  7 Jun 2024 01:42:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D91F7140C98;
	Fri,  7 Jun 2024 01:47:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 18:47:17 +0100
Date: Thu, 6 Jun 2024 18:47:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
	Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240606184716.00000708@Huawei.com>
In-Reply-To: <20240606160653.27226def@imammedo.users.ipa.redhat.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
	<20240606160653.27226def@imammedo.users.ipa.redhat.com>
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

On Thu, 6 Jun 2024 16:06:53 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 5 Jun 2024 19:04:55 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Treating the HID as an integer caused it to get bit reversed
> > on big endian hosts running little endian guests.  Treat it
> > as a character array instead.
> > 
> > Fixes hw/acpi: Generic Port Affinity Structure Support
> > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > ---
> > Richard ran the version posted in the thread on an s390 instance.
> > Thanks for the help!
> > 
> > Difference from version in thread:
> > - Instantiate i in the for loop.
> > 
> > Sending out now so Michael can decide whether to fold this in, or
> > drop the GP series for now from his pull request (in which case
> > I'll do an updated version with this and Markus' docs feedback
> > folded in.)
> > 
> > ---
> >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > index 1a899af30f..5baefda33a 100644
> > --- a/include/hw/acpi/acpi_generic_initiator.h
> > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> >              uint16_t bdf;
> >          };
> >          struct {
> > -            uint64_t hid;
> > +            char hid[8];
> >              uint32_t uid;
> >          };
> >      };  
> 
> not sure on top of what this patch applies but I have some generic comments wrt it

https://lore.kernel.org/qemu-devel/20240524100507.32106-1-Jonathan.Cameron@huawei.com/

Comments are all on elements of the existing upstream code, but I'm touching it
anyway so will look at making the improvements you suggest as new precursors
to v3 given we are going around again anyway.

> 
> why PCIDeviceHandle is in header file? is there plan for it
> being used outside of acpi_generic_initiator.c?

I'll add a precursor patch to my series that moves
it and anything else that should be more local.  May well move
to being local in aml_build.c given your later comments with the
various fields passed in as parameters.

> 
> 
> > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > index 78b80dcf08..f064753b67 100644
> > --- a/hw/acpi/acpi_generic_initiator.c
> > +++ b/hw/acpi/acpi_generic_initiator.c
> > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> >          build_append_int_noprefix(table_data, 0, 12);
> >      } else {
> >          /* Device Handle - ACPI */
> > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > +        }
> >          build_append_int_noprefix(table_data, handle->uid, 4);
> >          build_append_int_noprefix(table_data, 0, 4);  
> 
> instead of open codding structure
> 
> it might be better to introduce helper in aml_build.c
> something like 
>   /* proper reference to spec as we do for other ACPI primitives */
>   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
>       assert(strlen(hid) ...
>       for() {
>             build_append_byte()
>       }          
>       ...
> 
> the same applies to "Device Handle - PCI" structure

I'll look at moving that stuff and the affinity structure creation
code themselves in there. I think they ended up in this file because
of the other infrastructure needed to create these nodes and it
will have felt natural to keep this together.

Putting it in aml_build.c will put it with similar code though
which makes sense to me.

> 
> Also get rid of PCI deps in acpi_generic_initiator.c 
> move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> hw/acpi/pci.c

Today it's used only for PCI devices, but that's partly an artifact
of how we get to the root complex via the bus below it.

Spec wise, it's just as applicable to platform devices etc, but maybe
we can move it to pci.c for now and move it out again if it gains other
users. Or leave it in acpi_generic_initiator.c but have all the aml
stuff in aml_build.c as you suggest. 

> file if it has to access PCI code/structures directly
> (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)

Maybe. I'll see what I can come up with.  This feels involved
however so I'm more doubtful about this as a precursor.

> 
> btw:
> build_all_acpi_generic_initiators() name doesn't match what it's doing.
> it composes only one initiator entry.

I'll look at tidying up all the relevant naming.

Jonathan

> 
> >      }  
> 
> 

