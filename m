Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F0736895A;
	Mon,  9 Mar 2026 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087694; cv=none; b=JYWp/EPeM6/gPun4SjtJwdZxBR+UMPxJeEgLfB6UfTkt/vqSD1/WnLIeLoJBQRSM+A8bWtFfBDSwLh98msv1npRstneqhq3v/whc9hWe0sFSgcc+iYpYVmempox82XwvvkNjrD+XtMb6y8QIs0CQsmIZgC96AwWbzwv7WZ0uSeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087694; c=relaxed/simple;
	bh=J/lR7FlmkPkGcnaqT3X0PatPY/jjC12sNI7gOeIkIIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsFE75zPbhN9K8w7svFM/bwb/eSGP//9cS9NqC1fI8B0qeBuDToVDuy5Ru2IGlS9y+XtDeLNhbFHSGoIIenTd1kUrYudThH4OjqzcWrNyZJhStzNogLn3V5Uz410cycNkBEZ4+QfgV5Pyq4vdfdou52+PfGvpvqwvCrbRWLf+WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fi32S0o6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fi32S0o6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773087692; x=1804623692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J/lR7FlmkPkGcnaqT3X0PatPY/jjC12sNI7gOeIkIIE=;
  b=fi32S0o6Cql1DRlhCiHZFFAeY/jA9o1XDg1dwXHacT5x0UNJ1kdRty1R
   rofAK7bKEtN8OLJOQj3vI76+oVCZ+IReV2u0Ry6o45dhkwujydcrGo2RG
   Q5WZ4UXtpqV045mZHDPIgDuRutoxEgKlRtfi2QI7KPqTbs/Sjg3vxbLuu
   1w4YGXsksA9m+qLXFZeEujMKQ5Scw4h/GY4JGfZhDgoj09SK0eY8XYIWk
   lYdxrpwR/3X/JK3Xi6l9KimxwmcFzprgPwkdwJFRA1CY4OFO8rrcjc03P
   XfoH4H3qDdE2HvYSonmAPYgjo8SoIChSF0fqulzjiACKbmxmTwdC6rKSb
   g==;
