Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794065539;
	b=XX/w49pdh8sKT7GPufQTg6DXh3vAR6rqndkja+0et2Rmfu+oKy40+Meaa9axR0TmdixB
	 jtQBYFhubiKY52BpjVKeWN7XVito51vGpDWLo4ADbRL8sCdM+igYZ3SChanp95NuNaMtO
	 Rmq2QxPDe+pUdauzLcESLAEduX/2j7fMggC3ox2ACtl609UbTdeTqkQXx4MdXGDBJFOVn
	 J64LwiOWTNz8h/NSsKMgGU7o7FnHuqB/TMo7lG6P2VnBL/38LSebR9prIx39Hff4xHB2C
	 GlJ73kTmfzz1yj9VDCiJtk7IHwCXk3NPWZLwss5Vg9GYKILnqlZ5SZEqgM8Golj2Ugg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794065539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=h9qrf3usAaOwgzXqixygncZskN/jLmTci4sgLtHQbO0=;
	b=cYpyadSuD8unjfhZqCXbFniwNKGpQIUpJXlM5XRvPvVPtGPLKL3Ny5FSOpKDs9B8/WfE
	 tWrfNGU81uJX28QcxYV4+FZRfuErL77HvC9b4DgYr6W49iCoWM1HMu/DRtgfPFeLQimqJ
	 zDqqobrIKsXvhFYn2j15HaSyuNoPLmZGBsdx/bAj6csIzEFw7Kd7N3jzrd0BSUjCSDFmy
	 Xwg2uSpou1Y9/pcXmI9aoAT3mj9QKEiH9/ub+xfEG//VC0HGbIzCAVY0dhaS4Cbfn8bFG
	 aAYec53t9e4kkYuEBG9Vasf1cpjXuXwOE+VTyuuLCpSqcY4OQxwpZ5I1J8iJxJKeslQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StC8GkOb;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BDD606D811
	for <linux-cxl@vger.kernel.org>; Sat,  7 Nov 2026 15:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33BDD606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=StC8GkOb
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b244fb7fffso2331421c88.1
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794065537; x=1794670337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h9qrf3usAaOwgzXqixygncZskN/jLmTci4sgLtHQbO0=;
        b=StC8GkObXOPovW6dCCpZINGOP0R1kjXprhhWWq5fPpUEhvr4wUtsYEODvYcP+O6RDF
         hP3YVpPvAKvITBAIpnsTw9rhMIV2tzNQmB2sC7IcX/9x/4hUAYJ3qjegaxXWIQDaw7zW
         CMUj+QAq6ge4eE696TvHKImmgElzpqTHHNhjM+wsPeUc7o295uyJH4ODdsDtYHN1C4zu
         blcNOG9tqNSl94tYhMY6vqO14vWCG8YBBR9BrpXKpiO5vgzQpLLe1pwvh1SSXA/xNGFZ
         o/1lGJaeehJH5xzzDnTjxJTRCMXTEMr1FVsoacTQDTOQN/Zlb4BVYP6eq78dmeDIHbLO
         4HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794065537; x=1794670337;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9qrf3usAaOwgzXqixygncZskN/jLmTci4sgLtHQbO0=;
        b=cos5FLMxTxKhxLjeEyqQp0TXfXBGuCEVuYklAbikxbgsfr0HuQpWKfO0yVNBs5GKr2
         5DBuE+5m5eQVemC4Sw/xtOEQjsja0y77RfV2rvFESWABHk+x398OCCW0cJuXPh/dHyfO
         PbME6ZZK1h90uAFKRSEGVR3XJpBTFCp+Aly71iIORH0+IoHItYh3bzjkSDFqLEcm88Uz
         9pLZ/Nd86cfsSj7tLVV8ZyyY/lySVNgfl83m5lsoF0y7QbNIy/pkZOQAK2RzDML3itro
         ohly11Fha6kJw4B3p9c1LMWNCyCvr8dOd/xYlcl28vrodf8zaB+7E1VFUMCDHyi6YfEj
         Vetg==
