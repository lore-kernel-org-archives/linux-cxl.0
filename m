Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886AC30C63B;
	Mon, 27 Oct 2025 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580378; cv=none; b=FvWTmqaJ36gR3bm8go6ETFBGZNTAKkHihxvJg5ZeqK8oAGX1R76e/208THduVcNRDjKuqJtRyItZb98zjDcTLoB3D/kjzIZ7EakRqEWdMkOnAg+jCfXQDFkkkWY/NZCTar4Kd1jhPANpShAlvNcNflQ7e5VEqrToe2Qqj9+BXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580378; c=relaxed/simple;
	bh=0FD8jE3r3BQAd8qLv61nGNeltiMZUGuEGNj1kE2QHCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOy/aac2cASwAfs0Q4vTn2TUjaQgIKiWkrezeG/WP/fjan7HZs5xRU8jcS20vuHJFzvzlSMK+4rOH1V0F8N4UzeUefKpZYLnYiCjNc9zOAQsggRuu96hGDr5OWWqTwUomL30iBALjZSUBVrYDOx9oMWcmMETeafONSx8jYi5OtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcW83xkO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcW83xkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761580376; x=1793116376;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0FD8jE3r3BQAd8qLv61nGNeltiMZUGuEGNj1kE2QHCQ=;
  b=JcW83xkOJuL0HNcAahoKM6m4IpbztLthDVnGHOu0p/LKmkYqhri3u7FU
   k+doAnAD3Tw2bTydQjsI/RCPZ4tVbYcC5FNlIJegq7oA0OgZaqcsqEjEK
   +lpki6FgnOfkrza3Fi+woe3vLTEZEdlShOdC0CRYqdZEwI50M/SU85XAM
   aRxgvIEC5v0FlcTuEHfSs3F6wxaKQdH1tb116cIPDzsi98vkkKWiTByZ+
   3fc/u3r7XyGrJQBN1dXPMmO2JzJ9W//VasA7p49wCYE7cdwUPnYFCL/wS
   lVrMxrtEscQT32WnPAu28Q0iHnZXAWrc4Mii7M1NnSilZ23lSVmAmfrAI
   g==;
X-CSE-ConnectionGUID: UtFlwR7GQV6Axdv7Yk4ooA==
X-CSE-MsgGUID: YZF7BvzxSx6i8FBHAEc2cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66278297"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="66278297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:52:56 -0700
X-CSE-ConnectionGUID: G6bvje5XSum7S3DOyyrGBQ==
X-CSE-MsgGUID: 7uM8cH15Q+eBpWxUiT2sTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="222288557"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.111]) ([10.125.109.111])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 08:52:55 -0700
Message-ID: <380c7a65-109f-43ef-be1d-fc7735d5fe6e@intel.com>
Date: Mon, 27 Oct 2025 08:52:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] dax: add PROBE_PREFER_ASYNCHRONOUS to all the dax
 drivers
To: Michal Clapinski <mclapinski@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org
References: <20251024210518.2126504-1-mclapinski@google.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/24/25 2:05 PM, Michal Clapinski wrote:
> Comments in linux/device/driver.h say that the goal is to do async
> probing on all devices. The current behavior unnecessarily slows down
> the boot by synchronously probing dax devices, so let's change that.
> 
> For thousands of devices, this change saves >1s of boot time.
> 
> Michal Clapinski (5):
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the kmem driver
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the cxl driver
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the hmem drivers
>   dax: add PROBE_PREFER_ASYNCHRONOUS to the dax device driver
> 
>  drivers/dax/cxl.c       | 1 +
>  drivers/dax/device.c    | 3 +++
>  drivers/dax/hmem/hmem.c | 2 ++
>  drivers/dax/kmem.c      | 3 +++
>  drivers/dax/pmem.c      | 1 +
>  5 files changed, 10 insertions(+)
> 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
for the series
