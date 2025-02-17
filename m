Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C004227BAA
	for <linux-cxl@vger.kernel.org>; Mon, 17 Feb 2025 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822752; cv=none; b=IotC9wk/nyBOHmbaN3S5WFpnOOOy+JLsxcHAyuX8jnoL3hA/mqcgVHhDXvNA1UorXQQT0SFsfdzEjE0w56aV0BCEOvpZhuVUaaRBW8vm4rv+pckATlhyDGex3aXj07ca/vXZxEra/TWHSNi1P0x/VygTdW9m+S/BvXdHa6Cz44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822752; c=relaxed/simple;
	bh=k6DNKFKMaCUQ0DgrC2eIhHYG/gMH73GjjhFevt5GJKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOWqlrkDo744GlvItNDLkMcNIRBwi7OSmBkFoZGJmFcbWgaBIFS3xZ3S4+r2M5aYQ45J1yPAU8+xGJ53XzM91qa4wT0g+7ocily94SIIAgEb6kvUS+5vH8EjF0Z4xNPGib2ZbP+nSU4QCxVPnyID7q5EL5+lFoEn0WxdrSk7KHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m3nCne8t; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m3nCne8t"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e67ce516efso11350186d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 17 Feb 2025 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739822749; x=1740427549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vCgeOMU2MhngBhzCworEtjOZ+T+D6653XM8U1/nQhGA=;
        b=m3nCne8tCiewC8EhkbNFjLXFzgtYp1CWjAljSQmkPhhzXNZS63hJdGdijnmtlRqgxI
         3aVlPH5wnrNDRYWv3feZQ4LB/qCdF6z8M/L0JlCw2eENLKHU9j8Zz5P+gLznyW1+Bka1
         IhD+rQeiYarlB8qBvMcsqcLKzo5lDj+j81Sw3aiGDFMYsLc6/GqvwOhnKs4AuK+ZnfAA
         mJCkMGhNQuZqaVrBfB6EWiZTmtnQjMfRGoAWlbPwzL7vsynjuCiwIVJohlYoQh5pYIi0
         dlu+tRhkfem7Tltge2WtpJ2Np66+Av4Ce2Ljsj2dQPapXXAca00BExgUtLcd/zr/bkU2
         +1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739822749; x=1740427549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCgeOMU2MhngBhzCworEtjOZ+T+D6653XM8U1/nQhGA=;
        b=pqATBBjpvEu2CPU6AAUM582IUtZxY68WsfaPJ9AF09yguzaAGdlb+7ok4fTbfLdmtq
         hjCDfE/0BaIi0PvFWIMx/uyo7dIYCBHP2Jf8AGRBUKd8THu/WIrlQiR8ix6hKwdoW6Mg
         lldPh1fcfsbZuGHcsQwr0+kQRmimX/lC9lOimmIPtK/8PxFgXKE70Q17mieGq31gaurB
         bImQBr0f9CoxS2/V69GFJOnSYOh9mI7IZYBIoCxMuNZ57HrPg8XQRuNotdJzqxWLN2oo
         cRCecdQVqkt3RE+AI6aOnKRImp2qNihq5sixzTTxJoM8dfYpk0IvdGdQDW6RwrPk1G9d
         HvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWwH6W9R00mZEVwDr5GSZvoAOAYOq86GPMIqFw4NTag6etOZVkOTR4OMNEnyNuadqhCOaZ6FIndc3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAx97yS316ryK21SfSjbTa4bk5gIGHwkZ1w2mteIN6yUmLFyK
	ZYh6jLmNfAyzQk2ec6Lfo1ELfYdVStq/JP39iXDeKfdMZDRSzRBcj5CPlHFvmjo=
X-Gm-Gg: ASbGncsWV3YRbanKp5cizy+DpBK6Cn3AIFLPV7paJPTDIz0bopfiWxQ0grCg5QpaePg
	jCPfQTWLkSTKijFZeMgACw7OsJr0OT/Gx/naVgkVsYFeG7wi1CzrOWxDLCmp4pd0rnDMfE0sfjx
	Dk/wEJBoAfGlJoNbMC3lOqdkYhrj0CV232zD9mbNBTjAmm0uD5wHIeqhH6IMJP4gD7JUCwjNVGh
	ODjJBXfs9EXI+B2wsahiF03dWEebLHreEX64t5nW6XZSMCdcrZPTgbm/38hLjvbxJy/4VYzShTk
	mPfQJ8gqWryvSKSVuPE8M3l/DYnLu20a9dDP9sd8ArqPX7CeI5pkMq5mXq6gnxycelJi4Q+wSg=
	=
X-Google-Smtp-Source: AGHT+IFPULOdVELO2VyJgNV5ljLKvzQJzC37IUdklvHnQ5b1U1CtrvxTzhQkTu86wiLswV9Q8uTiRQ==
X-Received: by 2002:a05:6214:3bc9:b0:6e4:4331:aad9 with SMTP id 6a1803df08f44-6e676294de1mr124170946d6.2.1739822748947;
        Mon, 17 Feb 2025 12:05:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65daffdbbsm55675956d6.99.2025.02.17.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 12:05:48 -0800 (PST)
