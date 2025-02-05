Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC3191493
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771574; cv=none; b=kTmgmqAVHazlBciqLB5i47wp1JAkViRqRMEbp3+GhP1/cpELBdjWh5jXVYdH5lmj8druyHp2zPnf9hoZeB/+Wlvr031et1D+2BwY/SdzHloY4N03ESG0WZoBlnIQD3Pxa7CuCXtircvIo3atpU3PVDzsoyJRgvP3AXXfy2E1ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771574; c=relaxed/simple;
	bh=2k4OIvFwpgDmPtngF7PHhclVO299hl+2a0vTG+sO5pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzOwxqwjERxEEaJeDoNU4TzHf/Idq24IBl858uwK4J7p7Xa9/4wrCmhP9X7NEF3xcSyuHfLuczETWrN9mviVlJnBUb1MS+nxQdNpv2wvMk6lYBVTHwMtOIu+4OUPmZ5HQJE/1faTXfCjDlYtu8ZQQoplqYFXROvCrEQ9b4+3Hoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VIGEFECV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VIGEFECV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a3c85e11so43262601cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 05 Feb 2025 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738771571; x=1739376371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RtR+/2+vJwWC8LPRbdeCn1fr1KijuWFk6Bt2w0eRwc=;
        b=VIGEFECV+wd0tF7Qhfi3ZZzP7lxkSsI2+uhC9rXa/SNAaSEpjWuEZdgPS+MG1ZBxfA
         1gNvaNirNWh0UyQZvFHLqtf0lgX4XZGXW+V/631r7gK1fiuthNzMytiC62ME0L5Tur17
         IOEiIerRvRMk5hcyD1mHO8iOjYOh++X2jshJbfj44WTAeykxrkBqNrAsCu3WNstwC61B
         iiD4Jw79jPHqwbamgC4SAUhj5b6XdrjJLmwiJeliwpoyxyZ1wOOPfnV4ZB3j8qKevgEt
         37a17ptQR19XH5iWls6kEH9tx7h5QFC2IYlNvljeAOjsonjcGp7y93mIWgXuvIZ1MXyJ
         tCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771571; x=1739376371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RtR+/2+vJwWC8LPRbdeCn1fr1KijuWFk6Bt2w0eRwc=;
        b=fkT5Yz/xFASlJMkTlUEaCsGSA/GS2xG8A/qyZN/LDze1LdGCR29RPVccWifg0M8Z23
         rZdgZVTGsGfVltvlFdGb9PkqmMhpUZrneF6A2rrmfhUtcJXr88rkv0hgIGg0QmltYPsJ
         +lrEphJFzAuyFB95JYPbtAlv8X4ZPUq1zCOi9gWkUcybd9GFW6c4TslDoDXfyCw2E0ht
         M7Zks1Lj96Gqutq7OALCBGSpywpJWgZG+IEeDoLVM7GWbQ3jVMjtsRkEF/QRPG2woSWV
         hGlQVgUrB2qCOVS70b/Ebt15moVo2CJCd2iV7/209NeQIsij/lkuf3P7QH3L0Ccl6T1x
         Ryhw==
X-Forwarded-Encrypted: i=1; AJvYcCVoNuc3zYsc5kD2A5iLJ8/SaWfCSKNgQUv96swfz5tA0k3wt9v2+my8330vV2Gfbi51+Zumlusa6bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8iuQCtjKxlmDSG7sdYljHadO5KYh1E2RK6aZ7wfm4RXRnbjG
	dkygoxY6Sp/LS6FCqGzDFXrwnEvcyXsWqT06X8N9F9uZAGNIPbXasSq0H4Gobso=
X-Gm-Gg: ASbGnctRx7tDoSwfvY/rQd5MvCIpvQQ9Lk70aFxJmZthyuAyJq3GUa0wcsHqqnpCtiZ
	w6y+22z4zJEXurbNIGCJPCOUktPod2NMvIfFgdKghlu/k7ssM1JWhX9Q/UohRwGCM+ufpOaaIVf
	nDNHaNk4uVRqiyncaifa2U4vXhtSW594IcOT1W/tQ7b1QQ5sWNtbPopsCP5XAkEE/UGlMtNeYW3
	JvZZA3gtjpkH+M+z6f4Ay96lTt2+BIyAEo2HtXqrDac72TJ1s9fO6j1Y4iKZghYUt/i6FpAmBSx
	T11uR9tee8kS7zcqsPJ4mYYchwJxFxzpP7nosiFZe60mCnGkhPPk1VQH4PwOhnGHfuOPO8zUoQ=
	=