X-CSE-ConnectionGUID: tuP13doiQYiNpx9UJbRBcA==
X-CSE-MsgGUID: lTWzXYN1SpiCGdnkvTCQKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74095842"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74095842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:21:32 -0700
X-CSE-ConnectionGUID: Z/bF/jxCS2eGzww6qcJBTw==
X-CSE-MsgGUID: lr2mZe48QY6L/W3QG1kALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="242882295"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 13:21:29 -0700
Message-ID: <68ed44be-9b21-47b7-a833-284aa471fb9b@intel.com>
Date: Mon, 9 Mar 2026 13:21:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309000810.2632065-2-iam@sung-woo.kim>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260309000810.2632065-2-iam@sung-woo.kim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/8/26 5:08 PM, Sungwoo Kim wrote:
> In the following race scenario, devm_remove_action() can be called
> before devm_add_action(), triggering a warning because there is no
> action to remove.
> 
> To fix this, extend a critical section to embrace both
> __cxl_dpa_reserve() and devm_add_action().
> 
> task 1:
> cxl_dpa_alloc()
>   __cxl_dpa_reserve()    ...(1)
>   devm_add_action()      ...(4)
> 
> task 2:
> cxl_dpa_free()
>   guard()
>   if (!cxled->dpa_res)   ...(2) pass, due to (1)
>     return 0;
>   devm_cxl_dpa_release()
>     devm_remove_action()  ...(3) warning, no action is added yet
> 
> Warning log:
> 
> WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
> WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993
> Modules linked in:
> CPU: 0 UID: 0 PID: 25993 Comm: syz.1.6464 Not tainted 6.19.0-g15a37b05f387 #10 PREEMPT(lazy)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> RIP: 0010:devm_remove_action include/linux/device/devres.h:160 [inline]
> RIP: 0010:devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline]
> RIP: 0010:cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572
> Code: 01 31 ff 41 89 c4 89 c6 e8 a9 91 1d fe 45 85 e4 0f 85 55 ff ff ff e8 4b 96 1d fe 90 0f 0b 90 e9 47 ff ff ff e8 3d 96 1d fe 90 <0f> 0b 90 e9 63 ff ff ff bb f0 ff ff ff e9 68 ff ff ff 48 c7 c7 f4
> RSP: 0018:ffff888129f77bb8 EFLAGS: 00010282
> RAX: 00000000000000f3 RBX: ffff888102f64000 RCX: ffffffff837301d3
> RDX: 0000000000080000 RSI: ffffc90001c5a000 RDI: 0000000000000005
> RBP: 00000000fffffffe R08: 0000000000000001 R09: ffff888123f98000
> R10: 00000000fffffffe R11: 0000000000000000 R12: 0000000000000001
> R13: ffff888102f64040 R14: dffffc0000000000 R15: ffff888102f64000
> FS:  00007fae0488d6c0(0000) GS:ffff88827086d000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000012f7d6003 CR4: 0000000000770ef0
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  dpa_size_store+0xfb/0x230 drivers/cxl/core/port.c:269
>  dev_attr_store+0x58/0x80 drivers/base/core.c:2437
>  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
>  kernfs_fop_write_iter+0x3d6/0x5d0 fs/kernfs/file.c:352
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x68e/0x1050 fs/read_write.c:688
>  ksys_write+0x12a/0x250 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfc/0x670 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fae0399c669
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fae0488d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fae03c15fa0 RCX: 00007fae0399c669
> RDX: 000000000000000a RSI: 00002000000001c0 RDI: 0000000000000009
> RBP: 00007fae03a32c71 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fae03c16038 R14: 00007fae03c15fa0 R15: 00007ffe53519fb8
>  </TASK>
> irq event stamp: 1021
> hardirqs last  enabled at (1029): [<ffffffffb7d04c4b>] __up_console_sem+0x7b/0x90 kernel/printk/printk.c:347
> hardirqs last disabled at (1038): [<ffffffffb7d04c30>] __up_console_sem+0x60/0x90 kernel/printk/printk.c:345
> softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __do_softirq kernel/softirq.c:656 [inline]
> softirqs last  enabled at (1016): [<ffffffffb7b73b93>] invoke_softirq kernel/softirq.c:496 [inline]
> softirqs last  enabled at (1016): [<ffffffffb7b73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
> softirqs last disabled at (1005): [<ffffffffb7b73b93>] __do_softirq kernel/softirq.c:656 [inline]
> softirqs last disabled at (1005): [<ffffffffb7b73b93>] invoke_softirq kernel/softirq.c:496 [inline]
> softirqs last disabled at (1005): [<ffffffffb7b73b93>] __irq_exit_rcu+0xb3/0xe0 kernel/softirq.c:723
> 
> Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/hdm.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e3f0c39e68124..86239b1790a31 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -509,13 +509,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	int rc;
>  
> -	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
> -		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
>  
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	/* See comments in cxl_dpa_alloc()*/
> +	rc = devm_add_action(&port->dev, cxl_dpa_release, cxled);
> +	if (rc) {
> +		__cxl_dpa_release(cxled);
> +		return rc;
> +	}
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
>  
> @@ -613,7 +620,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	struct resource *p, *last;
>  	int part;
>  
> -	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	lockdep_assert_held_write(&cxl_rwsem.dpa);
>  	if (cxled->cxld.region) {
>  		dev_dbg(dev, "decoder attached to %s\n",
>  			dev_name(&cxled->cxld.region->dev));
> @@ -679,11 +686,28 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	int rc;
>  
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
>  	rc = __cxl_dpa_alloc(cxled, size);
>  	if (rc)
>  		return rc;
>  
> -	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +	/*
> +	 * Add the devres action while still holding cxl_rwsem.dpa to prevent
> +	 * a race with cxl_dpa_free(). Without this, a concurrent cxl_dpa_free()
> +	 * can observe dpa_res set (by __cxl_dpa_reserve()) and attempt
> +	 * devm_remove_action() before devm_add_action() has been called,
> +	 * triggering a WARN_ON in devm_remove_action().
> +	 * Also, devm_add_action_or_reset() cannot be used here because
> +	 * cxl_dpa_release() tries to hold the dpa lock that is already held,
> +	 * causing a self deadlock.
> +	 */
> +	rc = devm_add_action(&port->dev, cxl_dpa_release, cxled);
> +	if (rc) {
> +		__cxl_dpa_release(cxled);
> +		return rc;
> +	}
> +
> +	return 0;
>  }
>  
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)

