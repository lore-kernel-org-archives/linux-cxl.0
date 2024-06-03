Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA7391
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427056; cv=none; b=X5bGeo3imBCtoYzl+dBMytb7kPELXAstTjofBd2orKaOZ855rQFzWvdEhVLQA3/YEyoTqeDbHFGAgeNk53q5iweqxJ/bFPAcE2JW9kRL8wLLjqBs5P1Qf5I0tH61ZeJKtvLBM5tgiclf47uwf2y6oWVOwmWKtb8i1c5xMYpDAFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427056; c=relaxed/simple;
	bh=fO3mgdsV6w3M5w/n7P/GkK8IshUByznmtcvvPR6C0p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NxQmWclVV65qK29SeULEGWGnFmdAefK2dx1wfRJB8r1Szr+C5o9RP3YoLVdJgO+GrMMtZNkQResYR0RLjwsuipZZ7qyTt5mdduP4U+fCApbSihAHyimV2MLp/gTvRJ+vD2KddjchERvmRhSyJHTV41CUrtwPJp7v8G8NJp4g6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYMpVdxB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYMpVdxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717427053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eRoQODSdfaihIUPu/mCKgWE6oYbSsy1P8A3UVTHj02w=;
	b=hYMpVdxBs4qB5wkAcyP7iiv5VfiIxq3zK5v5oXA0IYk75Sb3Z1rxX5+jVexfeEW6oOFUHH
	ndARkGQu0alLufBhAlD3HTkVNPx/laPDjaqPOLqnVPzCJEcMZWNdEeKnqMMtRVI+d0EiBV
	ha5VE0DsSrD1CCr39aKMIxP/XvcyjNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-7RVJMf-JNrCwWf5nYxZtRA-1; Mon, 03 Jun 2024 11:04:12 -0400
X-MC-Unique: 7RVJMf-JNrCwWf5nYxZtRA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42129c0b821so27602105e9.0
        for <linux-cxl@vger.kernel.org>; Mon, 03 Jun 2024 08:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427051; x=1718031851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRoQODSdfaihIUPu/mCKgWE6oYbSsy1P8A3UVTHj02w=;
        b=G9oFsDvefMMJ81E26buDsVvGjqeuwoVknObAhGLcJO80D7fT3VhcaMCEnd2iIFMhTF
         oUuAzlzctuzqJLtzM1QkPt+SizvSZwEVCtpWwH87w6ybFgGmHqceeECyH5DY+FdoO0Wv
         MxR1ZmxvZ6soKeTu8CwAb1KYmMdhLpAu4UOanvfenyGJi3HiLAGhnd3pzkYTpnyMOzTl
         gaUI1WZVxn97aD+6MmKN3r8a5ghwh7E+/n2dXCjiu2cKqV3hD+7bGFqK25U6u/FglW+s
         KfH0zqYPxv8YrX7br+hLxUvA5Nu+XP0sODiEjurAQjj9Tps01wN9oNPIM+ROUF6vJS1j
         rzWg==
X-Forwarded-Encrypted: i=1; AJvYcCXVuRDySr28XY7sMV4sKzlNCIkxoPDRf82mPIYb0gtzRdunKSi8+yxLFLs3kuPkh2KY18ix5DfMlYJuxT3Ueghm9xDE3qG9+YxT
X-Gm-Message-State: AOJu0Yzt19GGXZszYvZLc+ROSEQruedkytT74rwBZDDDe49OT+ltW/48
	HNtDfKFMsQRk/Cs4gnDz/48ME7axzCSrzY/UUWt/CHdFGU36pXI11I9w3rUP4o/P4T5aE8CgsV9
	qLRuku+H8Crw6ZqV16oFSoqB63wx2Wq0TsU56BMKhaIqOq087DGrnAvitag==
X-Received: by 2002:a05:600c:4704:b0:421:7ad:daab with SMTP id 5b1f17b1804b1-4212e044c44mr75556195e9.7.1717427050760;
        Mon, 03 Jun 2024 08:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA+VR/uCkbEePCTKkm6g79Vei5e+rGaFUpryu1JWe/HImqNH/IngEu+3Y/wY+oTa3sV26pfw==
X-Received: by 2002:a05:600c:4704:b0:421:7ad:daab with SMTP id 5b1f17b1804b1-4212e044c44mr75555835e9.7.1717427050105;
        Mon, 03 Jun 2024 08:04:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7417:6800:36c9:6b1b:9f6e:56c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b84d66bsm120891535e9.12.2024.06.03.08.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 08:04:09 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:04:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	armbru@redhat.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 08/14] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240603110327-mutt-send-email-mst@kernel.org>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
 <20240523174651.1089554-9-nifan.cxl@gmail.com>
 <20240603132759.00005fbf@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240603132759.00005fbf@Huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2024 at 01:27:59PM +0100, Jonathan Cameron wrote:
