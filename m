Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC372CCB4
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167152; cv=none; b=ajRX38dSPAZd9QFwd1qW58tP5WEeSORVrTjFkUGLNjgrbgR56ikEftjsWHJw65hahe1lgP/ZSeEbotRbcRVUdY9HFe+WywzSzRtfKskAgLCgfWQ7bxDQDvLJhQLw+G9nuxcfpttw8j/o/PnSR91Y0LMs48moYbG67FhE8Q6CIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167152; c=relaxed/simple;
	bh=R/lC5M5HOFaT47fYsaY+MCJRM4HZmk8ucUKiNwTvHfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSwlabpaKv8Fu4egmidzrs5uygymQgstCZzkHKLutn4BCKvgGVR6YG6eh6/73awMZqWpETi1e0VwckGXxYSXNZ0O4K7vIdYhmrQyWW+vj5vYiGYLbZearNS73axp3CuYxSMCtC8I9/NpfV6Cfk0yqbj4oB8BDBMIwA3azK/l6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bo3UoWXj; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo3UoWXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167151; x=1740703151;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R/lC5M5HOFaT47fYsaY+MCJRM4HZmk8ucUKiNwTvHfA=;
  b=Bo3UoWXj2VTUKHe2UVNBTBnbw5LpYK1T7sbBIKcGw6CMdTltKL+6He69
   QrXHkgnemv5RsPtPPmvozkl/DmgXLtVWbvBaSDre4OsPTuhBgPSEVW47z
   g+wdkLdofjQTvEDgtI5WCjOGobE5t0zzx0Zf514ggh2xDuHrJEpuBvSrZ
   VyceXVbb1kyuMz03FfGaE4bmlVZfbRk79CVPhAyvLXCCup0ALy9Kgrj/P
   qQ63IKu4CNYKI/nQevtuwadQZSNo39fgBLcUdvyJDmehP3PmHN74GGaQW
   GHJFGBsRo9zwTUflS4rpIu57tthBlc2jPfdf1zWgQCGGGhTQK7hX9LLky
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3729851"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3729851"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7850859"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.174]) ([10.246.112.174])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:39:07 -0800
Message-ID: <9a20ce22-5910-418e-b13a-2312880e2400@intel.com>
Date: Wed, 28 Feb 2024 17:39:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl: Add checks to access_coordinate calculation to
 fail missing data
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240229002542.634982-1-dave.jiang@intel.com>
 <20240229002542.634982-2-dave.jiang@intel.com>
 <65dfd137a1406_1138c7294dd@dwillia2-xfh.jf.intel.com.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65dfd137a1406_1138c7294dd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/24 5:35 PM, Dan Williams wrote:
> Dave Jiang wrote:
>> Jonathan noted that when the coordinates for host bridge and switches
>> can be 0s if no actual data are retrieved and the calculation continues.
>> The resulting number would be inaccurate. Add checks to ensure that the
>> calculation would complete only if the numbers are valid.
> 
> Similar comment as patch1. This smells like a fix, is this an urgent
> thing to get into v6.8, i.e. most configurations are busted without
> this, or is a nice to have fixup for a QEMU effect that may or may not
> show up in physical systems?

This would only be an issue if the switches do not supply a proper CDAT and/or if BIOS does not provide proper ACPI tables. I think it is only experienced on QEMU currently. I'll add a fix tag if you think it should be a fix.
