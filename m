Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D8101DE;
	Tue,  3 Jun 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748968341; cv=none; b=DoB9Q8Bx4KoKd1BbT1dpdkTl4c61SmZMYP0OuP/pA9Mn69MgQvvQ56o9OXyUmSMfabMG5cFqLO33x23spGna2aYv0H3OnaUd40skLR7H9V02Ny11KENjZLXKLvFenm6FX+b5gbB1LlFHCq52oD54lTW8zYeXYH1fMGKcqJ4cOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748968341; c=relaxed/simple;
	bh=uC8osh/nCkJI/NtYkXLcR56cra/MRSlR32YmXN0gI4A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY6ILpceMZiqqNwnDY/oOJWMlBCkfl/kGz/VBXS/CPMMW/YzrLOP/wzFjr1o1k7+IsFo7sPM67yboq7E4MMrh5mBXwujXyiivBVvFuHmZTL8fISWDsrnTi381+ygiR22Y6k75TD2U83aXchNyRw03+MU4jX1fb8NshsTG6qyOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Etbi9b1A; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etbi9b1A"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3127cc662e2so66859a91.0;
        Tue, 03 Jun 2025 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748968339; x=1749573139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kixx20G90NfDaZrSLCKxFDSGbcs9K+8qnmD/aEbezXs=;
        b=Etbi9b1ASMvsNd0EAnFmpyMmwcsvcr13mKXvVqbLjU3LyixV/W5Uq9NmpWuBlYXwzx
         21b+hNPem7meyi4BWahGEYEEki2UBQna2TPvVIsKO7hS4af7szxgcGTEq7HwhSlRbSa+
         Ow9PHNhAmmS9hcImW04a/Ffa+q36elP1y6N06AdqxrOUs5wdF3aE9RONjrvXJAJpO27r
         683WnymFhSYBOZZuQizaTBJl8C//ozyEDyGIhkzqu3KXTc3JOXDe5pJWzTdliRaGvyAk
         Yt03FkHihANs2BoqHsiZSgXc/XtgK+4FgM9VcOukgYio3IXeQ5pCQ3zgoIEQQivVQwV0
         GnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748968339; x=1749573139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kixx20G90NfDaZrSLCKxFDSGbcs9K+8qnmD/aEbezXs=;
        b=C+hgsPoa4llEUQkAaeoGZvSN5HK+kQSOb6Zmiij1NoBcuicifeJNoWVye5BAjc96mC
         6l5Z3NvN2FM6XA2X4k7hOKijSURIquE40o1p/NGYxK8vJlrqmSTofqBxyJw9flmE90u+
         zcUqv+1AN1QtAqVnTU+yG+aT21M4+ImOU19A3sK6WW5TDacqmLBIQRwmKHzwa6YwsKio
         VfSYqyKz/t5Y0MnAGZgeMCp/jmjbB1dphuUn4D0049Sb8gKxoUosknIvpt2Hv5S5nxsa
         3r0iYs2CSbHeUd6UlvJcoEqO2FKyB9wYhpDCr5655QXOdranbxB2plZucxatXL92YbRi
         iRxw==
X-Forwarded-Encrypted: i=1; AJvYcCVDLrSwwiVEP6ow7WUVwTwPCAoZzDM3Oa1dVHFQcUfEtbsFCqWUB+T+0eddv0qCElIPROtEw0npTHl3ps2h@vger.kernel.org, AJvYcCXds0W65sl82GwIEO4/iwVpEH3J9WgvGBdwghSavypYHZtz1t3Ii7F4scLqKcE/DRcIf+d52p3xyac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7E+okXbR0vicOdoS1fj1WWWHMtIWrtgn86c1CuyROsfxHmZm
	x7KCX7ajo3QllHJcSzwwLctDnKH6UN4KAiNKazGTUIPi867+vAe0XPv3
X-Gm-Gg: ASbGncu8ZDpM1MvwrTG1aLv6ZtVnWx1tDOZuZHxJW1M2xVvjagu6ophppuHbh8esmZA
	MXb7NzCMVZdMwXRepSlRlmdjkjAhj+ZJljs5l78eo/x0Zk8USrF1agbxeFkKsnaa5tFtUCeFPtu
	CvlLvM5NwWJoNTLlkmHts1b3lj2Zv5SVsxABv5ANqwq6Xprtowmzsgxkue0cwrOd2vV66f4h2hx
	dtRK0GGlm5IpqacE+7uEpdaVABaHb2AbBQwfq+BXsIec7/CpdJIwNpBtm/ouIY6ldwFTKr7j0L9
	QtBlinabXEEJ2XCHVRmGR10LuhZ65HZgnPa144865vRyfHmqQm+a
