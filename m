Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5F3BBA14
	for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024366; cv=none; b=KMkbJ4kj6H86oVlyAYL4UsWAI6st+wgZAc+9vKiQZNaP7xJlXBOSeoTW6fnn/Q0NsGNNTpjZcYctDIej8vvMBpw4jFZu1O7o16kHkoBCSmUSEK1jjs+m6TR9Bvw+2y8Zeshwv382tX2hpY9LYTRE3vjjEKDTEKMmWwEZfFBK5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024366; c=relaxed/simple;
	bh=+z0M6TjzAaFxroJ82pTYE4olWLYHnuO2bDXqopI77Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sG1aUo5f1Wqjw5sdnLQS0H+RTDw9P1+S304BPHTOYBXXkVI79h+H6Wddqcz5mDHK2N72OoOdmLgihQzQATy/EpyPMBp/yZUrVMYKW6aNxIQCmDnSwLrRK3JpuvXJ6s3mSS2kIWtzLScdPwVzCrJqiNbr1UUBtsuoS0RwlRL4GjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=miquUrcO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="miquUrcO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8887ac841e2so1947596d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Jan 2026 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769024361; x=1769629161; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1V80Sn6RZwt6JK+nRNVlhds6ePvblgqL7ccSLBJdPQ=;
        b=miquUrcOFIuJvBEk3t6qHbWWZAcb/Be8hKh31xfXgw/OyCD68Tx0OSL3G+GlAVBsOl
         LiMZ8gFexerJhKZXmyLx3X8ZJH78jMc2HRaH1wocDnkQ15L9pFg9LncPK8qaqxL95wHu
         TmTjdprpn0VLhk/5YTP/LBo589u03pg/OMk0KdEUktdcNa3XlJGeQFIW8BFDh+sPksW/
         tQUj74nEOfX2DQweFEQXnfEwcbzY+fOsiPv43GmgSAlQhtwKqCw02wPB4IQ2iqehH0V3
         hfv67shScIB8BjBtilEWzp3q+dhuxZpoHxOpnGVJ1sSFPKVhCYu7YYftL6eQt6y73ouA
         BMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769024361; x=1769629161;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1V80Sn6RZwt6JK+nRNVlhds6ePvblgqL7ccSLBJdPQ=;
        b=woZXHKRFNUBmMGgpZph4GUUlWloTyxrcYeZ/TLds20nsc9lqfOSCNPcoEqhXirMKbM
         E2wJ9Xx47TymLHPuJqO+qE2nKx1XAdwos9IuveWrsbFnFpVwXHDt/+9AMGK3uDdF3Val
         kswIMfbjlTtNysHjBKo7EBIbNh7m2jrTTBg9IY6wkQxPiasoooF0WKLCjWAfsH8pMRED
         Z17v4SaUtXfO7ZwGZCkTbqHxKgN8DOK82qsyNF7YJkcz4IKDU0kO3jtXrrvQgB9vDUqG
         ZtK3gSkTxrNsIkSwBQUTXf+FRdRXyGkjHcxmo9BigoAlpLxVVh3Z+eTJr6BGEpPlQhq8
         4Sdg==
X-Gm-Message-State: AOJu0YyQgm/jZUSXE6KuS5IPG4iuCT8fO3Xxw8aejevW2NxAUtVdwSMj
	Hd0gu7rvM7igzd/+xD5G8Es5ji7hcqJ3fNULK5bKhyqmWsNXXFRabYps3o3LxXw8XQ5bO9MrebF
	5qTQrLM4=
