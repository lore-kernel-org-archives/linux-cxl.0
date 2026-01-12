Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BB3815C1
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242304; cv=none; b=GiG7vni6bk6TEUegatc/qDBJTl7jk0LRm1oZvTF6/f+FoOHeQMG/WZV4yZhKe0RbiL8jTfe4X6M49yb/e5NaWCLvvM4VY3yvU2faVNlWc9UUJVRuzaxY+tj0+GlFU29qUuXiWfGaMicsIQi8+UB/IOXdp4h/byeIoubmJbs/t64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242304; c=relaxed/simple;
	bh=zGOveUJBSydj6+f1Ng48sG1u8gGyaZbL+TtCvCFhQyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnG932qo68+ENBVgoEUppxL91tGkP029jI+lGrjL8amFpZNBv3tNp3iiJNPPIHEiY+tXBV3wYq2/VALYbK9lL/BBK9SamjW4VNtP5LeGzzZymZvz0QnrCbgRf2DcmT4V7+xKNA34Q8KBIShIrEJD3YS09B6ZE9b8BHVIt8OthOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X5yKzpec; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X5yKzpec"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a3d2f3299so80170586d6.2
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768242301; x=1768847101; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jdD8MqriJAO2uyiGLSo7KkiIHx3VWLqLd6aNoF+yCm8=;
        b=X5yKzpec7drmkLwczvotHIEs/RFApJJlDqIJrFABBm597UK3AtaxvQmn7L2a0gqWKc
         I/NFZxdnyIaTbC1Vnp/3JAbp5EmAJ7M8n7mARHPlcAzRHyAVAOy0yiNrY8gYYVasf9Tj
         PlJTnC56YVduwV5Lp8XP+YXgJc0YwfBy7HiTFEK/9Tvdgckp/FVA/6LMe38MGRGVB5UR
         TGatHKQS0Uv303CYzW8psHNHBHcp6W5jklx+95Bxkjz0SIbj/9B1G9xvzGWSez2Vn69u
         KtqwdsV7eEcss5kCDA4kzPztcm4yrV3fCxxALKK7lXuPZJX3/dzMJhNYYhirMp19EJj4
         rMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242301; x=1768847101;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdD8MqriJAO2uyiGLSo7KkiIHx3VWLqLd6aNoF+yCm8=;
        b=Pc5c697d2tIK1ePzE/rAAfZCb0V4t/4QRcQRVH5uaWjLY/7wsfssYpd5WrOXTnNZz0
         NKDRSK8DTjZii5E3Sa37h0p43TrYOzc5yhFZjiYxbU60+j09mZiZtD2Mp+r3EUJ+x2yx
         RsLAvXS/TBIxpG/prpP0IJE3rTPXIe0wLXXU5WYVC57XXDMOTdpMvylKlrH+g7DDzx3k
         KmJZl2rrETrFXq5KpmcvjuYOtSmvxrczRPabV8Y7egpwrkCeJW1l3FAldVDtp5jsMVrU
         yxIkd5egQN/oYttgG7Up/LIR9wbcRqY5jYtVSONx7pymS0JVTn+xc7sEVJ/cqZvAxLqI
         xnHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNqCcpsE+/iZtZ2pgq1y8DGCmVBnxcHJMPH8+Z1EbMttzC7ueLE/0WA/Nq5qpgES54paCiELykidI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsCBqGPDHoDP7sPUG2C4i6Nyvq05kQIuzGQENH8Z0ZeBNp0y+
	4P885wBPpkYbjyQMIYq8ue0WqqCXUKVrtE0JQSACX6DHbdvluwXUQUiNlsH+xN+D1aA=
X-Gm-Gg: AY/fxX5XngipO9Bwc7YpwrvIo8NobbYSuKAia6Ixl9ytx+eQbIFMv8Chga0NKLTasGx
	8pXftVWcBKOFO32SQHk2zPmT5cn/0Zn2kHQpfCZ5T3VY+7jN7vGBtoNYa67WKCtjuiGy6E9oAvn
	EtQ8Cn6gxNRohgAbjZ/0pZ2n+y/IwgYEnhdoMk9pF2Sz6MkFgqJi7h2yMZitkBRnTqUI+QuOPtb
	at+J9MTgl07Bsrm7HRDfHx9sfe+Os9VcHOt7a9IkWfcQhArZPKf2KdX5FqLHWtz8HGyKukDOr7W
	YWIBWihNEeSIL0T8H3GifkepDloUPf3d5Z9wIZSOMhsd++5PeDxPIXKitRDcTNkMkcXCC+x+7Rv
	b4DR0mKCZZcZXVgJswkLHOx+mey8c+hEGxdWWUlmzhNxw9T/jlhin1Fb26BTNY1ubqliebCOfv3
	10JIutWnPiBGNpSAX20wbKzfmIPolxwf0shPRm09R9aM6d8XKcgKBpdkA9ZpnKEzeckRU=
X-Google-Smtp-Source: AGHT+IGn2SBiEVfPnYP4nrga1XlmOOc9x/h3J7lqU+usVoOUoaNofJJs2v26tTONjDwmwZ1AsmIeFg==
X-Received: by 2002:a05:6214:428e:b0:88e:9f73:2c08 with SMTP id 6a1803df08f44-89084179da3mr258471116d6.5.1768242300986;
        Mon, 12 Jan 2026 10:25:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770ce985sm138366276d6.11.2026.01.12.10.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:25:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfMb6-00000003SfZ-05E0;
	Mon, 12 Jan 2026 14:25:00 -0400
Date: Mon, 12 Jan 2026 14:25:00 -0400
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
Message-ID: <20260112182500.GI745888@ziepe.ca>
References: <20260111205820.830410-1-francois.dugast@intel.com>
 <20260111205820.830410-2-francois.dugast@intel.com>
 <aWQlsyIVVGpCvB3y@casper.infradead.org>
 <874d29da-2008-47e6-9c27-6c00abbf404a@nvidia.com>
 <0D532F80-6C4D-4800-9473-485B828B55EC@nvidia.com>
 <20260112134510.GC745888@ziepe.ca>
 <218D42B0-3E08-4ABC-9FB4-1203BB31E547@nvidia.com>
 <20260112165001.GG745888@ziepe.ca>
 <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86D91C8B-C3EA-4836-8DC2-829499477618@nvidia.com>

On Mon, Jan 12, 2026 at 12:46:57PM -0500, Zi Yan wrote:
> On 12 Jan 2026, at 11:50, Jason Gunthorpe wrote:
> 
> > On Mon, Jan 12, 2026 at 11:31:04AM -0500, Zi Yan wrote:
> >>> folio_free()
> >>>
> >>> 1) Allocator finds free memory
> >>> 2) zone_device_page_init() allocates the memory and makes refcount=1
> >>> 3) __folio_put() knows the recount 0.
> >>> 4) free_zone_device_folio() calls folio_free(), but it doesn't
> >>>    actually need to undo prep_compound_page() because *NOTHING* can
> >>>    use the page pointer at this point.
> >>> 5) Driver puts the memory back into the allocator and now #1 can
> >>>    happen. It knows how much memory to put back because folio->order
> >>>    is valid from #2
> >>> 6) #1 happens again, then #2 happens again and the folio is in the
> >>>    right state for use. The successor #2 fully undoes the work of the
> >>>    predecessor #2.
> >>
> >> But how can a successor #2 undo the work if the second #1 only allocates
> >> half of the original folio? For example, an order-9 at PFN 0 is
> >> allocated and freed, then an order-8 at PFN 0 is allocated and another
> >> order-8 at PFN 256 is allocated. How can two #2s undo the same order-9
> >> without corrupting each other’s data?
> >
> > What do you mean? The fundamental rule is you can't read the folio or
> > the order outside folio_free once it's refcount reaches 0.
> 
> There is no such a rule. In core MM, folio_split(), which splits a high
> order folio to low order ones, freezes the folio (turning refcount to 0)
> and manipulates the folio order and all tail pages compound_head to
> restructure the folio.

That's different, I am talking about reaching 0 because it has been
freed, meaning there are no external pointers to it.

Further, when a page is frozen page_ref_freeze() takes in the number
of references the caller has ownership over and it doesn't succeed if
there are stray references elsewhere.

This is very important because the entire operating model of split
only works if it has exclusive locks over all the valid pointers into
that page.

Spurious refcount failures concurrent with split cannot be allowed.

I don't see how pointing at __folio_freeze_and_split_unmapped() can
justify this series.

> Your fundamental rule breaks this.  Allowing compound information
> to stay after a folio is freed means you cannot tell whether a folio
> is under split or freed.

You can't refcount a folio out of nothing. It has to come from a
memory location that already is holding a refcount, and then you can
incr it.

For example lockless GUP fast will read the PTE, adjust to the head
page, attempt to incr it, then recheck the PTE.

If there are races then sure maybe the PTE will point to a stray tail
page that refers to an already allocated head page, but the re-check
of the PTE wille exclude this. The refcount system already has to
tolerate spurious refcount incrs because of GUP fast.

Nothing should be looking at order and refcount to try to guess if
concurrent split is happening!!

Jason