X-Google-Smtp-Source: AGHT+IGFO4rBMAK7cGw+Qk6Y3U6feFRZLMSnaFOQeXcr/KKxBfAWfqO+FNobiOEAfbYyC/6yhO1sqQ==
X-Received: by 2002:a17:90b:4f4b:b0:311:1617:5bc4 with SMTP id 98e67ed59e1d1-312e8029394mr4654587a91.12.1748968338804;
        Tue, 03 Jun 2025 09:32:18 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2436:375a:a3a6:7932])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-312e72f3812sm963543a91.0.2025.06.03.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 09:32:18 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 3 Jun 2025 09:32:15 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 00/19] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <aD8iuf6J_jhyOK6v@lg>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>

On Sun, Apr 13, 2025 at 05:52:08PM -0500, Ira Weiny wrote:
> A git tree of this series can be found here:
> 
> 	https://github.com/weiny2/linux-kernel/tree/dcd-v6-2025-04-13
> 
> This is now based on 6.15-rc2.
> 
> Due to the stagnation of solid requirements for users of DCD I do not
> plan to rev this work in Q2 of 2025 and possibly beyond.
> 
> It is anticipated that this will support at least the initial
> implementation of DCD devices, if and when they appear in the ecosystem.
> The patch set should be reviewed with the limited set of functionality in
> mind.  Additional functionality can be added as devices support them.
> 
> It is strongly encouraged for individuals or companies wishing to bring
> DCD devices to market review this set with the customer use cases they
> have in mind.

Hi,
I have a general question about DCD.

How will the start dpa of the first region be set before any extent is
offer to the hosts?

In this series, no dpa gap (skip) is allowed between static capacity and
dynamic capacity. That seems to imply some component that knows the layout
of the host memory will need to set the start dpa of the first dc region?
The firmware?

Also, if a DC extent is shared among multiple hosts each of which has
different memory configuration, how the dcd device provides the extents
to each host to make sure there is no dpa gap between static and dynamic
capacity range on all the hosts?
It seems the start dpa of dcd needs to be different for each host. No sure how
to achieve that.

Fan