X-Forwarded-Encrypted: i=1; AKwUvBy4U10dJj6H+9l+4okLY8/UXLSbw9ClATZ6CX3/WjjiS9q4sKV2/F0PnawGqFPb3lYBRua+K0mLtaQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OTJrPFXDJFEVSeAWxEwcAaqDs0eNjk8ltIfUJAxZknEMZLNHX
	+muyHV8yov7vZ3jxwarz0iXPk8uCQjtcRm62PH/7KUneZ3BKeen6D0Ph
X-Gm-Gg: AYBFou3ENiBKe9Q3DQdGX8my0k/MFDorNbUXQBPkxlWvTtdzQLOiMjxk53Q49epWFHC
	X/nBpN/5lhe3CjUMG2SwKBO1003X8DgTMHHHU8coROwomKqUW/G0hWExLFEu+7oTr2m//WvJO0g
	MjC0Yig6OGvRqOU+8K908OlHEkfgQa2kOGafWDhPHTdIw3kY3Tg0Oug09eRjXUvS4MGUdgYqfT9
	eCA8qpBIFxVxsKeorTTIMtBOsfn8z79tIaKznMIVVOuTcyGqthprMgeR2u/GIFO2lG26xrExaAG
	uSD04PBw0Y6KJ7uYuQvRxB1I+wpI0R/EMQsCae7R1X5Sz/9/IZLwPP5OG6lLJqY36pKjka6yJ85
	LO+HQLlgk7aP9xHrRj/yiifL+D2bPUWgTt015h97tWD19yDde6uPzSIXVOTvIRNZwFEvEcL+feb
	IiNNKOHcAe6nrXdI3fdfLB4iWLL5MrD6vdDiKLV2xVH8sjYJH3/jb5RrBM91zi7L/jcK8V5vXFG
	EWI5tif4w+2A9ZgOt2uILsnEQolwbBqlQOE22dzP9XbBM2r03jMKOYetKNHXnxLVANYhIrqAw9T
	ltPCPtLswB4kd+ZYCH/xNYENTKk5
X-Received: by 2002:a05:7022:fc01:b0:1a9:d04f:1b55 with SMTP id a92af1059eb24-1b25d353a39mr6760614c88.26.1794065536721;
        Sat, 07 Nov 2026 07:32:16 -0800 (PST)
Received: from localhost ([27.4.76.229])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4f03f5sm15077105c88.21.2026.11.07.07.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:32:16 -0800 (PST)
Date: Sat, 7 Nov 2026 21:02:13 +0530
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
Message-ID: <au9EfcJr_kMRX9wA@acer-nitro-anv15-41>
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
> Now if I don't get it wrong, if we turn on memory_hotplug.memmap_on_memory,
> we can have part of CXL memory to do the bookkeeping for itself, without
> using the existing RAM.
> 
> What if that bookkeeping part is poisoned ? the check ignores this situation
> right ?
> 
> What about draw a clear line between normal RAM and hot-add CXL memory, have
> the latter gone through the thorough check and do the rest you want ?
>

Hi Richard,
 
In my earlier reply I focused on reproducing the issue you raised. This
is the follow-up on your last question: I traced where 0x190100 ends
up, and it also shows where I think the line should be drawn.
 
 
1. Layout of the first block
----------------------------
 
x86-64, 4 KiB pages, 128 MiB memory blocks, sizeof(struct page) = 64
(pahole -C page : "size: 64").
 
  block PFNs     0x190000000 >> 12 = 0x190000, 0x8000 pages
                 -> PFN 0x190000 - 0x197fff                  (128 MiB)
 
  memmap size    0x8000 * 64 = 0x200000 bytes                (2 MiB)
  memmap frames  PFN_UP(0x200000) = (0x200000 + 0xfff) >> 12 = 0x200
                 pageblock = 0x200 pages (order 9), already aligned,
                 so no padding: altmap->free = 0x200
                 (memory_block_memmap_on_memory_pages())
 
