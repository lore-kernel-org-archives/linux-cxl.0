Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C626A089;
	Tue, 18 Feb 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739900983; cv=none; b=FB39DffMDHkucgzFdWb5hjxqjV3EpbuekGcKRL9mDQOSRvEZ3Y33oJDYRJdrw/vZh+4recEFF2F+3tt5oA3Wvw2glhIVoSRqBy7IukfVLDfhykKJAclNjCxfZK+/tzEAg4suirYoFBVAzU6x40223g6TtWgmUzHjwOa1RIqibbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739900983; c=relaxed/simple;
	bh=tx9lR4J/0twZmUF+Dp+C2tfT55xfRl1U3HIbbiUM4hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8H3QSvZM6tw5yibJO9tWy/92g80vOJgAXGQIBxnuwd8m+myDIA+D6kvE5o6TumpJMkQdaxgpVIGWgLPTeE3Sj7FTBeG3L5dd97OQFs3q+lQUxXt9H9iE8xGuwzrXO989gy5DIMCcYA1xrOkzHVoIoo6Tb6GQMcvR1BBKz78srE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmMcCbtl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmMcCbtl"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e0505275b7so4600767a12.3;
        Tue, 18 Feb 2025 09:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739900980; x=1740505780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4D3RkKdQuZIty+oDae4mcM33z7ITGGOJJS9/JjB6iQ=;
        b=gmMcCbtlLNZBYK62M7182Xp20bLnaeVr4e5UIdeZJTnYEyrTg2ju9ewcC9IAqiAwnV
         jdpI8XxnV+4lhx7RuTqjDFsR9J/wPCP1pxPw30lyHZoB9oDiF3BraZfJvu+duxLzuMRC
         ftLjGM9W+cKTAOCK9s5+iyqRX82aStblFPjnsbczyQ4YMxnNGOEkVIXepPURFVk0izn+
         0VjsmDZTL2NVGhEqsPhrTTVu6bZUceK5aQVKNu9OpF25BoN3VE1PxHmk3DHW0z4y3nUH
         jAJqz3Z/6nnPJcAKvryJETn+CoXKqgi8NXwgFjL3J8yowK2F6d/07o2a+ON9LezKdDp/
         zv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739900980; x=1740505780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4D3RkKdQuZIty+oDae4mcM33z7ITGGOJJS9/JjB6iQ=;
        b=MnlLzuDpNJMr3bHZU6iB05xRg/P0sNbGwgGyYED089ZdtZLhihPfebRNo3Z2xJCked
         Q5AFyvkcBax0PcKyEI4xZDpyzR3biQjncmfgmj63OJIIcaQQLZI08LrtaMDSjlT6hE59
         R2aJaQni20xL+DxK0CViNhEjodegJH0hDSMs2YaghxTcdE5ANqXyvS8Qhcf2BgdcZ6M/
         PeM7BVxZ0rmtdM7yoILepPZYrCQeo2UjPo51l3eZ5hkSjfp0fHAsjfPSjkqlpJSXirZe
         5vHn/2g6vmSEKFFqakN5hgTZ6kP+gfcxCwVThZs7bgb5vdXAYA6vZwUiGDUtACmno/sg
         hF4g==
X-Forwarded-Encrypted: i=1; AJvYcCV48QVbccom+/pbt3GyGVlOEqYOyioPViETI1i1oeHxUi4hEiHuHI+dV4XXNCw2LAah11uvqX9PROWqSHbo@vger.kernel.org, AJvYcCWZAha9LqhoQy5fMRQXr/7FskNv543ngX1Kj6a3tj8BT4o5qHPM/02hl8GvpvyzrpZOQbw2/bw3pLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRH87q7ngXMU2lv4LU+8/cizP5NVc1ZPguHllENgq+Io2zmOky
	s1/yKG2g+MyANuMd6d6B9583J+LbQSdSzRkMELvQHtZo4dL36cGhNaKr4QIaPMOsfHFY9lfpGNK
	F1TLvVw6kX5h47N6HTvXToYu1yp0=
