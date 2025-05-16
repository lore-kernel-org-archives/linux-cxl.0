Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C48153BED;
	Fri, 16 May 2025 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405642; cv=none; b=lgv9aMOe5b2At0Kn8yScVQNSsHWyow+QFhMWeWGbmtVL6RuXVX8jA17+NlytMGuBWftkMjhxUlwNIdlntNkkjAqJpHMHbzPTRDCzrameYI+vtaXg/XSrJSZ1yEUHVROwatV6iD01MrMhNzGdi8O0a6n4dgccMVLjC7T+k6+PoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405642; c=relaxed/simple;
	bh=EeB3FBJAV2Zvjibb23QhvzW1feqAzORjGewWBxYc49A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTnQFRGAJzMHTTRUnNywzfJ1yu1eMNl28Gq/MouzIcvIPhKlX3EuvFag213XpWJ5awHQsMqIA8lm7gN6QmT5q0sX7o2oOfEPGEtkCxLysBDxKsLF2xyGhT9irRDw/Ch/JvB+M99A3Na+2vZAmua0vPrqacGwYVnGYYJg8xn809U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPmC1uLG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPmC1uLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747405640; x=1778941640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EeB3FBJAV2Zvjibb23QhvzW1feqAzORjGewWBxYc49A=;
  b=QPmC1uLGsDVg/5ITaGW8bf7JQQn4MJdeTzV/6cv41bOGhDsIu+wvuukx
   hRbMHL5DymM8ZmfYxrfF3fbqTW8V4xgvt7yGN0tmrcypM0sx7iIYhTLDD
   GxUqqttodGzhpkoltoUML1WHgPlDaDPIIlxcnYNtLNR0JYqIUbX7uPRYc
   bSWprdQk4lQwdLQ9nPIPtF89EcYl+unc+rOKXgb6m5Tx8yAHu27jqg1gZ
   XvJKJ5TyhC00K46HEXsGYVTeBvoG9vTw9joOsnP4Jvtf5/QCD//ehIf21
   r2Q8phH2jc8yCRIkHyKuP4ZsIZqYF7Vd2u8qnyHapfl4gvsbdK/LU0BHH
   Q==;
X-CSE-ConnectionGUID: vrvUjEY5RiSJ7g2aJvmzYA==
X-CSE-MsgGUID: 7rEvXnZsSyqRl7tHD4XbaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="53179793"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53179793"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:27:18 -0700
X-CSE-ConnectionGUID: PDZfghVlSPq6VgHAxVdGOQ==
X-CSE-MsgGUID: O8BadfdyTA+SBwtZ+Nuu4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="138630273"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.60]) ([10.125.109.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 07:27:18 -0700
Message-ID: <3bdf2d89-8bde-4c54-89b2-77f170af6159@intel.com>
Date: Fri, 16 May 2025 07:27:16 -0700
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

Thanks! I'll probably drop the fixes tag and the cc stable tag since it doesn't impact a running kernel.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

