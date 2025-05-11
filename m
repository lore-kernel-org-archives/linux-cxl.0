Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35322846F;
	Sun, 11 May 2025 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746929919; cv=none; b=LQ4YisweiCjWF1cM3hWxG528rV66fuv0F1frwcW8WtK9VrXYYxEnt/labmSeMnJTmQ7x0zdeqvMStkBrbCtroLRMIKliGWZoJqzqQNKNK/aDFTx4W8Zu7p34pCF2c3UtEiED/fA77iCFBK6rNXlND6QxoS8Jig+7Z+4zrHUtqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746929919; c=relaxed/simple;
	bh=hkbykRuCPbV2MO6N0vI99UpA+qlypDnlP9tcZnPvQi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtkRIMz4i0zKlxcB2xbUS95+mpXJHepE4i6zqEtQ80/Y18oPiWAxH1lOZw5xqLkOBM+8NqLVJwfvA45uej+ECs4UlJ6b00DnhdguGkBYvdMGzMaGLt/1v0H+Zov+Jmr+EOJddYi+IbqXXrsBFk/AMmM67AtzHvDqLA5e/Vpt7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aUQDdykE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUQDdykE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=IIOr0KRO/w9uVIzHiGo9e8afBVTWu02eElKI0nhbCLw=; b=aUQDdykEICFUfIzofIWUg9fvzg
	2NAd6xTpMc+rS/VhW+qKYtXa7WMhxT1QB9dbR36vlW4crYtY0GbJMvtkdqUxZ0AqSYibpSsUBSfLU
	4/kCmfdYkybncw8YAHVuoAOCIGlqBwrz41zkUb+uzRd0H2qcpiiffBCAAtwyi2dYO274xpaCXwbeq
	czJuEcT+O10P62AXuIAmrRFeNClFj1fAO+oHoeMFRnsKMF+mAlKxM2kalZ2KzCLTTvRmUDEQrpShT
	TrtFPmq4nd15AC60Ys3avhIARklecfgHCdTedUQmvo8PF92tWJvx18lAsLSuifjvlt4CT44bTAnDb
	WCF3Bdyg==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDwGu-0000000GXNs-1bqC;
	Sun, 11 May 2025 02:18:33 +0000
Message-ID: <43d957e0-f52b-4ba8-aa87-cfb8472b8b67@infradead.org>
Date: Sat, 10 May 2025 19:18:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/18] cxl: docs/linux/dax-driver documentation
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-11-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-11-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Add documentation on how the CXL driver interacts with the DAX driver.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/linux/cxl-driver.rst       | 115 ++++++++++++++++--
>  .../driver-api/cxl/linux/dax-driver.rst       |  43 +++++++
>  3 files changed, 149 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/driver-api/cxl/linux/dax-driver.rst
> 

> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index 486baf8551aa..1a354ea1cda4 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -34,6 +34,32 @@ into a single memory region. The memory region has been converted to dax. ::
>      decoder1.0   decoder5.0  endpoint5   port1  region0
>      decoder2.0   decoder5.1  endpoint6   port2  root0
>  
> +
> +.. kernel-render:: DOT
> +   :alt: Digraph of CXL fabric describing host-bridge interleaving
> +   :caption: Diagraph of CXL fabric with a host-bridge interleave memory region
> +
> +   digraph foo {
> +     "root0" -> "port1";
> +     "root0" -> "port3";
> +     "root0" -> "decoder0.0";
> +     "port1" -> "endpoint5";
> +     "port3" -> "endpoint6";
> +     "port1" -> "decoder1.0";
> +     "port3" -> "decoder3.0";
> +     "endpoint5" -> "decoder5.0";
> +     "endpoint6" -> "decoder6.0";
> +     "decoder0.0" -> "region0";
> +     "decoder0.0" -> "decoder1.0";
> +     "decoder0.0" -> "decoder3.0";
> +     "decoder1.0" -> "decoder5.0";
> +     "decoder3.0" -> "decoder6.0";
> +     "decoder5.0" -> "region0";
> +     "decoder6.0" -> "region0";
> +     "region0" -> "dax_region0";
> +     "dax_region0" -> "dax0.0";
> +   }
> +
>  For this section we'll explore the devices present in this configuration, but
>  we'll explore more configurations in-depth in example configurations below.
>  
> @@ -41,7 +67,7 @@ Base Devices
>  ------------
>  Most devices in a CXL fabric are a `port` of some kind (because each
>  device mostly routes request from one device to the next, rather than
> -provide a manageable service).
> +provide a direct service).
>  
>  Root
>  ~~~~
> @@ -53,6 +79,8 @@ The Root contains links to:
>  
>  * `Host Bridge Ports` defined by ACPI CEDT CHBS.
>  
> +* `Downstream Ports` typically connected to `Host Bridge Ports`

