Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9081DED42;
	Fri, 13 Mar 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421670; cv=none; b=rl3T2byU3HrCeqbQ/dCcQHwN0vsbAlBwBBUrLajA7CmVAwXEPOfoaURCWPbbY537X7D5x8E+Msqf5McwCXyOI/kSqoPj2wqunC8lSX+lvNmGzhkDY7riXiAR2ojg6krmd1FoGTZc2Ddt2IGGsikqC6YxBDywG9+OoyDJGV2Kwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421670; c=relaxed/simple;
	bh=R16viecbOLWWqtZhnjbq2YS3+FeK3hbfCWPlBnDO44Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6gga8c1IXX3OSRS7YZJ9Lh1wx/1nlbgJYWpejfVtvDJCSGFR+vElqLfIbzomqM0MEIOgl04z7nHnvuJUMGvpg056PKTXv/+GF+ardcMW8Hoxg7BuzgujEkt0JhV7S+f6AlpQppnxfEDpl0K7YUDnKmnpl0Huy1Ihyl6HWhsupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyKYcYBM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyKYcYBM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773421669; x=1804957669;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R16viecbOLWWqtZhnjbq2YS3+FeK3hbfCWPlBnDO44Y=;
  b=NyKYcYBMu+gE03qpOxE0FckisJUKYIOmE+6LRSCWjyvO1TnyUtQyBEF7
   zTp0vwusIAobfLiLntZGWgR3DG2G08I48sUe6qvgvlyN303TDSnfIPZAf
   mKYnqvJta1fZ5ePaAgwfFB0BydY8y+WwHo71sYVQXvgRZdFeuRextN51z
   qb+xcTWHpEHAuqJWP77o2fLma3G8K2B6Gsc/2hRugVoMY7nkglAo/FLBV
   RPUJrGscadndLafaaPa5hGZFpO0s2jKlkk2dEVfHnJIR94ggwbZ92n49X
   jld3GpNiHHwSM4PY8MDVFVOwwGSJtW47f+xWNh9hNlbuc7WBJVo/JlI48
   w==;
X-CSE-ConnectionGUID: EbXGhWrNTWqG5fWnJFhT1w==
X-CSE-MsgGUID: ONTnGd3IRaaGjZnabqO/ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="78383254"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="78383254"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:07:47 -0700
X-CSE-ConnectionGUID: W4ixfcyxS1i0bZ8AUcZy6g==
X-CSE-MsgGUID: SJR8QGKXQi2dVLanqQcRaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="216108933"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.233]) ([10.125.110.233])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 10:07:44 -0700
Message-ID: <4168a704-e9ec-405a-8e66-80c7e854d7c1@intel.com>
Date: Fri, 13 Mar 2026 10:07:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] vfio/cxl: Expose DPA memory region to userspace
 with fault+zap mmap
To: mhonap@nvidia.com, aniketa@nvidia.com, ankita@nvidia.com,
 alwilliamson@nvidia.com, vsethi@nvidia.com, jgg@nvidia.com,
 mochs@nvidia.com, skolothumtho@nvidia.com, alejandro.lucero-palau@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 jgg@ziepe.ca, yishaih@nvidia.com, kevin.tian@intel.com
Cc: cjia@nvidia.com, targupta@nvidia.com, zhiw@nvidia.com, kjaju@nvidia.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kvm@vger.kernel.org
References: <20260311203440.752648-1-mhonap@nvidia.com>
 <20260311203440.752648-12-mhonap@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260311203440.752648-12-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com> 
< --snip-- >

> +int vfio_cxl_register_cxl_region(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_cxl_state *cxl = vdev->cxl;
> +	u32 flags;
> +	int ret;
> +
> +	if (!cxl)
> +		return -ENODEV;
> +
> +	if (!cxl->region || cxl->region_vaddr)
> +		return -ENODEV;
> +
> +	cxl->region_vaddr = ioremap_cache(cxl->region_hpa, cxl->region_size);

Should this be using memremap_pages() family of call rather than ioremap() like how DAX does it? CXL mem regions are not MMIO regions.

DJ