Date: Mon, 17 Feb 2025 15:05:44 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>


The story up to now
-------------------
When we left the driver arena, we had created a dax device - which
connects a Soft Reserved iomem resource to one or more `memory blocks`
via the kmem driver.  We also discussed a bit about ZONE selection
and default online behavior.

In this section we'll discuss what actually goes into memory block
creation, how those memory blocks are exposed to kernel allocators
(tl;dr: sparsemem / memmap / struct page), and the implications of
the selected memory zones.


-------------------------------------
Step 7: Hot-(un)plug Memory (Blocks).
-------------------------------------
Memory hotplug refers to surfacing physical memory to kernel
allocators (page, slab, cache, etc) - as opposed to the action of
"physically hotplugging" a device into a system (e.g. USB). 

Physical memory is exposed to allocators in the form of memory blocks.

A `memory block` is an abstraction to describe a physically
contiguous region memory, or more explicitly a collection of physically
contiguous page frames which is described by a physically contiguous
set of `struct page` structures in the system memory-map.

The system memmap is what is used for pfn-to-page (struct) and
page(struct)-to-pfn conversions. The system memmap has `flat` and
`sparse` modes (configured at build-time). Memory hotplug requires the
use of `sparsemem`, which aptly makes the memory map sparse.

Hot *remove* (un-plug) is distinct from Hot add (plug).  To hot-remove
an active memory block, the pages in-use must have their data (and
therefore mappings) migrated to another memory block. Hot-remove must
be specifically enabled separate from hotplug.


Build configurations affecting memory block hot(un)plug
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG
  CONFIG_SPARSEMEM
  CONFIG_64BIT
  CONFIG_MEMORY_HOTPLUG
  CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_AUTO
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE
  CONFIG_MHP_MEMMAP_ON_MEMORY
  CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  CONFIG_MIGRATION
  CONFIG_MEMORY_HOTREMOVE

During early-boot, the kernel finds all SystemRAM memory regions NOT
marked "Special Purpose" and will create memory blocks for these
regions by default.  These blocks are defaulted into ZONE_NORMAL
(more on zones shortly).

Memory regions present at boot marked `EFI_MEMORY_SP` have memory blocks
created and hot-plugged by drivers.  The same mechanism is used to
hot-add memory physically hotplugged after system boot (i.e. not present
in the EFI Memory Map at boot time).

The DAX/KMEM driver hotplugs memory blocks via the
  `add_memory_driver_managed()`
function.


-------------------------------
Step 8: Page Struct allocation.
-------------------------------
A `memory block` is made up of a collection of physical memory pages,
which must have entries in the system Memory Map - which is managed by
sparsemem on systems with memory (block) hotplug.  Sparsemem fills the
memory map with `struct page` for hot-plugged memory.

Here is a rough trace through the (current) stack on how page structs
are populated into the system Memory Map on hotplug.

```
add_memory_driver_managed
  add_memory_resource
    memblock_add_node
      arch_add_memory
        init_memory_mapping
          add_pages
            __add_pages
              sparse_add_section
                section_activate
                  populate_section_memmap
                    __populate_section_memmap
                      memmap_alloc
                        memblock_alloc_try_nid_raw
                          memblock_alloc_internal
                            memblock_alloc_range_nid
                              kzalloc_node(..., GFP_KERNEL, ...)
```

All allocatable-memory requires `struct page` resources to describe the
physical page state.  On a system with regular 4kb size pages and 256GB
of memory - 4GB is required just to describe/manage the memory.

This is ~1.5% of the new capacity to just surface it (4/256).

This becomes an issue if the memory is not intended for kernel-use,
as `struct page` memory must be allocated in non-movable, kernel memory
`zones`.  If hot-plugged capacity is designated for a non-kernel zone
(ZONE_MOVABLE, ZONE_DEVICE, etc), then there must be sufficient
ZONE_NORMAL (or similar kernel-compatible zone) to allocate from.

Matthew Wilcox has a plan to reduce this cost, some details of his plan:
https://fosdem.org/2025/schedule/event/fosdem-2025-4860-shrinking-memmap/
https://lore.kernel.org/all/Z37pxbkHPbLYnDKn@casper.infradead.org/


---------------------
Step 9: Memory Zones.
---------------------
We've alluded to "Memory Zones" in prior sections, with really the only
detail about these concepts being that there are "Kernel-allocation
compatible" and "Movable" zones, as well as some relationship between
memory blocks and memory zones.

The two zones we really care about are `ZONE_NORMAL` and `ZONE_MOVABLE`.

For the purpose of this reading we'll consider two basic use-cases:
- memory block hot-unplug
- kernel resource allocation

