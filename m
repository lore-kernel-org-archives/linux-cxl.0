Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3D277C9F;
	Tue,  1 Jul 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383441; cv=none; b=gwbSIHqOkWM3/raxKny8x0kESCzlB4soM5XN39MHfxNzzgHSLF6iJjhs7F9RRABs1wqF2Fx8eOTpP05ta12Mk0VyFJwxgHu7PWyWeASlzMiIkH8q9/AaRoYv/RiBd3305tjqyRoudA63x5Qvw82660g6eJThme9lKC/NHt0MpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383441; c=relaxed/simple;
	bh=avG9QVTiB19t8sqVOmhJl0sjhGbCmDbse4lCvvoUBsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Puzt+vyCC83nAww4X2pbtH6wB/pYA6oQo3mCnuuzXL+2Oy1ApOQm+1Frgih8FECFQkfU7t2Sz5HIlrmn6H+wnY0hnw7Ygw4Cwmttpfe0sZbuA+7OWAnhSKOeSfnbSmiMQzQOLlIGe2HZQ3NshfyInIMQgXWuoPHnDBYZEJ0z4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjmXd+HI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjmXd+HI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751383440; x=1782919440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=avG9QVTiB19t8sqVOmhJl0sjhGbCmDbse4lCvvoUBsM=;
  b=IjmXd+HIDxYk6TPFKPJmDER7Ti09SvfgRwyEdCDI1TBzcExX9ky0wz8h
   YzEqwtll61bmvCS/gyFqet7f4+cifTiQ/rwU53vhPXtf0ihXWMuPiN96x
   42nOycQbxcTpFM5eyufuBKR4RIwyV/B5i3GPqTYa3YcodAYoNwDBw/61Y
   hUI1+Ryy65DO3Yl85/dMaMlmOTcExRrolWJfKV0gxIbfKw6tBE8LQ7Ltn
   H4ktdPkU70z52cdyG8mtzTF7DBS4NCAxCYAgItGVS//bLTI+9sN9swB/7
   8iuWUvTrbrj7d3L5dcarOOM1KVCwiGNDGzDslSC3skYL3EDoLpefCEyXn
   Q==;
X-CSE-ConnectionGUID: ot1Lo+pUQFOhZBWrXNKc/w==
X-CSE-MsgGUID: QMuJ6/3xTDqoTOvIq6lW3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53745116"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53745116"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:24:00 -0700
X-CSE-ConnectionGUID: sRSJ18lpTMa0Ez+mYznlJQ==
X-CSE-MsgGUID: FUiUsIDUSlqts1S8bb9p7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153884442"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:23:58 -0700
Message-ID: <c32cede0-643c-47bb-bfde-93adbcf16155@intel.com>
Date: Tue, 1 Jul 2025 08:23:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts btw
 CFMWS, LMH, ED
To: Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <aFmo18OEZGMA2HU8@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aFmo18OEZGMA2HU8@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/25 12:19 PM, Gregory Price wrote:
> On Mon, Jun 23, 2025 at 05:29:02PM +0200, Fabio M. De Francesco wrote:
>> Add documentation on how to resolve conflicts between CXL Fixed Memory
>> Windows, Platform Memory Holes, and Endpoint Decoders.
>>
>> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> 
> I won't block a doc update on a suggestion so
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
>> +Platform Firmware (BIOS) might reserve part of physical addresses below
>> +4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
>> +or a requirement for the greater than 8 way interleave CXL regions starting
>> +at address 0). In that case the Window Size value cannot be anymore
>> +constrained to the NIW * 256 MB above-mentioned rule.
> 
> It might be nice to have a diagram that explains this visually, as it's
> difficult for me to understand the implications through words alone...

+1 on request for diagram to explain. We should try to document this issue as clearly as possible. Thank you.

> 
> which is likely why the conflict exists in the first place :]
> 
> ~Gregory

