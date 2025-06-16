Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA2225408;
	Mon, 16 Jun 2025 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113169; cv=none; b=Og5csLCNIfYBCJg99saNTEqSFnnTpinUacJhES8N7xAPfgYQe16mcL3TrFWgCB/Gm4srfl+wHkWlskY/tBlxO+zWPvm+k6YL2NIBZk+4GhC3YxaRvtkaDkon7TudxAmVuDM3NrKmGHAOh/QYJTSnYBlqdN0u9iTve7m2x7XXq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113169; c=relaxed/simple;
	bh=21l1u44nFY/FSBWWEBNEFJN9ZxtEqMV3ZV+4YHzlHSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoxmeUhOWmLveclcyASlwyNlVidi94s0MoAlaPa5/XXT/ZMtF6nlHsawzAKwDvu7Z3kPqW5s1WPJN7zoZuHYMAGVuRpgVUjKsqTlMQRRDjLzect0GW41SzptKZ60O+76Eig1/skEmxXrhqt11Z4J3FA92VFNfUiwzzIbZEnhirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MnF8PUKM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MnF8PUKM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750113168; x=1781649168;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=21l1u44nFY/FSBWWEBNEFJN9ZxtEqMV3ZV+4YHzlHSA=;
  b=MnF8PUKMelqDiYFzHg9ER9a21Pp67sw/XSMCzUUTk5sXf7idAFkZzjGY
   AJmJK/WQ751muMr8cJJYoVjM7J3n1vx8juo/QUCnBu4DPPgojdBVVf2If
   oQLd7ToAtZwpsWKRPCwRPw+JGxpuht1OnkbcqEaEryKTepXAbLiPaIvGO
   JdEmXERuCi5Wo6taZ/YxjVzzN3CIUAbU3e0SY0Wbdbke+0KwRqnrnzldy
   gl2J5Tw4y4PZCc7oB8Q82HQimMZamFk3rjYCpV1XRn8P+0RQiUdRvuWr6
   IgyCsUQlNVk0ibl+PeHiniO5itJm69Mjlp1QComXjb2MQhQoInu8BmfGX
   Q==;
X-CSE-ConnectionGUID: DqQAc51yRsaHzvucFBKp7Q==
X-CSE-MsgGUID: zzrFsRXHQXWIMXvll9of+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52405959"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="52405959"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:32:47 -0700
X-CSE-ConnectionGUID: tqIyvY5BTTeAHz1kVRNJFw==
X-CSE-MsgGUID: SombBd8GRmyCumuQI0R3eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148428340"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.27]) ([10.125.108.27])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 15:32:45 -0700
Message-ID: <b2acd80e-38ce-488f-a6d8-8bdad425534c@intel.com>
Date: Mon, 16 Jun 2025 15:32:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: docs/devices Fix typos and clarify wording in
 device-types.rst
To: Gregory Price <gourry@gourry.net>, Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: linux-doc@vger.kernel.org, linux-cxl@vger.kernel.org, corbet@lwn.net,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-kernel@vger.kernel.org, darren.kenny@oracle.com
References: <20250616060737.1645393-1-alok.a.tiwari@oracle.com>
 <aFBUGTM4fpwU749k@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aFBUGTM4fpwU749k@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/25 10:27 AM, Gregory Price wrote:
> On Sun, Jun 15, 2025 at 11:07:32PM -0700, Alok Tiwari wrote:
>>  Documentation/driver-api/cxl/devices/device-types.rst | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
> ...
>>  
>>  A Multi-Logical Device (MLD) is a device which may present multiple devices
>> -to one or more devices.
>> +to one or more hosts.
> 
> This is subtly incorrect.
> 
> A *Multi-Headed* MLD presents one or more devices to one or more hosts.
> 
> A *Multi-logical Device* presents one or more devices to one or more
> upstream devices (such as a switch).
> 
> You can have a Single-Headed Multi-Logical Device that presents 2
> "Logical Devices" to a single upstream device (host or switch).
> 
> So please change "one or more hosts" to "one or more upstream devices".
> 
> 
> With that change you may add
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>

I fixed it up with your suggestion and applied to cxl/next. Please check and make sure the fix is correct. Thanks!

> 
> ~Gregory

