Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792699803;
	b=laaWzF1bwB8/1OqyIimwYX0PKxYPZvyqYlzOWy4/V+WYRhZjqWMDuYHyNGF7SgYDY+cQ
	 UgoSf0gW4OIGbRcFsjjii1puu6vZFp3CQSnGSG+xVqzxPtg8Mukt14yr3TeOisAuLCguB
	 5aHnHBO0ThU4GdZ7GPMRks/1z4uSPs9lERYPrmYdVugaV1pjt8GUQtXoMXHbWNzXPNELo
	 /la1ujuoNlOImCXGD7d2FBcz4GMA9ll1Wr64o918ecJF6c0kvhevGNX2fh8D/OLsHSFty
	 MHLqOD7IKXVqPlG5/C/x8KBE1W/PkcWyLSB3GeZAc8QiOGtI+sVPyGNKSlUM2Jl66zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792699803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=C21jdElIWwsssKLBUPwYkC+7CgwOgr8UZ/ugVKG2QZM=;
	b=xxkW4QipTBRtoKwNdMUFWlc954UCp5fBhIjUOApuIKtvI8bXH4wJUQwzvnKn1o5k7L0X
	 caHKZzvmCtIJO+M3VNm2PdM4HP4B5VdCsD+oCBvuRl6VbFUcntSMRmCBH0SN0ubTX4qtP
	 jg2DLmz6sTMQ3iKqoca92KLmy0rgoEb2z8vl2p5uHh6qtcV6ZyHUIwc8DBCUHADaO/nvI
	 wZ/peEqcvGeAvCWL0dv3NgSJOVMr0ghbtw815t3TTB668pS8S6MZQjiSFeWBufYk6053u
	 +mTwRyiMYPjRN4MGRSvpSOtMtblBVPoB02scc918AvxIbq6TdYQM3SRrl6YXP4OoxyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JWtJF8Em;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A20606A31D
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 20:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A20606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JWtJF8Em
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so313465eec.0
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 13:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792699801; x=1793304601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C21jdElIWwsssKLBUPwYkC+7CgwOgr8UZ/ugVKG2QZM=;
        b=JWtJF8EmTLaoMIcJ5JR49qO1oLuyWkiHbD/PciaxmpdX2j/NAldHoarkuUB9lMF8yH
         YES8RA7P83FCdnOaNxxbb/Af/WdrbibmiElyNhLtA8FTal5fNLixygmyzP/BrptgvCdy
         QZ/VyntXtsiHnUrQW5N6O89LEScz97z0P86m0sG+EBtKyL2VJwDJ0aXQfJCxWGNNnIbR
         WcdKuuKV2MwpSyWjIiBVXmIVIEhHu6OcB7oBB/9tzitC2err/6DzZEPm39drXF/vYJD1
         zIFEEso0OGOOWuPJoQ3SlEa4HwO854xmZNy0AXRp+P43Q9EnL4gn/3wAQN6mFSXcj+nh
         YLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792699801; x=1793304601;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C21jdElIWwsssKLBUPwYkC+7CgwOgr8UZ/ugVKG2QZM=;
        b=dg6SXsfFhnFgNm4Su0TK88H4rcPiIfui6Hr/KGxjnYaHUc0tF6E4/FacU3i1yK+eBV
         cHo9zPH6hCV5V1n/SZYgBMb8H0XAo+RpWzI1bGrERGzOLiC70FKoZJTgktD5G+H55GnJ
         hQkp74mY0Ok9q6UFnN/BspBGQ89KjHZybVrp+ZNPAThEiwU6orQ2fzaN3evb5jeTwMyo
         hZU92IJZeF9N0abkpD7rgEqg2OpNPR1NE+FP5jkj9uX81uylr0d7+Ejdxm0nMbzM4K55
         As3TntUq7LWU1X9Yhq6J03J7s3dTtoWraX7cK7JyLoFsZp521lhjhlvyctURpbhCHlPj
         jSSg==
X-Forwarded-Encrypted: i=1; AKwUvBw1NeJx+nX9cgGr/+2GLjRdD13n9WGb+TlSlnMoD/swXvkrU5QfRqGXHvI7f6Oeyqt75AQj/q2HSls=@vger.kernel.org
X-Gm-Message-State: AFq9FYKi4GiDYhhW5udotKrlzW9mQTmTeHrm12AfrmYdm67PT7EwMeY8
	wPLr2+npORw7o2igsURKCsKQECAOMpg1cyZTY471qeeQBHj9p5zZyd/P
