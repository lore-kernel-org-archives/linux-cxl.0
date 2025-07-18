Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E4226541
	for <linux-cxl@vger.kernel.org>; Fri, 18 Jul 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752881291; cv=none; b=qEgJSN7c2+ChQzNcEpSaRyvJLhcePauDGg1M/uShscnyRQEzYKrdxgYuQaPZy0/D48qLHYdKf54tsaQ8LMaZeltYhsEAHhHH2ojID3PMbfGacZc+5IN8sn/jyA7pIUXc7FQVZKJLfhiqF2acXFqMxBpdUdBIsz336Cllvb1K9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752881291; c=relaxed/simple;
	bh=v4XvJAk36ky/6yaolv1Nt0fDpKUI2Jcq3OYqWNXM7FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izX5G7n19l5CRE3xbjIDmooDF+Bdbhnd3QtMrvHW+0tQhY2V+xITvD3ebcUI4nguSeHWKWKYT/srKoyLbKku57y++fkTf5ZpzOrfeAgxK/F2fjzZ2L2yg1U+/YV5tfi7IftjY3DnOs8Qu3rj7NQVJKiHEEhj44YDZDCma6Pe2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLy0AIQa; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLy0AIQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752881288; x=1784417288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v4XvJAk36ky/6yaolv1Nt0fDpKUI2Jcq3OYqWNXM7FQ=;
  b=PLy0AIQaqSET6olrWMxJFbE6DX1kqR4ywyV8/GQBauUvo6/kCfmVPt8d
   fiOD4KOKi+0ZY2VOzU59CuawoikDLsD8NCfvn7Ing9dJsE6cAJQFyg8SX
   +LFVFOdhtA/m+v7xLMYYrbqH4BYi+DEqCibMC/00cQpWUwj8kI62vCA7a
   vNXuRhQCiIwDkFsuwkS9iCNqufLkjtVQ2fKFdf6TzosSd6u4oolMPzGVf
   ENF2lS+NmTe5voBzFYZz/PzKKbegbKZaDP3aDPVl/mBz6vbjU01z68Mu/
   xltakWAiQOef8DX4aPTveRTTa/1kCxqhMLYy6bXZQ3rmTNXPuB8PdHa2T
   Q==;
X-CSE-ConnectionGUID: yYzP9vraT8qWirqurF+Uug==
X-CSE-MsgGUID: hFJlw255Qri/CuHXScwJBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="54393672"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="54393672"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:28:08 -0700
X-CSE-ConnectionGUID: L5hhQIOCQRuRd7aOAJQErA==
X-CSE-MsgGUID: ts23DR1USpWBNq7BZ/ebJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="195398513"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.127]) ([10.247.118.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 16:28:02 -0700
Message-ID: <050ca69d-c48e-447a-80a1-8e617d942e79@intel.com>
Date: Fri, 18 Jul 2025 16:27:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] cxl/events: Update to rev 3.2, improvements and
 add trace memory sparing event record
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, dave@stgolabs.net, vishal.l.verma@intel.com,
 ira.weiny@intel.com
Cc: tanxiaofei@huawei.com, prime.zeng@hisilicon.com, linuxarm@huawei.com
References: <20250717101817.2104-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250717101817.2104-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/25 3:18 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add following changes to the CXL trace events,
> 1. Update Common Event Record to CXL spec rev 3.2
>    https://lore.kernel.org/all/20250522090002.831-1-shiju.jose@huawei.com/
> 2. Add extra validity checks for corrected memory error count
>    in General Media Event Record
> 3. Add extra validity checks for CVME count in DRAM Event Record
> 4. Add support for Trace Memory Sparing Event Record.

Series applied to cxl/next
3a32c5b3bb7d2dfad5fab94817f59e8963e2b1a6

> 
> Changes
> v1 -> v2
>  https://lore.kernel.org/all/20250716104945.2002-1-shiju.jose@huawei.com/
> 
> 1. Fixed comment "Spacing before the } is inconsistent" in patch
>    Add support for Trace Memory Sparing Event Record (Jonathan).
> 
> 2. Dropped note and question from patch(2) and patch (3) (Jonathan and
>    Dave Jiang)
> 
> 3 Fix for
>   https://lore.kernel.org/all/202507171153.p2RrAdN4-lkp@intel.com/ and
>   https://lore.kernel.org/all/202507171217.6p5GHqr0-lkp@intel.com/
>   Foregot to do get_unaligned_le24().
>   
> Shiju Jose (4):
>   cxl/events: Update Common Event Record to CXL spec rev 3.2
>   cxl/events: Add extra validity checks for corrected memory error count
>     in General Media Event Record
>   cxl/events: Add extra validity checks for CVME count in DRAM Event
>     Record
>   cxl/events: Trace Memory Sparing Event Record
> 
>  drivers/cxl/core/mbox.c  |  24 +++++++
>  drivers/cxl/core/trace.h | 133 +++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxlmem.h     |   8 +++
>  include/cxl/event.h      |  37 ++++++++++-
>  4 files changed, 195 insertions(+), 7 deletions(-)
> 

