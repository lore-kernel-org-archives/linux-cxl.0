Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11379D2;
	Sun, 11 May 2025 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746929175; cv=none; b=faTsgzi0TGGl1E4n0caf/Tq1FWqd5O4nrtlZ3F8uM0e1Ydyi9gCjltEUqXISopeMkwzxWO0nuS9nUwoorDmpnYcat+GG8vPlUM9y7MP076CSdkiEg4bahC1ZIbGaqNlQn+HlLq/dq+NyATvoGoW6BUQs3Q4hLSO9wH26IGfyeVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746929175; c=relaxed/simple;
	bh=+zRcrfpdif13/QaKrrArXBQSOsWQECpb8XM70L/hafo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfFQb064YXnWZEb1k1+xOiwAwPDkI3p9TIDasEyE/sixTJdFwv5nBhVwfBxWTkAvhFdOJf7eI+2ADBkbfC36G2T906LysRf6cXHFLklRnpUMqqK1qZyrlDdWodNx1AjgwOKkes0BOJpZc2VJiCX9qbR5D+AX6NVpU+VV1SftevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J13aXjsQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J13aXjsQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=cvWgG9nscT6kcEqo5+o1/cOQlkfYeOwE5B/x4zHuNCQ=; b=J13aXjsQrvKrmTnzHFAdrCV+Ue
	9nSEOuYjX1Mlir5OsBDXOhL65CqRLmfQ70QPyx0ulm/y/yrcspauR0YU62rka5QqOx2JMUvSc1Hqg
	1dkQ+JmtcucrvA75gsQ3Y8RgdgTmDk+DEgO0xmiNMM9KI3NuJyVeN4iTMZTnqC9oVd5fuyVQRcOxK
	LJhp7nuezSsHCpmOKOrj1AbSyPlyV29HAgBuzWm8orFhc0rcyVv+HajuEewz3X2Wdndndp321k4/Z
	z32Pf+3OEIyLRt5Klx/PuHXkMgOOPAllwhONJyFhDQwlCU7HfwIK75LfOzIx1zQ5VFXsiq9hdZHEy
	5gCUdwbQ==;
Received: from [50.39.124.201] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDw4v-0000000GXLH-0pl5;
	Sun, 11 May 2025 02:06:10 +0000
Message-ID: <6d2a2e4a-743c-42bf-b45f-c136b07f47c1@infradead.org>
Date: Sat, 10 May 2025 19:06:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 06/18] cxl: docs/linux - overview
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-7-gourry@gourry.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250430181048.1197475-7-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/25 11:10 AM, Gregory Price wrote:
> Add type-3 device configuration overview that explains the probe
> process for a type-3 device from early-boot through memory-hotplug.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  Documentation/driver-api/cxl/index.rst        |   3 +-
>  .../driver-api/cxl/linux/overview.rst         | 103 ++++++++++++++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/driver-api/cxl/linux/overview.rst
> 


>  
> diff --git a/Documentation/driver-api/cxl/linux/overview.rst b/Documentation/driver-api/cxl/linux/overview.rst
> new file mode 100644
> index 000000000000..f440d79d77d1
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/linux/overview.rst
> @@ -0,0 +1,103 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========
> +Overview
> +========
> +
> +This section presents the configuration process of a CXL Type-3 memory device,
> +and how it is ultimately exposed to users as either a :code:`DAX` device or
> +normal memory pages via the kernel's page allocator.
> +
> +Portions marked with a bullet are points at which certain kernel objects
> +are generated.
> +
> +1) Early Boot
> +
> +  a) BIOS, Build, and Boot Parameters
> +
> +    i) EFI_MEMORY_SP
> +    ii) CONFIG_EFI_SOFT_RESERVE
> +    iii) CONFIG_MHP_DEFAULT_ONLINE_TYPE
> +    iv) nosoftreserve
> +
> +  b) Memory Map Creation
> +
> +    i) EFI Memory Map / E820 Consulted for Soft-Reserved
> +
> +      * CXL Memory is set aside to be handled by the CXL driver
> +
> +      * Soft-Reserved IO Resource created for CFMWS entry
> +
> +  c) NUMA Node Creation
> +
> +    * Nodes created from ACPI CEDT CFMWS and SRAT Proximity domains (PXM)
> +
> +  d) Memory Tier Creation
> +
> +    * A default memory_tier is created with all nodes.
> +
> +  e) Contiguous Memory Allocation
> +
> +    * Any requested CMA is allocated from Online nodes
> +
> +  f) Init Finishes, Drivers start probing
> +
> +2) ACPI and PCI Drivers
> +
> +  a) Detects PCI devices is CXL, marking it for probe by CXL driver

                    device

> +
> +3) CXL Driver Operation


-- 
~Randy

