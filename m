Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512DA23EAB7
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614435; cv=none; b=E/i1Hf9WSw0mYOtmhPPJ9b2m0m8cjkE5OyzszFOUqPHN3s3lujINA809D3U4LkzA1PLsAOhH9e6RCPE6av8d4IMykzYz2rPwm4uJu/676iS2zCFnAS2j5sanB2x79PZjEQ7iIws/dKJFw3Ae+IfpYKrQLNRDZ/YGcyAgsjTTpQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614435; c=relaxed/simple;
	bh=pWiVdcU9aPvUE+4PC0ZRt0SlvtMS/BWxyWPTKAO52rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RT+SgsN5eZ1TXosKIwmU/DPCKM9z0siQHvJfoRhC9fS0knbw7qowWB0+dphGyjMA/uvXLZOaxOaFHrEeLXmz5vTtPHHz2/Ok8UT1edX3oYWvRom02hn8/LuE/2QtN1FTyI8wLMEhTAS75rr32kX0neJdQ/zEBE3X8ESKnrLnOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyWdTa3n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyWdTa3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769614434; x=1801150434;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=pWiVdcU9aPvUE+4PC0ZRt0SlvtMS/BWxyWPTKAO52rQ=;
  b=jyWdTa3na1p/f9rhLzIXT4rfAEUbLRdGX5z0/gFdIAoEFMnyps1Oo6PF
   YKwSY7t+k2Rtq7QAGunqVTQvGgL1cBfMu3X3WFamhY8QxaETB+Nf4zA0Y
   MqkffT1Qoqrucx2qHzwSi1rSZhICt0AQpyBxU0sDcj0Ld9/1JQoJR/8n6
   InhJ4r3QUpwPtOgOOGGvrXTpW85kmdMdtZmDq0vAhjhdtOEx0zD57VvHR
   PQMQTK1nu6R7q/6injZdgE7UXowonDVMz7qKKmNfNeXq1ccsqpCviHevU
   wHfAoOm1chXeUsdoXnTQstEMSetXuAvXm5nqb79u69/hC/nr7pBwwmxhU
   w==;
X-CSE-ConnectionGUID: jkwixYqpQIC0RFZ0/3GwRg==
X-CSE-MsgGUID: NHQ3ztm0SL+u/lWGCshAJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70724967"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70724967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:33:54 -0800
X-CSE-ConnectionGUID: pl3oAk9+R1a2ifZfz44LXA==
X-CSE-MsgGUID: fP7Y7RgsTnKMhg4m8d22cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213268510"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.199]) ([10.125.109.199])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 07:33:54 -0800
Message-ID: <e338b34e-72f9-4523-972b-314acd4a5630@intel.com>
Date: Wed, 28 Jan 2026 08:33:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ubuntu 24.04 not showing mem0 in "cxl list -M"
To: Learner cxl <learnercxl@gmail.com>, linux-cxl@vger.kernel.org
References: <CAFNvhHedX__1LdABSRqLXf4rtUWdoK-difOcr7TCWrAfG9Ssgg@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAFNvhHedX__1LdABSRqLXf4rtUWdoK-difOcr7TCWrAfG9Ssgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/28/26 2:55 AM, Learner cxl wrote:
> Hi list,
> 
> we are trying to setup CXL.mem in ubuntu 24.04 but  "cxl list -M"
> shows error as below.

What kernel version is that? Telling us Ubuntu 24.04 is meaningless without the kernel version. And we would also want to know what it looks like on a latest upstream kernel (v6.18). Otherwise it is a distro issue and you need to go talk to Ubuntu.  

> Can someone suggest what could be wrong here, how we root cause it further ?
> 
> root@amdgenoa1:/sys/bus/cxl/devices$ cxl list -M
>   Warning: no matching devices found
> []
> 
> 
> If we do lspci | grep cxl ---  we can see the memory expander but
>    there is no mem0 in /sys/bus/cxl/devices
> 
> root@amdgenoa1:/sys/bus/cxl/devices$ ls -l
> total 0
> lrwxrwxrwx 1 root root 0 Jan 28 06:31 root0 ->
> ../../../devices/platform/ACPI0017:00/root0
> root@amdgenoa1:/sys/bus/cxl/devices$

So you have an ACPI0017 device but no ACPI0016 (CXL host bridge) devices. Without those, the CXL devices cannot be enumerated. So maybe a BIOS issue?

> 
> Is there any upgrade required  BIOS / OS etc. We are using supermicro
> server(H13DSH, BIOS version 1.2)

What platform is this? Intel? AMD? ARM? Which CPU? Maybe you can host the kernel boot dmesg somewhere we can see? And would be helpful to add the following kernel boot parameters for debug.

cxl_acpi.dyndbg=+fplm cxl_pci.dyndbg=+fplm cxl_core.dyndbg=+fplm cxl_mem.dyndbg=+fplm cxl_pmem.dyndbg=+fplm cxl_port.dyndbg=+fplm cxl_region.dyndbg=+fplm

> 
> Appreciate your response
> Regards
> 

