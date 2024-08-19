Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80115B0F1;
	Mon, 19 Aug 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055242; cv=none; b=QOxxwBwCvuXBvlAulF7BumSau1/LcQG9BY1iD2Ym3Jtl5yzhOQnzDGz2u9HqsOgKk0f/sW8DUTfv/zxT8Yll9jB6cjONVBb0LXK4XWpCSvWWLbRT8Oypco7hNz6zdmDXAyQjLTTzNERBE4oFpDmhNy8/x8GigtrhSRPtWO27aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055242; c=relaxed/simple;
	bh=/0s38hQH0LjD8+H3UIC0MYt4+X4MGaqDVVL0Q8NXG+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoCcGUXL8K10BkgPDHnOslpY4HLFjjeVDtzK2yPMD0+/R8AfE7wQJf7PqIszkcTCpDc34QqAgRhySG/3KN5Fr62/v5YxFDUzj4UDwkwe/BxTAPOpMnxzAR2TRjvFOPY8Bx1rmeooAS0+TGct8d2FFHnvEtr5EcMGLa+zhmWRbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/Css+pK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/Css+pK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724055241; x=1755591241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0s38hQH0LjD8+H3UIC0MYt4+X4MGaqDVVL0Q8NXG+0=;
  b=A/Css+pKXMHr9NXovzv+FzETRvAj0NglDWXHA6VJesBR6ov5o6gLHxiu
   EPe25pB6Zu08mxlgpKqqnOC6tIUag11N8l4idH6ViFmQLweemOaERybaB
   U3zkwuRZR2tztlrDjBrY8HntpmYz6p23S4fJRGYbiSMDG7xW2Z5GnRLpL
   uxXBM0Rwg5B+dLAuLmARw5X9txFChwM5622OLxk+hTLp7dSb62Aagq7nM
   uFtjB8aGfFEdTi4JNi7eMR1TTm36GwXVBz56uP3XXb7lAo0J89+XYRhWQ
   DRVuzhkjFwYEvhFnLC8TRBswv68xYXsMN+avKZHR4pu8B7TnUGVYFV21W
   g==;
X-CSE-ConnectionGUID: Ms+634UISQ+Mgx6Ku+NPjg==
X-CSE-MsgGUID: 6Xy9CfeOSDyhnkl+6kWlwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="39802022"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="39802022"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:14:00 -0700
X-CSE-ConnectionGUID: /owpSLW8RgOPIcWTJaBmUQ==
X-CSE-MsgGUID: O1Yj8E3hQlK9swjrsnyJTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="83516490"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 01:13:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sfxWT-0000000Gorx-2bTx;
	Mon, 19 Aug 2024 11:13:53 +0300
Date: Mon, 19 Aug 2024 11:13:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -v2] Resource: fix region_intersects() for CXL memory
Message-ID: <ZsL-wfDYsUmWKBep@smile.fi.intel.com>
References: <20240819023413.1109779-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819023413.1109779-1-ying.huang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Aug 19, 2024 at 10:34:13AM +0800, Huang Ying wrote:
> On a system with CXL memory installed, the resource tree (/proc/iomem)
> related to CXL memory looks like something as follows.
> 
> 490000000-50fffffff : CXL Window 0
>   490000000-50fffffff : region0
>     490000000-50fffffff : dax0.0
>       490000000-50fffffff : System RAM (kmem)
> 
> When the following command line is run to try writing some memory in
> CXL memory range,
> 
>  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>  dd: error writing '/dev/mem': Bad address
>  1+0 records in
>  0+0 records out
>  0 bytes copied, 0.0283507 s, 0.0 kB/s
> 
> the command fails as expected.  However, the error code is wrong.  It
> should be "Operation not permitted" instead of "Bad address".  And,
> the following warning is reported in kernel log.

