Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FC02749DA
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069169; cv=none; b=H7GZVmVxD2W8cHudufs5TBwAeFUQy99LvLItAxycivVC/qZhKipOYEWPL1J0nyiYRxK/m9I9an3hiu8peRxt3I85nT6M2PrtbFaRkhTNnZdkiX7ll8NoRkl51o57UknaSrTV5bzuc9HhbCPKqGiQQYb1Ncv/NmVfQCbbKPXlbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069169; c=relaxed/simple;
	bh=7TQXP7JmIuRCp5MShFNQPu2lPjUu0k0Cj6nFPyZYgyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azW7XQ+QsrKlFAOHp8E5XycXD2D7bQkTHZMkB8Hab/VoQ2c9BwquMYEgmhzEoB2D2uKiHZbAC+rgYzb/gZhJAmMAQNE/8xAb2zd/TLDVJMgOQ45QUAimQxxGUL7/gI47hrWURXTCWg3WqU0rzY2G5fAhaA1gxFmXSB43revlE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScJdQLzh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScJdQLzh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so113589a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787069168; x=1787673968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aavrVeK6vCQCADq15/6bmdV2okv94iEyViF9ADLcajE=;
        b=ScJdQLzhs2lDGViQLLrdSbEN27inoxQMLwUQIroV+NURUgUiu60KAektL0HUqKM6vg
         JugzYljG8Ip0XwXARfZUbG+EHsNQOuiaVtBMnF4t/rwMYfBPZZ0pXaa5Uo/szADDNFZ+
         FhPwriphPaIusW4CctrCwTk9o1GdZxjLAgep78rgzWe7RlmdkCajKEDRX+yPizHn0o4I
         nUSIzq9oOisPBehkFkXmN+WHMdCv2eU/YXLr6qSb/56TbnuzR7APZ688UT70jS6QOR5Y
         9Q/SRBHkZIb3s6pJK9v6vEdw8r0sjrbY13JvBFnjU+mCFmzhsrzZJmF9VWVOKA7ewzQ7
         g2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069168; x=1787673968;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aavrVeK6vCQCADq15/6bmdV2okv94iEyViF9ADLcajE=;
        b=XBTTXuyHuAGo6VTekoAliyT0Qv/My9bfR0PyVHLvdyc+QdwmzqJkfbeSjNFrU+IL5e
         uD0YVwid3iwoUgZ/G42DBDuGh1SuuFOTFI4DFqyu/nHYqFobOn8yoqrN35lP2C0due2a
         1DNo2Ika9TbPcy0Kx41nYfKFLwTeFhWsb8H5WZnSBbVtuhWmtABW4m9aHgsWV8XQAqTX
         YsvVmZcdgu/dAmhldn+7+1BG4flA5aB4HRR0l7KEBZ9sMzgDJQ6h8HW7GGkNm4HgCEJd
         bFRolXM2NK+6Ox/d+F04F/DNV1NjnQaaWlDa6BYcijXdtbHZu3jPvdKjA7R//yoz44zl
         NQ8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqwQONFpB2WVBV0fKuiavslYXpaCVkECAgmy1jC+crBHRjsu5F/M+wE6DOstwISdyTKjBtFkm1YtDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCXrpWK8C8Y4z/ifJ0gEus40lGWXHUUW45BGg1aiTsa7rYTjgG
	BkS7Qpjr7o+Y7+DrdxrDtXuHm8GVXph+akVtH6WTSFe34Ire15JSsjM6Or41RCqf
X-Gm-Gg: AR+sD10dJuxKmR8x2moS9vHhaftpGnrhjJ2NHpLrjmWrUvj7n918CDQTNRQN1BiZVXL
	NHSQgB0DhjUERltgwyPOe3akEevdGIwM2SOKHwRPs3ljX4abuDUSrwvEekcCs3k2XX/0k8BUy0N
	7uinWixOzQX5Ay/0xj9W/lugI+DLbT8EDsHEFchYUNTDNkL+wSjv3AjBQkSVG7ClRiCUmaSnUPC
	zZnDrc6PBAGZgBZ2/z+OYn7+gjQ36x3peDpn0w6go5SslrEgCvn4ibftoJNMJUZbIrw0luHtyKF
	01pFEcjs0YN7H6ElGx+Hehcn0AqReT1tJWqVUaBKI3RLTDR9QUSnHPfodk5LiEHNa/KbPWRfza1
	8NVBkJuxodIhoaIfYBzZBRw/2tYMdtDbvvmJIQiB2xIBzWET2V8dwOTRYbE/8mvGTreYpGTbXk5
	tbo2Bg44hjAJKxsVOPaQbblXYvFLc3/CwTI16mpHUtdu0pM/4xfF952AofvMYekps=
