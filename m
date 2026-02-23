Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718033AD91;
	Mon, 23 Feb 2026 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869876; cv=none; b=hD5X5ybdRpiBkqIpqsDdVeLu0qmK52GY2OlDR3x26qYurOEabLw+dkArgkzak+yTn0D9sCsGNNd2Vi4Qe9GIBCwRjYWW9ficaLuq26TeJJ2eNw3dTRhVtmN7Vf5ZC96xuhiVdNln0S71jHGKSsK45wKLtNfcUQDEMdaO9ugXia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869876; c=relaxed/simple;
	bh=Q/fCjCKpE1k3AsRQscfFygB/Nn5oxHybbRWoTysz0U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VglyQyadwYq1CITn3ctb1ipZp2mgmGSVrSMcwWGVVQI8vrShZmG61bgHw3+61fzYsoTSQLKsiEIxR81O9Q7kqYDcudV8ATN4nllQah7Vp7ED9BRz/ywxyLNgGs+TLfzTRPU6WqQOxJthUqZLR4Fil9StM7KONPRyFcPHoarF8ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0KQ3lpQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0KQ3lpQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771869875; x=1803405875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q/fCjCKpE1k3AsRQscfFygB/Nn5oxHybbRWoTysz0U8=;
  b=i0KQ3lpQpcQ+ochbPLHW5/jfbbz9qAtjtsBtOvsU9jlaKJ35YSoElaLa
   1jgDmySwKZBK6z4TxkeYVo+03uSZGGnM0biaO/vDmuaCJq71xozRIoCKJ
   hP0FhP28/twd42rpQJbmEtCq6QldzI7/OuYuoc2QqDWmNICbj1ZcdPmeD
   bgKbsdxtYWzetYjAFQvnBeYLRPiPzKgPt2SydeD6ERl4vwvitSXsFVbYj
   cLZWYpWh0e2AJ1RBlxnItR4tr96smtnUoJ/gNTJD8fOwGlZIc6fFmuCFz
   6jvRd9n6TFSzOamnP2W0715j/a8+hBXhBYSy0FRYulbGbdJNtGFkeXmkq
   g==;
X-CSE-ConnectionGUID: 9wx0DTylRJyCpL0dzTNz/w==
X-CSE-MsgGUID: Yj7j7iakQJyWOTq3YpuNPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72773624"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72773624"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 10:04:35 -0800
X-CSE-ConnectionGUID: 75EalwMWRdCaODs5w7Rnrw==
X-CSE-MsgGUID: GKFreDJZQpe/pnxi90/rkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220193233"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 10:04:33 -0800
Message-ID: <8e3f7f91-99f3-4439-b08c-6bd04c6bf688@intel.com>
Date: Mon, 23 Feb 2026 11:04:32 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: fix test_bit misuse with CXL_DECODER_F_ bitmask
 flags
To: Gregory Price <gourry@gourry.net>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20260221021810.1390342-1-gourry@gourry.net>
 <85d7abf8-3b3c-4199-a680-1453f77b3fd5@amd.com>
 <aZySU-tcjVvYcb23@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aZySU-tcjVvYcb23@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 10:45 AM, Gregory Price wrote:
> On Mon, Feb 23, 2026 at 11:33:13AM -0600, Cheatham, Benjamin wrote:
>> On 2/20/2026 8:18 PM, Gregory Price wrote:
>>> CXL_DECODER_F_LOCK (BIT(4) = 16) and CXL_DECODER_F_NORMALIZED_ADDRESSING
>>> (BIT(6) = 64) are bit masks, but three call sites pass them to test_bit()
>>> which expects a bit number.
>>>
>>> Replace test_bit() with direct bitmask tests, consistent with every other
>>> use of these flags.
>>>
>>> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
>>> Signed-off-by: Gregory Price <gourry@gourry.net>
>>
>> Alison sent out a patch [1] two weeks ago for this. I suspect you found this bug
>> independently, so I figured I should point it out. Otherwise, I would add a Reported-by (or some
>> other tag) with her name.
>>
>> Thanks,
>> Ben
>>
>> [1]: https://lore.kernel.org/linux-cxl/20260206181404.1025991-1-alison.schofield@intel.com/
> 
> Ah, yeah, missed this, and did find independently when testing unbinds.
> 
> Wasn't on cxl/next so I thought it hadn't been found yet.

Yeah waiting on 7.0-rc1 for cxl/fixes. I also asked her to split the patches into 2 fixes. But if you don't mind go add your review tag that'd be great! :) 

> 
> Cool, thanks!
> ~Gregory

