Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07327381C4
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jul 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719867648; cv=none; b=EkvVIoy0z4HNgW2MOMjWDc2ZPohOxd+cucHgjeGhyWbFkstOBg1F8bVLo70HG8qC4HPC6OzZ7WxKYkvZOcUjSvsEHvn+vRja9XOXOJ99fw7z9pXEB3DAMoWq1f11sld1YBA12J/aO5oIR1DOj3lDuIri6oJfaDuj1MeolpgE+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719867648; c=relaxed/simple;
	bh=Xe+QehI/xDSxbQtukrr+ULu9KwUqTMOaMtr2CddF6Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBaQB9HR3iJ7NpvlOsxmLf1pyrLETDBxRunusRltgJ+tAVhQziqWAKMhFKBzquBokWZ3ogFLsMGynO31qp0YqnYAuYKJ225GKg6HxrXqt2l0gsWh1tF2cgEInATnpWIB5mV2Tn5gcUZ1mzaDM/OX08a4MkAObUgVFgnTP2v6dDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ys+de/VL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ys+de/VL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719867647; x=1751403647;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xe+QehI/xDSxbQtukrr+ULu9KwUqTMOaMtr2CddF6Zs=;
  b=Ys+de/VLdqY9RsfdDHft0CAsfBKbpouuqy3aZzvIil3vatRutRERd2Un
   HExhPwZ5+KtfpG37t+owdboojxuSgl/iScMA/8kqDYwwGA+epUa3gC1p7
   po4hvlXzR/vykcKXVY9eImX23aX8zZJ4GW52UI5Yud2M+fPzM2T1J8mwu
   uVXzLxUjjz8Ftz858oWiwQ5c59S/8n/JK6xMS/1354PRCJGK34VE0Y12y
   iNrCnzot69Vkdah37VCiR8OE5sQVSW7aB0o6BLcVcT8gHiH7YlXkZq3z/
   QJO6X9fPRab20M8tCTecRM0F2RYVkQMVbgqwDLC7dAkJ1w9PlumslJ+xY
   g==;
X-CSE-ConnectionGUID: 0MgbVA33RReskLciCCqg+A==
X-CSE-MsgGUID: Fv6YA2D5Th2RtW93OZqyzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16971733"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16971733"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:00:47 -0700
X-CSE-ConnectionGUID: dP6sjnaeSeSmXT8eboIMvg==
X-CSE-MsgGUID: EKx1meAMSIGiOYWN0IHQVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="50526130"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.46]) ([10.125.111.46])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 14:00:46 -0700
Message-ID: <562321ea-19bb-456b-b94e-a523afdb13e8@intel.com>
Date: Mon, 1 Jul 2024 14:00:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Compute Express Link (CXL) Fixes for 6.10-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <e5477d05-93e0-4268-90ca-581e3f492b4e@intel.com>
 <CAHk-=whQ1LH40w-iSkXq7EbCDfnt5_Z4rLvDa4awrqMOTZqy-Q@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAHk-=whQ1LH40w-iSkXq7EbCDfnt5_Z4rLvDa4awrqMOTZqy-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/24 1:12 PM, Linus Torvalds wrote:
> On Mon, 1 Jul 2024 at 10:53, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> A fix to add proper checking for CXL region interleave capability during assembly.
> 
> I pulled this, but this should not have been a post-rc6 "fix".

Thank you
> 
> That code is absolutely new development. Any interleave mis-match has
> never worked in the past afaik, and this really looks like a new
> feature to me.
> 
> So I think this should have been a "next merge window development"
> thing. Fixes are for things that have broken or cause acute problems.
> Not for "this never worked and nobody even reported it".

I contemplated whether this is a fix or should be left to the next merge window. Next time in doubt, I'll leave it to the next merge window. Sorry about that. 

> 
>              Linus
