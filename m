Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DB13ECBDD
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850424; cv=none; b=jCRo8Wk9af8cbg1YJMbkfwX2rrWnnkUrT4z9wBkTLlJ9psoFj2nx6C38frUltCggc5A4Td2cltKJdTGGBn+QoVFJh1wZ1myshZ6GFND4Ow25fEuI2PR6kBWEAXIiLqzq+gPnerCKJumipaH/j3KiMEmmqOXvgUNVZFmmaMVmCOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850424; c=relaxed/simple;
	bh=VBtl2yMqlKetVhjVh/rwemG66itSGGBo6G4/P7dKk7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jnRl2MYOBihKM5SC83+qdANOjpDRtmIw/xUU7XNUYNd3By/0IF2N619cisu9/OcSrMnY5S1xPlgKB1DlpWoz5VIjj3J9BcsOKj6+zPnQClN2HvKg3kBon1XUqbzPZOenFZ+MXlJyo5Sa9tqkmwUPoZmIfEL1HXuH2SXvNTJg3o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ee7XKUZ1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ee7XKUZ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773850419; x=1805386419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VBtl2yMqlKetVhjVh/rwemG66itSGGBo6G4/P7dKk7U=;
  b=ee7XKUZ1bRQQ2jrwOs+8eNxmAOF2pAHz7xFUbXLmd987Txjbu/aLC3vT
   oX6olEeyktAZ1dBbdmeHpmr5mqCG4ES3tHdnNUmB2qs7qx1TfL82ofuNz
   BhN99B1wDbIHS9OaJYY8fkN+UsEm3Q7UUCE4tIBeyzY2xbQDJZiZeYSwp
   cwS/wryxABDN3QJnjdQ+bfRApSnn3G42yywA6gTNRMBbqh13QH5k+Xwdc
   kW5MWcnlvN72TqJ+YChhKE3750hMDKlqzCF0tqqwA1Jl4PL4n4/QS7Esl
   Lhh47m743V3YX9a6q32UQOBO7NE0P9EvcT9+iav4vCrYCzVyaEFCKlytF
   A==;
X-CSE-ConnectionGUID: aOEwxPjIR+i6/NOGkKqclg==
X-CSE-MsgGUID: uGFpZJQFQOO7Rg8TSi97FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92482544"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="92482544"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:13:38 -0700
X-CSE-ConnectionGUID: JbZezcG+TfGyON7RaI9baA==
X-CSE-MsgGUID: 9MB3oLzaQnWQUke4V8FgbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="221756189"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 09:13:37 -0700
Message-ID: <db588b17-37f9-497a-aa98-7de375bf4837@intel.com>
Date: Wed, 18 Mar 2026 09:13:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Use proper endpoint validity check upon
 sanitize
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260301221739.1726722-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260301221739.1726722-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/1/26 3:17 PM, Davidlohr Bueso wrote:
> Fuzzying CXL triggered:
> 
> BUG: KASAN: null-ptr-deref in cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
> Read of size 4 at addr 0000000000000642 by task syz.0.97/2282
> 
> CPU: 2 UID: 0 PID: 2282 Comm: syz.0.97 Not tainted 7.0.0-rc1-gebd11be59f74-dirty #494 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  kasan_report+0xe0/0x110 mm/kasan/report.c:595
>  cxl_num_decoders_committed+0x3e/0x80 drivers/cxl/core/port.c:49
>  cxl_mem_sanitize+0x141/0x170 drivers/cxl/core/mbox.c:1304
>  security_sanitize_store+0xb0/0x120 drivers/cxl/core/memdev.c:173
>  dev_attr_store+0x46/0x70 drivers/base/core.c:2437
>  sysfs_kf_write+0x95/0xb0 fs/sysfs/file.c:142
>  kernfs_fop_write_iter+0x276/0x330 fs/kernfs/file.c:352
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x5df/0xaa0 fs/read_write.c:688
>  ksys_write+0x103/0x1f0 fs/read_write.c:740
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x111/0x680 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f60a584ba79
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f60a42a7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f60a5ab5fa0 RCX: 00007f60a584ba79
> RDX: 0000000000000002 RSI: 00002000000001c0 RDI: 0000000000000003
> RBP: 00007f60a58a49df R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f60a5ab6038 R14: 00007f60a5ab5fa0 R15: 00007ffe58fad8b8
>  </TASK>
> 
> This goes away using the correct check instead of abusing cxlmd->endpoint,
> which is unusable (ENXIO) until the driver has probed. During that window
> the memdev sysfs attributes are already visible, as soon as device_add()
> completes.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/fixes
9a6a2091324a ("cxl/mbox: Use proper endpoint validity check upon sanitize")

> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e7a6452bf544..12386d912705 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1301,7 +1301,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
>  	 * Require an endpoint to be safe otherwise the driver can not
>  	 * be sure that the device is unmapped.
>  	 */
> -	if (endpoint && cxl_num_decoders_committed(endpoint) == 0)
> +	if (cxlmd->dev.driver && cxl_num_decoders_committed(endpoint) == 0)
>  		return __cxl_mem_sanitize(mds, cmd);
>  
>  	return -EBUSY;

