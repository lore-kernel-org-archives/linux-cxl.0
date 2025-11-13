Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59286264638;
	Thu, 13 Nov 2025 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051678; cv=none; b=Cuc1m9IIIxsdDUR0l2mqW4dd/CKJP1DCFBy+cSuYuxZFy1NeL6wCzMauTcuJfXuTBQQdh5x5kKFWMW4s9xrkFGRsQekOFWVlkaPDKJn/xwdtYLps4VuByIHvaloB6OWW8P6GkXOp3oDxE8o3WO8XC6Ikil+sSlg0L0TC7TMHDr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051678; c=relaxed/simple;
	bh=NCb9Bzu7WQEFInCd9jw3p7avb4Vai1iqxOM55MGgbK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFf84Mxm+7c4fn/noOcZfaOWsiiriF5mHEDNtiQKeqsPozxNT7bnwgm7V9BUcELf+xLi0lFx3iE3hoI10LNpzKJNt+ZPmRQ+2yj13OwL5bDVs+QF9a5QWYNTYLGt3SnXRwnF76AYbPwYXyKlxO/eLxCpZ//76Xsy7K5+0BKe8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cRoWUD68; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cRoWUD68"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051677; x=1794587677;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NCb9Bzu7WQEFInCd9jw3p7avb4Vai1iqxOM55MGgbK4=;
  b=cRoWUD689igclhNAFdaQENy1Ue4mgrcyuHoM1rXdT6ZOWb1TWfefPNAH
   PUE3hSFD9lKMEhY2w+HHjWdNfIC8O3Uyqixqx9t4x/SGSel+QSH86CsRG
   4G3HN/5hmc9juktUqR8KqZUJpiN2dz7G97OJ9kgSuY/v6PsyRPKVeRDMU
   r+Ub6nW6avGibVv3+Aw3KEbg7rO7fdVE+EqY/3lhSxtP/agmK477wzk/w
   kYk6wreUIRdcE/Zb3KvoaXIX2suf7IDfpDdIi024/gAhB4TTExHdte8iY
   OCDgFBeazwl0mO+05xyrGY2CbFkKZPv3aRoJOyjT7yyQjNIXgSl9m5p8p
   g==;
X-CSE-ConnectionGUID: 1wSTAscRRkSGeJbiPVQiiQ==
X-CSE-MsgGUID: zSP3ZXKxRDaH/jl8KTxtwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64340257"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="64340257"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:34:37 -0800
X-CSE-ConnectionGUID: xGP/66LDT/OegyJcqEm0LA==
X-CSE-MsgGUID: WTEsHERoT9G6GZqsRCyV8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="220187027"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:34:36 -0800
Message-ID: <170c89c8-ac37-4283-8a1c-6c7c442a1654@intel.com>
Date: Thu, 13 Nov 2025 09:34:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
To: Gregory Price <gourry@gourry.net>
Cc: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRX59JpZJa18QfoQ@gourry-fedora-PF4VCD3F>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRX59JpZJa18QfoQ@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 8:32 AM, Gregory Price wrote:
> On Thu, Nov 13, 2025 at 08:20:59AM -0700, Dave Jiang wrote:
>> On 11/13/25 4:01 AM, Robert Richter wrote:
>>> On 12.11.25 14:45:28, Dave Jiang wrote:
>>>>
>>>>
>>> Additionally, patch 3/3 (@inc variable change) of this series also
>>> depends on patch 02/11 of v5 (store root decoder in in struct
>>> cxl_region). If you chose to pickup some patches from v5 first on top
>>> of cxl/next, then all this 3 patches should apply cleanly.
>>>
>>> Since 02/11 is one of the first patches and it sounded to me some of
>>> them will be applied as well, I would prefer that order to avoid
>>> rebasing and resubmitting a v6 for that. Let me know if you want to
>>> handle this differently.
>>
>> Hmmm....maybe I should just take the entire series hopefully next cycle when it's ready given all the dependencies?
> 
> As an active user of the Zen5 translation patch (I've been carrying
> backports Zen5 support for over a year), I would greatly prefer not
> to delay the Zen5 series for the sake of this series.

Well if we can have the series applies cleanly on 6.18-rc5 with all the needed review tags and all the outstanding concerns resolved next week, we can go this cycle. I'd like Dan to take a look if he has time though.

> 
> ~Gregory