X-Google-Smtp-Source: AGHT+IFgnrB6Xi1DmmsezS76vJs01fy6PDZJgZsh76Mfnx4A8g6iZOvyt772etAwkiXourOCWwc8QQ==
X-Received: by 2002:a05:622a:199b:b0:467:6901:7589 with SMTP id d75a77b69052e-470281d0e07mr38522361cf.29.1738771570680;
        Wed, 05 Feb 2025 08:06:10 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0a768bsm71859021cf.7.2025.02.05.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 08:06:10 -0800 (PST)
Date: Wed, 5 Feb 2025 11:06:08 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: CXL Boot to Bash - Section 2: The Drivers
Message-ID: <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
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

(background reading as we build up complexity)

Driver Management - Decoders, HPA/SPA, DAX, and RAS.

The Drivers
===========
----------------------
The Story Up 'til Now.
----------------------

When we left the Platform arena, assuming we've configured with special
purpose memory, we are left with an entry in the memory map like so:

BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] soft reserved
/proc/iomem: c050000000-fcefffffff : Soft Reserved

This resource (see mm/resource.c) is left unused until a driver comes
along to actually surface it to allocators (or some other interface).

In our case, the drivers involved (or at least the ones we'll reference)

drivers/base/     : device probing, memory (block) hotplug
drivers/acpi/     : device hotplug
drivers/acpi/numa : NUMA ACPI table info (SRAT, CEDT, HMAT, ...)
drivers/pci/      : PCI device probing
drivers/cxl/      : CXL device probing
drivers/dax/      : cxl device to memory resource association

We don't necessarily care about the specifics of each driver, we'll
focus on just the aspects that ultimately affect memory management.

-------------------------------
Step 4: Basic build complexity.
-------------------------------
To make a long story short:

CXL Build Configurations:
  CONFIG_CXL_ACPI
  CONFIG_CXL_BUS
  CONFIG_CXL_MEM
  CONFIG_CXL_PCI
  CONFIG_CXL_PORT
  CONFIG_CXL_REGION

DAX Build Configurations:
  CONFIG_DEV_DAX
  CONFIG_DEV_DAX_CXL
  CONFIG_DEV_DAX_KMEM

Without all of these enabled, your journey will end up cut short because
some piece of the probe process will stop progressing.

The most common misconfiguration I run into is CONFIG_DEV_DAX_CXL not
being enabled. You end up with memory regions without dax devices.

[/sys/bus/cxl/devices]# ls
dax_region0  decoder0.0  decoder1.0  decoder2.0 .....
dax_region1  decoder0.1  decoder1.1  decoder3.0 .....

^^^ These dax regions require `CONFIG_DEV_DAX_CXL` enabled to fully
surface as dax devices, which can then be converted to system ram.


---------------------------------------------------------------
Step 5: The CXL driver associating devices and iomem resources.
---------------------------------------------------------------

The CXL driver wires up the following devices:
   root        :  CXL root
   portN       :  An intermediate or endpoint destination for accesses
   memN        :  memory devices


Each device in the heirarchy may have one or more decoders
   decoderN.M  :  Address routing and translation devices


The driver will also create additional objects and associations
   regionN     :  device-to-iomem resource mapping
   dax_regionN :  region-to-dax device mapping


Most associations built by the driver are done by validating decoders
against each other at each point in the heirarchy.

  Root decoders describe memory regions and route DMA to ports.
  Intermediate decoders route DMA through CXL fabric.
  Endpoint decoders translate addresses (Host to device).


A Root port has 1 decoder per associated CFMW in the CEDT
   decoder0.0  ->  `c050000000-fcefffffff   : Soft Reserved`


A region (iomem resource mapping) can be created for these decoders
   [/sys/bus/cxl/devices/region0]# cat resource size target0
      0xc050000000   0x3ca0000000   decoder5.0


A dax_region surfaces these regions as a dax device
   [/sys/bus/cxl/devices/dax_region0/dax0.0]# cat resource
      0xc050000000


So in a simple environment with 1 device, we end up with a mapping
that looks something like this.

     root      ---   decoder0.0  --- region0 -- dax_region0 -- dax0
       |                |              |
     port1     ---   decoder1.0        |
       |                |              |
     endpoint0 ---   decoder3.0--------/


Much of the complexity in region creation stems from validating decoder
programming and associating regions with targets (endpoint decoders).

The take-away from this section is the existence of "decoders", of which
there may be an arbitrary number between the root and endpoint.

This will be relevant when we talk about RAS (Poison) and Interleave.


---------------------------------------------------------------
Step 6: DAX surfacing Memory Blocks - First bit of User Policy.
---------------------------------------------------------------

The last step in surfacing memory to allocators is to convert a dax
device into memory blocks. On most default kernel builds, dax devices
are not automatically converted to SystemRAM.

Policy Choices
   userland policy:  daxctl
   default-online :  CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
                     or
		     CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
		     or
		     memhp_default_state=*

To convert a dax device to SystemRAM utilizing daxctl:

  daxctl online-memory dax0.0 [--no-movable]

  By default the memory will online into ZONE_MOVABLE
  The --no-movable option will online the memory in ZONE_NORMAL


Alternatively, this can be done at Build or Boot time using
  CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE   (v6.13 or below)
  CONFIG_MHP_DEFAULT_ONLINE_TYPE_*       (v6.14 or above)
  memhp_default_state=*                  (boot param predating cxl)

I will save the discussion of ZONE selection to the next section,
which will cover more memory-hotplug specifics.

At this point, the memory blocks are exposed to the kernel mm allocators
and may be used as normal System RAM.


---------------------------------------------------------
Second bit of nuanced complexity: Memory Block Alignment.
---------------------------------------------------------
In section 1, we introduced CEDT / CFMW and how they map to iomem
resources.  In this section we discussed out we surface memory blocks
to the kernel allocators.

However, at no time did platform, arch code, and driver communicate
about the expected size of a memory block. In most cases, the size
of a memory block is defined by the architecture - unaware of CXL.

On x86, for example, the heuristic for memory block size is:
   1) user boot-arg value
   2) Maximize size (up to 2GB) if operating on bare metal
   3) Use smallest value that aligns with the end of memory

