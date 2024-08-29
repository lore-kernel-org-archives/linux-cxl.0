Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205D31B5321
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946691; cv=none; b=HQNrOm4DJodD6qk/XDuhb1tXTtV+TIp+XUNY0s3o3ucEwH/34KhKIr43WZ6eFwqwA4d4Y1NrgLc+pOBmTM4mvKCc9oPZUZ8sZgTUkySxiEkf9tnrRKxQ59+qeW/ylbo4LI8uzLE9a07bPNXUU/tqnVHQ8w1CfNeMfJ2PnbsniZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946691; c=relaxed/simple;
	bh=9xBcxOBj83T8n/u0HvlC0j3l60pJ3lf23wgwpFWoibg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fGr6xWlph9o7iumwN25oq6fLcf+jOM7RJs8qupS0PmeqZGR/J2wyhkqyJInncn0OI0oJCTRXDMKS44Rrgvk9fwC+qBGzL0oYe3dWXBNf9PgZr7xMGrZUZxM20wnXg/L8aQoN04hrpZil7icrCh9v6nYJSmNmNiv92R72fg8oTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWM7WAT+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWM7WAT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724946690; x=1756482690;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9xBcxOBj83T8n/u0HvlC0j3l60pJ3lf23wgwpFWoibg=;
  b=fWM7WAT+vnEezx1iuXs0ijFhewVEb4IZnBMSwyp3vquC7mnSMlv7VNAf
   UhP51UV9wC34BR237OLM6uKRLSN82uYYq2Nf8e/dKbkGCohJOuk5qxONE
   xKR97TCrCOUkifNg/CgXP/zg+i5loOjydBEyFJZGEhcybUUtT1UOsyVem
   lRPSIMjbNgynyJwNhwoYRVLQ0bmgtXO48vxuvtrIrPAiuIZv7nxcA0a54
   4wxN2I8hsrnAW74bZecLmw/PRg0eWsZtinoI8917bbeqytacpTRJrUrVR
   FoqNjriHcPK5PxChNvRySK48wXmda96DfVL/wFtQGBuOES5L5EX8dpL2k
   g==;
X-CSE-ConnectionGUID: sHMUt/ZhTOW3ux7WpjJ67Q==
X-CSE-MsgGUID: qo38a8yHQZi6vawy1OYZCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23419563"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23419563"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:51:30 -0700
X-CSE-ConnectionGUID: GEA1XK5lSQClF8vIPkmO+w==
X-CSE-MsgGUID: d0hDW3/sTVahJVgBm7DQug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63814154"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.222]) ([10.125.111.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:51:28 -0700
Message-ID: <5e33f39b-4be9-47dd-ac58-5be87023112c@intel.com>
Date: Thu, 29 Aug 2024 08:51:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cxl: Move mailbox related bits to the same context
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, alejandro.lucero-palau@amd.com,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, fan.ni@samsung.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20240827215116.536126-1-dave.jiang@intel.com>
 <20240827215116.536126-2-dave.jiang@intel.com>
 <ZtCWmAxX8766Blpj@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZtCWmAxX8766Blpj@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/24 8:41 AM, Alison Schofield wrote:
> On Tue, Aug 27, 2024 at 02:49:49PM -0700, Dave Jiang wrote:
>> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
>> it. This allows isolation of all CXL mailbox data in order to export
>> some of the calls to external callers and avoid exporting of CXL driver
>> specific bits such has device states. The allocation of
>> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
>> mailbox can be created independently.
> 
> The reasoning for this mentions 'external callers' yet this new struct
> is added to a header file that is still internal to the kernel. It's
> now available outside the CXL driver but not externally.
> 
> Does it belong in to include/uapi/linux/  and need to be documented
> in the driver-api/cxl/ (same as cxl_mem.h)
> 
external as to CXL but still kernel caller. this is not for user space consumption. for example future fwctl cxl support or maybe type2 support Alejandro is working on. 

> If it stays internal to include/linux/ note that cxl-event.h 
> already exists there w no 'cxl' subdir'. Maybe skip the subdir
> addition, or mv cxl-event.h along with.

yeah I need to move cxl-event.h into that dir as well. missed that. 

> 
> --Alison
> 
> snip
> 
> 
