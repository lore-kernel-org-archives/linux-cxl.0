Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927552D877D;
	Mon,  5 Jan 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646808; cv=none; b=hPPVZ48Dkf6j+ZWcGywoDunmyx0LBx8SxNQ3Xma7Z4WApAxO9v2KQsqzBmCwb0A5ZxNqN0I/tKT1F1I79+5TCuT+aiwfkCoBvv3pb23rtQoU5CU5N25PArdgiWd2dAHWEqRIrOmvBayFKoe7eNhmnoo39xe5drcyIrUwfim9ia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646808; c=relaxed/simple;
	bh=Y443WbclwrlrELdBE22N+YAFyN+YHlyNFya9QGrTubY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmYHjxsOX9L4xLMGgVRbMKF0mIaI3AuD+MfOC/HtoVTuGFyFrx3OiDNQthwqA3oadhy6m6Ko0iyTV6qtCLu/KwZ/XtmcVT3vuYoTV4K1npgzbqh9JggyxTG3ojwyuNGtf7lsBWn8bA9lpvjcClwm1lel+gJ5EMISKvL6vlFTJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lNzqekj1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lNzqekj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767646806; x=1799182806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y443WbclwrlrELdBE22N+YAFyN+YHlyNFya9QGrTubY=;
  b=lNzqekj1kYh3b0JVNEnTd4GXEsJtmhDULvKTIqucrHv6x1+WqThAPGxt
   F2CsUIKnDSS7b7NMqa12LgLko4zgHrMYzp62K7AjgZBPxr/4LMyPaBQrK
   e5+X62hqIrMRdoklztkvGbRD4/IpCPElXCZiqXaA+GYcC1Q5//zfOt+9t
   XCUr+lBuLrEyDZpwCUliOGR59hiWV9dKcnRuDR/DfuEqLAL3YNOXrfZ1f
   iG0uD4/jNIqbfL65GmA3p/svLarsuIektVf7kACAvR12LWbKU3ccRoH8p
   v+gmSc/P2VHoQ0n4+XYVDiHt+Jh1u5D/XVb8jC38AL54AAX5pv0GoFMEH
   Q==;
X-CSE-ConnectionGUID: yetsdBeAQqKxrTbY54EXIQ==
X-CSE-MsgGUID: tR7NtcMpTUWfLwiAKa7c4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79321889"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="79321889"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 13:00:06 -0800
X-CSE-ConnectionGUID: ets8Jf6JTOqSDkzcEpWb1Q==
X-CSE-MsgGUID: pA4sYZEAQS+wnfjWtHiJIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="206954536"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.109.45]) ([10.125.109.45])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 13:00:03 -0800
Message-ID: <2fb3f73d-a808-4a6a-a90e-b83a32a4da57@intel.com>
Date: Mon, 5 Jan 2026 14:00:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Documentation/driver-api/cxl: BIOS/EFI expectation
 update
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net, rakuram.e96@gmail.com,
 alucerop@amd.com
References: <20251219170538.1675743-1-gourry@gourry.net>
 <20251219170538.1675743-2-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251219170538.1675743-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/25 10:05 AM, Gregory Price wrote:
> Add a snippet about what Linux expects BIOS/EFI to do (and not
> to do) to the BIOS/EFI section.
> 
> Suggested-by: Alejandro Lucero Palau <alucerop@amd.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  .../driver-api/cxl/platform/bios-and-efi.rst  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> index a9aa0ccd92af..9034c206cf8e 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -29,6 +29,26 @@ at :doc:`ACPI Tables <acpi>`.
>     on physical memory region size and alignment, memory holes, HDM interleave,
>     and what linux expects of HDM decoders trying to work with these features.
>  
> +
> +Linux Expectations of BIOS/EFI Software
> +=======================================
> +Linux expects BIOS/EFI software to construct sufficient ACPI tables (such as
> +CEDT, SRAT, HMAT, etc) and platform-specific configurations (such as HPA spaces
> +and host-bridge interleave configurations) to allow the Linux driver to
> +subsequently configure the devices in the CXL fabric at runtime.
> +
> +Programming of HDM decoders and switch ports is not required, and may be
> +deferred to the CXL driver based on admin policy (e.g. udev rules).
> +
> +Some platforms may require pre-programming HDM decoders and locking them
> +due to quirks (see: Zen5 address translation), but this is not the normal,
> +"expected" configuration path.  This should be avoided if possible.
> +
> +Some platforms may wish to pre-configure these resources to bring memory
> +up without requiring CXL driver support.  These platform vendors should
> +test their configurations with the existing CXL driver and provide driver
> +support for their auto-configurations if features like RAS are required.
> +
>  UEFI Settings
>  =============
>  If your platform supports it, the :code:`uefisettings` command can be used to

