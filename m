Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C584AD58;
	Sun, 11 May 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746930152; cv=none; b=TbfL2lp5L6B26YugE/bEO/2MP8V4Z3iPTkKs4u/gbxFbe4l1vYN30cnegzdUR41kHJYIbUFdmTbvhI/nSAflg+i/+m5FgEvpyJqjxl0vDWHkdvCfTRN5r44K46XwhdVD9kcPwf6KXK8udVQrT/EIt1Dz3r2hmJGSGumYm5EIAaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746930152; c=relaxed/simple;
	bh=ZSsMl7n7PbRC+3/hNBisgGyLMp21ef6s4kCIfFWnDok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDzhb7FsmAwiEzK4FnxUYTA3vRQpLEjbDCLHCCKXaWGMwJarrXhqMQU5HNRKdn3O0RTpzcda5uRTi5hVSD+stX3k8LZ+ofISevghM7DShS6Y36r4pFvqUcJuUtBg5+FeXHQht3bTfb74T5WrR/CLPdCS2O5KsgvbZsSw3rHlsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p8yl15MF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8yl15MF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=b5TEM3EBzlPccuFjNxuocrCI2U65PtRahdepso+gRF8=; b=p8yl15MFzQgQmMXophhRs3QJN6
	7zKA9S0+Ea1mTfZWS9hnannIaJg/y2ccYAkVKFMP3bNGxepZtCr/dx9X6stYr+1uyLoVrQQTC3TLC
	C91wI3zT6H2sNOGHvGIj44434KUX0ZNmRbdAIJsHpWSTan6jif6Lhz9ilmGZRwg4HWeKNmwN8ypmv
	/LT2GWQAdmihXLSR0RYz9b4kkvmsDTBcaW6QttFUPbt0+Le96NkJrD+Qw3vydBSGM88/mcWMA3feP
	16PxTtl4+hgiljGJn1T/rPnlzyaR+PAagZqu+Yct3EEn694xNn6ZCX3Usht2++pkPVv5apF+cYtDc
	JEzWHEYA==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDwKg-0000000GXP0-2qpf;
	Sun, 11 May 2025 02:22:27 +0000
Message-ID: <7cfd6cb4-78fd-4db4-84db-d093aaeacb6d@infradead.org>
Date: Sat, 10 May 2025 19:22:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 11/18] cxl: docs/linux/memory-hotplug
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-12-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-12-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Add documentation on how the CXL driver surfaces memory through the
> DAX driver and memory-hotplug.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  .../driver-api/cxl/linux/memory-hotplug.rst   | 78 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/linux/memory-hotplug.rst
> 


> diff --git a/Documentation/driver-api/cxl/linux/memory-hotplug.rst b/Documentation/driver-api/cxl/linux/memory-hotplug.rst
> new file mode 100644
> index 000000000000..a757e0e4487e
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/memory-hotplug.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +Memory Hotplug
> +==============
> +The final phase of surfacing CXL memory to the kernel page allocator is for
> +the `DAX` driver to surface a `Driver Managed` memory region via the
> +memory-hotplug component.
> +
> +There are four major configurations to consider

Add ending ':' ?

> +
> +1) Default Online Behavior (on/off and zone)
> +2) Hotplug Memory Block size
> +3) Memory Map Resource location
> +4) Driver-Managed Memory Designation
> +
> +Default Online Behavior
> +=======================
> +The default-online behavior of hotplug memory is dictated by the following,
> +in order of precedence:
> +
> +- :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE` Build Configuration
> +- :code:`memhp_default_state` Boot parameters

                                      parameter

> +- :code:`/sys/devices/system/memory/auto_online_blocks` value
> +
> +These dictate whether hotplugged memory blocks arrive in one of three states:
> +
> +1) Offline
> +2) Online in :code:`ZONE_NORMAL`
> +3) Online in :code:`ZONE_MOVABLE`
> +
> +:code:`ZONE_NORMAL` implies this capacity may be used for almost any allocation,
> +while :code:`ZONE_MOVABLE` implies this capacity should only be used for
> +migratable allocations.
> +
> +:code:`ZONE_MOVABLE` attempts to retain the hotplug-ability of a memory block
> +so that it the entire region may be hot-unplugged at a later time.  Any capacity
> +onlined into :code:`ZONE_NORMAL` should be considered permanently attached to
> +the page allocator.
> +
> +Hotplug Memory Block Size
> +=========================
> +By default, on most architectures, the Hotplug Memory Block Size is either
> +128MB or 256MB.  On x86, the block size increases up to 2GB as total memory
> +capacity exceeds 64GB.  As of v6.15, Linux does not take into account the
> +size and alignment of the ACPI CEDT CFMWS regions (see Early Boot docs) when
> +deciding the Hotplug Memory Block Size.
> +
> +Memory Map
> +==========
> +The location of :code:`struct folio` allocations to represent the hotplugged
> +memory capacity are dicated by the following system settings:

                       dictated

> +
> +- :code:`/sys_module/memory_hotplug/parameters/memmap_on_memory`
> +- :code:`/sys/bus/dax/devices/daxN.Y/memmap_on_memory`
> +
> +If both of these parameters are set to true, :code:`struct folio` for this
> +capacity will be carved out of the memory block being onlined.  This has
> +performance implications if the memory is particularly high-latency and
> +its :code:`struct folio` becomes hotly contended.
> +
> +If either parameter is set to false, :code:`struct folio` for this capacity
> +will be allocated from the local node of the processor running the hotplug
> +procedure.  This capacity will be allocated from :code:`ZONE_NORMAL` on
> +that node, as it is a :code:`GFP_KERNEL` allocation.
> +
> +Systems with extremely large amounts of :code:`ZONE_MOVABLE` memory (e.g.
> +CXL memory pools) must ensure that there is sufficient local
> +:code:`ZONE_NORMAL` capacity to host the memory map for the hotplugged capacity.
> +
> +Driver Managed Memory
> +=====================
> +The DAX driver surfaces this memory to memory-hotplug as "Driver Managed". This
> +is not a configurable setting, but it's important to not that driver managed

                                                        note

> +memory is explicitly excluded from use during kexec.  This is required to ensure
> +any reset or out-of-band operations that the CXL device may be subject to during
> +a functional system-reboot (such as a reset-on-probe) will not cause portions of
> +the kexec kernel to be overwritten.

-- 
~Randy