> 
> Series info
> ===========
> 
> This series has 2 parts:
> 
> Patch 1-17: Core DCD support
> Patch 18-19: cxl_test support
> 
> Background
> ==========
> 
> A Dynamic Capacity Device (DCD) (CXL 3.1 sec 9.13.3) is a CXL memory
> device that allows memory capacity within a region to change
> dynamically without the need for resetting the device, reconfiguring
> HDM decoders, or reconfiguring software DAX regions.
> 
> One of the biggest anticipated use cases for Dynamic Capacity is to
> allow hosts to dynamically add or remove memory from a host within a
> data center without physically changing the per-host attached memory nor
> rebooting the host.
> 
> The general flow for the addition or removal of memory is to have an
> orchestrator coordinate the use of the memory.  Generally there are 5
> actors in such a system, the Orchestrator, Fabric Manager, the Logical
> device, the Host Kernel, and a Host User.
> 
> An example work flow is shown below.
> 
> Orchestrator      FM         Device       Host Kernel    Host User
> 
>     |             |           |            |               |
>     |-------------- Create region ------------------------>|
>     |             |           |            |               |
>     |             |           |            |<-- Create ----|
>     |             |           |            |    Region     |
>     |             |           |            |(dynamic_ram_a)|
>     |<------------- Signal done ---------------------------|
>     |             |           |            |               |
>     |-- Add ----->|-- Add --->|--- Add --->|               |
>     |  Capacity   |  Extent   |   Extent   |               |
>     |             |           |            |               |
>     |             |<- Accept -|<- Accept  -|               |
>     |             |   Extent  |   Extent   |               |
>     |             |           |            |<- Create ---->|
>     |             |           |            |   DAX dev     |-- Use memory
>     |             |           |            |               |   |
>     |             |           |            |               |   |
>     |             |           |            |<- Release ----| <-+
>     |             |           |            |   DAX dev     |
>     |             |           |            |               |
>     |<------------- Signal done ---------------------------|
>     |             |           |            |               |
>     |-- Remove -->|- Release->|- Release ->|               |
>     |  Capacity   |  Extent   |   Extent   |               |
>     |             |           |            |               |
>     |             |<- Release-|<- Release -|               |
>     |             |   Extent  |   Extent   |               |
>     |             |           |            |               |
>     |-- Add ----->|-- Add --->|--- Add --->|               |
>     |  Capacity   |  Extent   |   Extent   |               |
>     |             |           |            |               |
>     |             |<- Accept -|<- Accept  -|               |
>     |             |   Extent  |   Extent   |               |
>     |             |           |            |<- Create -----|
>     |             |           |            |   DAX dev     |-- Use memory
>     |             |           |            |               |   |
>     |             |           |            |<- Release ----| <-+
>     |             |           |            |   DAX dev     |
>     |<------------- Signal done ---------------------------|
>     |             |           |            |               |
>     |-- Remove -->|- Release->|- Release ->|               |
>     |  Capacity   |  Extent   |   Extent   |               |
>     |             |           |            |               |
>     |             |<- Release-|<- Release -|               |
>     |             |   Extent  |   Extent   |               |
>     |             |           |            |               |
>     |-- Add ----->|-- Add --->|--- Add --->|               |
>     |  Capacity   |  Extent   |   Extent   |               |
>     |             |           |            |<- Create -----|
>     |             |           |            |   DAX dev     |-- Use memory
>     |             |           |            |               |   |
>     |-- Remove -->|- Release->|- Release ->|               |   |
>     |  Capacity   |  Extent   |   Extent   |               |   |
>     |             |           |            |               |   |
>     |             |           |     (Release Ignored)      |   |
>     |             |           |            |               |   |
>     |             |           |            |<- Release ----| <-+
>     |             |           |            |   DAX dev     |
>     |<------------- Signal done ---------------------------|
>     |             |           |            |               |
>     |             |- Release->|- Release ->|               |
>     |             |  Extent   |   Extent   |               |
>     |             |           |            |               |
>     |             |<- Release-|<- Release -|               |
>     |             |   Extent  |   Extent   |               |
>     |             |           |            |<- Destroy ----|
>     |             |           |            |   Region      |
>     |             |           |            |               |
> 
> Implementation
> ==============
> 
> This series requires the creation of regions and DAX devices to be
> closely synchronized with the Orchestrator and Fabric Manager.  The host
> kernel will reject extents if a region is not yet created.  It also
> ignores extent release if memory is in use (DAX device created).  These
> synchronizations are not anticipated to be an issue with real
> applications.
> 
> Only a single dynamic ram partition is supported (dynamic_ram_a).  The
> requirements, use cases, and existence of actual hardware devices to
> support more than one DC partition is unknown at this time.  So a less
> complex implementation was chosen.
> 
> In order to allow for capacity to be added and removed a new concept of
> a sparse DAX region is introduced.  A sparse DAX region may have 0 or
> more bytes of available space.  The total space depends on the number
> and size of the extents which have been added.
> 
> It is anticipated that users of the memory will carefully coordinate the
> surfacing of capacity with the creation of DAX devices which use that
> capacity.  Therefore, the allocation of the memory to DAX devices does
> not allow for specific associations between DAX device and extent.  This
> keeps allocations of DAX devices similar to existing DAX region
> behavior.
> 
> To keep the DAX memory allocation aligned with the existing DAX devices
> which do not have tags, extents are not allowed to have tags in this
> implementation.  Future support for tags can be added when real use
> cases surface.
> 
> Great care was taken to keep the extent tracking simple.  Some xarray's
> needed to be added but extra software objects are kept to a minimum.
> 
> Region extents are tracked as sub-devices of the DAX region.  This
> ensures that region destruction cleans up all extent allocations
> properly.
> 
> The major functionality of this series includes:
> 
> - Getting the dynamic capacity (DC) configuration information from cxl
>   devices
> 
> - Configuring a DC partition found in hardware.
> 
> - Enhancing the CXL and DAX regions for dynamic capacity support
> 	a. Maintain a logical separation between hardware extents and
> 	   software managed extents.  This provides an abstraction
> 	   between the layers and should allow for interleaving in the
> 	   future
> 
> - Get existing hardware extent lists for endpoint decoders upon region
>   creation.
> 
> - Respond to DC capacity events and adjust available region memory.
>         a. Add capacity Events
> 	b. Release capacity events
> 
> - Host response for add capacity
> 	a. do not accept the extent if:
> 		If the region does not exist
> 		or an error occurs realizing the extent
> 	b. If the region does exist
> 		realize a DAX region extent with 1:1 mapping (no
> 		interleave yet)
> 	c. Support the event more bit by processing a list of extents
> 	   marked with the more bit together before setting up a
> 	   response.
> 
> - Host response for remove capacity
> 	a. If no DAX device references the extent; release the extent
> 	b. If a reference does exist, ignore the request.
> 	   (Require FM to issue release again.)
> 	c. Release extents flagged with the 'more' bit individually as
> 	   the specification allows for the asynchronous release of
> 	   memory and the implementation is simplified by doing so.
> 
> - Modify DAX device creation/resize to account for extents within a
>   sparse DAX region
> 
> - Trace Dynamic Capacity events for debugging
> 
> - Add cxl-test infrastructure to allow for faster unit testing
>   (See new ndctl branch for cxl-dcd.sh test[1])
> 
> - Only support 0 value extent tags
> 
> Fan Ni's upstream of Qemu DCD was used for testing.
> 
> Remaining work:
> 
> 	1) Allow mapping to specific extents (perhaps based on
> 	   label/tag)
> 	   1a) devise region size reporting based on tags
> 	2) Interleave support
> 
> Possible additional work depending on requirements:
> 
> 	1) Accept a new extent which extends (but overlaps) already
> 	   accepted extent(s)
> 	2) Rework DAX device interfaces, memfd has been explored a bit
> 	3) Support more than 1 DC partition
> 
> [1] https://github.com/weiny2/ndctl/tree/dcd-region3-2025-04-13
> 
> ---
> Changes in v9:
> - djbw: pare down support to only a single DC parition
> - djbw: adjust to the new core partition processing which aligns with
>   new type2 work.
> - iweiny: address smaller comments from v8
> - iweiny: rebase off of 6.15-rc1
> - Link to v8: https://patch.msgid.link/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com
> 
> ---
> Ira Weiny (19):
>       cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
>       cxl/mem: Read dynamic capacity configuration from the device
>       cxl/cdat: Gather DSMAS data for DCD partitions
>       cxl/core: Enforce partition order/simplify partition calls
>       cxl/mem: Expose dynamic ram A partition in sysfs
>       cxl/port: Add 'dynamic_ram_a' to endpoint decoder mode
>       cxl/region: Add sparse DAX region support
>       cxl/events: Split event msgnum configuration from irq setup
>       cxl/pci: Factor out interrupt policy check
>       cxl/mem: Configure dynamic capacity interrupts
>       cxl/core: Return endpoint decoder information from region search
>       cxl/extent: Process dynamic partition events and realize region extents
>       cxl/region/extent: Expose region extent information in sysfs
>       dax/bus: Factor out dev dax resize logic
>       dax/region: Create resources on sparse DAX regions
>       cxl/region: Read existing extents on region creation
>       cxl/mem: Trace Dynamic capacity Event Record
>       tools/testing/cxl: Make event logs dynamic
>       tools/testing/cxl: Add DC Regions to mock mem data
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  100 ++-
>  drivers/cxl/core/Makefile               |    2 +-
>  drivers/cxl/core/cdat.c                 |   11 +
>  drivers/cxl/core/core.h                 |   33 +-
>  drivers/cxl/core/extent.c               |  495 +++++++++++++++
>  drivers/cxl/core/hdm.c                  |   13 +-
>  drivers/cxl/core/mbox.c                 |  632 ++++++++++++++++++-
>  drivers/cxl/core/memdev.c               |   87 ++-
>  drivers/cxl/core/port.c                 |    5 +
>  drivers/cxl/core/region.c               |   76 ++-
>  drivers/cxl/core/trace.h                |   65 ++
>  drivers/cxl/cxl.h                       |   61 +-
>  drivers/cxl/cxlmem.h                    |  134 +++-
>  drivers/cxl/mem.c                       |    2 +-
>  drivers/cxl/pci.c                       |  115 +++-
>  drivers/dax/bus.c                       |  356 +++++++++--
>  drivers/dax/bus.h                       |    4 +-
>  drivers/dax/cxl.c                       |   71 ++-
>  drivers/dax/dax-private.h               |   40 ++
>  drivers/dax/hmem/hmem.c                 |    2 +-
>  drivers/dax/pmem.c                      |    2 +-
>  include/cxl/event.h                     |   31 +
>  include/linux/ioport.h                  |    3 +
>  tools/testing/cxl/Kbuild                |    3 +-
>  tools/testing/cxl/test/mem.c            | 1021 +++++++++++++++++++++++++++----
>  25 files changed, 3102 insertions(+), 262 deletions(-)
> ---
> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
> change-id: 20230604-dcd-type2-upstream-0cd15f6216fd
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 

-- 
Fan Ni
