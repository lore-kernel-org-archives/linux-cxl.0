Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2243215175;
	Sat, 16 Aug 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755375657; cv=none; b=iNu2emL57mvwPBdkfl+oznuFh34f3aTv1N71IPf7fSlKhbeQ0JmasCBHKFjq0i/qkMeVFpXsCog+3aJBO86sDdA/RfN38flsMgK0gIcM8hxVhTBd1oIR4pVV/3WsiryOMKyD5ar+aAoxpPuPKaWkIufIOZ6r+TyWGkN3LJSivU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755375657; c=relaxed/simple;
	bh=0iD5Zn10j+hRwp1KNjGhNOoJ8UqwWQyyKlBc9v/dF4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahCruXCtBCvzBBj0akIiUf7EajT8KF22H52MSnRBSXenL21Xv1fJKiNINVKhE6E8QMkcjB1mDKIJ7p4u0E3L3UY+UqryT29LRbl2hjhK3p18kmro1GINv5zdN9k7eApZq1BgqcVGzHaqLUBU1QcVFFWlAtn1eovNx/aPCiokW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dU5KEkFj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dU5KEkFj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=EUeXu/2DCU0fXiHQ7lQWRj20/Vwjp9o8J49BwAgYgNc=; b=dU5KEkFjhzJOwStBBKzS2gltau
	HG9CRVtlDYx9wwa/U7hzuLgc0IKOqR7kMs45YoI4HI7f9Aal7+8/PYuVt4COO8ftobqak0tQojB3B
	3U8t5nCTqDU0I+qnsVn3zxXhGR7166mCZTNRTohhCiiC6lFQCayaAEnfMNiG2Ky8N0kOQLKt18K8X
	vgpOCegG9LLq6OaSjcZC2zxY5KtOfGsLXYjYkjexlO+e6EHYj2oKIIX9kvAdYhQIBv+HG9NFqgJrl
	Po0GIj/RbXHOEOi0jgQHffc/IrGaqawlFVqh3HMdmiP+ihF2BkeIw3OIBx/G22/2RqOm4pPrOMDJv
	Hm+NG5NQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unNOU-0000000598j-2vHN;
	Sat, 16 Aug 2025 20:20:50 +0000
Message-ID: <b7be48b2-d326-45af-9608-375117ffb4db@infradead.org>
Date: Sat, 16 Aug 2025 13:20:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/driver-api: Fix typo error in cxl
To: rakuram <rakuram.e96@gmail.com>, linux-doc@vger.kernel.org
Cc: dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
 jonathan.cameron@huawei.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 linux-cxl@vger.kernel.org, alison.schofield@intel.com, gourry@gourry.net,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org,
 corbet@lwn.net
References: <20250816183034.7970-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250816183034.7970-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/25 11:30 AM, rakuram wrote:
> Fixed the following typo errors
> 
> intersparsed ==> interspersed
> in Documentation/driver-api/cxl/platform/bios-and-efi.rst
> 
> ndoe ==> node
> in Documentation/driver-api/cxl/allocation/page-allocator.rst
> 
> Signed-off-by: rakuram <rakuram.e96@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/driver-api/cxl/allocation/page-allocator.rst | 2 +-
>  Documentation/driver-api/cxl/platform/bios-and-efi.rst     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> index 7b8fe1b8d5bb..4ac3368c3947 100644
> --- a/Documentation/driver-api/cxl/allocation/page-allocator.rst
> +++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
> @@ -62,7 +62,7 @@ Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
>  functionally unreachable for direct allocation.  As a result, the only way
>  for CXL capacity to be used is via `demotion` in the reclaim path.
>  
> -This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
> +This configuration also means that if the DRAM node has :code:`ZONE_MOVABLE`
>  capacity - when that capacity is depleted, the page allocator will actually
>  prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
>  
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index 645322632cc9..a9aa0ccd92af 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -202,7 +202,7 @@ future and such a configuration should be avoided.
>  
>  Memory Holes
>  ------------
> -If your platform includes memory holes intersparsed between your CXL memory, it
> +If your platform includes memory holes interspersed between your CXL memory, it
>  is recommended to utilize multiple decoders to cover these regions of memory,
>  rather than try to program the decoders to accept the entire range and expect
>  Linux to manage the overlap.

-- 
~Randy