Add ending '.' for consistency.

> +
>  * `Root Decoders` defined by ACPI CEDT CFMWS.
>  
>  ::
> @@ -150,6 +178,27 @@ device configuration data. ::
>      driver    label_storage_size  pmem         serial
>      firmware  numa_node           ram          subsystem
>  
> +A Memory Device is a discrete base object that is not a port.  While it the
> +physical device it belongs to may host an `endpoint`, this relationship is

I have some parsing trouble with the sentence above. Maybe s/it the/the/.

> +not captured in sysfs.
> +
> +Port Relationships
> +~~~~~~~~~~~~~~~~~~
> +In our example described above, there are four host bridges attached to the
> +root, and two of the host bridges have one endpoint attached.
> +
> +.. kernel-render:: DOT
> +   :alt: Digraph of CXL fabric describing host-bridge interleaving
> +   :caption: Diagraph of CXL fabric with a host-bridge interleave memory region
> +
> +   digraph foo {
> +     "root0"    -> "port1";
> +     "root0"    -> "port2";
> +     "root0"    -> "port3";
> +     "root0"    -> "port4";
> +     "port1" -> "endpoint5";
> +     "port3" -> "endpoint6";
> +   }
>  
>  Decoders
>  --------
> @@ -322,6 +371,29 @@ settings (granularity and ways must be the same).
>  Endpoint decoders are created during :code:`cxl_endpoint_port_probe` in the
>  :code:`cxl_port` driver, and is created based on a PCI device's DVSEC registers.
>  
> +Decoder Relationships
> +~~~~~~~~~~~~~~~~~~~~~
> +In our example described above, there is one root decoder which routes memory
> +accesses over two host bridges.  Each host bridge has a decoder which routes
> +access to their singular endpoint targets.  Each endpoint has an decoder which

                                                                 a decoder

