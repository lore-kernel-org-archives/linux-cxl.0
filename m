Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432DEEBA;
	Fri, 16 May 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405734; cv=none; b=LDAEiStz6NpW4Fg8Zbb2p2KUyThnbQJuKnkmE2yK8W4KJvxiAG5uHotR6UDtmodhTjTD5wei1IdrL0FbX0nZtM6/Qg/f+U27TwR2ULbEW70qwEleDI/Q7fn6TYw0YjMyd3xxb8Ndq7QxFLcsV9uwbtHMDx9/bQAHThZzSzHL5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405734; c=relaxed/simple;
	bh=epdQC5Dsg8Uin1O3G30cUHYmoFfnAc2Qqp9izSBhCzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAV68XB8mhi+xeYg2+dguasVA6k3kzMAx1RCLhlu5/bpFHV8wNd+HZVXKrpsQI6oFT/spPsmnLYj0FtLcYKGtYSUuLg6VVNS97UPkhczbFlaemafNvrPD1hPMK84fECTwP5ep+wfeObrIWq8QNc2D6IkIWn0al7/TFCZ2jqNK2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOJnbHH7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOJnbHH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747405733; x=1778941733;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=epdQC5Dsg8Uin1O3G30cUHYmoFfnAc2Qqp9izSBhCzU=;
  b=YOJnbHH7z8dLGenfvAbs+sZdFwv1JRK89kopbBMXMvFa/hlNvIGusjUL
   /tlBmOkYHwuf8hXXhNDnPgpMpoF90/xzjcQ4niLEzuVVlNmEVtA1gB5Q/
   pwtWn2bz2/38AtNJzthaf6LLx2uPPOqAKutHGjN2oYcqSMefNslsvcGmc
   8ZaudK3W1b0ZHObR7WfJUUZvHXEz9P8WSjyZsdUKYFr/2HJ4yPh2CtSMC
   /8YtA5XMc8+WkLkG7aWxhMnXthiPgy8uFyFAIwTyo93JToK5/Ck9Vsx9P
   xJXnlO/mIe4oV6tIMjp6wvybRZSL6s+6lSBuQUQGxxdbadvrWMeuzRD+/
   A==;
X-CSE-ConnectionGUID: cukZslVQRhizve+f5qvkLw==
X-CSE-MsgGUID: ywv3x4vKT0aLFIqyG3KMpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="52005756"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="52005756"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:28:52 -0700
X-CSE-ConnectionGUID: n5jnEtliQBiq3UU8WO0pJA==
X-CSE-MsgGUID: 121z9jaBQ++wEZT8FeUunQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138630441"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.60]) ([10.125.109.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:28:51 -0700
Message-ID: <0550ad01-9125-4946-a3f7-92822725c4c8@intel.com>
Date: Fri, 16 May 2025 07:28:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/Documentation: Fix typo in sysfs write_bandwidth
 attribute path
To: Alok Tiwari <alok.a.tiwari@oracle.com>, ira.weiny@intel.com,
 dave@stgolabs.net, Jonathan.Cameron@huawei.com, ming.li@zohomail.com
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 darren.kenny@oracle.com
References: <20250516103855.3820882-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250516103855.3820882-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/16/25 3:38 AM, Alok Tiwari wrote:
> Fix a typo in the sysfs documentation for the CXL "write_bandwidth"
> attribute path. The attribute was incorrectly documented as write_banwidth.
> Update it to the correct write_bandwidth to align with the actual
> implementation.
> 
> Fixes: c20eaf44113e ("cxl/region: Add sysfs attribute for locality attributes of CXL regions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

applied to cxl/next

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 99bb3faf7a0e..eca1054ca168 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -572,7 +572,7 @@ Description:
>  
>  
>  What:		/sys/bus/cxl/devices/regionZ/accessY/read_bandwidth
> -		/sys/bus/cxl/devices/regionZ/accessY/write_banwidth
> +		/sys/bus/cxl/devices/regionZ/accessY/write_bandwidth
>  Date:		Jan, 2024
>  KernelVersion:	v6.9
>  Contact:	linux-cxl@vger.kernel.org

