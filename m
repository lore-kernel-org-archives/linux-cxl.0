Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096613DBBC;
	Fri, 16 Aug 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794449; cv=none; b=RubIoRd71EdbHnc+YOfkRl8OlGJAlO07kxoQt3KLE7BSkqy2OWtwuQMxx9ACjzu6Q1vxHvEvOlWTaepeeJiBdAMl96fYvya/t9+PUA2Nz8BWZ1ukMBVguv43J/5NX/d26PQRgFyS5CMvKFMrEdg4aQgC2W/e3Z6PP2wqOquRwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794449; c=relaxed/simple;
	bh=OqVTIszw2Wu/WHB8JbwN1IKzYU3OakSmmpks4rcjQ68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aX1pd13d6mq8k83nTiqgRHoEASrG96z+1ll1CmWU9BAZX1IjDAH4kyZ68AgvuHoKlqp90CTjMLy1H8suVRGB+VIko2QglSPe7nM/ESCKrUne+5NTK0kukMB50dWQtACIpdlE0jyxidgCyKZpA1MD766TXfakXnASm/txfLAq11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU7W9P1N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU7W9P1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723794447; x=1755330447;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OqVTIszw2Wu/WHB8JbwN1IKzYU3OakSmmpks4rcjQ68=;
  b=mU7W9P1Na0Mv4a0SY1PGWYJJeR7C4lpvBLnVqF+J+1PL2r43Q/n7YTPM
   52Dgbxn4zarVWVrtQDDwNV0my2EVXU30fNDPOnCPvQ0F8W9WYq2g0BIFd
   1xhU7h9NCWM8EtMQmZYTHs5kfjUWlVTfSJgZ5XpF/AWQ90+ZFPSzIcjax
   6l6kvboROQ7KormJOmXnbAL2O2+zSa0Ij1jn/j88trKYV52MmNA02tewN
   Ep1H3hpupwQyPinH0wd8Pabgu7hYwJQAxHgdhzlKp+uq17IuF3aEOnplC
   pG+uRrgU8v3CaM2oIKDJX2IMpMSnuseExTErR4e8bGrjNlXXYevOPVdtJ
   w==;
X-CSE-ConnectionGUID: gQjcKEwiQVyyxPihJkz1/Q==
X-CSE-MsgGUID: o99GZSHSRZyffcV7xQTmxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22051673"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22051673"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 00:47:26 -0700
X-CSE-ConnectionGUID: kzn96sZiSz+afU+mHl02Wg==
X-CSE-MsgGUID: r5CXRn9pQq6vcuKL9sOvdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59437266"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 00:47:23 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  linux-cxl@vger.kernel.org,  Davidlohr
 Bueso <dave@stgolabs.net>,  Jonathan Cameron
 <jonathan.cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,  Alison
 Schofield <alison.schofield@intel.com>,  Vishal Verma
 <vishal.l.verma@intel.com>,  Ira Weiny <ira.weiny@intel.com>,  Alistair
 Popple <apopple@nvidia.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Bjorn Helgaas <bhelgaas@google.com>,
  Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] Resource: fix region_intersects() for CXL memory
