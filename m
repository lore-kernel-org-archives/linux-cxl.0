Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37E6365A1C;
	Tue,  6 Jan 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767722056; cv=none; b=habqkPPq8MYfzB/GluWKA/3lx/MijM/QVtRwlDkMatKhojMuWkt6MDTfLAIJvD6jJQNtn4RLaB0wypR95fbEc0FBiYQIOpHWq1GTslZUD/Vhl/LSuPQGMXSVpjJrnz9mKlAT75F6XuYy9o6jSr2UyD7/AIhNWuOHfKcahySz0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767722056; c=relaxed/simple;
	bh=hMbWpDwFSphPeIsWsASVMOZNr+PtHza/3gaRPtfLtNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWtpL/9fMeXLtySg3VakAK+aruqwuqk/NtQc1A6sNgavbLOegEdCRx2zWnbrx3DiSZSQF566UdQkF/gXXGn509GMmfd68xqlCXAC0bqJTuualn97Fa1bZidgx3S3BMREgWZAwZxQ40mQiNSUD7UKYCtP0GN6myqxAaJgFf2pij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKOGwqBE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKOGwqBE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767722054; x=1799258054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hMbWpDwFSphPeIsWsASVMOZNr+PtHza/3gaRPtfLtNk=;
  b=KKOGwqBEvj+8rhyOcWO/s3icR+8/dALULRBxIXQMpCMEtWFSgcxxMf+P
   A0RLqklK5Qs+ObWWEy7FXM9XYkwysbaQWs5w4nR+2u5Cc6NlNKN4jojlL
   L9697QGz7H7Us7TPjWfHoQuIxTNJwsfgtwrJTfdsEAbwJTy3lENBl7hoC
   Y5db4eXxR5OYczPpcgBvOtab+zpAFG8cT+k6q4mRF8zPWjLIv8a5vK9Ue
   dMlQwthh8GMyJWJgQ3sEipTbdliTKjqV6PWDnMzg/aNEvfNAggDPeEMPQ
   wT0amMOL2oZtjiVWnBsKX0PZYEI8fEYacKDk+I10Cse1iMWqYYHChX9Qu
   Q==;
X-CSE-ConnectionGUID: U1ODlYgpTmiUJ63eSU59Tg==
X-CSE-MsgGUID: rf+iyPOBTkK+7wV+D+SPhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="68287994"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="68287994"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 09:54:13 -0800
X-CSE-ConnectionGUID: xBuy5fBvS5uXU4iVBiNAGA==
X-CSE-MsgGUID: T7PDgIYTQTSWy9R/9roH/Q==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 09:54:12 -0800
Message-ID: <57244070-3ed8-47e1-a1c5-2e0d420731f9@intel.com>
Date: Tue, 6 Jan 2026 10:54:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Documentation/driver-api/cxl: device hotplug
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, corbet@lwn.net, rakuram.e96@gmail.com,
 alucerop@amd.com
References: <20251219170538.1675743-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251219170538.1675743-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/25 10:05 AM, Gregory Price wrote:
> Add some documentation on Linux expectations of platform software
> configurations to support device hotplug.
> 
> Add some docs about general BIOS/EFI expectations regarding CXL devices
> in general as a predicate.
> 
> Gregory Price (2):
>   Documentation/driver-api/cxl: BIOS/EFI expectation update
>   Documentation/driver-api/cxl: device hotplug section
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../driver-api/cxl/platform/bios-and-efi.rst  |  23 ++++
>  .../cxl/platform/device-hotplug.rst           | 130 ++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
> 

Applied to cxl/next
63e5a6294dad80be9830c935e8952a1f62068c86
fa19611f96fd8573c826d61a1e9410938a581bf3