X-Gm-Gg: ASbGncuC6MeB7vYZLn/+zC6XZs0bjCvI1+9ghN4M6JYM6lWFI/gmMYt3FV7AuxuvgRZ
	Y66whJaekx37II2F6bWZ99Tpzj5W25PPdmwEK/kJtPmOzM5CE/JstoWxe0GGhTqsgKBHOXcNz
X-Google-Smtp-Source: AGHT+IF30cO73ZHk8lsLdxM9JqGuET62bpvaxA4FoYYrORLv6LwGBx/g81X9jt1z3YnCkAfBvl04sCjPVR2uLixOjJ0=
X-Received: by 2002:a05:6402:26d2:b0:5e0:51a9:d425 with SMTP id
 4fb4d7f45d1cf-5e089f2b807mr283207a12.29.1739900979572; Tue, 18 Feb 2025
 09:49:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F> <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 18 Feb 2025 09:49:28 -0800
X-Gm-Features: AWEUYZmAPUBBn9Bihii5OezBwEt76xfUEg_WniyupQXJMNKXU2HRJVUhdQfRZ6E
Message-ID: <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 12:05=E2=80=AFPM Gregory Price <gourry@gourry.net> =
wrote:
>
>
> The story up to now
> -------------------
> When we left the driver arena, we had created a dax device - which
> connects a Soft Reserved iomem resource to one or more `memory blocks`
> via the kmem driver.  We also discussed a bit about ZONE selection
> and default online behavior.
>
> In this section we'll discuss what actually goes into memory block
> creation, how those memory blocks are exposed to kernel allocators
> (tl;dr: sparsemem / memmap / struct page), and the implications of
> the selected memory zones.
>
>
> -------------------------------------
> Step 7: Hot-(un)plug Memory (Blocks).
> -------------------------------------
> Memory hotplug refers to surfacing physical memory to kernel
> allocators (page, slab, cache, etc) - as opposed to the action of
> "physically hotplugging" a device into a system (e.g. USB).
>
> Physical memory is exposed to allocators in the form of memory blocks.
>
> A `memory block` is an abstraction to describe a physically
> contiguous region memory, or more explicitly a collection of physically
> contiguous page frames which is described by a physically contiguous
> set of `struct page` structures in the system memory-map.
>
> The system memmap is what is used for pfn-to-page (struct) and
> page(struct)-to-pfn conversions. The system memmap has `flat` and
> `sparse` modes (configured at build-time). Memory hotplug requires the
> use of `sparsemem`, which aptly makes the memory map sparse.
>
> Hot *remove* (un-plug) is distinct from Hot add (plug).  To hot-remove
> an active memory block, the pages in-use must have their data (and
> therefore mappings) migrated to another memory block. Hot-remove must
> be specifically enabled separate from hotplug.
>
>
> Build configurations affecting memory block hot(un)plug
>   CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG
>   CONFIG_SPARSEMEM
>   CONFIG_64BIT
>   CONFIG_MEMORY_HOTPLUG
>   CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_AUTO
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE
>   CONFIG_MHP_MEMMAP_ON_MEMORY
>   CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>   CONFIG_MIGRATION
>   CONFIG_MEMORY_HOTREMOVE
>
> During early-boot, the kernel finds all SystemRAM memory regions NOT
> marked "Special Purpose" and will create memory blocks for these
> regions by default.  These blocks are defaulted into ZONE_NORMAL
> (more on zones shortly).
>
> Memory regions present at boot marked `EFI_MEMORY_SP` have memory blocks
> created and hot-plugged by drivers.  The same mechanism is used to
> hot-add memory physically hotplugged after system boot (i.e. not present
> in the EFI Memory Map at boot time).
>
> The DAX/KMEM driver hotplugs memory blocks via the
>   `add_memory_driver_managed()`
> function.
>
>
> -------------------------------
> Step 8: Page Struct allocation.
> -------------------------------
> A `memory block` is made up of a collection of physical memory pages,
> which must have entries in the system Memory Map - which is managed by
> sparsemem on systems with memory (block) hotplug.  Sparsemem fills the
> memory map with `struct page` for hot-plugged memory.
>
> Here is a rough trace through the (current) stack on how page structs
> are populated into the system Memory Map on hotplug.
>
> ```
> add_memory_driver_managed
>   add_memory_resource
>     memblock_add_node
>       arch_add_memory
>         init_memory_mapping
>           add_pages
>             __add_pages
>               sparse_add_section
>                 section_activate
>                   populate_section_memmap
>                     __populate_section_memmap
>                       memmap_alloc
>                         memblock_alloc_try_nid_raw
>                           memblock_alloc_internal
>                             memblock_alloc_range_nid
>                               kzalloc_node(..., GFP_KERNEL, ...)
> ```
>
> All allocatable-memory requires `struct page` resources to describe the
> physical page state.  On a system with regular 4kb size pages and 256GB
> of memory - 4GB is required just to describe/manage the memory.
>
> This is ~1.5% of the new capacity to just surface it (4/256).
>
> This becomes an issue if the memory is not intended for kernel-use,
> as `struct page` memory must be allocated in non-movable, kernel memory
> `zones`.  If hot-plugged capacity is designated for a non-kernel zone
> (ZONE_MOVABLE, ZONE_DEVICE, etc), then there must be sufficient
> ZONE_NORMAL (or similar kernel-compatible zone) to allocate from.
>
> Matthew Wilcox has a plan to reduce this cost, some details of his plan:
> https://fosdem.org/2025/schedule/event/fosdem-2025-4860-shrinking-memmap/
> https://lore.kernel.org/all/Z37pxbkHPbLYnDKn@casper.infradead.org/
>
>
> ---------------------
> Step 9: Memory Zones.
> ---------------------
> We've alluded to "Memory Zones" in prior sections, with really the only
> detail about these concepts being that there are "Kernel-allocation
> compatible" and "Movable" zones, as well as some relationship between
> memory blocks and memory zones.
>
> The two zones we really care about are `ZONE_NORMAL` and `ZONE_MOVABLE`.
>
> For the purpose of this reading we'll consider two basic use-cases:
> - memory block hot-unplug
> - kernel resource allocation
>
> You can (for the most part) consider these cases incompatible.  If the
> kernel allocates `struct page` memory from a block, then that block canno=
t
> be hot-unplugged.  This memory is typically unmovable (cannot be migrated=
),
> and its pages unlikely to be removed from the memory map.
>
> There are other scenarios, such as page pinning, that can block hot-unplu=
g.
> The individual mechanisms preventing hot-unplug are less important than
> their relationship to memory zones.
>
> ZONE_NORMAL basically allows any allocations, including things like page
> tables, struct pages, and pinned memory.
>
> ZONE_MOVABLE, under normal conditions, disallows most kernel allocations.
>
> ZONE_MOVABLE does NOT make a *strong* guarantee of hut-unplug-ability.
> The kernel and privileged users can cause long-term pinning to occur -
> even in ZONE_MOVABLE.  It should be seen as a best-attempt at providing
> hot-unplug-ability under normal conditions.
>
>
> Here's the take-away:
>
> Any capacity marked SystemRAM but not Special Purpose during early boot
> will be onlined into ZONE_NORMAL by default - making it available for
> kernel-use during boot.  There is no guarantee of being hot-unpluggable.
>
> Any capacity marked Special Purpose at boot, or hot-added (physically),
> will be onlined into a user-selected zone (Normal or Movable).
>
> There are (at least) 4 ways to select what zone to online memory blocks.
>
> Build Time:
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
> Boot Time:
>   memhp_default_state (boot parameter)
> udev / daxctl:
>   user policy explicitly requesting the zone
> memory sysfs
>   online_movable > /sys/bus/memory/devices/memoryN/online
>
>
> ------------------------------------------
> Nuance: memmap_on_memory and ZONE_MOVABLE.
> ------------------------------------------
> As alluded to in the prior sections - hot-added ZONE_MOVABLE capacity
> will consume ZONE_NORMAL capacity for its kernel resources.  This can
> be problematic if vast amounts of ZONE_MOVABLE is added on a system
> with limited ZONE_NORMAL capacity.
>
> For example, consider a system with 4GB of ZONE_NORMAL and 256GB of
> ZONE_MOVABLE.  This wouldn't work, as the entirety of ZONE_NORMAL would
> be consumed to allocate `struct page` resources for the ZONE_MOVABLE
> capacity - leaving no working memory for the rest of the kernel.
>
> The `memmap_on_memory` configuration option allows for hotplugged memory
> blocks to host their own `struct page` allocations...
>
>                    if they're placed in ZONE_NORMAL.
>
> To enable, use the boot param: `memory_hotplug.memmap_on_memory=3D1`.
>
> Sparsemem allocation of memory map resources ultimately uses a
> `kzalloc_node` call, which simply allocates memory from ZONE_NORMAL with
> a *suggested* node.
>
> ```
> memmap_alloc
>   memblock_alloc_try_nid_raw
>     memblock_alloc_internal
>       memblock_alloc_range_nid
>         kzalloc_node(..., GFP_KERNEL, ...)
> ```
>
> The node ID passed in as an argument is a "preferred node", which means
> is insufficient space on that node exists to service the GFP_KERNEL
> allocation, it will fall back to another node.
>
> If all hot-plugged memory is added to ZONE_MOVABLE, two things occur:
>
>   1) A portion of the memory block is carved out for to allocate memmap
>      data (reducing usable size by 64b*nr_pages)
>
>   2) The memory is allocated on ZONE_NORMAL on another node..