>  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
>  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
>  Modules linked in: cxl_pmem libnvdimm cbc encrypted_keys cxl_pmu
>  CPU: 2 UID: 0 PID: 416 Comm: dd Not tainted 6.11.0-rc3-kvm #40
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:__ioremap_caller.constprop.0+0x131/0x35d
>  Code: 2d 80 3d 24 6a a1 02 00 75 c1 48 8d 54 24 70 48 8d b4 24 90 00 00 00 48 c7 c7 40 3a 05 8a c6 05 07 6a a1 02 01 e8 a3 a0 01 00 <0f> 0b eb 9d 48 8b 84 24 90 00 00 00 48 8d 4c 24 60 89 ea 48 bf 00
>  RSP: 0018:ffff888105387bf0 EFLAGS: 00010282
>  RAX: 0000000000000000 RBX: 0000000490000fff RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffed1020a70f73
>  RBP: 0000000000000000 R08: ffffed100d9fce92 R09: 0000000000000001
>  R10: ffffffff892348e7 R11: ffffed100d9fce91 R12: 0000000490000000
>  R13: 0000000000000001 R14: 0000000000000001 R15: ffff888105387ca0
>  FS:  00007f86c438c740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055ba75b1b818 CR3: 0000000005231000 CR4: 0000000000350eb0
>  Call Trace:
>   <TASK>
>   ? __warn+0xd7/0x1b8
>   ? __ioremap_caller.constprop.0+0x131/0x35d
>   ? report_bug+0x136/0x19e
>   ? __ioremap_caller.constprop.0+0x131/0x35d
>   ? handle_bug+0x3c/0x64
>   ? exc_invalid_op+0x13/0x38
>   ? asm_exc_invalid_op+0x16/0x20
>   ? irq_work_claim+0x16/0x38
>   ? __ioremap_caller.constprop.0+0x131/0x35d
>   ? tracer_hardirqs_off+0x18/0x16d
>   ? kmem_cache_debug_flags+0x16/0x23
>   ? memremap+0xcb/0x184
>   ? iounmap+0xfe/0xfe
>   ? lock_sync+0xc7/0xc7
>   ? lock_sync+0xc7/0xc7
>   ? rcu_is_watching+0x1c/0x38
>   ? do_raw_read_unlock+0x37/0x42
>   ? _raw_read_unlock+0x1f/0x2f
>   memremap+0xcb/0x184
>   ? pfn_valid+0x159/0x159
>   ? resource_is_exclusive+0xba/0xc5
>   xlate_dev_mem_ptr+0x25/0x2f
>   write_mem+0x94/0xfb
>   vfs_write+0x128/0x26d
>   ? kernel_write+0x89/0x89
>   ? rcu_is_watching+0x1c/0x38
>   ? __might_fault+0x72/0xba
>   ? __might_fault+0x72/0xba
>   ? rcu_is_watching+0x1c/0x38
>   ? lock_release+0xba/0x13e
>   ? files_lookup_fd_raw+0x40/0x4b
>   ? __fget_light+0x64/0x89
>   ksys_write+0xac/0xfe
>   ? __ia32_sys_read+0x40/0x40
>   ? tracer_hardirqs_off+0x18/0x16d
>   ? tracer_hardirqs_on+0x11/0x146
>   do_syscall_64+0x9a/0xfd
>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>  RIP: 0033:0x7f86c4487140
>  Code: 40 00 48 8b 15 c1 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
>  RSP: 002b:00007ffca9f62af8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>  RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007f86c4487140
>  RDX: 0000000000000400 RSI: 000055ba75b1a000 RDI: 0000000000000001
>  RBP: 000055ba75b1a000 R08: 0000000000000000 R09: 00007f86c457c080
>  R10: 00007f86c43a84d0 R11: 0000000000000202 R12: 0000000000000000
>  R13: 0000000000000000 R14: 000055ba75b1a000 R15: 0000000000000400
>   </TASK>
>  irq event stamp: 0
>  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>  hardirqs last disabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
>  softirqs last  enabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
>  softirqs last disabled at (0): [<0000000000000000>] 0x0