X-Gm-Gg: AZuq6aJIpBZqEV0zeRbKXmFqzxmBwVBQYOjn03FiDq3/PTZ7cRA+OwQP7sNNvBEkqGl
	ounJZnJpwAHn0TSkp/yVfCyacCaUto37/hjiODNCFRbFxXTJ2ymgar8Mik8rq25oDvZWXkcTK8C
	dt+37k6IyRGyY/R8jQqXGSOUAyuD/Exry7mZd9B5xctwjFMB4jKkgNI543IeRRjnHYR5LSF6BWS
	z1SRAb2HLlwXW3BWZrOm1Wf0pLmL9TgXZMVTl3OOsuR70UMt9gf8B9mg4jMKwwcMOCafx0AGts4
	nzzcWc4EdgV/T5a6okG7Rff7lJdrRc5lsXB77TdzGZqSlIqgzrWf9unFrQ6y7DWB7PEcfCa2JvC
	9EibSPn1vRxNgeBbraqyiKrPAUXdlN/gl4q/nAyi3vUnLmWe+MoZmPGoN+wxNs8lxI6D209tCDh
	zAwrMeFZU2kAu7Yocya4V1LXvSBA6Xzag1smxVmDxT0te+wz2bZzmtMoc6AFoxjQcF5DZaGg==
X-Received: by 2002:ad4:4eaa:0:b0:894:76f1:b6f7 with SMTP id 6a1803df08f44-89476f1b7a0mr34031996d6.14.1769024361169;
        Wed, 21 Jan 2026 11:39:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad8b0sm135412426d6.28.2026.01.21.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 11:39:20 -0800 (PST)
Date: Wed, 21 Jan 2026 14:38:48 -0500
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, dave@stgolabs.net,
	linux-kernel@vger.kernel.org, gourry@gourry.net,
	kernel-team@meta.com, vishal.l.verma@intel.com, david@kernel.org,
	benjamin.cheatham@amd.com
Subject: cxl/region.c improvements and DAX/Hotplug plumbing
Message-ID: <aXErSP1zKnv4koKG@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Jonathan asked me to summarize my roadmap/thoughts, so below is the
gist of it: observations, high level design details, some patches.

@David (Hildrenbrand): I CC'd you due to DAX and MHP discussion.


My larger motivation is identifying and solving friction between
different use-cases trying to leverage a single backend: DAX

My personal motivation is to drive towards a defensible abstraction
for CXL-backed N_PRIVATE_MEMORY nodes.

~Gregory

<great wall of text> 
=================================================================
TL;DR: 

   The current CXL-DAX glue is not flexible enough for everyone.

   Lets treat dax_region as a specific mode of operation, and
   offer additional x_region modes as "region drivers" with
   their own policies on how to handle the memory capacity.

=================================================================

Overview
========

To me - this appears to all intersect at drivers/cxl/core/region.c

Today: regionN/ has a static "backend interface" when it's created.
       for ram_region  - DAX     (or NONE for BIOS config SysRAM)
       for pmem_region - NVDIMM
       for dc_region   - DAX?    (not upstream/settled)

The DAX plumbing (as-is) lacks some flexibility to handle multiple
use-cases - especially DCD and some accelerator features.

For current-use, the DAX glue (dax_region) has some rough edges:
 - per-region dax-driver preference not plumbed (kmem, devdax, fsdax)
 - per-region auto online preference not plumbed (kmem)
 - per-region hotplug protection not plumbed (memblock races)
 - DCD implied sparseness (runtime allocations) - but no sparse-DAX.
 - DCD Tags may be needed by user software, but no ABI (dax/uuid?).
 - DCD Tags imply consumption policy, but no infrastructure.
 - Onlining as NUMA is all or nothing:
   Whole system gets access or driver has to write own mm services

Some policy above can be mutually exclusive.

Example: Can't have driver-wide auto-probe() auto-online policy on
         systems with multiple devices using the dax glue.

	 This drives userland complexity - tools have to understand
	 multiple subsystems.

Example: Tag-consumption policies may differ between use cases.
         sysram - might ignore
         famfs  - might use as filesystem information
         virtio - might use as routing info for target VM

So putting auto-configured regions aside (tl;dr: BIOS people pls no),
the core proposal is to formalize:

   cxl_region.region_driver

that encodes some of this common policy.

Some of the simple backends might be userland exposed, for example:

   cxl create-region --driver=sysram --auto-online=online_movable
   cxl create-region --driver=dax --daxdev=fsdax