You can (for the most part) consider these cases incompatible.  If the
kernel allocates `struct page` memory from a block, then that block cannot
be hot-unplugged.  This memory is typically unmovable (cannot be migrated),
and its pages unlikely to be removed from the memory map.

There are other scenarios, such as page pinning, that can block hot-unplug.
The individual mechanisms preventing hot-unplug are less important than
their relationship to memory zones.

ZONE_NORMAL basically allows any allocations, including things like page
tables, struct pages, and pinned memory.

ZONE_MOVABLE, under normal conditions, disallows most kernel allocations.

ZONE_MOVABLE does NOT make a *strong* guarantee of hut-unplug-ability.
The kernel and privileged users can cause long-term pinning to occur - 
even in ZONE_MOVABLE.  It should be seen as a best-attempt at providing
hot-unplug-ability under normal conditions.


Here's the take-away:

Any capacity marked SystemRAM but not Special Purpose during early boot
will be onlined into ZONE_NORMAL by default - making it available for
kernel-use during boot.  There is no guarantee of being hot-unpluggable.

Any capacity marked Special Purpose at boot, or hot-added (physically),
will be onlined into a user-selected zone (Normal or Movable).

There are (at least) 4 ways to select what zone to online memory blocks.

Build Time:
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
Boot Time:
  memhp_default_state (boot parameter)
udev / daxctl:
  user policy explicitly requesting the zone
memory sysfs
  online_movable > /sys/bus/memory/devices/memoryN/online


------------------------------------------
Nuance: memmap_on_memory and ZONE_MOVABLE.
------------------------------------------
As alluded to in the prior sections - hot-added ZONE_MOVABLE capacity
will consume ZONE_NORMAL capacity for its kernel resources.  This can
be problematic if vast amounts of ZONE_MOVABLE is added on a system
with limited ZONE_NORMAL capacity.

For example, consider a system with 4GB of ZONE_NORMAL and 256GB of
ZONE_MOVABLE.  This wouldn't work, as the entirety of ZONE_NORMAL would
be consumed to allocate `struct page` resources for the ZONE_MOVABLE
capacity - leaving no working memory for the rest of the kernel.

The `memmap_on_memory` configuration option allows for hotplugged memory
blocks to host their own `struct page` allocations... 

                   if they're placed in ZONE_NORMAL.

To enable, use the boot param: `memory_hotplug.memmap_on_memory=1`.

Sparsemem allocation of memory map resources ultimately uses a
`kzalloc_node` call, which simply allocates memory from ZONE_NORMAL with
a *suggested* node.

```
memmap_alloc
  memblock_alloc_try_nid_raw
    memblock_alloc_internal
      memblock_alloc_range_nid
        kzalloc_node(..., GFP_KERNEL, ...)
```

The node ID passed in as an argument is a "preferred node", which means
is insufficient space on that node exists to service the GFP_KERNEL
allocation, it will fall back to another node.

If all hot-plugged memory is added to ZONE_MOVABLE, two things occur:

  1) A portion of the memory block is carved out for to allocate memmap
     data (reducing usable size by 64b*nr_pages)

  2) The memory is allocated on ZONE_NORMAL on another node..

Result: Lost capacity due to the unused carve-out area for no value.

--------------------------------
The Complexity Story up til now.
--------------------------------
Platform and BIOS:
  May configure all the devices prior to kernel hand-off.
  May or may not support reconfiguring / hotplug.

BIOS and EFI:
  EFI_MEMORY_SP              - used to defer management to drivers

Kernel Build and Boot:
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG
  CONFIG_SPARSEMEM
  CONFIG_64BIT
  CONFIG_MEMORY_HOTPLUG
  CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_AUTO
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE
  CONFIG_MHP_MEMMAP_ON_MEMORY
  CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  CONFIG_MIGRATION
  CONFIG_MEMORY_HOTREMOVE
  CONFIG_EFI_SOFT_RESERVE=n  - Will always result in CXL as SystemRAM
  nosoftreserve              - Will always result in CXL as SystemRAM
  kexec                      - SystemRAM configs carry over to target
  memory_hotplug.memmap_on_memory

Driver Build Options Required
  CONFIG_CXL_ACPI
  CONFIG_CXL_BUS
  CONFIG_CXL_MEM
  CONFIG_CXL_PCI
  CONFIG_CXL_PORT
  CONFIG_CXL_REGION
  CONFIG_DEV_DAX
  CONFIG_DEV_DAX_CXL
  CONFIG_DEV_DAX_KMEM

User Policy
  CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE (<=v6.13)
  CONFIG_MHP_DEFAULT_ONLINE_TYPE       (>=v6.14)
  memhp_default_state                  (boot param)
  daxctl online-memory daxN.Y          (userland)

Nuances
  Early-boot resource re-use
  Memory Block Alignment
  memmap_on_meomry + ZONE_MOVABLE

----------------------------------------------------
Next up:
  RAS - Poison, MCE, and why you probably want CXL=ZONE_MOVABLE
  Interleave - RAS and Region Management

~Gregory