X-Received: by 2002:a17:90b:2891:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-3933b916f3fmr36753097a91.10.1787069167382;
        Tue, 18 Aug 2026 09:06:07 -0700 (PDT)
Received: from localhost ([118.34.230.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bd51sm6533222a91.12.2026.08.18.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 09:06:06 -0700 (PDT)
Date: Tue, 18 Aug 2026 21:36:05 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	alison.schofield@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/test: Map mock device nodes to an online node
Message-ID: <aoSC7U7QSuCFzzGH@acer-nitro-anv15-41>
References: <20260723180630.1302871-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723180630.1302871-1-dave@stgolabs.net>

On Thu, Jul 23, 2026 at 11:06:30AM -0700, Davidlohr Bueso wrote:
> cxl_mem_init() assigns alternating NUMA nodes to the mock memdevs
> to model multi-node topologies. On a single-node host node 1 has
> no pgdat, and the first node-aware allocation in an odd device's
> probe faults on a NULL zonelist:
> 
>   Oops: general protection fault, probably for non-canonical address 0xdffffc00000006e3
>   KASAN: probably user-memory-access in range [0x0000000000003718-0x000000000000371f]
>   Workqueue: async async_run_entry_fn
>   RIP: __alloc_frozen_pages_noprof+0x288
>    new_slab
>    ___slab_alloc
>    __kmalloc_node_track_caller_noprof
>    devm_kmalloc
>    cxl_mock_mem_probe
> 
> Map the requested node to an online one, as dax_hmem already does
> for its target node.
> 
> Fixes: cf1f6877b088 ("cxl/memdev: Add numa_node attribute")
> Fixes: e41c8452b9b2 ("tools/testing/cxl: Add a single-port host-bridge regression config")
> Fixes: c9435dbee119 ("tools/testing/cxl: Add an RCH topology")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> Found while regression testing unrelated work.
> 
>  tools/testing/cxl/test/cxl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef92dd35e030..5156516a82d2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1748,7 +1748,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_mem;
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
>  		if (rc)
> @@ -1763,7 +1763,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_single;
>  		pdev->dev.parent = &dport->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
>  		if (rc)
> @@ -1779,7 +1779,7 @@ static int cxl_mem_init(void)
>  		if (!pdev)
>  			goto err_rcd;
>  		pdev->dev.parent = &rch->dev;
> -		set_dev_node(&pdev->dev, i % 2);
> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>  
>  		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
>  		if (rc)
> -- 
> 2.39.5
>

Hi Davidlohr,

I was hitting the same repeated crash while running `modprobe cxl_test` on a single-node virtme-ng guest.

For reference, the guest had only NUMA node 0 available and online:

# cat /sys/devices/system/node/possible 0  # cat /sys/devices/system/node/online 0

The crash followed the same path:

__alloc_frozen_pages_noprof  new_slab  ___slab_alloc  __kmalloc_node_track_caller_noprof  devm_kmalloc  cxl_mock_mem_probe

I found this patch while looking through the linux-cxl archives and applied the same `numa_map_to_online_node()` fix to my current cxl/next tree.

The code has changed since this patch was posted. The original patch updates three sites in `cxl_mem_init()`, while current cxl/next has those corresponding sites under `cxl_type3_mem_init()`, along with a separate `cxl_type2_mem_init()` path.

After applying the equivalent changes to the three `set_dev_node()` calls in `cxl_type3_mem_init()`, the repeated crash is resolved and `modprobe cxl_test` succeeds.

I also noticed that `cxl_type2_mem_init()` now has:


set_dev_node(&pdev->dev, i % 2);


`NR_CXL_TYPE2_ACCEL` is currently 1, so this does not trigger the offline-node case today, but perhaps it would be worth using `numa_map_to_online_node()` there as well for consistency and future expansion.

Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

Thanks,
Shaikh
