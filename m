Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A411D55F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 12:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BymR253D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D40C6
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 05:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696596739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8n0TI4SHYWR8D0+rFw5ZDTzVGQmlQiFrCFjY/Y1ZyN8=;
	b=BymR253DRkU9RRvqih7PO6rQt+DJtTFs9ov2gC/GPCf9LQ/A3xaNHPqE0R5XxVghn12rnv
	qKGTW1FMReikjiI6NmfqoOqYy6WtAywU+62mEBo2Q+n0IN/C8CXgS2Qqsl0NnKz9MvijfR
	ZzSxIifsmF8mpHgAB+6jnGa1w61byDQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-i1EXxFPiNKCZ5UQ9a-fx8g-1; Fri, 06 Oct 2023 08:52:17 -0400
X-MC-Unique: i1EXxFPiNKCZ5UQ9a-fx8g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32320b9d671so1531352f8f.3
        for <linux-cxl@vger.kernel.org>; Fri, 06 Oct 2023 05:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596736; x=1697201536;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8n0TI4SHYWR8D0+rFw5ZDTzVGQmlQiFrCFjY/Y1ZyN8=;
        b=VzmuIZwKBGuKFAUmM68MpRXqIC1rYRbRNYyABGteRnDBSF+Ady7Me2N0BF9KUUgZ0S
         OemPzLeT3oa4Od9CSujx1Z25YNjM78JEbpw5oj+zur7p7d+jyh/N6v9NSu0+yfU36yi5
         HLsYunE0RzyS43tJ0DbW/uRIi93mI++geZx/5bKUSlPRctFQhbZsUQLF0xpsItk3TpMf
         4vFnO+bYLF3jUV+2zj0xT0OGLtzQnPx2u/L9ZcGl06ywFYQk9By+UwJEKlR4IVeTYwWR
         31PIVIUsOHh2DKnWCfiOtA5bmdt+bqkFslvRrOXecsYEB+f9g+wex/QjCOwFh3goOm5K
         Iqrw==
X-Gm-Message-State: AOJu0YwYfyrbvuI2iYenN3n6VSmsBytA6ayFVe40YmuL7WWhw7KSjlws
	tgDHn/wnu9KI+e10BbwP+prqqBhXftCBBSJplzh81c+b8jLKPJDnyIkqPlNdpgeVa5Mww/iYdQl
	dl8wtjBLU/7tH62REtTlw
X-Received: by 2002:adf:fd46:0:b0:31c:7001:3873 with SMTP id h6-20020adffd46000000b0031c70013873mr7396140wrs.60.1696596736392;
        Fri, 06 Oct 2023 05:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMUjFqwG0bWRjll9bNskCayaIMukTFBBWv6LIwzEtvDAwr4vsLCz67BNLL4G0+qfj7f4GDKw==
