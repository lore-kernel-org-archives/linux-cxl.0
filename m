Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7041B0412;
	Wed, 11 Jun 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656361; cv=none; b=fuGzCjITzkEevwDJ5Fj+BV+LHiJPJYp0vHxzusJVnna4WJNBHMCYu4FQtET8LPWDPFaRVCVaS8sQzq25L6/4J4wFXWRvlddMtiBjw7XfLi9mBnqjqRXoPevaLmuZt36Ce7ZlMyHVSpHdPm40oeJjDpHTBvBhHGVmk/NbXmSrvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656361; c=relaxed/simple;
	bh=XLk4LWwwo5lH3hddjSgOakROb8Q1UrrXjATsa1j/tAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET2q3kFESfJGIyuE7ZiHBkS0984zBf1RJsSgMR1sjrpNJLebCYA+puAGcn4SU2+vpW+70kbawFcpuKVuBAlHRYhlQ8ln/CL5oQd1TZ/Wv+SqgYUMhlXYjxC3hf0qb7Nb/nLu3T7mdXfGNQZQUSIGZacWfLWc1XyFmeax+whnKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npV1I8tm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npV1I8tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749656360; x=1781192360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XLk4LWwwo5lH3hddjSgOakROb8Q1UrrXjATsa1j/tAs=;
  b=npV1I8tmL42SgIvxv8IEjwxgyxv5prvHc0Kgy9g0gH4eIhA4/pkeMH8n
   2J0VCQrfpfOdCIdUkS39t5XU9svnvyua0rZUM2idhwEbWXga2ekSj2U8X
   PEnJNTKyOuW2+nH0MsLzoTRBQUrj25ymnCO3m41WxuA4WifMpfzKw6prC
   JE0PhM+fV5r1L4RerbgL10ZMo3hEpufimiP9taQi1NRcJXFliyqtIbe25
   PxAIbUzzuXuB98Q3pSg+l85g+3HSoIzk4bbR5GluClzFrNaDNVnwnxJui
   axMP0rh6xUVtjTR4POxBQTOHWrWGzgbp8RtuX6xKbD8bejTa42f1mkxYR
   g==;
X-CSE-ConnectionGUID: 5MXQ+HuJQne+krtIPo6Zeg==
X-CSE-MsgGUID: eBqajxzLQqSEALDJyzcjyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62417325"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="62417325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:39:19 -0700
X-CSE-ConnectionGUID: HY5jWm2rTKiyb2HVs93cpA==
X-CSE-MsgGUID: aEJ1Xm/jS/Kdqg94q13zHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="152505341"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.168]) ([10.125.111.168])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:39:18 -0700
Message-ID: <8c95a001-3593-452a-a4aa-714938b62f50@intel.com>
Date: Wed, 11 Jun 2025 08:39:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fix typo in CXL driver documentation
To: Nai-Chen Cheng <bleach1827@gmail.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20250610173152.33566-1-bleach1827@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250610173152.33566-1-bleach1827@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/25 10:31 AM, Nai-Chen Cheng wrote:
> Fix typo 'enumates' to 'enumerate' in CXL driver operation
> documentation to improve readability.
> 
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>

Applied to cxl/next

> ---
>  Documentation/driver-api/cxl/linux/cxl-driver.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index 9759e90c3cf1..dd6dd17dc536 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -20,7 +20,7 @@ The CXL driver is split into a number of drivers.
>  * cxl_port  - initializes root and provides port enumeration interface.
>  * cxl_acpi  - initializes root decoders and interacts with ACPI data.
>  * cxl_p/mem - initializes memory devices
> -* cxl_pci   - uses cxl_port to enumates the actual fabric hierarchy.
> +* cxl_pci   - uses cxl_port to enumerate the actual fabric hierarchy.
>  
>  Driver Devices
>  ==============