X-Gm-Gg: AYBFou37cKb2IWmeh+ePK02VZ8LFxUgO/FjPekpfrf0/XRIKgy6xElvz4jZY/qldz5d
	l9pQkVkE7CZKBbUMK9VrmdxBJ3PmLCtX5YPPFRZu+clH+GTUY9Tkj07xhwSLgSzBzBE/51nXEXN
	UmZtSBLy4h2mptW+jLEXpDdP1OFd6qs5ROaIIsfqOVb26D54B5EyQ+PyvftziqLLTjku1SkVBx9
	9xxfP35VO+vd3lEWPBh2FW/Jm2cJfJjj7Qyi8ErEOG8ThloA8rQohI8nS95plDPn9XfokYP079n
	hJNsPTNSj2EsMh+hJBGzYgZts4VXpUE++HjDzEMYZD2irBfBgxeyToiBKOG0QCgnWTD6MMuJ0MD
	bZQpQhyOwNPoozFzyDPEEenW2xde0lQ+mmWC6etooJYduluFQn3Cz0Y9/dfXLrWQ6MY3oyQH5rL
	ExbGeQuKVxAJyADV163iL74nN+hZVmlAfjmsWBsJ/rwo0ipLaUnAzdaBRdZ/3nK8+XsH6dv1dXH
	XyIPYkPq4lagTsNURRJTBQ+4lYhqxTiKa5zvwEvHL2xDOONUBNLIgy3F0KlQ2/fRQ==
X-Received: by 2002:a05:7301:650b:b0:360:c266:cdd8 with SMTP id 5a478bee46e88-369d982e719mr358462eec.24.1792699801138;
        Thu, 22 Oct 2026 13:10:01 -0700 (PDT)
Received: from localhost ([2409:4062:2d82:947a:d2bd:526:9310:d9af])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9e180f6sm160737eec.28.2026.10.22.13.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:10:00 -0700 (PDT)
Date: Fri, 23 Oct 2026 01:39:56 +0530
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Richard Cheng <icheng@nvidia.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>, Harry Yoo <harry@kernel.org>
Subject: Re: [RFC PATCH 4/5] mm/page_alloc: Keep pre-online poison out of the
 buddy allocator
Message-ID: <atptlI4Pstd70N9u@acer-nitro-anv15-41>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
 <20261010162017.62506-5-shaikhkamal2012@gmail.com>
 <atB-cL8x5CSMOHEP@MWDK4CY14F>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atB-cL8x5CSMOHEP@MWDK4CY14F>

On Thu, Oct 15, 2026 at 03:27:54PM +0800, Richard Cheng wrote:
> On Sat, Oct 10, 2026 at 09:50:12PM +0800, Shaikh Kamaluddin wrote:
> > The inherited-poison path checks initialized blocks before releasing
> > them to the buddy allocator. CXL device poison discovered before
> > hot-added memory is onlined is recorded separately in the pre-online
> > poison registry.
> > 
> > Extend __free_pages_core() to send a block to free_poisoned_block() when
> > it intersects either poison source. In free_poisoned_block(), withhold a
> > page when its PFN is registered as pre-online poison or its physical
> > address is present in the inherited-poison table.
> > 
> > Pages identified by either source continue through
> > hwpoison_boot_page(), while clean pages are released through
> > accept_and_free_block().
> > 
> > Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> > ---
> >  mm/page_alloc.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cca67a2702a4..57843df01b2a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/cpuset.h>
> >  #include <linux/folio_batch.h>
> >  #include <linux/memory_hotplug.h>
> > +#include <linux/memory-failure.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/vmstat.h>
> >  #include <linux/fault-inject.h>
> > @@ -1601,12 +1602,14 @@ static void __meminit free_poisoned_block(struct page *page, unsigned int order,
> >  					  enum meminit_context context)
> >  {
> >  	unsigned long i, nr_pages = 1UL << order;
> > +	unsigned long pfn = page_to_pfn(page);
> >  
> >  	for (i = 0; i < nr_pages; i++) {
> >  		struct page *p = page + i;
> >  		phys_addr_t phys = page_to_phys(p);
> >  
> > -		if (range_contains_poisoned_memory(phys, PAGE_SIZE)) {
> > +		if (range_contains_poisoned_memory(phys, PAGE_SIZE) ||
> > +		    preonline_hwpoison_contains(pfn + i)) {
> >  			hwpoison_boot_page(p, context);
> >  			continue;
> >  		}
> > @@ -1652,7 +1655,8 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
> >  
> >  	/* First: a block parked by __free_unaccepted() never returns here. */
> >  	if (range_contains_poisoned_memory(page_to_phys(page),
> > -					   PAGE_SIZE << order)) {
> > +					   PAGE_SIZE << order) ||
> > +	    preonline_hwpoison_intersects(page_to_pfn(page), nr_pages)) {
> >  		free_poisoned_block(page, order, context);
> >  		return;
> >  	}
> > -- 
> > 2.43.0
> >
> 
> Hi Shaikh,
> 
> I think the idea of discovering device poison first is good, but the boundary
> should be more strictly designed.
>

Thanks for the review, Richard.

> Now if I don't get it wrong, if we turn on memory_hotplug.memmap_on_memory,
> we can have part of CXL memory to do the bookkeeping for itself, without
> using the existing RAM.
> 
> What if that bookkeeping part is poisoned ? the check ignores this situation
> right ?

Yes, you are right. With memmap_on_memory, each 128 MiB block's struct
pages are placed in its first 2 MiB (0x200 pages) by vmemmap_populate()
when the memory is added, and memory_block_online() then onlines only
start_pfn + 0x200 onwards. Those vmemmap pages never reach
__free_pages_core(), so the registry is never consulted for them.

I reproduced it in QEMU 9.1 (TCG) on next-20260908 + [1] v5 + this RFC,
with two Internal poison records in the first block: DPA 0x100000
(PFN 0x190100, inside the vmemmap area 0x190000-0x1901ff) and DPA
0x400000 (PFN 0x190400, outside it). Both are registered, but only
0x190400 is withheld.

Steps:

1. Config: CONFIG_SPARSEMEM_VMEMMAP=y, CONFIG_MHP_MEMMAP_ON_MEMORY=y.

2. Boot with memmap_on_memory, without auto-online:

   vng --disable-kvm --run ./arch/x86/boot/bzImage \
     --disable-microvm --memory 4G --cpus 4 \
     --append "memory_hotplug.memmap_on_memory=1" \
     --qemu-opts="-machine q35,cxl=on \
       -object memory-backend-ram,id=vmem0,share=on,size=512M \
       -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
       -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
       -device cxl-type3,bus=rp0,volatile-memdev=vmem0,id=cxl-vmem0 \
       -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
       -qmp unix:/tmp/qmp.sock,server=on,wait=off"

   # cat /sys/module/memory_hotplug/parameters/memmap_on_memory
   Y

3. Inject Internal poison over QMP (host):

   { "execute": "cxl-inject-poison",
     "arguments": { "path": "/machine/peripheral/cxl-vmem0",
                    "start": 1048576, "length": 64 } }
   { "execute": "cxl-inject-poison",
     "arguments": { "path": "/machine/peripheral/cxl-vmem0",
                    "start": 4194304, "length": 64 } }

4. Create the region with kmem not yet bound, then enable
   memmap_on_memory on the dax device:

   # grep MemTotal /proc/meminfo
   MemTotal:        3999996 kB
   # echo 0 > /sys/bus/dax/drivers_autoprobe
   # cxl create-region -m -t ram -d decoder0.0 -w 1 mem0
   cxl_region region0: withholding 2 frame(s) reported poisoned by the device
   # echo 1 > /sys/bus/dax/devices/dax0.0/memmap_on_memory

5. Add and online the memory:

   # daxctl reconfigure-device --mode=system-ram dax0.0
   # lsmem
   0x0000000190000000-0x00000001afffffff  512M online  yes 50-53

6. Result:

   # grep -E 'MemTotal|HardwareCorrupted' /proc/meminfo
   MemTotal:        4516092 kB
   HardwareCorrupted:     4 kB
   # tools/mm/page-types -a 0x190000+0x20000 -b hwpoison -l
   offset  len  flags
   190400  1    ___________________X_______________________

MemTotal grows by 504 MiB rather than 512 MiB (4 blocks x 2 MiB of
memmap), so memmap_on_memory was in effect. Only 0x190400 is
hwpoisoned; 0x190100 holds struct pages.

> 
> What about draw a clear line between normal RAM and hot-add CXL memory, have
> the latter gone through the thorough check and do the rest you want ?
> 
> Best regards,
> Richard Cheng.
> 
> 
> 
> 
> 
> 
> 
> 
> 
>  