Some of these backends might be intended for building device drivers

my_famfs_driver.c
   cxl_create_dcd_region(..., my_dcd_hotplug_callbacks);
   /* May use tags as filesystem information */
   (Don't worry John - just an example, not prescriptive)

my_virtio_driver.c
   cxl_create_dcd_region(..., my_dcd_hotplug_callbacks);
   /* May use tags for routing capacity to VMs */ 

my_accelerator_driver.c
   cxl_create_private_region(..., my_callbacks, NODE_TYPE_ACCEL);
   /* Wants memory as a NUMA node, but isolated from allocations */

This also encourages some amount of code re-use:
    the core sysram driver can be the same for static-regions and
    dcd, but dcd calls hotplug()/unplug() functions at runtime.

It also encourages upstreaming/specification of some operations.

My list of current discrete steps (some serial, some parallel):

   1) Internally formalize cxl_region.region_driver (no ABI exposure)

   3) Plumb additional information through to DAX based on driver
      - dax-driver mode preference
      - uuid for tagged capacity

   2) Create explicit sysram_driver
      - Write in terms of DCD
      - Tagged Extents:   use DAX glue to manage set of tagged extents
      - Untagged Extents: Hotplug and manage directly
      - new ABI: `region0/region_driver` - switch between [dax,sysram]

   4) Plumb additional hotplug policy from CXL into DAX and MHP
      - dax0.0/hotplug  (atomic operation on all blocks)
      - cxl region auto-online policy (region0/rctl/auto-online)
      - block-protection policy? (memory_notifier controls)
      - hiding memory blocks? (discussed in last meeting)
      - ABI: `region0/rctl/*` controls

   5) Formalize DCD dax_region driver use
      - each extent list = new dax device in devdax mode
      - tags enforced to be globally unique
      - dax_region.add_extents(tag, extent_list)
          -> create new daxN.0
          -> expose daxN.0/uuid
      - dax_region.remove_extents(extent_list)
      - dax_region.remove_tagged_extents(tag)

   6) Formalize DCD sysram_region driver use
      - sysram_region.add_extents(tag, extent_list)
          -> untagged capacity managed as individual memory blocks
          -> tagged capacity managed with DAX glue
      - sysram_region.remove_extents(extent_list) (untagged)
      - sysram_region.remove_tagged_extents(tag)  (tagged)

   7) Add private_region infrastructure
      - private_region driver design
      - N_PRIVATE_MEMORY infrastructure
      - derivative driver (in my case compressed memory)
      - Probably wants memory_blocks hiding and/or retricted operations


