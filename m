Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C040E2046BA;
	Thu, 16 Jul 2026 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784233681; cv=none; b=iCQAZJS2H3l5OyRGJHvEWwJ0eWe6rvs+pim/dToOoviexUMbOLrpWjC/x2DONwXrWjtPldupJSkyemVPbdXZ6V9JDRCRhPk8FjSW/Nb/Cj/uIXntRCCX5oQxRItDbKQuEScvMBVFD3QsSKoH7awDYFsdgVmBwcLgLNMKohKWWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784233681; c=relaxed/simple;
	bh=N+z09URhOh5wue60Bkb55uHguEpSf8u6mV2EkLPQQVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKkdg48f6iYYNXewdFcph79iUWRMlzZAo/DZmIWn7RznsOiWeNUdUN06Jtv7P3iDj4zMEipSqOe68pPK3/3rJDxQhtpU1ylDyeE1EsjwQB6nBOrbgKccJfst2+ZjGeIjEkCL7LkRcaU3O2AAzB8wiDgV5hcQT9Y3K+y6I7X38uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMPdhTiD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMPdhTiD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784233679; x=1815769679;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N+z09URhOh5wue60Bkb55uHguEpSf8u6mV2EkLPQQVU=;
  b=kMPdhTiDOUgEzyzTLHmESFnvZuSRgvoGCm/GN9Lb84amOgRYHJibtzL+
   wWNRM6VTwAr5HQ5UXQBtAOW+lQQm4FKLgwxJzViXSwkxgirRSTR5Vpb/6
   QYLift35YmPWSHLzM6H/2trl8ocXvDAkJ6i0H5glUV1gcyxrDe3uHZu74
   5E1GzTeRMHdAln932q6r1OLFZ9Eu6ns/6MmdgWS3XQ9/E4DSEPEzQtLKH
   +R1bXq6xpfKGZEJVCZ+nymBGQMatIQn9MKsEszzkPRY1RzzM+DjFEVF/X
   HCFB4uvTKu3rs53pSLC/LszmjFd2ocY0BXfFyG0l1l0azWtVo9ZctX5RS
   A==;
X-CSE-ConnectionGUID: 56cn8WU/RWeY90EmnAcATg==
X-CSE-MsgGUID: PXVWoVbqR1ya4r45jB5p5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="87454194"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="87454194"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 13:27:58 -0700
X-CSE-ConnectionGUID: nwXSLrYqRW2rFRnEbpHKSg==
X-CSE-MsgGUID: d1SNBu9gS2uLvG5x3GDUog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="260422769"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.15]) ([10.125.109.15])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 13:27:58 -0700
Message-ID: <4b146ef6-ffa1-4406-b625-85fe05ed4604@intel.com>
Date: Thu, 16 Jul 2026 13:27:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] acpi/hmat: preserve hmat_adist_nb notifier block
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, rafael@kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
 <20260716181114.35962-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260716181114.35962-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/26 11:11 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Remove __meminitdata from hmat_adist_nb declaration preserving it even
> when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> registrations using register_mt_adistance_algorithm() will find a
> notifier chain likely corrupted.
> 
> This is the case when cxl_region_probe() calls
> register_mt_adistance_algorithm() what can happen when CXL regions
> are dynamically created at any time from Type3 device(s) or when a Type2
> device is initialized at its driver probe.
> 
> Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/acpi/numa/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 9792dc394756..3006789ae31f 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
>  	return NOTIFY_STOP;
>  }
>  
> -static struct notifier_block hmat_adist_nb __meminitdata = {
> +static struct notifier_block hmat_adist_nb = {
>  	.notifier_call = hmat_calculate_adistance,
>  	.priority = 100,
>  };