> +translates HPA to DPA and services the memory request.
> +
> +The driver validates relationships between ports by decoder programming, so
> +we can think of decoders being related in a similarly hierarchical fashion to
> +ports.
> +
> +.. kernel-render:: DOT
> +   :alt: Digraph of hierarchical relationship between root, switch, and endpoint decoders.
> +   :caption: Diagraph of CXL root, switch, and endpoint decoders.
> +
> +   digraph foo {
> +     "root0"    -> "decoder0.0";
> +     "decoder0.0" -> "decoder1.0";
> +     "decoder0.0" -> "decoder3.0";
> +     "decoder1.0" -> "decoder5.0";
> +     "decoder3.0" -> "decoder6.0";
> +   }
> +
>  Regions
>  -------
>  
> @@ -348,6 +420,17 @@ The interleave settings in a `Memory Region` describe the configuration of the
>  `Interleave Set` - and are what can be expected to be seen in the endpoint
>  interleave settings.
>  
> +.. kernel-render:: DOT
> +   :alt: Digraph of CXL memory region relationships between root and endpoint decoders.
> +   :caption: Regions are created based on root decoder configurations. Endpoint decoders
> +             must be programmed with the same interleave settings as the region.
> +
> +   digraph foo {
> +     "root0"    -> "decoder0.0";
> +     "decoder0.0" -> "region0";
> +     "region0" -> "decoder5.0";
> +     "region0" -> "decoder6.0";
> +   }
>  
>  DAX Region
>  ~~~~~~~~~~
> @@ -360,7 +443,6 @@ for more details. ::
>      dax0.0      devtype  modalias   uevent
>      dax_region  driver   subsystem
>  
> -
>  Mailbox Interfaces
>  ------------------
>  A mailbox command interface for each device is exposed in ::
> @@ -418,17 +500,30 @@ the relationships between a decoder and it's parent.
>  
>  For example, in a `Cross-Link First` interleave setup with 16 endpoints
>  attached to 4 host bridges, linux expects the following ways/granularity
> -across the root, host bridge, and endpoints respectively. ::
> +across the root, host bridge, and endpoints respectively.
> +
> +.. flat-table:: 4x4 cross-link first interleave settings
> +
> +  * - decoder
> +    - ways
> +    - granularity
>  
> -                   ways   granularity
> -  root              4        256
> -  host bridge       4       1024
> -  endpoint         16        256
> +  * - root
> +    - 4
> +    - 256
> +
> +  * - host bridge
> +    - 4
> +    - 1024
> +
> +  * - endpoint
> +    - 16
> +    - 256
>  
>  At the root, every a given access will be routed to the
>  :code:`((HPA / 256) % 4)th` target host bridge. Within a host bridge, every
> -:code:`((HPA / 1024) % 4)th` target endpoint.  Each endpoint will translate
> -the access based on the entire 16 device interleave set.
> +:code:`((HPA / 1024) % 4)th` target endpoint.  Each endpoint translates based
> +on the entire 16 device interleave set.
>  
>  Unbalanced interleave sets are not supported - decoders at a similar point
>  in the hierarchy (e.g. all host bridge decoders) must have the same ways and
> @@ -467,7 +562,7 @@ In this example, the CFMWS defines two discrete non-interleaved 4GB regions
>  for each host bridge, and one interleaved 8GB region that targets both. This
>  would result in 3 root decoders presenting in the root. ::
>  
> -  # ls /sys/bus/cxl/devices/root0
> +  # ls /sys/bus/cxl/devices/root0/decoder*
>      decoder0.0  decoder0.1  decoder0.2
>  
>    # cat /sys/bus/cxl/devices/decoder0.0/target_list start size
> diff --git a/Documentation/driver-api/cxl/linux/dax-driver.rst b/Documentation/driver-api/cxl/linux/dax-driver.rst
> new file mode 100644
> index 000000000000..5063d2b675b4
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/dax-driver.rst
> @@ -0,0 +1,43 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +DAX Driver Operation
> +====================
> +The `Direct Access Device` driver was originally designed to provide a
> +memory-like access mechanism to memory-like block-devices.  It was
> +extended to support CXL Memory Devices, which provide user-configured
> +memory devices.
> +
> +The CXL subsystem depends on the DAX subsystem to generate either:

                                                  to either:

> +
> +- A file-like interface to userland via :code:`/dev/daxN.Y`, or

   - Generate a file-like interface ...

> +- Engaging the memory-hotplug interface to add CXL memory to page allocator.

   - Engage the ...

> +
> +The DAX subsystem exposes this ability through the `cxl_dax_region` driver.
> +A `dax_region` provides the translation between a CXL `memory_region` and
> +a `DAX Device`.
> +
> +DAX Device
> +==========
> +A `DAX Device` is a file-like interface exposed in :code:`/dev/daxN.Y`. A
> +memory region exposed via dax device can be accessed via userland software
> +via the :code:`mmap()` system-call.  The result is direct mappings to the
> +CXL capacity in the task's page tables.
> +
> +Users wishing to manually handle allocation of CXL memory should use this
> +interface.
> +
> +kmem conversion
> +===============
> +The :code:`dax_kmem` driver converts a `DAX Device` into a series of `hotplug
> +memory blocks` managed by :code:`kernel/memory-hotplug.c`.  This capacity
> +will be exposed to the kernel page allocator in the user-selected memory
> +zone.
> +
> +The :code:`memmap_on_memory` setting (both global and DAX device local) dictate

                                                                           dictates

> +where the kernell will allocate the :code:`struct folio` descriptors for this

             kernel

> +memory will come from.  If :code:`memmap_on_memory` is set, memory hotplug
> +will set aside a portion of the memory block capacity to allocate folios.  If
> +unset, the memory is allocated via a normal :code:`GFP_KERNEL` allocation -
> +and as a result will most likely land on the local NUM node of the cpu executing

s/cpu/CPU/ preferably.

> +the hotplug operation.

-- 
~Randy

