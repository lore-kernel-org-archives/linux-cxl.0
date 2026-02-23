Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9473793B0;
	Mon, 23 Feb 2026 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886084; cv=none; b=KO54GiN9KzzoRHYZxyZ6Lh/cyMLEsr2UXvqy+hs4HAZO84ivAQ/+ggz5CYzJqw9a16TH9VenFRnueeBpXdlym87S+BXg9PRrBxiDItKItFgt+3us6SxiumWOpCkLhGyX2kjYvHglSis/WGzYk0X1h9VnarQ6mCAH5aQAYTxoP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886084; c=relaxed/simple;
	bh=jHASsqjdKZa3dki3qh+bImT9GhWDimrPCU0v5/ree4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+mMZKKGR3a2mlWPFKcdEBHWXBgturwhO+dfRhQ+Dlv7TrFD7MDEC7o72igUpVrjvxfStS/x8WsnRLNdOfWhTKPVeaMlBh6lRvaEwzs36wz/esDBHgoYQ4L80vzp0PiBhy1wVqNNLd0f9PLdwWL8iaCVvcZb/VWQNxievWgnQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaIuTRTm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaIuTRTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771886080; x=1803422080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jHASsqjdKZa3dki3qh+bImT9GhWDimrPCU0v5/ree4M=;
  b=XaIuTRTmc1J9GugizEmvpqF3/l8yCr4gwhIA5wxa71AcWa/Q8Zd9w5FD
   7nVu5w3ujnq4F1G+6k0Bx6Uiu6oVS8huTT7kRclqyCUT4sZpx/NygFynF
   SKXJ621mc4qsGeSAQ6Ml4pBYs8OPSFSbpSx/FmiZhiDcHQbOIP3eB8y3X
   oUF/QUx2h/J8Lc0vFtutajZv7bktal2yQrl4n18HJHM8LOkhI6764VUaF
   Qk+rSwQNTQ57PNV6Ms9QGnJN0hUO/1tvkopIuB06mQBAq7OXgLjiYhMSc
   0PkmXX7HHCavbMGnjALjOa+TbwpaU0+Le7ombKyOAf6S81tswNe95hmbS
   g==;
X-CSE-ConnectionGUID: mzR312nOQIm+hkWLme4eBA==
X-CSE-MsgGUID: 5hiJg+B1QFGjbVI2d+slKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71922209"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="71922209"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:34:40 -0800
X-CSE-ConnectionGUID: 1lFNeHt+QvKenjIUWAw22w==
X-CSE-MsgGUID: qncwjDHBTQKQmMdoWVQqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="215555905"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:34:39 -0800
Message-ID: <801e7fa5-572b-49e6-9d47-2121e48c094a@intel.com>
Date: Mon, 23 Feb 2026 15:34:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Fix port enumeration failure
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260210-fix-port-enumeration-failure-v3-0-06acce0b9ead@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/10/26 4:46 AM, Li Ming wrote:
> I ran CXL mock testing with next branch, I usually hit the following
> call trace.

Applied series to cxl/fixes. I squashed patch 1 and 3 together.
0066688dbcdc cxl/port: Hold port host lock during dport adding.
822655e6751d cxl/port: Introduce port_to_host() helper

> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
>  CPU: 3 UID: 0 PID: 42 Comm: kworker/u16:1 Tainted: G           O      J 6.19.0-rc5-cxl+ #4 PREEMPT(voluntary)
>  Tainted: [O]=OOT_MODULE, [J]=FWCTL
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>  Workqueue: async async_run_entry_fn
>  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
>  Call Trace:
>   <TASK>
>   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
>   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
>   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
>   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
>   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
>   platform_probe+0x9d/0x130
>   really_probe+0x1c8/0x960
>   driver_probe_device+0x45/0x120
>   __device_attach_driver+0x15d/0x280
>   bus_for_each_drv+0x100/0x180
>   __device_attach_async_helper+0x199/0x250
>   async_run_entry_fn+0x95/0x430
>   process_one_work+0x7db/0x1940
> 
> After detailed debugging, I identified adding dport failure leads to the
> problem.
> What I observed is when two memdev were trying to enumerate a same port,
> the first memdev was responsible for port creation and bind it to the
> cxl port driver. However, there is a small window between the point
> where the new port becomes visible(after being added to the device list
> of cxl bus) and when it is bound to the port driver. During this window,
> the second memdev may discover the port and acquire its lock while
> attempting to add its dport, which blocks bus_probe_device() inside
> device_add(). As a result, the second memdev observes the port as
> unbound and fails to add its dport. The second memdev->endpoint would
> not be updated because of that, then trigger above trace.
> 
> The solution is to fix this race by holding the host lock of the target
> port during dport addition, preventing premature access before driver
> binding completed.
> 
> base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23 cxl/next
> 
> Changes from V2:
> - Split to_port_host() implementation to a lead-in patch. (Dan)
> - Use to_port_host() instead of open coded. (Dan)
> - Rename to_port_host() to port_to_host() to align with dport_to_host().
> 
> Changes from V1:
> - Remove the patch of initializing memdev->endpoint to NULL. (Dan)
> - Fixes typo errors. (Jonathan)
> - Introduce a helper called to_port_host().
> - unregister_port() cleanup.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> Li Ming (3):
>       cxl/port: Introduce port_to_host() helper
>       cxl/port: Hold port host lock during dport adding.
>       cxl/port: Use port_to_host() to get port host
> 
>  drivers/cxl/core/core.h | 18 +++++++++++++++++
>  drivers/cxl/core/port.c | 52 +++++++++++++++++--------------------------------
>  2 files changed, 36 insertions(+), 34 deletions(-)
> ---
> base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23
> change-id: 20260208-fix-port-enumeration-failure-34e1f4953f02
> 
> Best regards,