> On Thu, 23 May 2024 10:44:48 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add (file/memory backed) host backend for DCD. All the dynamic capacity
> > regions will share a single, large enough host backend. Set up address
> > space for DC regions to support read/write operations to dynamic capacity
> > for DCD.
> > 
> > With the change, the following support is added:
> > 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all DC regions share one
> >    host backend;
> > 2. Add namespace for dynamic capacity for read/write support;
> > 3. Create cdat entries for each dynamic capacity region.
> > 
> > Reviewed-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> >      dvsec = (uint8_t *)&(CXLDVSECDevice){
> > @@ -579,11 +622,28 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >  {
> >      int i;
> >      uint64_t region_base = 0;
> > -    uint64_t region_len =  2 * GiB;
> > -    uint64_t decode_len = 2 * GiB;
> > +    uint64_t region_len;
> > +    uint64_t decode_len;
> >      uint64_t blk_size = 2 * MiB;
> >      CXLDCRegion *region;
> >      MemoryRegion *mr;
> > +    uint64_t dc_size;
> > +
> > +    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +    dc_size = memory_region_size(mr);
> > +    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
> > +
> > +    if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
> > +        error_setg(errp, "backend size is not multiple of region len: 0x%lx",
> 
> Just seen a build error for this in mst's gitlab.
> Needs to be the messy PRIx64(not tested) e.g.
> 
>     error_setg(errp, "backend size is not multiple of region len: " PRIx64,
>                region_len);
> 
> Michael, do you want a new version, or are you happy to fix this up?
> 
> Thanks,
> 
> Jonathan


I did this fixup. If nothing else happens I'll keep it, if more
issues creep up I will drop. Thanks!

> > +                   region_len);
> > +        return false;
> > +    }
> > +    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
> > +        error_setg(errp, "DC region size is unaligned to 0x%lx",
> > +                   CXL_CAPACITY_MULTIPLIER);
> > +        return false;
> > +    }
> > +    decode_len = region_len;
> >  
> >      if (ct3d->hostvmem) {
> >          mr = host_memory_backend_get_memory(ct3d->hostvmem);
> > @@ -610,6 +670,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> >              /* dsmad_handle set when creating CDAT table entries */
> >              .flags = 0,
> >          };
> > +        ct3d->dc.total_capacity += region->len;
> >      }
> >  
> >      return true;
> > @@ -619,7 +680,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >  {
> >      DeviceState *ds = DEVICE(ct3d);
> >  
> > -    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> > +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
> > +        && !ct3d->dc.num_regions) {
> >          error_setg(errp, "at least one memdev property must be set");
> >          return false;
> >      } else if (ct3d->hostmem && ct3d->hostpmem) {
> > @@ -683,7 +745,37 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >          g_free(p_name);
> >      }
> >  
> > +    ct3d->dc.total_capacity = 0;
> >      if (ct3d->dc.num_regions > 0) {
> > +        MemoryRegion *dc_mr;
> > +        char *dc_name;
> > +
> > +        if (!ct3d->dc.host_dc) {
> > +            error_setg(errp, "dynamic capacity must have a backing device");
> > +            return false;
> > +        }
> > +
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        if (!dc_mr) {
> > +            error_setg(errp, "dynamic capacity must have a backing device");
> > +            return false;
> > +        }
> > +
> > +        /*
> > +         * Set DC regions as volatile for now, non-volatile support can
> > +         * be added in the future if needed.
> > +         */
> > +        memory_region_set_nonvolatile(dc_mr, false);
> > +        memory_region_set_enabled(dc_mr, true);
> > +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> > +        if (ds->id) {
> > +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> > +        } else {
> > +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> > +        }
> > +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> > +        g_free(dc_name);
> > +
> >          if (!cxl_create_dc_regions(ct3d, errp)) {
> >              error_append_hint(errp, "setup DC regions failed");
> >              return false;
> > @@ -779,6 +871,9 @@ err_release_cdat:
> >  err_free_special_ops:
> >      g_free(regs->special_ops);
> >  err_address_space_free:
> > +    if (ct3d->dc.host_dc) {
> > +        address_space_destroy(&ct3d->dc.host_dc_as);
> > +    }
> >      if (ct3d->hostpmem) {
> >          address_space_destroy(&ct3d->hostpmem_as);
> >      }
> > @@ -797,6 +892,9 @@ static void ct3_exit(PCIDevice *pci_dev)
> >      pcie_aer_exit(pci_dev);
> >      cxl_doe_cdat_release(cxl_cstate);
> >      g_free(regs->special_ops);
> > +    if (ct3d->dc.host_dc) {
> > +        address_space_destroy(&ct3d->dc.host_dc_as);
> > +    }
> >      if (ct3d->hostpmem) {
> >          address_space_destroy(&ct3d->hostpmem_as);
> >      }
> > @@ -875,16 +973,23 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >                                         AddressSpace **as,
> >                                         uint64_t *dpa_offset)
> >  {
> > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> >  
> >      if (ct3d->hostvmem) {
> >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size = memory_region_size(vmr);
> >      }
> >      if (ct3d->hostpmem) {
> >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size = memory_region_size(pmr);
> > +    }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        dc_size = memory_region_size(dc_mr);
> >      }
> >  
> > -    if (!vmr && !pmr) {
> > +    if (!vmr && !pmr && !dc_mr) {
> >          return -ENODEV;
> >      }
> >  
> > @@ -892,19 +997,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >          return -EINVAL;
> >      }
> >  
> > -    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
> > +    if (*dpa_offset >= vmr_size + pmr_size + dc_size) {
> >          return -EINVAL;
> >      }
> >  
> > -    if (vmr) {
> > -        if (*dpa_offset < memory_region_size(vmr)) {
> > -            *as = &ct3d->hostvmem_as;
> > -        } else {
> > -            *as = &ct3d->hostpmem_as;
> > -            *dpa_offset -= memory_region_size(vmr);
> > -        }
> > -    } else {
> > +    if (*dpa_offset < vmr_size) {
> > +        *as = &ct3d->hostvmem_as;
> > +    } else if (*dpa_offset < vmr_size + pmr_size) {
> >          *as = &ct3d->hostpmem_as;
> > +        *dpa_offset -= vmr_size;
> > +    } else {
> > +        *as = &ct3d->dc.host_dc_as;
> > +        *dpa_offset -= (vmr_size + pmr_size);
> >      }
> >  
> >      return 0;
> > @@ -986,6 +1090,8 @@ static Property ct3_props[] = {
> >      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> > +    DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
> > +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -1052,33 +1158,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> >  
> >  static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> >  {
> > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> >      AddressSpace *as;
> > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> >  
> >      if (ct3d->hostvmem) {
> >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size = memory_region_size(vmr);
> >      }
> >      if (ct3d->hostpmem) {
> >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size = memory_region_size(pmr);
> >      }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        dc_size = memory_region_size(dc_mr);
> > +     }
> >  
> > -    if (!vmr && !pmr) {
> > +    if (!vmr && !pmr && !dc_mr) {
> >          return false;
> >      }
> >  
> > -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
> > +    if (dpa_offset + CXL_CACHE_LINE_SIZE > vmr_size + pmr_size + dc_size) {
> >          return false;
> >      }
> >  
> > -    if (vmr) {
> > -        if (dpa_offset < memory_region_size(vmr)) {
> > -            as = &ct3d->hostvmem_as;
> > -        } else {
> > -            as = &ct3d->hostpmem_as;
> > -            dpa_offset -= memory_region_size(vmr);
> > -        }
> > -    } else {
> > +    if (dpa_offset < vmr_size) {
> > +        as = &ct3d->hostvmem_as;
> > +    } else if (dpa_offset < vmr_size + pmr_size) {
> >          as = &ct3d->hostpmem_as;
> > +        dpa_offset -= vmr_size;
> > +    } else {
> > +        as = &ct3d->dc.host_dc_as;
> > +        dpa_offset -= (vmr_size + pmr_size);
> >      }
> >  
> >      address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index f7f56b44e3..c2c3df0d2a 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -467,6 +467,14 @@ struct CXLType3Dev {
> >      uint64_t poison_list_overflow_ts;
> >  
> >      struct dynamic_capacity {
> > +        HostMemoryBackend *host_dc;
> > +        AddressSpace host_dc_as;
> > +        /*
> > +         * total_capacity is equivalent to the dynamic capability
> > +         * memory region size.
> > +         */
> > +        uint64_t total_capacity; /* 256M aligned */
> > +
> >          uint8_t num_regions; /* 0-8 regions */
> >          CXLDCRegion regions[DCD_MAX_NUM_REGION];
> >      } dc;

