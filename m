Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F713BC0C;
	Sun, 11 May 2025 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746929503; cv=none; b=oMxA86GzSpsxA0j3eNx1nr2vRh2te4+6RiDURab+++jYDR/LXEUkeq/tiyaCSdy8Iv8hxTBhKIgcXU39vlaCN+g6yFCQ/I7+a8OEm7GigzAZ6muAsIVGKFZ8BAmPX6dEyEC3eHyDw3elzho2fxDv0L/pU3u8WUSm+cr0YAW81f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746929503; c=relaxed/simple;
	bh=/ZttMtOqdZXJjP3wVsUNBq/zJMFu25KYMXihE4ZwiZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlxZOP5RUkIRY97SgmpmdxXYJCvQWqsa7dVa0EDdLl9AOR/NLIS3UEmAVBrq+1vU01/zNcRUhr6JZONI6kEDSsbS7hguPEZISmHXRGwEn1BrF1rsOTwTXR7Qd5jvzW3/NVR31QfIl7cA6J6sYsQY9AkHz6vCG0jOr/0XdjLikI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YSX7WJV1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YSX7WJV1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/TbWo8gaktSCwlVthFDiGTpBIfa4Kl80ITZsMX9sxUo=; b=YSX7WJV1L4K7jPQUzpaNEb7xug
	56Jt9QYSeTxjpusZeqwPaoaC01apFsuOXRrSb//9Ah9sE8+JTlhatAYzdAItrvozC8IGdm8oxJONm
	zIDtQ7Qn4ykc8wE9E3yf1UL/p3g9As8a+iJl4ehdWuJg68HHT0Al/xef848d5FR5CKKZBx2Kq5C2z
	JMFpmTBdPCNkJKX+xz+ersbWp/Z9IQJuq67SgfHcDQkFo9GLcAavEdD6l9ooeaFAJX9im3Sa2i+Zi
	4RjXpTUNmeTI9j35wXhJpdSn56hFXETunQfslG+brkrnKZSWjmY52Vjy8+XbhunJQVjun2KM2bxDo
	tmp60wyQ==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDwAB-0000000GXMK-0pE9;
	Sun, 11 May 2025 02:11:37 +0000
Message-ID: <8db7a29a-740a-4ebd-bc86-41d92a9101a6@infradead.org>
Date: Sat, 10 May 2025 19:11:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/18] cxl: docs/linux - early boot configuration
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-8-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-8-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Document __init time configurations that affect CXL driver probe
> process and memory region configuration.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/linux/early-boot.rst       | 130 ++++++++++++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst
> 


> diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
> new file mode 100644
> index 000000000000..275174d5b0bb
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/early-boot.rst
> @@ -0,0 +1,130 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Linux Init (Early Boot)
> +=======================
> +
> +Linux configuration is split into two major steps: Early-Boot and everything else.
> +
> +During early boot, Linux sets up immutable resources (such as numa nodes), while
> +later operations include things like driver probe and memory hotplug.  Linux may
> +read EFI and ACPI information throughout this process to configure logical
> +representations of the devices.
> +
> +During Linux Early Boot stage (functions in the kernel that have the __init
> +decorator), the system takes the resources created by EFI/BIOS (ACPI tables)
> +and turns them into resources that the kernel can consume.
> +
> +
> +BIOS, Build and Boot Options
> +============================
> +
> +There are 4 pre-boot options that need to be considered during kernel build
> +which dictate how memory will be managed by Linux during early boot.
> +
> +* EFI_MEMORY_SP
> +
> +  * BIOS/EFI Option that dictates whether memory is SystemRAM or
> +    Specific Purpose.  Specific Purpose memory will be deferred to
> +    drivers to manage - and not immediately exposed as system RAM.
> +
> +* CONFIG_EFI_SOFT_RESERVE
> +
> +  * Linux Build config option that dictates whether the kernel supports
> +    Specific Purpose memory.
> +
> +* CONFIG_MHP_DEFAULT_ONLINE_TYPE
> +
> +  * Linux Build config that dictates whether and how Specific Purpose memory
> +    converted to a dax device should be managed (left as DAX or onlined as
> +    SystemRAM in ZONE_NORMAL or ZONE_MOVABLE).
> +
> +* nosoftreserve
> +
> +  * Linux kernel boot option that dictates whether Soft Reserve should be
> +    supported.  Similar to CONFIG_EFI_SOFT_RESERVE.
> +
> +Memory Map Creation
> +===================
> +
> +While the kernel parses the EFI memory map, if :code:`Specific Purpose` memory
> +is supported and detect, it will set this region aside as :code:`SOFT_RESERVED`.

                    detected,

> +
> +If :code:`EFI_MEMORY_SP=0`, :code:`CONFIG_EFI_SOFT_RESERVE=n`, or
> +:code:`nosoftreserve=y` - Linux will default a CXL device memory region to
> +SystemRAM.  This will expose the memory to the kernel page allocator in
> +:code:`ZONE_NORMAL`, making it available for use for most allocations (including
> +:code:`struct page` and page tables).
> +
> +If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
> +dictates whether the memory is onlined by default (:code:`_OFFLINE` or
> +:code:`_ONLINE_*`), and if online which zone to online this memory to by default
> +(:code:`_NORMAL` or :code:`_MOVABLE`).
> +
> +If placed in :code:`ZONE_MOVABLE`, the memory will not be available for most
> +kernel allocations (such as :code:`struct page` or page tables).  This may
> +significant impact performance depending on the memory capacity of the system.
> +
> +
> +NUMA Node Reservation
> +=====================
> +
> +Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT to
> +create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 relation
> +between :code:`PXM` and NUMA node IDs.
> +
> +SRAT is the only ACPI defined way of defining Proximity Domains. Linux chooses
> +to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of SPA
> +ranges which Linux may wish to map to one or more NUMA nodes

Add ending period above.

> +
> +If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`PXM`
> +is created (as of v6.15). In the future, Linux may reject CFMWS not described
> +by SRAT due to the ambiguity of proximity domain association.


-- 
~Randy

