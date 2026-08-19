Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807281E515
	for <linux-cxl@vger.kernel.org>; Wed, 19 Aug 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156404; cv=none; b=l4Md0yaHbKLCi6tzmjHWECfwJYbsRnQbTI1yPRyMGtVmFc6wG5+ChVb2Qu2wgtbEqtcb/D05qlkTO5ZWsYL6RvVw+H1IBbp0yW68e+xyHKJITJX9IQ42Cu1+yA0nMAxTFDNCcXO3+fQQATrY8bu4TtaSmobNDyqamtvQyBM6jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156404; c=relaxed/simple;
	bh=h94N4q9VtulqWrhgCdg10iRfNpjLyWh5UYlR0s7Hi2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA+6506upTjFbMgtFzOQTSkF1V8Oh8zuGRRTJ3RBpFZOUOQ8AeAjTGxpXxfIadUd7wq0ng+WPxi+spfeQ5+m1xbkDChQzP/wrZX1A72vfwlfZkAZ9Lf23xuVrK1tzpXN81jjPD2DOXumWbktbCEt7BA1coc7BUNtB9kvQwXjFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UIsC8loj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UIsC8loj"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9061a795d76so14678706d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 19 Aug 2026 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787156401; x=1787761201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vOyNwvDSRUS1Upjsu+pzlbi9K5KMMrGH5Oy3vY4FCNI=;
        b=UIsC8lojijGSktKFVmgB3hTy88h1B4WSnPIOrXzu77q8N7pB+aPPTYbtoRbPcrrN3E
         9jMaff3EcUByGI+5/C8i9kns3bmsHMRcF89qo6xAkqLWcUlj2YfKdBlJiZ+bwqXSxo9e
         1mj+/rbNwefLJrQ/Wq3lIKGiC1O2muydjarACf9f0c2LliPaT5N4ISxTZ5BgJCz12BXy
         OuXUwVwivNYnZ+uIOu/kDMLM8zERcxf+cWnBgUQq93c47HPDVnRECbeSbGqyOqtsJQq5
         ukvhsALwMB7abpNXpgynw25mUdQeF1XxY080ucfRR6w5yZ4AMmuuKCRTAPAkPhF0wlQk
         4QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787156401; x=1787761201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vOyNwvDSRUS1Upjsu+pzlbi9K5KMMrGH5Oy3vY4FCNI=;
        b=VSLu+sewdM4Vpdt0eXutJ93JgQPlHLCNkDYhWMSHzW5V0Gquq+wjCU0bexjo23JL+t
         n0YEbFIxaJPUEz/AlFvApf+dnWk27Kzz1VhP8LZq2FH9AKLiq9qngeJ12pYp6okAef3D
         zYCdKtAFwV/LRUVZUnkB+yJMpw+sW5NJ4MUzdfszcrxzIoKGX4T1LeG2X0EoYfUFNsri
         HrKTUcVSMnKlz5xQNSk1dAMgkUrbkXTfFpMJntf/bDt3iV6peqp7ujrys2CrVlGdkbVv
         VWo9un+ChCjPFisLUW9ge3vS8/q36cc3HV/lnGgBJOoFoTC/ZDKoSaVb40lGuDVRRHsb
         J6nQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrj4rDXNzBremBi+vevWfsC8DPEgd00ngvTL9WVBBTlHNd/hdEaskuolhIQLo+JBoxG1jsFYJVNT/g=@vger.kernel.org
X-Gm-Message-State: AFuF++nyKTopch9lM/0wbiscCsZSp7/CJBH6ACqBE/AecP1xULvzXgEV
	XS6ZPYCkr7Q1kebfDsU4NbUQ7nN25XB4A1j8WP+aZZrawVPYq/JgiKqOFYc0o8xPFhc=
X-Gm-Gg: AR+sD12SplQW84/vc2W4lLudXVr6pUSU0ERQEBTqb4yuETEZacJzbnjvGdJSZOC/ceG
	PtfV3oEH+ALNOr/8m+2mMNFm7buy+6oOb8TDJbC3xczJMXFF+ePoK9jgS6mXUjiA8hXjgFW7Vqz
	r9XDBcD7R0fxprCOmTKp110LBc40pL097y/OwaFALGNCsYKKzYMp9+XwUip1uBW5knqNL4sS3nZ
	S8hapH4pdoyJGAGLr1dhOqL51+6ljOdjErjU8QFcdF3YtIY0e5IfBdzrSTsLHPlnujLjcl+U97y
	MsJZYFAuf+trTz8hm4jEoUusixUfjn0D4Ax0f/SaHggLj+eIvFDgiPi8P6D8WghhFF6mKRQdfIe
	vTfG5R7gkrBAmLwteVDbdFbruYNDzt/srK8zdR9L2f5C9nOxzJPQoY1FfZm8/SLT1SwPlqu+rH7
	9QXqS7jgv27C83G97iEj1bz8SupcXT4MLcMDKWWOP9lpqBstpFNoXEi4+DoTR1ys9iPHCFas9+l
	KNejqkoIkbwLF5AbeG2ctLFBzTnrgYtK7d8ZeJmSbp0D6wUSkA4DVU=
X-Received: by 2002:a05:6214:488:b0:907:94e6:f8bc with SMTP id 6a1803df08f44-90c5eaf7548mr55369666d6.15.1787156401240;
        Wed, 19 Aug 2026 09:20:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eee196esm17981886d6.19.2026.08.19.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:20:00 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:19:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org, 
	alison.schofield@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/test: Map mock device nodes to an online node
Message-ID: <aoXXgaUoIOQDDqjd@gourry-fedora-PF4VCD3F>
References: <20260723180630.1302871-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I think should only have a single fixes tag? Otherwise seems it seems
unclear where/how to backport?

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

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
> 
