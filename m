Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014B2F6192
	for <linux-cxl@vger.kernel.org>; Mon,  2 Mar 2026 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469665; cv=none; b=t3XZjVZ+rnint4byaNbe5PLMfgZx2llrZfwAaA06RD6VMkZdd4PjOpFUjrBd6rQP/B9ReS4DhvZFrNxrtu9bx7R/l/O08/C7jWbZtdZmtLO9VqpISP+GzbLSHF3Jufc1iDUi77cJXoNMtEBU3wRblMCTcZNjc/V4J31JfLicjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469665; c=relaxed/simple;
	bh=7PSMjQslt5vNTtZAvldameZLoJSsc+yQPPosvIluAeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT/xc41zO4hDuxYjFoqg1vCxtNWh/0ztRgsXYBJWNYDWZffmIXQmBhi3HSCa3dl5fNEUVQxSOhxWKQwbrB3IamoJvCe8fCcvhl5zt1dBHUfi2uCIiJTpfvoaCjKClnlwuu54VUj/oyIufmbe1hxMtTiRpeCBJDn3/zTe6pM37yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BU4QxDHy; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BU4QxDHy"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cb5138df1aso462131585a.3
        for <linux-cxl@vger.kernel.org>; Mon, 02 Mar 2026 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772469662; x=1773074462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hU7kSiCjcFnv0RvhGpsJiCl4D36MygbfX8bcDojHP+s=;
        b=BU4QxDHy8Fa2EKTwY14O97d0swX9rwxFqOk1C3VVOZfzZOH6yhXm2PfbGrdrArmm6W
         4Iz6WXt6vIxi4/QiHfmP6lcCL1tvauxh+O2XpgTk7L9t4qAcwLrsJoKg/l3VyulTIHVR
         qBB0Izn3r3+dOQ+/idcR36I5m9urI1VZFifmg3t7Sz+wS1Pyjt+NxDS5TRRFfEtV36yh
         LTZHf7FMDk3d/d5m/0CpuZNO6KbN68u0tSu3pv0GV5zNXBRINb9J5BZHQ1L6jXJXH2MG
         hyGA4WKz1VVDBFxRih7SRfGRuZITtNwgkjeo5V1CpZJP8Q9fzx5HbdR1irGdUEHt61BH
         sWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772469662; x=1773074462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU7kSiCjcFnv0RvhGpsJiCl4D36MygbfX8bcDojHP+s=;
        b=iDMnz4V87rUchvHTplIyGNnaIOaFJwdrXj1xDmkeqmxUqFReDgXjlnvrDEnuzompud
         d3E0jf4wMWw2/VxMkmv8B5Q6zrWdU554S8cP6fPYc2nFCn/Lbx0AsWdMWpwBlGAEh/Zj
         zhb0WreHKa22c18PkMe34i3I6Q6aH0vMMC4iXYHQwynmlq8mohCLKqBGh27xFuzYGews
         uBZ36/zw9Y1gCfADuplvGJyvn4ZxckfNMY8LboLrLEF4Io4TvpmlVbXBTkWMS+1nmVYx
         SOFjiGewzGczUn9xWWyDbobcFIlsPezfbd6506m6Xj8CqouCDItY5Jp51NSDeHFu6eQN
         5kUw==
X-Forwarded-Encrypted: i=1; AJvYcCVv3hUyouoAI9BNErYrDWf9K3KDVIxL+dN9ReRgkaTWphVOAHRNta/fygMl3bU9YUM41F4YuQO+P5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVOVCaLwm7Cci7x7VyRZe/ZPuwtmxrQuuOhyMuXadtx1l+Odc
	R5VD93Rtwlg9xl0dPOn1ATPRXTi660lTnj2QkhsujhXQ5qur3yHbmXjfNqxLXeZ9vGA=
X-Gm-Gg: ATEYQzwDkqfpFsJG3pFIPOyFxgQ14m+wyGqFLANSHVAWLZMixHxqbOgT2ul/k/aqLr4
	/xGVz+9QcRsA0namo4VQG+SapL7i12Vlm9Lg0Fb61XclWa2YXmiJY78UO5L1H2kqB1gBmQwedzc
	m7/xc6fTOKKvdqp2QD8al0NMoDxu/4OIMbXNvs2yAcBMyRxnPDcM9LJuBQbrte/N83uHbL/U5mL
	0mVzNimpevQELYPtlEcIIO0Q8pa3KYEDZbtrlFgWHy4XzkiNsoFJsJiZm9ufo62EkJvhqWY2aDl
	NiCRycwJTHYgEPILm2xS360uQwlZOUCx/a1mcfySpeJkgvms9/F3zQ6nOjnyCDaSjk4MbHr58rp
	OHiyQyS4tIJM/m/DIRpbhX63hRh222m+H5J5Obd2Xtk24RmNwFKUFVTabETMZaxc5ey948Vef2g
	aQnzuP15bReMfvogRv3OYHQeffx4D/UkUg0eTj8N+LdSqYnigkawbT7KKIwjbcmdk586oTcAaj4
	F31uYIKTw==
X-Received: by 2002:a05:620a:4727:b0:8b2:e827:14bc with SMTP id af79cd13be357-8cbc8e083dbmr1393634985a.56.1772469662191;
        Mon, 02 Mar 2026 08:41:02 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf736bffsm1157535885a.50.2026.03.02.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:41:01 -0800 (PST)
Date: Mon, 2 Mar 2026 11:41:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Use proper endpoint validity check upon
 sanitize
Message-ID: <aaW9nGhGY_DOgvF6@gourry-fedora-PF4VCD3F>
References: <20260301221739.1726722-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301221739.1726722-1-dave@stgolabs.net>

On Sun, Mar 01, 2026 at 02:17:39PM -0800, Davidlohr Bueso wrote:
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

nice catch

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
