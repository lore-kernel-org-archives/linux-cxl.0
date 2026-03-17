Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6437998A;
	Tue, 17 Mar 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780511; cv=none; b=MCujYxGjOAiF0FVRK6M0vVHK3wgoLzkdSOkDQhaixWNHEABRCz+YHayK9SEYeIdud8qh4JnmMSANGa2MDCmZdchOa/qI9ab784dzeI4CX/WVFDBqEfnNAgOszWyXwQMZSE6ICoqA+4jqPGDatunJnXQqKHew40feMbYBZyRODeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780511; c=relaxed/simple;
	bh=gfUINaVutrMX+CKtYXTn427ZrsWRyTvup7TNGBpE+Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+2i2PrzRtpGSykFykTU3KHqRfI0oYGQMTB+ICHuAF+UV/L2P5zHW42kHuHjEK3Z4czVQEAy1vdvGsiirIVNcmpYdleTQKDoJAXxEosfaENKvPkoL+bWe/g5AxzufCWh/ohj0JHFxXdHwFbllU7qZT5gfb+AwLKkFWgC2ikArJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktAdqkun; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktAdqkun"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773780510; x=1805316510;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gfUINaVutrMX+CKtYXTn427ZrsWRyTvup7TNGBpE+Vk=;
  b=ktAdqkunKH+snM55PZvM0hzugWcH2wzlsuTshZBHRMjC4eh7QQsCYOCl
   eOVBnDXtwSBxSWX6difjMXvMKbbGJfkL+4pj/fi++JYumYNp3HjQZgIwh
   ftAXud2gsdpQ/JsJirnQStFaxziKmTkgPZCv0H4s2kranOyHzeVmZYw7F
   AbaKIKRgqFhe77TONzR0TdsIO+XCJAxD8OQoyNx+VuXbNaQ8TGaHi4NKa
   kKuMRy6E1ob1j++YsJyMiWiRa2dayFQBot+1cVEa/J+xJhjuQwnY6HNA8
   nJ/A2i09XyqOexhEZ0TcknxscqbhWa7Of5ioNMW+o6HG20pkSZcM4hxmI
   g==;
X-CSE-ConnectionGUID: FT4HoeGORLi15s+lWAGVIQ==
X-CSE-MsgGUID: 7uKzm8EKRfuPbAtaXyFj/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73847108"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="73847108"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 13:48:29 -0700
X-CSE-ConnectionGUID: xsKkf4uYTSSmuokWkJDYdw==
X-CSE-MsgGUID: mXi++9XLRe+RAUcLEIS2Gg==
X-ExtLoop1: 1
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.108.169]) ([10.125.108.169])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 13:48:28 -0700
Message-ID: <b5d7d38d-9130-49bc-b343-937c7c326353@intel.com>
Date: Tue, 17 Mar 2026 13:48:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/hdm: Avoid incorrect DVSEC fallback when HDM
 decoders are enabled
To: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Terry Bowman <terry.bowman@amd.com>, Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260316201950.224567-1-Smita.KoralahalliChannabasappa@amd.com>
 <d87ff3d2-de30-4c47-8f47-3633507b4e48@intel.com>
 <8343ad50-0bb3-4fed-a32b-a2b46db6c8b6@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <8343ad50-0bb3-4fed-a32b-a2b46db6c8b6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 1:32 PM, Koralahalli Channabasappa, Smita wrote:
> On 3/16/2026 5:08 PM, Dave Jiang wrote:
>>
>>
>> On 3/16/26 1:19 PM, Smita Koralahalli wrote:

< -- snip -- >

>>> Fixes: 52cc48ad2a76 ("cxl/hdm: Limit emulation to the number of range registers")
>>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Smita,
>>
>> Applied to cxl/fixes
>> 75cea0776de5 cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled
>>
>> Any chance to add the issue reproduce steps to a regression test script in CXL CLI test please? Thanks!
> 
> Thank you! Okay I will add it. That should be in ndctl/test?

Yes. Thanks!