Submitting Patches documentation suggests how to shrink the above to make it
somewhat readable and important.

> After investigation, we found the following bug.
> 
> In the above resource tree, "System RAM" is a descendant of "CXL
> Window 0" instead of a top level resource.  So, region_intersects()
> will report no System RAM resources in the CXL memory region
> incorrectly, because it only checks the top level resources.
> Consequently, devmem_is_allowed() will return 1 (allow access via
> /dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
> doesn't allow to map System RAM and reject the access.
> 
> However, region_intersects() needs to be fixed to work correctly with
> the resources tree with CXL Window as above.  To fix it, if we found a
> unmatched resource in the top level, we will continue to search
> matched resources in its descendant resources.  So, we will not miss
> any matched resources in resource tree anymore.  In the new
> implementation,
> 
> |------------- "CXL Window 0" ------------|
> |-- "System RAM" --|
> 
> will look as if
> 
> |-- "System RAM" --||-- "CXL Window 0a" --|
> 
> in effect.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Baoquan He <bhe@redhat.com>

You may move Cc list after '---', so it won't unnecessarily pollute the commit
message.

> ---
> Changelogs:
> 
> v2:
> 
> - Fix a bug which occurs when descendant of a matched resource matches.
> 
> - Revise the patch description and comments to make the algorithm clearer.
>   Thanks Dan and David's comments!
> 
> - Link to v1: https://lore.kernel.org/linux-mm/20240816020723.771196-1-ying.huang@intel.com/

...

>  {
>  	struct resource res;
>  	int type = 0; int other = 0;
> -	struct resource *p;
> +	struct resource *p, *dp;
> +	resource_size_t ostart, oend;
> +	bool is_type, covered;

Maybe keep more reversed xmas tree ordering?

>  	res.start = start;
>  	res.end = start + size - 1;
>  
>  	for (p = parent->child; p ; p = p->sibling) {
> -		bool is_type = (((p->flags & flags) == flags) &&
> -				((desc == IORES_DESC_NONE) ||
> -				 (desc == p->desc)));
> -
> -		if (resource_overlaps(p, &res))
> -			is_type ? type++ : other++;
> +		if (!resource_overlaps(p, &res))
> +			continue;
> +		is_type = (((p->flags & flags) == flags) &&
> +			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));

In the original code and here the most outer parentheses are redundant.

> +		if (is_type) {
> +			type++;
> +			continue;
> +		}
> +		/*
> +		 * Continue to search in descendant resources as if the
> +		 * matched descendant resources cover some ranges of 'p'.
> +		 *
> +		 * |------------- "CXL Window 0" ------------|
> +		 * |-- "System RAM" --|
> +		 *
> +		 * looks as if
> +		 *
> +		 * |-- "System RAM" --||-- "CXL Window 0a" --|
> +		 *
> +		 * in effect.
> +		 */
> +		covered = false;

> +		ostart = max(res.start, p->start);
> +		oend = min(res.end, p->end);

Isn't a reinvention of resource_intersection()? With that in place you may also
drop the above resource_overlaps().

> +		for_each_resource(p, dp, false) {
> +			if (!resource_overlaps(dp, &res))
> +				continue;
> +			is_type = (((dp->flags & flags) == flags) &&
> +				   ((desc == IORES_DESC_NONE) ||
> +				    (desc == dp->desc)));

Most outer parentheses are redundant. With them being dropped you also may
unite the last two lines into a single one.

> +			if (is_type) {
> +				type++;
> +				if (dp->start > ostart)
> +					break;
> +				if (dp->end >= oend) {
> +					covered = true;
> +					break;
> +				}
> +				ostart = max(ostart, dp->end + 1);
> +			}
> +		}
> +		if (!covered)
> +			other++;
>  	}

-- 
With Best Regards,
Andy Shevchenko


