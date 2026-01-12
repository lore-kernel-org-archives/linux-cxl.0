Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2C36CE03
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236606; cv=none; b=arjBRp66bzZSRE+0mDTLma8ig31qrzWLsCYd86Vw0sNh5AgZ4fZlZ+ds5SeDfSK4Feovngu5z/exFl3OGlAvKDcPTa2G/N2LrqIh1Kyw/LS7pA/xJVpssO9ghITyXlRRfYWQHA9CslBhdgoM5VxrkCXclUJrXLUv0eD0Mqhc95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236606; c=relaxed/simple;
	bh=tqjQya8iav+U2F1Y8sTA4RoO8FG8N5ZbxkqeKQhKHMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J13p7BjrMRvDO3DQdZAlo0c/S4z76CZRjezaXBOslMg4f5HtFddZk6D9O5LHKT9I2UCO2UKmP+Z5OwC3tEs7jBRLVcBEcDBeourzmaePKnkHoPyi4cDpqvXtR2keWcucgJiRPu9tKILMSBaJPvAnHctIsVj8bhuavsyAUcohxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xh28jBuC; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xh28jBuC"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4f4a88e75a5so64430481cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768236603; x=1768841403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eAxh70JY3ShLNfnDxBWsRZWpalCHcaRfsM5YzKZ+W9w=;
        b=Xh28jBuCzSmjNImJHPipMhJ0Ay7bk672VmA9OuRlRS5xHW5yOjBQoqGrHp/AwF81rB
         U4wbU+uoNLx2hWjU7U4zq3tWfLHjExnBD0S2eQKaomwC1k6Re30nBI8pSTT4ZUFwDXtw
         NB+3sqspu7NHXnhnH1vGI97i4pjAI57Tck8NM8TbREST9HEQAuFfCqITWgCnp0IvR9fK
         +ZdAosDXqrYrMVZd4ILWmB9i07jlSbP6DyIB9yxkaOjGqB4aGN22b/QWCSygCzJpyPQe
         W6fEtrLRoKz3QtzuKuqh5mJBRVgPzcZzMRv1SZTKdpfxUsRxAxwrExm1lW+TsFUPDzah
         L4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236603; x=1768841403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAxh70JY3ShLNfnDxBWsRZWpalCHcaRfsM5YzKZ+W9w=;
        b=ZbKBM88nBf37E97VbhinFmmIUVbAMh9KA17SitjoFzc9De8LzljCqHNDJcctxrzJ9m
         w81GZXrZ3KhadqPEyr08LmXVu6niLF047OEjhRp/xLRkX0iyZ3Lgso0RjFQJcGNnZz81
         yzkPYy+X8uwMeqER7UVdwla/fjrm55WUHfYf8Wf9MspdxNssetS71u48dJVy+/vnFQcR
         hTxZMbaL/PfSkJ6M/QNaDeBbkYAqevt+fnyhdcj5OgW5ff7h1KOURWbaQUxKdZ3eiysx
         moRLC1mGRJyC18RM4j7k/SHGV016FPvYloWFsWr68ut+FaebmNrvGGyLkPj0XLTdNYPS
         13Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV3e9UlsYD6WMmm00UFROu+8RLJBKoOkPjpoLIdt1z/9Mor+WXY8nz84QkguIUI4W3xnMgNfZab27c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykfdjn1urKrtNYYkFv+i+OpVdt6J1wW8L0GerX5dLLWD32OLpK
	QxJYgU6ha+S92trFnIL85AK49UPXKPpApuLl+Hr7mBdsruubtjGBgy6GI9KaaMWu8fk=
