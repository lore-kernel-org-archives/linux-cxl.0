Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316566;
	b=nSYOdA0q0iJCSi49yhJ6gHS8DIUVWLc6heOhMfZ0uwiXHuW2LQbU0EZwiBCqIkXhhW6R
	 5o9EzlOyoXsaeVDnVA8eSxec9/puXQnLaluRrf7HvdNpq5B4aXr4bco6InoQDBo9KoD+Q
	 xHV0G4nmfeAOUbSHv3/FByM+ceseu30rRoLk3tcW8pr9Ej2s9ttjyubmMxBqsNQnKtT+D
	 KMBeyZWfKWB0DqSdNkB6pnNk9QFOyqUu0yoExTRXEbJwreoOkLp2KenEG2a6BfQAw5PJK
	 PAYwzzy202NikZ7yAkM2XsgASOaO+I5lHyVIdgELZ5qeQCRw/ARH0/IjSHC57C6kRKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316566;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HMWFmoA+eqXwcHYBGY3S6+xFSrfo+eJ5GzWH5gZmVXA=;
	b=2Kcuk8tlOErCE3HibP5Dx1j997OFymfuKho4kQgMAQ9/8lmvgwAorksMobUvq6HsVG2a
	 GxMZPKiqgejlYfURL5EN4xoeIyKMroyIADh32KcHR7nw4x3v6PWZQJEIZrU0t+2J3Xdyd
	 qqTd3uUpDfmKF3uAvKUEcjw+CnDTMcZ5cMZF2f8K3C6TZtRLiQ6F0AnmMss5DyTb9ynnl
	 HPbHkI29zAd9dq9zOsDMyWUDX66ihxopDeIE6Q6HzMLh06tmOWcPBj2u72p+dbiRq/8hQ
	 gLVjRNrZYChJkCYiZY6F6vmsKArLfWz8KS/DF/kSV8DQK0CBOOQmAMfPEPfWCgYlsZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SoZJ1bJG;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C099B60A2610
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 23:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C099B60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SoZJ1bJG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793316566; x=1824852566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wYeBilJiqtkeQGro1DsC1N3rsyq0IOTMGTeNr966ezY=;
  b=SoZJ1bJGKw0m7WuObAoML8kOa5ZJMseT4RlRXyytzIvSL+MDuO/IvrjU
   w6cv9M22os9uM7x1SQvzN/x57I7dB5bIFuVGhyfsxS+l0yxOeVq6rR3ZS
   t6VZhNVC+0SMemRLQaYzJY7bKOTb8H6htvgZv2yUS+TjLB8VWXM1Y855A
   ur3pjTsmlbeCPjBxQTKhDQoFIyI3lLMc+Dl51M/DxnC26xgFLlM4Xd49s
   DRYKKgSVDd03g4NJzVVkCFhorx0rJUUl9BZJbZzAPPsB+YrDVmBh2beus
   j7Npklc8UGtgkq+tMd7JvfzGU5rB2y1qBs7yYntTqdR+IJJ3nK4sqekr8
   g==;
X-CSE-ConnectionGUID: ZdvkSZ9XQtyZS+aZF44Iow==
X-CSE-MsgGUID: cgZFj8XCQ5KZCmcBbPyi+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2066188"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2066188"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:29:25 -0700
X-CSE-ConnectionGUID: MzLcu/STTV6GE8ho+gGp9Q==
X-CSE-MsgGUID: wd9qAxS1SeKAeDnBoXtsiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5195387"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.28]) ([10.125.109.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 16:29:25 -0700
Message-ID: <01dd1f94-d613-4508-a496-1f14295c7e40@intel.com>
Date: Thu, 29 Oct 2026 16:29:23 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH 2/4] libdaxctl: tie mapping cache lifetime to the
 device
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev,
 Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
References: <cover.1792695259.git.alison.schofield@intel.com>
 <6b3b42e253c4aca3f4c080d0a7698a09ef24465e.1792695259.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <6b3b42e253c4aca3f4c080d0a7698a09ef24465e.1792695259.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/22/26 12:56 PM, Alison Schofield wrote:
> Cached mappings are not freed when a device is destroyed or invalidated
> when its ranges change. This leaks memory and can leave callers using
> obsolete physical address ranges, potentially operating on memory blocks
> that no longer belong to the device.
> 
> Free mappings on device destruction and invalidate the cache when device
> ranges may have changed.
> 
> Fixes: 5a31bf710399 ("libdaxctl: add mapping iterator APIs")
> Fixes: 52a2653098a5 ("libdaxctl: add daxctl_dev_set_mapping()")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  daxctl/lib/libdaxctl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index f630f4791f59..f7cbf3fa12e7 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -241,6 +241,7 @@ static void free_dev(struct daxctl_dev *dev, struct list_head *head)
>  	free(dev->dev_buf);
>  	free(dev->dev_path);
>  	free_mem(dev);
> +	free_mappings(dev);
>  	free(dev);
>  }
>  
> @@ -593,14 +594,15 @@ static void *add_dax_dev(void *parent, int id, const char *daxdev_base)
>  	else
>  		dev->target_node = -1;
>  
> +	dev->num_mappings = -1;
> +	list_head_init(&dev->mappings);
> +
>  	daxctl_dev_foreach(region, dev_dup)
>  		if (dev_dup->id == dev->id) {
>  			free_dev(dev, NULL);
>  			free(path);
>  			return dev_dup;
>  		}
> -	dev->num_mappings = -1;
> -	list_head_init(&dev->mappings);
>  	list_add(&region->devices, &dev->list);
>  	free(path);
>  	return dev;
> @@ -1186,6 +1188,7 @@ DAXCTL_EXPORT int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long
>  	}
>  
>  	sprintf(buf, "%#llx\n", size);
> +	free_mappings(dev);
>  	if (sysfs_write_attr(ctx, path, buf) < 0) {
>  		err(ctx, "%s: failed to set size\n",
>  				daxctl_dev_get_devname(dev));
> @@ -1242,6 +1245,7 @@ DAXCTL_EXPORT int daxctl_dev_set_mapping(struct daxctl_dev *dev,
>  	}
>  
>  	sprintf(buf, "%#llx-%#llx\n", start, end);
> +	free_mappings(dev);
>  	if (sysfs_write_attr(ctx, path, buf) < 0) {
>  		err(ctx, "%s: failed to set mapping\n",
>  				daxctl_dev_get_devname(dev));