========================================================
Specific problem descriptions and ABI/NDCTL implications
========================================================
--------------------------------
Problem: Per-region usage policy
--------------------------------
  Use-case-driven requirements are testing the limits of the existing
  region driver and dax integration designs, and encoding the policies
  related to them in region.c is going to get cumbersome.

  Use-case 1: Static Volatile RAM   (none, dax_region w/ single dax dev)
  Use-case 2: Static PMEM           (pmem_region/NVDIMM)
  Use-case 3: DCD SysRAM            (sysram_region w/ hotplug)
  Use-case 4: SP Anon Memory        (compressed_region - private_region)
  Use-case 5: Static FAMFS Region   (dax_region w/ single daxdev)
  Use-case 6: DCD FAMFS Region      (dax_region w/ multi-daxdev)
  Use-case 7: Accelerator Memory    (private_region)

  "Private" here means exposure to rest of the system is driver-defined
  but there may be re-usable infrastructure.

  The CXL driver is the right place to expose the region driver choice.
  - Users use common memory region types (sysram, dax) from ABI/CLI.
  - Device drivers can register a region types w/ default operations.
  - Special devices implement advanced usage policy w/ private region.

  Solution:  Discrete regionN backend drivers, I list some above.
             (none)  - Static SYSRAM Region setup by BIOS
             DAX     - has multiple modes (devdax, kmem, fsdax)
             sysram  - Dynamic SYSRAM region w/ more functionality
             private - integrate w/ N_PRIVATE_MEMORY infrastructure
  
  Region drivers re-used for multiple region types (e.g. ram vs dcd).
  - ram_region w/ sysram driver calls add()/remove() at setup/teardown.
  - dc_region w/ sysram driver calls add()/remove() at runtime.

  ABI:  (RW) regionN/region_driver
        Read: Displays what region driver is assigned
        Write: Changing an uncommitted region's underlying driver

  ABI:  regionN/rctl/*
        Exposes region_driver specific controls / information
        example: auto-online policy for sysram_region
  
  ndctl extesion:
      cxl create-region --driver=_____

Starting Patch Link:
https://lore.kernel.org/linux-cxl/20260113202138.3021093-1-gourry@gourry.net/

---------------------------------------------------------
Problem: SysRAM Auto-Hotplug policy is too broadly scoped
---------------------------------------------------------
  Hotplug SYSRAM indirection through DAX leads to complex auto-online
  interactions and/or current policy options are too broad in scope.
  (e.g. MHP_AUTO_ONLINE build option is bad cross-platform)

  Solution 1: Plumb auto-online policy from cxl_region into dax_kmem

    Build Options:
       Default auto-online policy for auto-regions?
       Moves scope from MHP-Global to CXL-local

    ABI: dax_region - regionN/rctl/auto-online
       Gives the region creator a chance to define before probe()

  Solution 2:  Make a dedicated sysram_region with policy

  May want both solutions longer term (for tagged DCD capacity)

  ndctl extension:
       cxl create-region --driver=sysram --auto-online=movable ?

---------------------------------------------
Annoyance: DAX driver binding could be easier
---------------------------------------------
  dax_region encodes a default dax device type
  - RAM wants kmem
  - other users might want fsdax, devdax
  - Other tools can bind the wrong driver

  If your DAX use-case is not the default, more setup steps required.

  Solution:
    Plumb dax driver default / restriction from cxl_region through to
    DAX. Disallow bind-operation (-ENOSUPP) based on that policy.

  We can't prevent unbind, but we can prevent bad-bind.

  ndctl extension:
     cxl create-region --driver=dax --daxmode=[devdax,kmem,...]

  Backward Compatibility:
     The current ndctl w/o new args would essentially be

       cxl create-region --driver=dax --daxmode=devdax

     And all the follow up operations would work as-is.

---------------------------------------------------------------
Problem/Annoyance: DAX kmem per-block operation race conditions
---------------------------------------------------------------
  DAX exposes SYSRAM regions as individual memory blocks, which
  creates race conditions when trying to manage a set of blocks.

  Example: udev can have an auto-onlining policy that twiddles
           memory_block bits while cxl driver is trying to unplug.

  Affects: DCD, SysRAM, potentially N_PRIVATE_MEMORY

  Solution 1: [unplug, online, online_movable] > dax0.0/hotplug
              Does operation on all blocks under the hotplug lock.

  Solution 2: dedicated sysram_region driver w/ or w/o DAX.
              Can support sparseness w/o DAX (see DCD problem)
	      Could use DAX for tagged DCD regions.
              Tradeoff: May duplicate some DAX logic.

  Solution 3: Hide nodeN/memory_block's w/ MHP Flag.
              Issue: Possibly userland breaking.

  Solution 4: Prevent non-driver actions from changing state.
              Also solves hotplug protection problem (see next)

Patch: Implements solution 1
https://lore.kernel.org/linux-cxl/20260114235022.3437787-5-gourry@gourry.net/

--------------------------------------------------------------
Problem: SYSRAM or N_PRIVATE want memory_block policy controls
--------------------------------------------------------------
  A SYSRAM or N_PRIVATE region may have an implied zone-policy to
  protect - or N_PRIVATE blocks may want to restrict any operation.

  Privileged userspace action could do this:
    cat memoryN/state              => online_movable
    cat memoryN/valid_zones        => movable
    echo offline > memoryN/state   => offline
    echo online > memoryN/state    => online
    cat memoryN/valid_zones        => normal

  - A DCD driver wants to try to protect hotpluggability.
  - userspace has no business twiddling private_region blocks.

  Solution: Prevent non-driver actions from changing state.

      Essentially, add memory_notifier to region_driver or DAX
      that rejects operations according to driver-defined policy.

  May not require explicit, could be encoded in default region
  driver policy (e.g. dcd implies protection).

Example Patch:
https://lore.kernel.org/linux-cxl/20260114235022.3437787-6-gourry@gourry.net/

-----------------------------------------------------
Problem: DCD Tags are confusing and make people angry
-----------------------------------------------------
  DCD untagged extent sets are confusing and make people angry.
  DCD tagged extent sets are confusing and make people angry.

  Solution:  Per region_driver policy

  Example 1: SysRAM
     Linux cares about memory-block aligned contiguous chunks.

     Everything else is basically an opini... policy.

     My opinion
     ----------
     Untagged extents:
        Managed individually, and doesn't need a DAX device to
        online (hotplug directly from sysram_region.c).

	May be sparse.
	Even if arrive together, may be released separate.

     Tagged extents have two options:
       Manage set of extents as a collective block: dax0.0/hotplug

  Example 2: DAX  (FAMFS)
     Tags may actually mean something.

     Linux should enforce globally unique tags per set of extents.
         Each tagged set of extents comes/goes collectively.
         Sparseness not allowed
             set(A) and set(B) have unique tags
             set(N) arrives together w/ MORE=1 set in logs.
         Each tagged set is exposed as a separate dax device.
             
     DAX likely requires a dax0.0/uuid to provide consumers info.


  Example 3: virtio
     Tags may imply destination VM capacity

     In this case, a tag is essentially just routing data.

TL;DR:
    Implementing region_drivers lets us break up the tag debates
    into discrete use-case silos.

---------------------------------------------
Problem: "Special" Device memory usage policy
---------------------------------------------
   Memory devices may have special features that dictate use patterns.
   They may also prefer using core mm/ services for basic operation.
   (page_alloc, reclaim, migration, etc)
   
   But: This memory shouldn't be exposed as "Normal System RAM".

   Solution: N_PRIVATE_MEMORY node_state

   CXL Driver Piece: private_region driver
       These drivers would know how to register N_PRIVATE_MEMORY
       Would also allow device-specific usage behavior to be written.
       Would likely be used by upper layer drivers rather than uapi.

   Example:  Compressed Memory

     general service can use page_alloc() for get_page_from_freelist()
     region_driver registers memory on a compressed memory node
     vmscan.c/memory-tiers.c calls back to driver to handle migration

   Example:  Accelerator Memory Region

      Accel library/drive does node-based allocs.
      Driver callbacks might include write-faults (ZONE_DEVICE-esque
        pattern that passes page ownership between CPU/GPU)

      Either way, driver applies mapping policy w/o accounting cargo

   Example:  Slow(er) memory
      Some memory is "just memory", but might be particularly slow and
      intended for use as a filesystem backend or as only a demotion
      target.  Otherwise its allocated / mapped like any other memory,
      but it still required isolation so isolated to the demotion path
      and not a fallback allocation target 

      Driver basically say: kernel should prefer reclaim over fallback.


   Benefits:
      Simplifies driver design.
      Encourages upstreaming common operations as new spec extentions.
      Keeps device policy out of mm/

   ABI:  region/rdrv/*    (maybe?)

   More likely something like vendors just build derivative drivers:

   driver/[common_use]/[vendor]/my_driver.c
      #include linux/cxl.h
    
   If cxl decoders involved, common driver can programs and make the
   private_memory region, device-driver provides relevant callbacks
   for the N_PRIVATE_MEMORY infrastructure.

   If decoders programming not involved, device can call private node
   infrastructure directly and omit cxl-patterns.

RFC:
https://lore.kernel.org/linux-cxl/20260108203755.1163107-1-gourry@gourry.net/

================================================
</great wall of text>