Nice write-up, thanks for putting everything together. A follow up
question on this. Do you mean the memmap memory will show up as a new
node with ZONE_NORMAL only besides other hot-plugged memory blocks? So
we will actually see two nodes are hot-plugged?

Thanks,
Yang

>
> Result: Lost capacity due to the unused carve-out area for no value.
>
> --------------------------------
> The Complexity Story up til now.
> --------------------------------
> Platform and BIOS:
>   May configure all the devices prior to kernel hand-off.
>   May or may not support reconfiguring / hotplug.
>
> BIOS and EFI:
>   EFI_MEMORY_SP              - used to defer management to drivers
>
> Kernel Build and Boot:
>   CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG
>   CONFIG_SPARSEMEM
>   CONFIG_64BIT
>   CONFIG_MEMORY_HOTPLUG
>   CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_AUTO
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE
>   CONFIG_MHP_MEMMAP_ON_MEMORY
>   CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
>   CONFIG_MIGRATION
>   CONFIG_MEMORY_HOTREMOVE
>   CONFIG_EFI_SOFT_RESERVE=3Dn  - Will always result in CXL as SystemRAM
>   nosoftreserve              - Will always result in CXL as SystemRAM
>   kexec                      - SystemRAM configs carry over to target
>   memory_hotplug.memmap_on_memory
>
> Driver Build Options Required
>   CONFIG_CXL_ACPI
>   CONFIG_CXL_BUS
>   CONFIG_CXL_MEM
>   CONFIG_CXL_PCI
>   CONFIG_CXL_PORT
>   CONFIG_CXL_REGION
>   CONFIG_DEV_DAX
>   CONFIG_DEV_DAX_CXL
>   CONFIG_DEV_DAX_KMEM
>
> User Policy
>   CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE (<=3Dv6.13)
>   CONFIG_MHP_DEFAULT_ONLINE_TYPE       (>=3Dv6.14)
>   memhp_default_state                  (boot param)
>   daxctl online-memory daxN.Y          (userland)
>
> Nuances
>   Early-boot resource re-use
>   Memory Block Alignment
>   memmap_on_meomry + ZONE_MOVABLE
>
> ----------------------------------------------------
> Next up:
>   RAS - Poison, MCE, and why you probably want CXL=3DZONE_MOVABLE
>   Interleave - RAS and Region Management
>
> ~Gregory
>
