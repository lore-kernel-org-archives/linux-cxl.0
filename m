Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCDA3FD145
	for <linux-cxl@vger.kernel.org>; Mon,  2 Mar 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466095; cv=none; b=hjWyLdfEboMKm1r7YBIiJs0zOP6uQnhb15ZJGqxQ/0dfojsH+Q9H0wC16xvVIRZE1a1f70S22Zgc02W6jO7RQPXZ4im+c0GX46R6c0Y8pY5p34paE89sidOuxqn2RZMAE6Hm+t9XiAAtORjP8BkChOIPVTkrSnq5ro+GKiQ6Bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466095; c=relaxed/simple;
	bh=kdfSVt8wzK1XJLzIzlFH5PRq8GNX0UzlBGV+NKF3GAg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgqzhZB0m9ZkLr+i7UJtC92PKoABu31R56U4O1e6TNWoirT+Zy8cVw7o5B9JPSLN1VW7yxidE9oyaoU3PmPe/xKCXHLdtdrWp53tAmhFtDWU/EBJ8TgDaUhwe6FdNeJeI/eQisWJ13odwWPJu4MnIMtZiLbR9585s67FX0ot4VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPjnk57xzzJ469l;
	Mon,  2 Mar 2026 23:40:58 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 57B8540585;
	Mon,  2 Mar 2026 23:41:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 15:41:29 +0000
Date: Mon, 2 Mar 2026 15:41:28 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Use proper endpoint validity check upon
 sanitize
Message-ID: <20260302154128.00001e3b@huawei.com>
In-Reply-To: <20260301221739.1726722-1-dave@stgolabs.net>
References: <20260301221739.1726722-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun,  1 Mar 2026 14:17:39 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

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
Given the device guard for cxlmd->dev is held (just off the top of the context
here) this seems reasonable to me. I wonder if we should have some descriptive
comment though as it's not obvious that the validity of endpoint depends on
the driver being set + the lock being held.  Otherwise LGTM.


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