The pageblock rounding is from 2d1f649c7c08 ("mm/memory_hotplug:
support memmap_on_memory when memmap is not aligned to pageblocks"):
online/offline need pageblock-aligned ranges, so the memmap area
is padded to a whole pageblock and online_pages() starts on a
pageblock boundary. Here 0x200 already is one pageblock, so free equals
the memmap size; on 64K-page ppc64 with 256 MiB blocks it would be 32
frames for a 4-frame memmap.
 
  altmap         .base_pfn = 0x190000, .free = 0x200
                 (create_altmaps_and_memory_blocks())
                 -> memmap stored in PFN 0x190000 - 0x1901ff
 
With CONFIG_SPARSEMEM_VMEMMAP, pfn_to_page(pfn) = vmemmap_base + pfn, so
 
  struct page VA of pfn = vmemmap_base + pfn * 64
  pfn of a struct page  = (VA - vmemmap_base) / 64
 
The block's struct pages are one 2 MiB array, 64 bytes per page, stored
in PFN order in its first 0x200 frames:
 
  offset:   0x0       0x40      ...  0xfc0     0x1000    ...  0x100000
  entry:    0x190000  0x190001  ...  0x19003f  0x190040  ...  0x194000
            |<-- frame 0x190000 (64 entries) ->|              |<- frame 0x190100
 
Frame 0x190100 starts at offset 0x100 * 4096 = 0x100000, i.e. entry
0x100000 / 64 = 0x4000. So the registered frame holds the struct pages
of PFN 0x194000 - 0x19403f.
 
 
2. Trace
--------
 
kprobes with stacktrace triggers:
 
  p:poison/vmemmap     vmemmap_populate start=$arg1:x64 altmap=$arg4:x64 vbase=@vmemmap_base:x64
  p:poison/memmap_init mhp_init_memmap_on_memory pfn=$arg1:x64 nr=$arg2:x64
  p:poison/online      online_pages pfn=$arg1:x64 nr=$arg2:x64
  p:poison/hwpoison    hwpoison_boot_page page=$arg1:x64
 
13 events, each with a stack, none lost. vmemmap_base was
0xffc4f4aa80000000.
 
Add (daxctl binds kmem; one __add_memory_driver_managed() for the whole
range, one vmemmap_populate() per block):
 
  725.066915 vmemmap_populate start=0xffc4f4aa86400000 altmap=0xff4a93014354df80
  725.084123 vmemmap_populate start=0xffc4f4aa86600000 altmap=0xff4a9301434b8080
  725.086550 vmemmap_populate start=0xffc4f4aa86800000 altmap=0xff4a9301421dafc0
  725.090221 vmemmap_populate start=0xffc4f4aa86a00000 altmap=0xff4a93014340bd40
 
  start = pfn_to_page(block start), from __populate_section_memmap():
    (0x86400000 - 0x80000000) / 64 = 0x190000
    (0x86600000 - 0x80000000) / 64 = 0x198000
    (0x86800000 - 0x80000000) / 64 = 0x1a0000
    (0x86a00000 - 0x80000000) / 64 = 0x1a8000
  Consecutive starts are 0x200000 apart: one block's memmap.
 
  altmap is a pointer to the per-block struct vmem_altmap (kmemdup()ed,
  hence four different direct-map addresses). Non-NULL means the
  memmap is allocated from the block: for the first block, PFN
  0x190000 - 0x1901ff, including 0x190100.
 
Online (daxctl writes memoryN/state; memory_block_online() inlined into
memory_block_change_state()):
 
  725.214535 mhp_init_memmap_on_memory pfn=0x190000 nr=0x200
  725.231165 online_pages              pfn=0x190200 nr=0x7e00
  725.658068 hwpoison_boot_page        page=0xffc4f4aa86410000
             (0x86410000 - 0x80000000) / 64 = 0x190400
             stack: online_pages -> __free_pages_core -> hwpoison_boot_page
 
  The other three blocks show the same memmap_init/online pair
  (pfn base and base + 0x200) and no hwpoison event.
 
The two online events are memory_block_online() (drivers/base/memory.c)
splitting the block at altmap->free:
 
	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
						/* 0x190000 */
	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
						/* 0x8000 */
	unsigned long nr_vmemmap_pages = 0;
	...
	if (mem->altmap)
		nr_vmemmap_pages = mem->altmap->free;	/* 0x200 */
	...
	if (nr_vmemmap_pages) {
		ret = mhp_init_memmap_on_memory(start_pfn, nr_vmemmap_pages,
						zone);
						/* 0x190000, 0x200 */
		...
	}
 
	ret = online_pages(start_pfn + nr_vmemmap_pages,
			   nr_pages - nr_vmemmap_pages, zone, mem->group);
						/* 0x190200, 0x7e00 */
						
						
 
                                 0x1901FF 0x190200
  block   0x190000 |---------------------|------------------------------------|0x197fff
          |<----- altmap->free = 0x200 ->|<---- 0x8000 - 0x200 = 0x7e00 ----->|

  part 1  mhp_init_memmap_on_memory()  (0x190100 here), Its range [0x190000 ~ 0x1901FF]

  part 2                              online_pages()  (0x190400 here), its range  [0x190200 ~ 0x197FFF]
  
  
The trace values pfn=0x190000 nr=0x200 and pfn=0x190200 nr=0x7e00 are
these two expressions evaluated. mhp_init_memmap_on_memory() only moves
part 1 into the zone and marks it PageVmemmapSelfHosted; it never calls
online_page_callback or __free_pages_core(), since those frames hold
live struct pages. Only part 2 goes through online_pages_range() ->
generic_online_page() -> __free_pages_core().
 
 
3. Why 0x190100 is missed and 0x190400 is not
---------------------------------------------
 
  PFN 0x190000 +--------------------------------+
               | memmap, altmap->free = 0x200   | vmemmap_populate() at add,
      0x190100 | X registered, NOT withheld     | mhp_init_memmap_on_memory()
               |                                | at online: never freed
      0x1901ff +--------------------------------+
      0x190200 +--------------------------------+
               | online_pages(), 0x7e00 pages   | [online_pages_range]
      0x190400 | X registered, withheld         | [generic_online_page]
               |                                | __free_pages_core() <- RFC
      0x197fff +--------------------------------+ hwpoison_boot_page()
 
0x190100 < base + altmap->free. It is taken for struct pages in
__add_pages() (725.07s), before any online code runs (725.21s), and at
online it is excluded from the range online_pages() frees. It never
reaches __free_pages_core(), where the RFC checks.
 
0x190400 >= base + altmap->free. It is in the freed range, reaches
__free_pages_core(), matches the registry and is withheld.
 
No check at online can catch the first case: the decision is made when
the altmap is chosen.
 

The full reproduction (memmap_on_memory on , every command, and the
complete stacks) is at the end .
 
 
4. A line between normal RAM and hot-added CXL memory
-----------------------------------------------------
 
The two already reach the allocator by different paths; the RFC put
its check at the one point they share:
 
  boot RAM                              hot-added CXL (dax/kmem)
  --------                              ------------------------
  sparse_init()                         [create_altmaps_and_memory_blocks]  <----- A
    memmap from memblock                  arch_add_memory()
                                            memmap: altmap or regular
  memblock_free_pages()                 online_pages()
  deferred_free_pages()                   [generic_online_page]             <----- B
           |                                 |
           |                                 |
           '----- __free_pages_core() -------'   <- RFC v1 check (shared)
 
 
For v2 I plan to move everything for hot-added memory to the right-hand
side, in mm/memory_hotplug.c, and leave __free_pages_core() and boot RAM
alone.
 
A. Add time, in create_altmaps_and_memory_blocks(), before
   arch_add_memory(). If a block's [base_pfn, base_pfn + free) range
   intersects a registered range, add that block without an altmap.
   Sketch:
 
	if (preonline_hwpoison_intersects(mhp_altmap.base_pfn,
					  mhp_altmap.free)) {
		params.altmap = NULL;
	} else {
		params.altmap = kmemdup(&mhp_altmap, sizeof(mhp_altmap),
					GFP_KERNEL);
		if (!params.altmap) {
			ret = -ENOMEM;
			goto out;
		}
	}
 
   That block's memmap then comes from regular memory,
   memory_block_online() sees no altmap and onlines the whole block,
   and the bad frame is an ordinary page that reaches B. Other blocks
   keep memmap_on_memory. The check covers the whole altmap->free
   range, including the pageblock padding added in "force" mode by
   2d1f649c7c08, since all of it is kept out of online_pages(). This
   is the check that is missing today.
 
   A also sits right where 2d1f649c7c08 decides how many frames each
   block gives up (memory_block_memmap_on_memory_pages() feeding
   mhp_altmap.free), so the range it checks is exactly the range
   memory_block_online() later excludes.
 
B. Online time, in generic_online_page(). Free the good pages and keep
   the registered ones out of the buddy:
 
	void generic_online_page(struct page *page, unsigned int order)
	{
		unsigned long pfn = page_to_pfn(page);
		unsigned long i, nr = 1UL << order;
 
		if (!preonline_hwpoison_intersects(pfn, nr)) {
			__free_pages_core(page, order, MEMINIT_HOTPLUG);
			return;
		}
		for (i = 0; i < nr; i++) {
			if (preonline_hwpoison_contains(pfn + i))
				hwpoison_hotplug_page(page + i);
			else
				__free_pages_core(page + i, 0,
						  MEMINIT_HOTPLUG);
		}
	}
 
   Withheld pages go to a new helper in mm/memory-failure.c, which
   leaves a page in the state Breno's v6 [1] gives an inherited frame:
 
	void hwpoison_hotplug_page(struct page *page)
	{
		unsigned long pfn = page_to_pfn(page);
 
		if (PageHWPoison(page))
			return;
 
		/* __free_pages_core() would have cleared it. */
		__ClearPageOffline(page);
		SetPageHWPoison(page);

		/* Device-reported media error: unpoison must not free it. */
		hw_memory_failure = true;

		/* offline_pages() subtracts it again. */
		adjust_managed_page_count(page, 1);

		/* The memory block exists before online: count both. */
		num_poisoned_pages_inc(pfn);
	}
 
   memory_block_online() then keeps refusing to re-online the block
   (-EHWPOISON), and removing it subtracts the count again.

The case tested in the RFC cover letter (memmap_on_memory off, the
Internal record at 0x190100 withheld) goes through B alone: there is no
altmap, so A never comes into play, and the poison list is still read
at region probe exactly as in patch 5.

With A in place every registered frame of hot-added memory reaches B,
so the __free_pages_core() hook in patch 4 is no longer needed (Breno's
v6 has dropped that hook anyway). Patch 4 goes away: boot RAM does no
registry lookups, and the series no longer depends on Breno's and
applies to cxl/next on its own.
 
Do A and B match what you had in mind? If you see a problem with
either, especially dropping the altmap per block in A, I would rather
hear it before I start on v2.
 
One more question for B. Breno's v6 has hwpoison_boot_page() for a
frame inherited across kexec:
 
	void __init hwpoison_boot_page(struct page *page)
	{
		SetPageHWPoison(page);
		atomic_long_inc(&num_poisoned_pages);
		hw_memory_failure = true;
		adjust_managed_page_count(page, 1);
	}
 
My hotplug helper is almost the same. It also clears PageOffline, and
it uses num_poisoned_pages_inc(pfn) because the memory block is already
there at that point. I can't call Breno's helper from hotplug since it
is __init.
 
For v2 I'd like to keep the two helpers separate, so this series does
not depend on Breno's. Once both are merged, the common part can be
pulled out into one function:
 
	static void __meminit hwpoison_withheld_page(struct page *page)
	{
		SetPageHWPoison(page);
		hw_memory_failure = true;
		adjust_managed_page_count(page, 1);
	}
 
Is that okay with you, or would you rather have one shared helper
from the start?
 
Thanks,
Shaikh Kamaluddin
 
[1] https://lore.kernel.org/all/20261016-hwpoison-kho-v6-0-f304255147da@debian.org/
 
Reproducing the hotplug events:
---------------------------------
Step 1 (T1): boot the guest

From the top of your kernel tree:
vng --disable-kvm --run ./arch/x86/boot/bzImage \
  --disable-microvm --memory 4G --cpus 4 \
  --append "memory_hotplug.memmap_on_memory=1 tsc=unstable" \
  --qemu-opts="-machine q35,cxl=on \
    -object memory-backend-ram,id=vmem0,share=on,size=512M \
    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
    -device cxl-rp,port=0,bus=cxl.1,id=rp0,chassis=0,slot=2 \
    -device cxl-type3,bus=rp0,volatile-memdev=vmem0,id=cxl-vmem0 \
    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
    -qmp unix:/tmp/qmp.sock,server=on,wait=off"
	
	
	

Step 2 (T1, guest): basic setup and checks
----------------------------------------

# mount -t debugfs none /sys/kernel/debug   2>/dev/null
# mount -t tracefs none /sys/kernel/tracing 2>/dev/null
# mount -t tmpfs   none /mnt                            

cat /sys/module/memory_hotplug/parameters/memmap_on_memory   # Y
#cxl list -M                                                  # mem0 present
# grep -E 'MemTotal|HardwareCorrupted' /proc/meminfo           # note MemTotal


Step 3 (T2, host): inject two Internal records
-------------------------------------------------
Do this after every boot, because QEMU loses the poison list when it restarts:

# qmp() { printf '{"execute":"qmp_capabilities"}\n%s\n' "$1" | socat - UNIX-CONNECT:/tmp/qmp.sock; }

# qmp '{"execute":"cxl-inject-poison","arguments":{"path":"/machine/peripheral/cxl-vmem0","start":1048576,"length":64}}'   # DPA 1 MiB -> PFN 0x190100, inside vmemmap
# qmp '{"execute":"cxl-inject-poison","arguments":{"path":"/machine/peripheral/cxl-vmem0","start":4194304,"length":64}}'   # DPA 4 MiB -> PFN 0x190400, outside


Step 4 (T1): create the region without letting kmem bind
---------------------------------------------------------
# echo 0 > /sys/bus/dax/drivers_autoprobe
# cxl create-region -m -t ram -d decoder0.0 -w 1 mem0
# dmesg | grep withhold                                  # "withholding 2 frame(s)"

# echo 1 > /sys/bus/dax/devices/dax0.0/memmap_on_memory
# cat /sys/bus/dax/devices/dax0.0/memmap_on_memory       # 1
#lsmem                                                  # blocks 50-53 must NOT be listed



Step 5 (T1): add the four probes with stack traces
---------------------------------------------------
# cd /sys/kernel/tracing
# echo nop > current_tracer
# echo > kprobe_events

# echo 'p:poison/vmemmap     vmemmap_populate          start=$arg1:x64 altmap=$arg4:x64' >> kprobe_events
# echo 'p:poison/memmap_init mhp_init_memmap_on_memory pfn=$arg1:x64 nr=$arg2:x64'       >> kprobe_events
# echo 'p:poison/online      online_pages              pfn=$arg1:x64 nr=$arg2:x64'       >> kprobe_events
# echo 'p:poison/hwpoison    hwpoison_boot_page        page=$arg1:x64'                   >> kprobe_events
# cat kprobe_events                                     

#for e in vmemmap memmap_init online hwpoison; do
  echo stacktrace > events/poison/$e/trigger
done


Step 6 (T1): run it
---------------------
# echo 1 > events/poison/enable
# echo > trace
# daxctl reconfigure-device --mode=system-ram dax0.0
# echo 0 > events/poison/enable


Step 7 (T1): read the call chains
-----------------------------------
cat trace > /mnt/hotplug_stacks.txt
 cat /mnt/hotplug_stacks.txt 
# tracer: nop
#
# entries-in-buffer/entries-written: 26/26   #P:4
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          daxctl-224     [003] .....   725.066915: vmemmap: (vmemmap_populate+0x4/0x60) start=0xffc4f4aa86400000 altmap=0xff4a93014354df80
          daxctl-224     [003] .....   725.069220: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => vmemmap_populate
 => __populate_section_memmap
 => sparse_add_section
 => __add_pages
 => add_pages
 => __add_memory_resource
 => __add_memory_driver_managed
 => dax_kmem_do_hotplug
 => dev_dax_kmem_probe
 => dax_bus_probe
 => really_probe
 => __driver_probe_device
 => driver_probe_device
 => __driver_attach
 => bus_for_each_dev
 => do_id_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.084123: vmemmap: (vmemmap_populate+0x4/0x60) start=0xffc4f4aa86600000 altmap=0xff4a9301434b8080
          daxctl-224     [003] .....   725.084240: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => vmemmap_populate
 => __populate_section_memmap
 => sparse_add_section
 => __add_pages
 => add_pages
 => __add_memory_resource
 => __add_memory_driver_managed
 => dax_kmem_do_hotplug
 => dev_dax_kmem_probe
 => dax_bus_probe
 => really_probe
 => __driver_probe_device
 => driver_probe_device
 => __driver_attach
 => bus_for_each_dev
 => do_id_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.086550: vmemmap: (vmemmap_populate+0x4/0x60) start=0xffc4f4aa86800000 altmap=0xff4a9301421dafc0
          daxctl-224     [003] .....   725.087099: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => vmemmap_populate
 => __populate_section_memmap
 => sparse_add_section
 => __add_pages
 => add_pages
 => __add_memory_resource
 => __add_memory_driver_managed
 => dax_kmem_do_hotplug
 => dev_dax_kmem_probe
 => dax_bus_probe
 => really_probe
 => __driver_probe_device
 => driver_probe_device
 => __driver_attach
 => bus_for_each_dev
 => do_id_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.090221: vmemmap: (vmemmap_populate+0x4/0x60) start=0xffc4f4aa86a00000 altmap=0xff4a93014340bd40
          daxctl-224     [003] .....   725.090409: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => vmemmap_populate
 => __populate_section_memmap
 => sparse_add_section
 => __add_pages
 => add_pages
 => __add_memory_resource
 => __add_memory_driver_managed
 => dax_kmem_do_hotplug
 => dev_dax_kmem_probe
 => dax_bus_probe
 => really_probe
 => __driver_probe_device
 => driver_probe_device
 => __driver_attach
 => bus_for_each_dev
 => do_id_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.214535: memmap_init: (mhp_init_memmap_on_memory+0x4/0xa0) pfn=0x190000 nr=0x200
          daxctl-224     [003] .....   725.214996: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => mhp_init_memmap_on_memory
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.231165: online: (online_pages+0x4/0x330) pfn=0x190200 nr=0x7e00
          daxctl-224     [003] .....   725.231245: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => online_pages
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.658068: hwpoison: (hwpoison_boot_page+0x4/0x70) page=0xffc4f4aa86410000
          daxctl-224     [003] .....   725.658306: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => hwpoison_boot_page
 => __free_pages_core
 => online_pages
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.888289: memmap_init: (mhp_init_memmap_on_memory+0x4/0xa0) pfn=0x1a8000 nr=0x200
          daxctl-224     [003] .....   725.888421: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => mhp_init_memmap_on_memory
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   725.924992: online: (online_pages+0x4/0x330) pfn=0x1a8200 nr=0x7e00
          daxctl-224     [003] .....   725.925075: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => online_pages
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   727.248819: memmap_init: (mhp_init_memmap_on_memory+0x4/0xa0) pfn=0x198000 nr=0x200
          daxctl-224     [003] .....   727.248893: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => mhp_init_memmap_on_memory
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [003] .....   727.262077: online: (online_pages+0x4/0x330) pfn=0x198200 nr=0x7e00
          daxctl-224     [003] .....   727.262127: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => online_pages
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [000] .....   728.465063: memmap_init: (mhp_init_memmap_on_memory+0x4/0xa0) pfn=0x1a0000 nr=0x200
          daxctl-224     [000] .....   728.465203: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => mhp_init_memmap_on_memory
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe
          daxctl-224     [000] .....   728.480563: online: (online_pages+0x4/0x330) pfn=0x1a0200 nr=0x7e00
          daxctl-224     [000] .....   728.480690: <stack trace>
 => kprobe_trace_func
 => kprobe_dispatcher
 => kprobe_ftrace_handler
 => 0xffffffffc024e0da
 => online_pages
 => memory_block_change_state
 => memory_subsys_online
 => device_online
 => state_store
 => kernfs_fop_write_iter
 => vfs_write
 => ksys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe



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