In-Reply-To: <66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	(Dan Williams's message of "Thu, 15 Aug 2024 22:01:03 -0700")
References: <20240816020723.771196-1-ying.huang@intel.com>
	<66bedd0f746ab_1c18294b5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Date: Fri, 16 Aug 2024 15:43:49 +0800
Message-ID: <87y14wj4ju.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dan Williams <dan.j.williams@intel.com> writes:

> Huang Ying wrote:
>> On a system with CXL memory installed, the resource tree (/proc/iomem)
>> related to CXL memory looks like something as follows.
>> 
>> 490000000-50fffffff : CXL Window 0
>>   490000000-50fffffff : region0
>>     490000000-50fffffff : dax0.0
>>       490000000-50fffffff : System RAM (kmem)
>> 
>> When the following command line is run to try writing some memory in
>> CXL memory range,
>> 
>>  $ dd if=data of=/dev/mem bs=1k seek=19136512 count=1
>>  dd: error writing '/dev/mem': Bad address
>>  1+0 records in
>>  0+0 records out
>>  0 bytes copied, 0.0283507 s, 0.0 kB/s
>> 
>> the command fails as expected.  However, the error code is wrong.  It
>> should be "Operation not permitted" instead of "Bad address".  And,
>> the following warning is reported in kernel log.
>> 
>>  ioremap on RAM at 0x0000000490000000 - 0x0000000490000fff
>>  WARNING: CPU: 2 PID: 416 at arch/x86/mm/ioremap.c:216 __ioremap_caller.constprop.0+0x131/0x35d
>>  Modules linked in: cxl_pmem libnvdimm cbc encrypted_keys cxl_pmu
>>  CPU: 2 UID: 0 PID: 416 Comm: dd Not tainted 6.11.0-rc3-kvm #40
>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>  RIP: 0010:__ioremap_caller.constprop.0+0x131/0x35d
>>  Code: 2d 80 3d 24 6a a1 02 00 75 c1 48 8d 54 24 70 48 8d b4 24 90 00 00 00 48 c7 c7 40 3a 05 8a c6 05 07 6a a1 02 01 e8 a3 a0 01 00 <0f> 0b eb 9d 48 8b 84 24 90 00 00 00 48 8d 4c 24 60 89 ea 48 bf 00
>>  RSP: 0018:ffff888105387bf0 EFLAGS: 00010282
>>  RAX: 0000000000000000 RBX: 0000000490000fff RCX: 0000000000000000
>>  RDX: 0000000000000001 RSI: 0000000000000003 RDI: ffffed1020a70f73
>>  RBP: 0000000000000000 R08: ffffed100d9fce92 R09: 0000000000000001
>>  R10: ffffffff892348e7 R11: ffffed100d9fce91 R12: 0000000490000000
>>  R13: 0000000000000001 R14: 0000000000000001 R15: ffff888105387ca0
>>  FS:  00007f86c438c740(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 000055ba75b1b818 CR3: 0000000005231000 CR4: 0000000000350eb0
>>  Call Trace:
>>   <TASK>
>>   ? __warn+0xd7/0x1b8
>>   ? __ioremap_caller.constprop.0+0x131/0x35d
>>   ? report_bug+0x136/0x19e
>>   ? __ioremap_caller.constprop.0+0x131/0x35d
>>   ? handle_bug+0x3c/0x64
>>   ? exc_invalid_op+0x13/0x38
>>   ? asm_exc_invalid_op+0x16/0x20
>>   ? irq_work_claim+0x16/0x38
>>   ? __ioremap_caller.constprop.0+0x131/0x35d
>>   ? tracer_hardirqs_off+0x18/0x16d
>>   ? kmem_cache_debug_flags+0x16/0x23
>>   ? memremap+0xcb/0x184
>>   ? iounmap+0xfe/0xfe
>>   ? lock_sync+0xc7/0xc7
>>   ? lock_sync+0xc7/0xc7
>>   ? rcu_is_watching+0x1c/0x38
>>   ? do_raw_read_unlock+0x37/0x42
>>   ? _raw_read_unlock+0x1f/0x2f
>>   memremap+0xcb/0x184
>>   ? pfn_valid+0x159/0x159
>>   ? resource_is_exclusive+0xba/0xc5
>>   xlate_dev_mem_ptr+0x25/0x2f
>>   write_mem+0x94/0xfb
>>   vfs_write+0x128/0x26d
>>   ? kernel_write+0x89/0x89
>>   ? rcu_is_watching+0x1c/0x38
>>   ? __might_fault+0x72/0xba
>>   ? __might_fault+0x72/0xba
>>   ? rcu_is_watching+0x1c/0x38
>>   ? lock_release+0xba/0x13e
>>   ? files_lookup_fd_raw+0x40/0x4b
>>   ? __fget_light+0x64/0x89
>>   ksys_write+0xac/0xfe
>>   ? __ia32_sys_read+0x40/0x40
>>   ? tracer_hardirqs_off+0x18/0x16d
>>   ? tracer_hardirqs_on+0x11/0x146
>>   do_syscall_64+0x9a/0xfd
>>   entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>  RIP: 0033:0x7f86c4487140
>>  Code: 40 00 48 8b 15 c1 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
>>  RSP: 002b:00007ffca9f62af8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>>  RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007f86c4487140
>>  RDX: 0000000000000400 RSI: 000055ba75b1a000 RDI: 0000000000000001
>>  RBP: 000055ba75b1a000 R08: 0000000000000000 R09: 00007f86c457c080
>>  R10: 00007f86c43a84d0 R11: 0000000000000202 R12: 0000000000000000
>>  R13: 0000000000000000 R14: 000055ba75b1a000 R15: 0000000000000400
>>   </TASK>
>>  irq event stamp: 0
>>  hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>  hardirqs last disabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
>>  softirqs last  enabled at (0): [<ffffffff89091e85>] copy_process+0xb60/0x255f
>>  softirqs last disabled at (0): [<0000000000000000>] 0x0
>> 
>> After investigation, we found the following bug.
>> 
>> In the above resource tree, "System RAM" is a descendant of "CXL
>> Window 0" instead of a top level resource.  So, region_intersects()
>> will report no System RAM resources in the CXL memory region
>> incorrectly, because it only checks the top level resources.
>> Consequently, devmem_is_allowed() will return 1 (allow access via
>> /dev/mem) for CXL memory region incorrectly.  Fortunately, ioremap()
>> doesn't allow to map System RAM and reject the access.
>> 
>> However, region_intersects() needs to be fixed to work correctly with
>> the resources tree with CXL Window as above.  To fix it, we will
>> search matched resources in the descendant resources too.  So, we will
>> not miss any matched resources anymore.
>
> Thanks for this Ying!
>
> I think this needs an explanation of the expected semantics of
> region_intersects() and maybe a fixup to meet that expectation, see
> below.
>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> ---
>>  kernel/resource.c | 44 +++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 37 insertions(+), 7 deletions(-)
>> 
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 14777afb0a99..c97a5add9394 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -542,18 +542,48 @@ static int __region_intersects(struct resource *parent, resource_size_t start,
>>  {
>>  	struct resource res;
>>  	int type = 0; int other = 0;
>> -	struct resource *p;
>> +	struct resource *p, *dp;
>> +	resource_size_t ostart, oend;
>> +	bool is_type;
>>  
>>  	res.start = start;
>>  	res.end = start + size - 1;
>>  
>>  	for (p = parent->child; p ; p = p->sibling) {
>> -		bool is_type = (((p->flags & flags) == flags) &&
>> -				((desc == IORES_DESC_NONE) ||
>> -				 (desc == p->desc)));
>> -
>> -		if (resource_overlaps(p, &res))
>> -			is_type ? type++ : other++;
>> +		if (!resource_overlaps(p, &res))
>> +			continue;
>> +		is_type = (((p->flags & flags) == flags) &&
>> +			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));
>> +		if (is_type) {
>> +			type++;
>> +			continue;
>> +		}
>> +		/*
>> +		 * Continue to search in descendant resources.  Unless
>> +		 * the matched descendant resources cover the whole
>> +		 * overlapped range, increase 'other', because it
>> +		 * overlaps with 'p' at least.
>> +		 */
>> +		other++;
>
> This results in REGION_MIXED whenever the target of the search is found
> as a descendant of @parent which I believe is unwanted.

This is not the behavior of this patch.  There's a "other--" later in
this patch.

+		ostart = max(res.start, p->start);
+		oend = min(res.end, p->end);
+		for_each_resource(p, dp, false) {
+			if (!resource_overlaps(dp, &res))
+				continue;
+			is_type = (((dp->flags & flags) == flags) &&
+				   ((desc == IORES_DESC_NONE) ||
+				    (desc == dp->desc)));
+			if (is_type) {
+				type++;
+				if (dp->start > ostart)
+					break;
+				if (dp->end >= oend) {
+					other--;     <====================== HERE!
+					break;
+				}
+				ostart = dp->end + 1;
+			}
+		}
 	}
 
 	if (type == 0)


That is, if the overlapped range is covered by matched (is_type == true)
descendant resources completely, other will not increase.

So, for resource tree as follows

490000000-52fffffff : CXL Window 0
  490000000-50fffffff : region0
    490000000-50fffffff : dax0.0
      490000000-50fffffff : System RAM (kmem)
  510000000-52fffffff
    510000000-52fffffff : dax0.1

region_intersects(, 0x490000000, PAGE_SIZE, IORESOURCE_SYSTEM_RAM,
IORES_DESC_NONE) => REGION_INTERSECTS
region_intersects(, 0x50f000000, 0x2000000, IORESOURCE_SYSTEM_RAM,
IORES_DESC_NONE) => REGION_MIXED

Even for

490000000-52fffffff : CXL Window 0
  490000000-50fffffff : region0
    490000000-50fffffff : dax0.0
      490000000-50fffffff : System RAM (kmem)

region_intersects(, 0x50f000000, 0x2000000, IORESOURCE_SYSTEM_RAM,
IORES_DESC_NONE) => REGION_MIXED

This isn't perfect, but it looks OK for me.  Because for

490000000-50fffffff : System RAM
510000000-52fffffff : CXL Window 0

region_intersects(, 0x50f000000, 0x2000000, IORESOURCE_SYSTEM_RAM,
IORES_DESC_NONE) => REGION_MIXED

However, I admit that the original code is hard to be understood,
whether is something like below better?

	for (p = parent->child; p ; p = p->sibling) {
		if (!resource_overlaps(p, &res))
			continue;
		is_type = (((p->flags & flags) == flags) &&
			   ((desc == IORES_DESC_NONE) || (desc == p->desc)));
		if (is_type) {
			type++;
			continue;
		}
		/*
		 * Continue to search in descendant resources.  Unless
		 * the matched descendant resources cover the whole
		 * overlapped range, increase 'other', because it
		 * overlaps with 'p' at least.
		 */
		covered = false;
		ostart = max(res.start, p->start);
		oend = min(res.end, p->end);
		for_each_resource(p, dp, false) {
			if (!resource_overlaps(dp, &res))
				continue;
			is_type = (((dp->flags & flags) == flags) &&
				   ((desc == IORES_DESC_NONE) ||
				    (desc == dp->desc)));
			if (is_type) {
				type++;
				if (dp->start > ostart)
					break;
				if (dp->end >= oend) {
					covered = true;
					break;
				}
				ostart = dp->end + 1;
			}
		}
		if (!covered)
			other++;
	}

> The semantics of region_intersects() has always been within a single
> sibling level to date. So, I don't think @other should be incremented
> until @is_type is non-zero. It follows that if @is_type is set and
> !resource_contains(p, &res) then there is no point in descending because
> it is known at that there are no descendants to worry about.

Sorry, I don't understand your words here.  Can you show your idea with
some examples or pseudo code?

> I do note that with those changes region_intersects() will start
> reporting REGION_MIXED rather than REGION_INTERSECTS when the passed in
> range intersects a hole plus the target, but I am not aware of any code
> path that expects to ignore resource holes. I.e. better to report holes
> as occupied in that case.
>
> Lastly, it would probably also be useful to special case the "@flags ==
> 0 && @desc == IORES_DESC_NONE" case because there is no point in
> descending the resource tree to look for additional holes. Those are all
> visible at the top of the resource tree.

--
Best Regards,
Huang, Ying