X-Gm-Gg: AY/fxX4tHlWgOQDjA+9aRDvn/7UQq9RW6XaYmCkjjw4Wae0PxLLv9/32O0JyRHxTXS/
	tPhZY64JANc3ibUOagwGmJPeETwteLVbchGvFLBgokqj1r6wZ9GgipujYuAK3HIY9U5tM7rIvvT
	pHd28Q1c1+Y8WyA6ObH3JHUoTyADbKA4i9HcAoZrpJDXQhQ+jwhkt62GcVTcCEd7G9DKDo1ZxEi
	JUEbt4VS5Sq92sIYAWoo+MXUFb7eErsjUjgyuZylrRxJURdcgqtKC9M+jO5ZdcPMamUJTNPUDyz
	3U4s0iQG7mKP8+ZFvsa4+nFLKf4E2hsB1S4ZgNYSkK6xwWWt9gSCQ6h6n9pRrNZq7gC66rMItV1
	PPvCQi6HisEF8l9CHWkBCIcqbNF5jYwHOQ79JVYQZkIOIQmEbkhNKrSPpsh3ybKpCZdC/4BJgKs
	kgs7FtNF1tA25HGb1WcDCVvl14Cu3EIw2yQUrMfm74tEJziXkasSP5vSufDggdQvdYpLI=
X-Google-Smtp-Source: AGHT+IE/A98Uf8f6ySXPvh9xamBlLANpUoYS4iXttzp8YDJn905I/7mcjcPxPkNVMXbRPnmf8UaJPg==
X-Received: by 2002:ac8:6f1a:0:b0:4ee:208a:fbec with SMTP id d75a77b69052e-4ffb4a1ed32mr255276771cf.66.1768236602551;
        Mon, 12 Jan 2026 08:50:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm139285396d6.43.2026.01.12.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:50:02 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfL7B-00000003RcK-2R9k;
	Mon, 12 Jan 2026 12:50:01 -0400
Date: Mon, 12 Jan 2026 12:50:01 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>, Balbir Singh <balbirs@nvidia.com>,
	Francois Dugast <francois.dugast@intel.com>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Matthew Brost <matthew.brost@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alistair Popple <apopple@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/7] mm/zone_device: Add order argument to folio_free
 callback
Message-ID: <20260112165001.GG745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>

On Mon, Jan 12, 2026 at 11:31:04AM -0500, Zi Yan wrote:
> > folio_free()
> >
> > 1) Allocator finds free memory
> > 2) zone_device_page_init() allocates the memory and makes refcount=1
> > 3) __folio_put() knows the recount 0.
> > 4) free_zone_device_folio() calls folio_free(), but it doesn't
> >    actually need to undo prep_compound_page() because *NOTHING* can
> >    use the page pointer at this point.
> > 5) Driver puts the memory back into the allocator and now #1 can
> >    happen. It knows how much memory to put back because folio->order
> >    is valid from #2
> > 6) #1 happens again, then #2 happens again and the folio is in the
> >    right state for use. The successor #2 fully undoes the work of the
> >    predecessor #2.
> 
> But how can a successor #2 undo the work if the second #1 only allocates
> half of the original folio? For example, an order-9 at PFN 0 is
> allocated and freed, then an order-8 at PFN 0 is allocated and another
> order-8 at PFN 256 is allocated. How can two #2s undo the same order-9
> without corrupting each other’s data?

What do you mean? The fundamental rule is you can't read the folio or
the order outside folio_free once it's refcount reaches 0.

So the successor #2 will write updated heads and order to the order 8
pages at PFN 0 and the ones starting at PFN 256 will remain with
garbage.

This is OK because nothing is allowed to read them as their refcount
is 0.

If later PFN256 is allocated then it will get updated head and order
at the same time it's refcount becomes 1.

There is corruption and they don't corrupt each other's data.

> > If the allocator is using the struct page memory then step #5 should
> > also clean up the struct page with the allocator data before returning
> > it to the allocator.
> 
> Do you mean ->folio_free() callback should undo prep_compound_page()
> instead?

I wouldn't say undo, I was very careful to say it needs to get the
struct page memory into a state that the allocator algorithm expects,
whatever that means.

Jason
