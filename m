Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62FA435AA7
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377309; cv=none; b=tATh/DV3c2XVn64jDGZ9E1iBlK6/p78M2/tV9a4Rp4CiYS98lDe/q8I1BfK/3RVrKYBJRE3KZBlL1iThNRvWnSRF1vhXVJM9CFTTFlLjZ9r/0zJqVQb/PQ67OoJbEr0aFZOv26A/cTyij/YDHgSgbPV4fnX/5iuJAMjQf/8w2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377309; c=relaxed/simple;
	bh=sw8OuJY5Abt+/8UePJzbFoUyvQUJsgSIz+vKVWg0jr0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ri8OndHuwZFKg2H53nytFMjIY4md/4ANRzHGwcn+vZvzJ6iApDLmOiGvpHloVMxUn8ODRYFhENOZ1wsHzYsUBtZqWV+BtWk/wGj4EPMqPFYDCz4Yqt1tYllvgJO9uBJlF19iDW83X8VW8tMFvRclkp9wjT9sB0hRdMX+57MKEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJoOfzub; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJoOfzub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783377308; x=1814913308;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=sw8OuJY5Abt+/8UePJzbFoUyvQUJsgSIz+vKVWg0jr0=;
  b=SJoOfzub3JxkFCsydK9VFQE3U7lImy9rnOEG357ZPH8cbQJRbJmoFQVy
   +CIz2XH9bQFRc3TVSTA/zJhuGF/TVHqgyEcR2m5z/8GqUjh4k1Gb37e6Z
   bdB61psWoSxJNBDW6Wyp9IqMtHIPRrEJj+hw8DRMTlny7l/VwZHS1KN9D
   /1Ad/grytZHfIVMu43v2FB6Ii3B7/6KoBN6G+9UlOlcvO+uOl6jcmpISe
   18TK/aNgKsKWWd52b1X4wDCHoHyyRCFvc/eI/pG6yWmTYcMmBVWpUOTGq
   RIyhNUNnF3jTvDSiyejJOEA6hZvA+AA2kYAa4Gmy4omnlpZg9dM6JoKTW
   w==;
X-CSE-ConnectionGUID: gphtkbgPQWGrh9vF7LuA7A==
X-CSE-MsgGUID: SE3wsZr+S/Wca96455Jmng==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="101441310"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="101441310"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:35:07 -0700
X-CSE-ConnectionGUID: XYHSIGJoQgS6hLe+20TzMw==
X-CSE-MsgGUID: JB5wILsMSFO2T64bCw3CsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257702459"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 15:35:07 -0700
Message-ID: <5071fab6-1b8e-4ded-abc7-872bb806b001@intel.com>
Date: Mon, 6 Jul 2026 15:35:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Honor -EPROBE_DEFER from component register
 setup
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, sashiko-bot@kernel.org
References: <20260706223059.693499-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260706223059.693499-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please ignore. Sent wrong version. 

On 7/6/26 3:30 PM, Dave Jiang wrote:
> cxl_pci_setup_regs() for CXL_REGLOC_RBI_COMPONENT can return
> -EPROBE_DEFER on a Restricted CXL Host (RCD) when the upstream port
> has not yet been enumerated and the Component Registers must be
> extracted from the RCRB. cxl_pci_probe() treats every non-zero return
> from that call as the benign "component registers not found" case,
> logs a warning, and continues. The rc is then immediately overwritten
> by the subsequent cxl_pci_type3_init_mailbox() call, so the deferral
> is silently swallowed.
> 
> Return -EPROBE_DEFER instead of continuing so the probe is retried
> once the upstream port is available.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-cxl/ajzhsubot_PSYtHQ@MWDK4CY14F/T/#m063bbf76b1c9c293ade52ab311018ae6bba11a44
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c..c85aa790ff6e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -826,9 +826,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	/*
>  	 * If the component registers can't be found, the cxl_pci driver may
>  	 * still be useful for management functions so don't return an error.
> +	 * A deferral request must still be honored, otherwise the component
> +	 * and RAS registers are never mapped for the life of the binding.
>  	 */
>  	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
>  				&cxlds->reg_map);
> +	if (rc == -EPROBE_DEFER)
> +		return rc;
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  	else if (!cxlds->reg_map.component_map.ras.valid)
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda

