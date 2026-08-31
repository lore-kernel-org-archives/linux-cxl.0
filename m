Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAD427F8D
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191394; cv=none; b=jaduwDQxoo3wCtSfVwcASf09C/tGM6sgbm9AOUdyFzW7q4d3lKV3BLpTiWO4G+N9Ka38BxDQ/BBIEic8KaUo180vX4giKf78XP+hBgqvP9tQZXCa98YcXJEU1XNEWxMGVQ6o1RkA9jb7sle+VcS88xSKIb++X3YJsGzXn8TxloE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191394; c=relaxed/simple;
	bh=EKK3IiqKXly4ho9V8DJmFZT8vdGU3+bAYq4WI118PZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEMSt0+k+7pQRxP/4NEyfaaguKdOsLtzYEVSYAlcK7bIjU0R8Qb4XED40r/zniPqTRWy6qPsG4oGExPCNIdUc9S6A103uB4mq9NHQwa4/IaXCRn+Dsifu3ej7K3Kc8qvvHII3J9Z8qLcz9rfF2BqXV3fBELFXpv5MtpGEU/HWZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDK4IOuN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDK4IOuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788191392; x=1819727392;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EKK3IiqKXly4ho9V8DJmFZT8vdGU3+bAYq4WI118PZM=;
  b=HDK4IOuNHivUP0IGFa/k13Mk3pboWM527reSsosrUIs5SKeN6IlO4MRf
   lWiFVtPNfjGGKQAHT0cm2bunYWbwEu6GBrkcFncXDRZCJ41pQ7GTtM08Y
   cmba3VUmGwVKZdhizi29t0GEu98GMQrzaBTvm8RRLIEQVRUI0BkOv0q0M
   E/UUyiO/5IW46Bih7obFfFIv2s3g5p0TEFt2P2eWtk5iI+Jp3DD0TV/12
   eQKjXfv16a8Acnhw2+8pr8FSBEWAA1Of/xRRxQhXH25OYgmwgNDtFrEiS
   m2/Xr82RSN7E6dwvcAV+A0UCeEeQrnw+68jQg7nYLVyEHWqLFcE0cQgT7
   w==;
X-CSE-ConnectionGUID: DzCzcPhXTaiTwKX00VSX5w==
X-CSE-MsgGUID: tQ0yu/IIRUG4V4J+oGGguA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92289069"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="92289069"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 08:49:51 -0700
X-CSE-ConnectionGUID: a9cb5jH/RJKnbWrjOqYI2Q==
X-CSE-MsgGUID: 5ibc3qilTNSp9LMfP0Qunw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="268272535"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.14]) ([10.125.110.14])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 08:49:50 -0700
Message-ID: <ec5caa6b-02e4-4e01-9ac0-48e62272fc70@intel.com>
Date: Mon, 31 Aug 2026 08:49:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/region: Unregister the pmem region when the bridge
 is unbound
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260831061120.200790-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260831061120.200790-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/30/26 11:11 PM, Guixin Liu wrote:
> Removing cxl_acpi unbinds the nvdimm bridge before the regions it
> serves. A region probe can therefore register its cxl_pmem_region and
> only then find the bridge unbound, which leaves the new device with
> nothing to remove it.
> 
> The orphan outlives the teardown and pins its region and its memdevs, so
> a later cxl_acpi bind renumbers the root port, ports, endpoints,
> decoders and the memdev.
> 
> Unregister the cxl_pmem_region when the bridge is unbound.
> 
> Found by code inspection. Racing a cxl_region bind against a cxl_acpi
> unbind leaked a pmem_region device on 12 of 12 attempts, and none with
> this patch.
> 
> Fixes: f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Found by inspecting the CXL error paths, then confirmed on a QEMU CXL
> topology (4 memdevs behind a CXL switch, one of them with 2G of
> persistent capacity).
> 
> Test procedure, with a dev_err() temporarily added on the unbound-bridge
> branch so that taking it could be observed:
> 
>   cxl create-region -d decoderX.Y -m memN -t pmem -s 2G -w 1 -g 256
>   echo regionN > /sys/bus/cxl/drivers/cxl_region/unbind
>   echo regionN > /sys/bus/cxl/drivers/cxl_region/bind &
>   echo ACPI0017:00 > /sys/bus/platform/drivers/cxl_acpi/unbind &
>   wait
> 
> Without the patch all 12 attempts took the unbound-bridge branch. The
> region bind failed with -ENXIO and pmem_regionN stayed registered on the
> cxl bus after the teardown had removed everything else, including the
> bridge and the region it hangs off, leaving its /sys/bus/cxl/devices/
> link dangling into the deleted path. Because the orphan keeps references
> on its region and on the mapped memdev, the ancestor chain up to the CXL
> root port stayed pinned, so rebinding cxl_acpi renumbered the topology:
> root0 became root1, port1 became port2 and mem3 became mem4.
> 
> With the patch the same 12 attempts still reach that branch and the bind
> still fails with -ENXIO, but nothing is left registered and the numbering
> is stable across repeated bind and unbind cycles.
> 
> No artificial delay was needed to land in the window. The teardown
> releases the bridge first, so it gets there while the probe is still
> inside device_add().
> 
> v2 -> v3:
> - Reframe the changelog around cxl_acpi teardown, which is the reachable
>   path, rather than cxl_pmem being unloaded or unbound. The bridge driver
>   sets suppress_bind_attrs and cxl_acpi now depends on cxl_pmem, so that
>   framing could not happen (Alison Schofield)
> - Drop the -EEXIST claim. The leaked device pins the region id, so the id
>   is never reused and no duplicate name occurs; the observable
>   consequence is the leak and the renumbering after a rebind
> - Cut the implementation narration and state what was tested
>   (Alison Schofield)
> - The code is unchanged from v2, so Richard Cheng's and Li Ming's
>   Reviewed-by tags are carried over. Note that the changelog has been
>   rewritten since they gave them, in particular the -EEXIST claim above
> 
> v1 -> v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> v1 was patch 8/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are
> resent individually instead. Patches 1, 2 and 7 of the series are
> dropped, as those issues are already fixed in cxl/next.
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> v2: https://lore.kernel.org/linux-cxl/20260812061043.57319-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/region_pmem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region_pmem.c b/drivers/cxl/core/region_pmem.c
> index 23d97e3d78b6..7ab1373a95e0 100644
> --- a/drivers/cxl/core/region_pmem.c
> +++ b/drivers/cxl/core/region_pmem.c
> @@ -168,12 +168,14 @@ int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  		dev_name(dev));
>  
>  	scoped_guard(device, &cxl_nvb->dev) {
> -		if (cxl_nvb->dev.driver)
> +		if (cxl_nvb->dev.driver) {
>  			rc = devm_add_action_or_reset(&cxl_nvb->dev,
>  						      cxlr_pmem_unregister,
>  						      cxlr_pmem);
> -		else
> +		} else {
>  			rc = -ENXIO;
> +			cxlr_pmem_unregister(cxlr_pmem);
> +		}
>  	}
>  
>  	if (rc)
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

