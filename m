Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916F29DB8C;
	Tue,  4 Mar 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106017; cv=none; b=rpkg3Ljn3JlnH9ksZCJQpiu2PdwzZJRRTj+UxaiIsbDgXpJI5B819zoXO+IG4kqIyTabD1OSH8mSZE75xiejKZTOXFqrjV/N3iyFFXJNcgp14tchsfFFSyFUXh5wsD8hrKE8iImbYX4QVyynrrFZ2GZ+hFXzAC+AWp3ew/UWayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106017; c=relaxed/simple;
	bh=VCOeL991JkwbQRi293YQHFz7wPutL8i9mtZnvqnriTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2sYE8zYOjwGZ/XbGGmaGiAflOpGxZ+Tr+UVvXUTPwqxadIVWYuR1HJP57kb14+Sb9L4Z8tXsZm+OhNdM+DR+nKcQPRcpAcSFSt+Rdu+uvkjCncGyVsCZDvhH4/gD4O5V8r0S0efsXM/8OMsu/k/lWIo3QbOq3v9go3kdCadjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kGEdcN1U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kGEdcN1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741106015; x=1772642015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VCOeL991JkwbQRi293YQHFz7wPutL8i9mtZnvqnriTM=;
  b=kGEdcN1UE3TxWTVNxWhjxt9mL7FcZ8fI9xr2VB9XgPy8WZt7H2pOYHox
   7QBZt4a8OhWiS04e1xZTEdCPQjLxWZO5J5A52DAssA3bRn6SkkyhOX+2S
   Eisymyc+JqWHO6VX4Gu/x8H13BVwmFwBN6ebEN6WmJEAyQnhuSTEC52Tu
   EHKm03JEdalXfgTPrd75IwUdWP1Vgky4fJxaWL2N0xiHY+ggp52PDGFAm
   +z3//hXgGqFdbogzxVoXp+6xubFSoI5CaeJytpUEOzvGx7fIG7xg5arQW
   GSMYzylIUiYRdFwIArFKs8YT3fsbfhx957nrhDMR7XG47TRvzLVEL6ZZZ
   g==;
X-CSE-ConnectionGUID: HrfXzM0TRqGspAB+6irjDA==
X-CSE-MsgGUID: z1rTr8WOT7+Ab8yJbbsTrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52240177"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="52240177"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:33:35 -0800
X-CSE-ConnectionGUID: ppR4q47NSCelxYxBkNfb9Q==
X-CSE-MsgGUID: 3iZBu1TlTnSQOAZL0ftwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123627822"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.109.118]) ([10.125.109.118])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:33:33 -0800
Message-ID: <3d621fa8-b288-41c4-9ede-233ca9608237@intel.com>
Date: Tue, 4 Mar 2025 09:33:32 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/Documentation: Remove 'mixed' from sysfs mode doc
To: Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/25 11:29 AM, Ira Weiny wrote:
> Commit 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> removed the mixed mode.
> 
> Remove it from the sysfs documentation.
> 
> Fixes: 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Applied to cxl/next

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a16aca7c18d17131a56491048a0c2..3ba551ed10e29f33b9eb873bab9b542c8afb66f0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -321,14 +321,13 @@ KernelVersion:	v6.0
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> -		translates from a host physical address range, to a device local
> -		address range. Device-local address ranges are further split
> -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> -		'mixed', or 'none'. The 'mixed' indication is for error cases
> -		when a decoder straddles the volatile/persistent partition
> -		boundary, and 'none' indicates the decoder is not actively
> -		decoding, or no DPA allocation policy has been set.
> +		translates from a host physical address range, to a device
> +		local address range. Device-local address ranges are further
> +		split into a 'ram' (volatile memory) range and 'pmem'
> +		(persistent memory) range. The 'mode' attribute emits one of
> +		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
> +		not actively decoding, or no DPA allocation policy has been
> +		set.
>  
>  		'mode' can be written, when the decoder is in the 'disabled'
>  		state, with either 'ram' or 'pmem' to set the boundaries for the
> 
> ---
> base-commit: 8760c1c0bf7eee63a56b5f9edb42d93737a6a378
> change-id: 20250224-remove-mixed-sysfs-e3baa7616bcc
> 
> Best regards,

