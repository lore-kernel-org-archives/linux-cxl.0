Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33E16EC19
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737667860; cv=none; b=G26jAEdn02ecRFum3jAbu0TjRvpn9BKs1Q61GrFYt1if/d+gS1Qu/7mc8SMTkOF+1EVMwarHoc0CYaFMA5tuAaN/rKZGFeUL65EXUhXqD9Wxvgb9DysELf32vQ6osLIGOSTR9F1oLJwcwxuVLxD1DCDIYoqQahBOZggWI/TdhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737667860; c=relaxed/simple;
	bh=X4z1BeUUKTgzvIym5mLGL7wqvjNMzAn0NYcx9zbAZiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtkGJk4t/uotca5MTJPupfeX0UynXphSTlwZitkRXO1rFanMXvwiJ4hm6mpP0IdP80EKzlR2r/dA4EG/hnLXLBikvLyrxZds+F6ghuVBP1CUG9Ga1xDwxUkRuPXRLhiqDcdJPM7OuqZ2nVHEhrp4sxl93GMJwiWc4CeIzGQuXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWrnsl09; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWrnsl09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737667858; x=1769203858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X4z1BeUUKTgzvIym5mLGL7wqvjNMzAn0NYcx9zbAZiw=;
  b=hWrnsl09rp0Fd8Ag8mPIjpe9HhsGiHi562vcwKKCQthgY1Kjqm4mtVzh
   jJbBeajYe6NiUGKBv/D4QbkwsBL3y+HBnyk4ObFb14BiDCemVsPCi1rbj
   jT6wUe+TW0RiBYgU0Pi75uAzM5/bAZBUPr4mo6oW7iqjfhrlWn/gjSQri
   hhidk3crXCi2CRigxsOYhQesyiWXPGGpOMIpn3dq1pyqyc9Dj0ZikJLF3
   L5vBnwqTChMueio6O8YuQzLU+uJOoY5WavKMQHybbezFteVJ4aKsaj2Wm
   ZSGU1I9NP3JCQyO5Kk3/iAQcRtQrcTJ+jHwUtQpLBZcv2Ym1RtQ6tVt1v
   Q==;
X-CSE-ConnectionGUID: 3Nsfpw9ZQSaDSXqrNfaIig==
X-CSE-MsgGUID: 6dcB4iMVSQOHgv1Y7rcYyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="60659028"
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="60659028"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:30:58 -0800
X-CSE-ConnectionGUID: Wt9V3QmzQYGtykLyRMjzfQ==
X-CSE-MsgGUID: Mb24NOO/QfyH26494rGX6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,229,1732608000"; 
   d="scan'208";a="112582344"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.229]) ([10.125.110.229])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:30:57 -0800
Message-ID: <e5783dcb-1060-43ed-bb4b-04ad737adb58@intel.com>
Date: Thu, 23 Jan 2025 14:30:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-cxl@vger.kernel.org
Cc: Alejandro Lucero <alucerop@amd.com>, Jonathan.Cameron@huawei.com
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
 <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
 <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <67912e07cc2f3_1eafc2948c@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/22/25 10:42 AM, Ira Weiny wrote:
> Dan Williams wrote:
>> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
>> tracked in the partition, and no code paths have dependencies on the
>> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
>> can be cleaned up, specifically this ambiguity on whether the operation
>> mode implied anything about the partition order.
>>
>> Endpoint decoders simply reference their assigned partition where the
>> operational mode can be retrieved as partition mode.
> 
> You really seem to be defining a region mode not a partition mode.
> 
> I did a lot of work to resolve this for DCD interleave in the future.
> This included the introduction of the DC region mode.  I __think__ that
> what you have here will work fine.
> 
> However, from a user ABI standpoint I'm going to have to play games with
> having the DCD partitions in a well defined sub-array such that the user

Are you talking about instead of having additional elements in the partition array, DCD will have it's own array?

DJ

> can specify which DCD partition they want to use.  So the user concept of
> decoder mode does not really go away.
> 
> In the interest of urgency I'm going to give my tag on this.  But I would
> have preferred this called region mode.  But I can see why partition mode
> makes sense too.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]

