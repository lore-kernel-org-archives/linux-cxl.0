Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B211F55ED;
	Tue,  4 Mar 2025 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741070524; cv=none; b=aVO8IJYvqhft02hJz8sw1pcihKRCqbNvmqY98eAfDxuAreJiTuZh/sKw/0x/mIvgJAr3P0j6ZsPvgLmv76wlG2xcjxs7nT5/YDzyphKg/Ig1d42v9mZHiE4qhUNHfkglb594xoSKHhN3s1oF8IBOJt7XMPKTvga8IYrc4rUMlVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741070524; c=relaxed/simple;
	bh=DurccOWeYyopOYQ2zUIsfyrkxG07YsyetCenllD8sHA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BR+F/yuJ4LxKdSBXYBu3Zqv9xNc0ywyAWiSzJt9qfEG6Wwrd+LgbUEEFJB2Tll6oA7BXCUA4nNXfsza22vk175mYlKINKadqu76JxquTzIVqHtK6GCehGcCGvKLWgfr1bidQeJ3HXdnnSzfwvcuqUajrGJpPAG+ffnq/uamDSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6Qwh32lYz6L56X;
	Tue,  4 Mar 2025 14:37:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 97A00140A36;
	Tue,  4 Mar 2025 14:41:58 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 07:41:56 +0100
Date: Tue, 4 Mar 2025 14:41:51 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ira Weiny <ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Fan Ni <fan.ni@samsung.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/Documentation: Remove 'mixed' from sysfs mode doc
Message-ID: <20250304144151.000016c3@huawei.com>
In-Reply-To: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
References: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 24 Feb 2025 12:29:29 -0600
Ira Weiny <ira.weiny@intel.com> wrote:

> Commit 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> removed the mixed mode.
> 
> Remove it from the sysfs documentation.
> 
> Fixes: 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Would be nice to put wrap back in text we aren't changing
as creates unnecessary churn / staring at text to see if
it is different...

Either way
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

Ideally avoid the extra diff from wrap changes in text that isn't changing.


> +		local address range. Device-local address ranges are further
> +		split into a 'ram' (volatile memory) range and 'pmem'
> +		(persistent memory) range. The 'mode' attribute emits one of

I think actual changes only happen here.

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