X-Received: by 2002:adf:fd46:0:b0:31c:7001:3873 with SMTP id h6-20020adffd46000000b0031c70013873mr7396109wrs.60.1696596735883;
        Fri, 06 Oct 2023 05:52:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819? (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de. [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
        by smtp.gmail.com with ESMTPSA id a9-20020adfe5c9000000b003142e438e8csm1601359wrn.26.2023.10.06.05.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:52:15 -0700 (PDT)
Message-ID: <4ad40b9b-086b-e31f-34bd-c96550bb73e9@redhat.com>
Date: Fri, 6 Oct 2023 14:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Vishal Verma <vishal.l.verma@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Dan Williams <dan.j.williams@intel.com>,
 Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Michal Hocko <mhocko@suse.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Jeff Moyer <jmoyer@redhat.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
 <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
In-Reply-To: <20231005-vv-kmem_memmap-v5-1-a54d1981f0a3@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05.10.23 20:31, Vishal Verma wrote:
> The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is restricted to
> 'memblock_size' chunks of memory being added. Adding a larger span of
> memory precludes memmap_on_memory semantics.
> 
> For users of hotplug such as kmem, large amounts of memory might get
> added from the CXL subsystem. In some cases, this amount may exceed the
> available 'main memory' to store the memmap for the memory being added.
> In this case, it is useful to have a way to place the memmap on the
> memory being added, even if it means splitting the addition into
> memblock-sized chunks.
> 
> Change add_memory_resource() to loop over memblock-sized chunks of
> memory if caller requested memmap_on_memory, and if other conditions for
> it are met. Teach try_remove_memory() to also expect that a memory
> range being removed might have been split up into memblock sized chunks,
> and to loop through those as needed.
> 

Maybe add that this implies that we're not making use of PUD mappings in 
the direct map yet, and link to the proposal on how we could optimize 
that eventually in the future.
[...]

>   
> -static int __ref try_remove_memory(u64 start, u64 size)
> +static void __ref remove_memory_block_and_altmap(int nid, u64 start, u64 size)


You shouldn't need the nid, right?

>   {
> +	int rc = 0;
>   	struct memory_block *mem;
> -	int rc = 0, nid = NUMA_NO_NODE;
>   	struct vmem_altmap *altmap = NULL;
>   


> +	rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
> +	if (rc) {
> +		altmap = mem->altmap;
> +		/*
> +		 * Mark altmap NULL so that we can add a debug
> +		 * check on memblock free.
> +		 */
> +		mem->altmap = NULL;
> +	}
> +
> +	/*
> +	 * Memory block device removal under the device_hotplug_lock is
> +	 * a barrier against racing online attempts.
> +	 */
> +	remove_memory_block_devices(start, size);

We're now calling that under the memory hotplug lock. I assume this is 
fine, but I remember some ugly lockdep details ...should be alright I guess.

> +
> +	arch_remove_memory(start, size, altmap);
> +
> +	/* Verify that all vmemmap pages have actually been freed. */
> +	if (altmap) {
> +		WARN(altmap->alloc, "Altmap not fully unmapped");
> +		kfree(altmap);
> +	}
> +}
> +
> +static int __ref try_remove_memory(u64 start, u64 size)
> +{
> +	int rc, nid = NUMA_NO_NODE;
> +
>   	BUG_ON(check_hotplug_memory_range(start, size));
>   
>   	/*
> @@ -2167,47 +2221,28 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   	if (rc)
>   		return rc;
>   
> +	mem_hotplug_begin();
> +
>   	/*
> -	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
> -	 * the same granularity it was added - a single memory block.
> +	 * For memmap_on_memory, the altmaps could have been added on
> +	 * a per-memblock basis. Loop through the entire range if so,
> +	 * and remove each memblock and its altmap.
>   	 */
>   	if (mhp_memmap_on_memory()) {
> -		rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
> -		if (rc) {
> -			if (size != memory_block_size_bytes()) {
> -				pr_warn("Refuse to remove %#llx - %#llx,"
> -					"wrong granularity\n",
> -					start, start + size);
> -				return -EINVAL;
> -			}
> -			altmap = mem->altmap;
> -			/*
> -			 * Mark altmap NULL so that we can add a debug
> -			 * check on memblock free.
> -			 */
> -			mem->altmap = NULL;
> -		}
> +		unsigned long memblock_size = memory_block_size_bytes();
> +		u64 cur_start;
> +
> +		for (cur_start = start; cur_start < start + size;
> +		     cur_start += memblock_size)
> +			remove_memory_block_and_altmap(nid, cur_start,
> +						       memblock_size);
> +	} else {
> +		remove_memory_block_and_altmap(nid, start, size);

Better call remove_memory_block_devices() and arch_remove_memory(start, 
size, altmap) here explicitly instead of using 
remove_memory_block_and_altmap() that really can only handle a single 
memory block with any inputs.


>   	}
>   
>   	/* remove memmap entry */
>   	firmware_map_remove(start, start + size, "System RAM");

Can we continue doing that in the old order? (IOW before taking the lock?).

>   
> -	/*
> -	 * Memory block device removal under the device_hotplug_lock is
> -	 * a barrier against racing online attempts.
> -	 */
> -	remove_memory_block_devices(start, size);
> -
> -	mem_hotplug_begin();
> -
> -	arch_remove_memory(start, size, altmap);
> -
> -	/* Verify that all vmemmap pages have actually been freed. */
> -	if (altmap) {
> -		WARN(altmap->alloc, "Altmap not fully unmapped");
> -		kfree(altmap);
> -	}
> -
>   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
>   		memblock_phys_free(start, size);
>   		memblock_remove(start, size);
> @@ -2219,6 +2254,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
>   		try_offline_node(nid);
>   
>   	mem_hotplug_done();
> +

Unrelated change.

>   	return 0;
>   }
>   
> 

-- 
Cheers,

David / dhildenb

