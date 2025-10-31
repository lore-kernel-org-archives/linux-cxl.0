Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970426ED24
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761944767; cv=none; b=KdZZvfb7L/gD4PzF+FRxbdOUklLZgicHo79A2VAewn7AA2Ycr3r5mIiyI3t3pK3QXRIMk4+EdZeAonanzrdxmyTD1nafGKNgZ2ZbTbC/ihCeA5Dgfy+uHzee4ujtwBuvmKpcamV0LUjjoYTfaY4vC8x4iZgqVSu1NZ524z0R7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761944767; c=relaxed/simple;
	bh=blMuZxVcQpLRrta4b7kXMGpaYZtLJU+TMu1aF+M0tAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orUz+0EZXYqziNGXVmP0J6T7EOd4ukGzwRKLyemwSLQygfeo4IGvbWZs5pkFxjcDu6RUo51Er0719re+39VasljFF8ynM2XY7trVNLmDlhK5hAFZiMaQXM2Npm6YiblIQVkPrfg2ZvJa5h3FdmjlnO8LOMtS39wFxjR4Axj3aSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHPq6ped; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHPq6ped"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761944766; x=1793480766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=blMuZxVcQpLRrta4b7kXMGpaYZtLJU+TMu1aF+M0tAs=;
  b=PHPq6pedJ7rSfltG1jDP7ZX/oJQ7FU5LeqpRIh/BPIxaqswqWO5CJAw+
   rSsdtwRZxbvDIgKPQpogGN942Yp0vhuEiJKi8p40oc9O8Z5i8mn7RNZPq
   USlD1rpwxtqgjFecNxXvglHF8iY3ugURAFHec3J2bzWp06ISgBHKBOuCw
   xcNHBtOwpztRHmR3f6HrU8B8ALapytFuNr2q1cRWBaAPhxVUbXSUkliZi
   ZW2MBnVTUTieprKP4vpnGtNPmngTRzRh+e2rEz5+p9ZFlXaSA5vXR4JJd
   VRxSWxsKnbNdaflixq8JopADSWDloqD9YN/hmvoKaLZo0AwdcCmf838sK
   A==;
X-CSE-ConnectionGUID: /UDJaAMJQ0uIPYYj2Mg5/A==
X-CSE-MsgGUID: agLbZ8eFSQKHCfsZ1eBdhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="64211993"
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="64211993"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:06:05 -0700
X-CSE-ConnectionGUID: Int+ilj9SK+UQQUnSWZMNg==
X-CSE-MsgGUID: iJn8mTj/QsOIWQsWq85eqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="187070266"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 14:06:05 -0700
Message-ID: <770c29cc-628b-496f-bfb6-6e64b10336c1@intel.com>
Date: Fri, 31 Oct 2025 14:06:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl: Adjust offset calculation for poison injection
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251031173224.3537030-1-dave.jiang@intel.com>
 <20251031173224.3537030-5-dave.jiang@intel.com>
 <aQUi5Tbcn2IHNgzY@aschofie-mobl2.lan>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aQUi5Tbcn2IHNgzY@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 1:58 PM, Alison Schofield wrote:
> On Fri, Oct 31, 2025 at 10:32:24AM -0700, Dave Jiang wrote:
>> The HPA to DPA translation for poison injection assumes that the
>> base address starts from where the CXL region begins. When the
>> extended linear cache is active, the offset can be within the DRAM
>> region. Adjust the offset so that it correctly reflects the offset
>> within the CXL region.
> 
> Dave, good catch!
> 
> This breakage was added in 6.18-rc1. Please consider it for a pull
> request before the end of 6.18.
> 
> Here's justification and Fixes Tag:
> 
> Without this patch, when a user intends to inject poison at an offset
> in region, it can inject poison into a location in a device that is
> not mapped by that region.
> 
> The test case in cxl-poison-elc.sh that exposed this issue, injected
> poison 0x20000000 which should have been the first byte of the CXL
> half of an Extended Linear Cache (ELC) region. Instead, it injected
> poison at the next byte of a device beyond the regions mapping.
> 
> Fixes: c3dd67681c70 ("cxl/region: Add inject and clear poison by region offset")
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
Yeah I can move it to fixes instead