The problem is that [SOFT RESERVED] memory is not considered in the
alignment calculation - and not all [SOFT RESERVED] memory *should*
be considered for alignment.

In the case of our working example (real system, btw):

         Subtable Type : 01 [CXL Fixed Memory Window Structure]
   Window base address : 000000C050000000
           Window size : 0000003CA0000000

The base is 256MB aligned (the minimum for the CXL Spec), and the
window size is 512MB.  This results in a loss of almost a full memory
block worth of memory (~1280MB on the front, and ~512MB on the back).

This is a loss of ~0.7% of capacity (1.5GB) for that region (121.25GB).

[1] has been proposed to allow for drivers (specifically ACPI) to advise
the memory hotplug system on the suggested alignment, and for arch code
to choose how to utilize this advisement.

[1] https://lore.kernel.org/linux-mm/20250127153405.3379117-1-gourry@gourry.net/


--------------------------------------------------------------------
The Complexity story up til now (what's likely to show up in slides)
--------------------------------------------------------------------
Platform and BIOS:
  May configure all the devices prior to kernel hand-off.
  May or may not support reconfiguring / hotplug.
BIOS and EFI:
  EFI_MEMORY_SP              - used to defer management to drivers
Kernel Build and Boot:
  CONFIG_EFI_SOFT_RESERVE=n  - Will always result in CXL as SystemRAM
  nosoftreserve              - Will always result in CXL as SystemRAM
  kexec                      - SystemRAM configs carry over to target
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

--------------------------------------------------------------------
Next Up:
   Memory (Block) Hotplug - Zones and Kernel Use of CXL
   RAS - Poison, MCE, and why you probably want CXL=ZONE_MOVABLE
   Interleave - RAS and Region Management (Hotplug-ability)

~Gregory
