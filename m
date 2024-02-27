Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC414EB43
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052033; cv=none; b=S0J2WZYp26BHw7q7twnJZ6DspG2nkJlDn9RxPNxJgb31aZB6rEZ9lKRAmfm15w4o8V04XAniHb4bL6Ngln9bC1faNfaMJMhrC83tEV9pY2YHVybyewAsJpvyIzk8SZfISIMaJZnIII7l7MWh91dAnhZCLrXn+FhWCmvmewrcyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052033; c=relaxed/simple;
	bh=oGY/1c58aPR/33s1f/2U3hoauwGPpqCDwBiJZqfZASY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZDbvuFLqe2KJZYMuHjbpKNh4yYrFAcnMYd97ZaacrpnvrSJ95BPr8YNqguP6KvLY0U6zoZNGrhdZicG9DME9mHuHPxNCGXxHDCGkWo8z8ZbUTPV1uK1PXbxPAHDPhKDBs3BEzBqWBL48uEpY96Udz3Nxyl0mjgPyl33AyG+bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ikq+3K6v; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ikq+3K6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709052032; x=1740588032;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oGY/1c58aPR/33s1f/2U3hoauwGPpqCDwBiJZqfZASY=;
  b=Ikq+3K6vbcfvTMCpkRViSR8iy7FBSl2sD4BnIShNN8xKVGvu6Zk2UZCq
   5zgJovmzgAPMG/dyiHzKgzhui5EpcowzLweJqy7Zv2S2nT5zIp2TU1Z2L
   F5LhLSS60oKDHESPPpj0hHMvSs0rPpWxpRUIIf4ox+0RPmyzdPPb6n5A9
   0uGZo6dWFoK5tuRyevvNLxY0g9K/iaqGOG+nnsIi/zbK9hXAywq2KhTGS
   NbC+SwQGjIPtCSeXBGpRWu0VMTwJdLofhXT/Rk9l06M6KhYE46oCoIJY1
   CrvJa9sMb0M4yLtOqZv5F4GW7g0+AAEYgb02csq8k85jRW1tNrqOvtRGm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7186489"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7186489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7058441"
Received: from pbackus-mobl1.amr.corp.intel.com (HELO [10.246.114.227]) ([10.246.114.227])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 08:40:30 -0800
Message-ID: <dd61a8f2-ef80-46cc-8033-b3a4b987b3f4@intel.com>
Date: Tue, 27 Feb 2024 09:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about forcing 'disable-memdev'
Content-Language: en-US
To: =?UTF-8?B?Q2FvLCBRdWFucXVhbi/mm7kg5YWo5YWo?= <caoqq@fujitsu.com>,
 linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc: vishal.l.verma@intel.com
References: <3788c116-50aa-ae97-adca-af6559f5c59a@fujitsu.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3788c116-50aa-ae97-adca-af6559f5c59a@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/26/24 10:32 PM, Cao, Quanquan/曹 全全 wrote:
> Hi, Dave
> 
> On the basis of this patch, I conducted some tests and encountered unexpected errors. I would like to inquire whether the design here is reasonable? Below are the steps of my testing:
> 
> Link: https://lore.kernel.org/linux-cxl/170138109724.2882696.123294980050048623.stgit@djiang5-mobl3/
> 
> 
> Problem description: after creating a region, directly forcing 'disable-memdev' and then consuming memory leads to a kernel panic.

If you are forcing memory disable when the memory cannot be offlined, then this behavior is expected. You are ripping the memory away from underneath kernel mm. The reason the check was added is to prevent the users from doing exactly that.


> 
> 
> Test environment:
> KERNEL    6.8.0-rc1
> QEMU    8.2.0-rc4
> 
> Test steps：
>       step1: set memory auto_online to movable zones.
>            echo online_movable > /sys/devices/system/memory/auto_online_blocks
>       step2: create region
>            cxl create-region -t ram -d decoder0.0 -m mem0
>       step3: disable memdev
>            cxl disable-memdev mem0 -f
>       step4: consum CXL memory
>            ./consumemem   <------kernel panic
> 
> numactl node status:
>       step1: numactl -H
> 
>     available: 2 nodes (0-1)
>     node 0 cpus: 0 1
>     node 0 size: 968 MB
>     node 0 free: 664 MB
>     node 1 cpus: 2 3
>     node 1 size: 683 MB
>     node 1 free: 333 MB
>     node distances:
>     node   0   1
>       0:  10  20
> 
>     step2: numactl -H
> 
>     available: 3 nodes (0-2)
>     node 0 cpus: 0 1
>     node 0 size: 968 MB
>     node 0 free: 677 MB
>     node 1 cpus: 2 3
>     node 1 size: 683 MB
>     node 1 free: 333 MB
>     node 2 cpus:
>     node 2 size: 256 MB
>     node 2 free: 256 MB
>     node distances:
>     node   0   1   2
>       0:  10  20  20
>       1:  20  10  20
>       2:  20  20  10
> 
>     step3: numactl -H
> 
>     available: 3 nodes (0-2)
>     node 0 cpus: 0 1
>     node 0 size: 968 MB
>     node 0 free: 686 MB
>     node 1 cpus: 2 3
>     node 1 size: 683 MB
>     node 1 free: 336 MB
>     node 2 cpus:
>     node 2 size: 256 MB
>     node 2 free: 256 MB
>     node distances:
>     node   0   1   2
>       0:  10  20  20
>       1:  20  10  20
>       2:  20  20  10
