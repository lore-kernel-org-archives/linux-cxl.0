Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA746FB1
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374123; cv=none; b=een/Shkc3EfRs5OCL9iQV2EUkIYp0erbsSCLOW8gPJBVoREm/lruFptIQoRw1U1H8HcNf33qYogiJV25frX8oUNfKruqT8XlB4JIJ69ypDXM7Zf/jQ4iUGBi+eFk2Gsq8K8RHcSPQ4KyTvjUJzr87gW8MbLJf2Iyc8j9giX9E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374123; c=relaxed/simple;
	bh=15NFjcvCJwa/BOqdC5ipammNGrvgDIyvmI0eD9aX+4E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKx+VJicBYOiTzdiIbXPZviWziP3klnqObQgNk/QxW2CZi1hvZ+cvy/rRNz8M8kXIunH9BCtUH1AtxKRu+SagCJOE2VkjCM46D46/0kxcb+/bZRum1ceXwGoIXmDl7aFJ7GgriJXVcGozg0CGO+OgqMkXgJeTlanptZF01QQ+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W11N06wP8z6H7ds;
	Fri, 14 Jun 2024 22:08:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B9C89140B54;
	Fri, 14 Jun 2024 22:08:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 15:08:37 +0100
Date: Fri, 14 Jun 2024 15:08:35 +0100
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
Message-ID: <20240614150835.00000674@Huawei.com>
In-Reply-To: <20240614125725.730f8914@imammedo-mac>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
	<20240606160653.27226def@imammedo.users.ipa.redhat.com>
	<20240606184716.00000708@Huawei.com>
	<20240614125725.730f8914@imammedo-mac>
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

On Fri, 14 Jun 2024 12:57:25 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 6 Jun 2024 18:47:16 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Thu, 6 Jun 2024 16:06:53 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Wed, 5 Jun 2024 19:04:55 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > Treating the HID as an integer caused it to get bit reversed
> > > > on big endian hosts running little endian guests.  Treat it
> > > > as a character array instead.
> > > > 
> > > > Fixes hw/acpi: Generic Port Affinity Structure Support
> > > > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > ---
> > > > Richard ran the version posted in the thread on an s390 instance.
> > > > Thanks for the help!
> > > > 
> > > > Difference from version in thread:
> > > > - Instantiate i in the for loop.
> > > > 
> > > > Sending out now so Michael can decide whether to fold this in, or
> > > > drop the GP series for now from his pull request (in which case
> > > > I'll do an updated version with this and Markus' docs feedback
> > > > folded in.)
> > > > 
> > > > ---
> > > >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> > > >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > > > index 1a899af30f..5baefda33a 100644
> > > > --- a/include/hw/acpi/acpi_generic_initiator.h
> > > > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > > > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> > > >              uint16_t bdf;
> > > >          };
> > > >          struct {
> > > > -            uint64_t hid;
> > > > +            char hid[8];
> > > >              uint32_t uid;
> > > >          };
> > > >      };    
> > > 
> > > not sure on top of what this patch applies but I have some generic comments wrt it  
> > 
> > https://lore.kernel.org/qemu-devel/20240524100507.32106-1-Jonathan.Cameron@huawei.com/
> > 
> > Comments are all on elements of the existing upstream code, but I'm touching it
> > anyway so will look at making the improvements you suggest as new precursors
> > to v3 given we are going around again anyway.
> >   
> > > 
> > > why PCIDeviceHandle is in header file? is there plan for it
> > > being used outside of acpi_generic_initiator.c?  
> > 
> > I'll add a precursor patch to my series that moves
> > it and anything else that should be more local.  May well move
> > to being local in aml_build.c given your later comments with the
> > various fields passed in as parameters.
> >   
> > > 
> > >   
> > > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > > index 78b80dcf08..f064753b67 100644
> > > > --- a/hw/acpi/acpi_generic_initiator.c
> > > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> > > >          build_append_int_noprefix(table_data, 0, 12);
> > > >      } else {
> > > >          /* Device Handle - ACPI */
> > > > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > > > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > > > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > > > +        }
> > > >          build_append_int_noprefix(table_data, handle->uid, 4);
> > > >          build_append_int_noprefix(table_data, 0, 4);    
> > > 
> > > instead of open codding structure
> > > 
> > > it might be better to introduce helper in aml_build.c
> > > something like 
> > >   /* proper reference to spec as we do for other ACPI primitives */
> > >   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
> > >       assert(strlen(hid) ...
> > >       for() {
> > >             build_append_byte()
> > >       }          
> > >       ...
> > > 
> > > the same applies to "Device Handle - PCI" structure  
> > 
> > I'll look at moving that stuff and the affinity structure creation
> > code themselves in there. I think they ended up in this file because
> > of the other infrastructure needed to create these nodes and it
> > will have felt natural to keep this together.
> > 
> > Putting it in aml_build.c will put it with similar code though
> > which makes sense to me.  
> 
> the point of moving handle packing to aml-build.c,
> is to isolate primitives that likely could be reused later on elsewhere
> and hide little endiannes from API user.
> So shuch errors as you are fixing wouldn't be easy to introduce
> (as long as API does it right)
> 
> 
> Also this API probably should take not packed BDF, i.e. something like this:
>     build_append_srat_pci_device_handle(GArray *table_data, bus, dev, func)
> 
> Or a packed BDF as you suggest in the later email, but then API function wold have
> to 'decode' that before putting numbers into table, which complicates things
> and likely would pull in PCI deps to unpack BDF, which I'd rather avoid in
> generic aml-build.c

Ok. I can split it up. My motivation for the encoded version was that
the spec field is defined as a 2 byte field, but it is also broken out
in the description into byte 2 then various bits of byte 3 so we can construct
it that way instead. (were it defined as bits in the 16 bit field this would
make less sense).  Should still be obvious enough to anyone trying to
correlate the two.

Splitting the devfn bit up though is tricky as that doesn't really
have a separate meaning in PCI any more given ARI where it becomes an 8 bit
function ID. So probably makes more sense to keep that as devfn as it's
coming from pci->devfn in that form anyway and they both forms get encoded
into a byte anyway.

Jonathan


> 
> >   
> > > 
> > > Also get rid of PCI deps in acpi_generic_initiator.c 
> > > move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> > > hw/acpi/pci.c  
> > 
> > Today it's used only for PCI devices, but that's partly an artifact
> > of how we get to the root complex via the bus below it.
> > 
> > Spec wise, it's just as applicable to platform devices etc, but maybe
> > we can move it to pci.c for now and move it out again if it gains other
> > users. Or leave it in acpi_generic_initiator.c but have all the aml
> > stuff in aml_build.c as you suggest. 
> >   
> > > file if it has to access PCI code/structures directly
> > > (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)  
> > 
> > Maybe. I'll see what I can come up with.  This feels involved
> > however so I'm more doubtful about this as a precursor.
> >   
> > > 
> > > btw:
> > > build_all_acpi_generic_initiators() name doesn't match what it's doing.
> > > it composes only one initiator entry.  
> > 
> > I'll look at tidying up all the relevant naming.
> > 
> > Jonathan
> >   
> > >   
> > > >      }    
> > > 
> > >   
> >   
> 
> 

