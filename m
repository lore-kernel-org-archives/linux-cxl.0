Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD23148B7;
	Thu, 29 Jan 2026 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703201; cv=none; b=myJcuqgDm8wlowDPN0OxvxcTLa5bXqfzfopkdQ2KtvDv4ljSzy2p/5dg4vwg9sFyB2JzvMpG/NjGTopH9JOjBxEEf/4MqJiF+wW7TPNJntpK59nXjU9GHP51JwEuHQduQ5V3o31lSqq9Nssa7Ns9G12RSpup+QquSDi/t9ciasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703201; c=relaxed/simple;
	bh=aF7LY7dAuJ/blzhBcSzB6uOPM4Zsfv2E6ATGYFERWWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cmgc+dEu+QxBM/qIsXBFBNbT115ySKzNpFAillKQYkyrxFF7+EHHK7SfOmDiDLyFM0QPlqkd+fbA9fKoPxv507Gi4PThwMZ4VKW/T77bMOTgLz8sEBmgOJvmV1fLqnaYEtgxnO775Bkc5Z8PRo3kEqNqQaBY5ACzGQyAfKTXrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8VljspQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8VljspQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769703200; x=1801239200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aF7LY7dAuJ/blzhBcSzB6uOPM4Zsfv2E6ATGYFERWWA=;
  b=m8VljspQLmYw4inJVz9I7jPZCQrY4PCz1PrMt0LIFV5l1upYDpi97vK6
   OKE5maRKjtbXUJnCOjt9+nVQuRNC7zXBYRrJY7yWGhRy0FAPCBgNIjYoZ
   AnDqpdUJYoqIgBpx8JP8CZ9VOVIFdsokx1eN6Lk3VSCbWR1WCpYgldIWj
   hsxMQiaCkZEL6M5N5OcyC5itM+5Bq7cRIS2CYlHXNcHGXEnGs2SZJedKt
   +vMgB4aROiezzT4v1ARsZFFUMqz0GcO1IWbLQI2o9sKLMVP8m5+fANUBN
   wTdvvzCsGZ2EMDfv1A6yGcoMlBKBrOkk167Jk2elbDJajc5skZ5uqK8wi
   w==;
X-CSE-ConnectionGUID: hl96g+3zSqaEunpRKXUeww==
X-CSE-MsgGUID: LA4bjp/XSKu2V1ZIFED2xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70841985"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70841985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 08:13:20 -0800
X-CSE-ConnectionGUID: p6sZR8/1SE6TImktBa0kIQ==
X-CSE-MsgGUID: MpZuwtSLQdO3gKHmXEenjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="231533956"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.10]) ([10.125.110.10])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 08:13:17 -0800
Message-ID: <29030d41-3044-4e90-8054-7bf23d12d868@intel.com>
Date: Thu, 29 Jan 2026 09:13:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
To: Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 linux-doc@vger.kernel.org
References: <20260122172432.369215-1-rrichter@amd.com>
 <20260122172432.369215-3-rrichter@amd.com>
 <69790b8ff40bd_1d6f100c5@dwillia2-mobl4.notmuch>
 <aXoJPP00R7qblx-o@rric.localdomain>
 <697a6236185dd_3095100d2@dwillia2-mobl4.notmuch>
 <aXs0jW3dK6IwtXwZ@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aXs0jW3dK6IwtXwZ@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/26 3:21 AM, Robert Richter wrote:
> On 28.01.26 11:23:34, dan.j.williams@intel.com wrote:
>> Robert Richter wrote:
>> [..]
>>> the Zen5 machines only use the PRM method as described. They have been
>>> out for more than a year now with stable firmware. Moving to _DSM
>>> would require a new firmware release and force all of them to run a
>>> firmware update.
>>
>> Ok, so then do not document _DSM as an option in the convention
>> document. Only document what has been shipped and require anything that
>> follows to not deviate from that de facto "standard".
> 
> Ok, thanks, will update the documentation.
> 
>>
>> I was confused by this convention document offering optionality (direct
>> PRM or _DSM) and then requiring that the kernel accommodate the less
>> preferred option (direct PRM). If there are no plans for the only
>> existing implementation in the ecosystem to support _DSM then simply
>> require direct PRM forevermore.
> 
> Oh, I thought you were aware of the existing PRM implementation and
> then wanted me to specify _DSM in the spec, so I started with that.
> 
>>
>>>> ...and for the implementation can you update it to only invoke a _DSM
>>>> and hide the fact that it might be implemented by PRM on the backend?
>>>
>>> Additionally, a kernel implementation change is needed including
>>> another test and review cycle. As you described, the implementation on
>>> the BIOS side would probably be a _DSM wrapper in AML added to the
>>> SSDT that calls the actual PRM handler. An alternative is an ACPI
>>> quirk injecting that as AML code, but that makes things worse. IMO,
>>> all this is not worth the effort just to define the interface as _DSM
>>> only, and then use a wrapper to call it. Plus, there will probably be
>>> no platforms that adopt this.
>>>
>>> I really would like to see PRM and _DSM coexist in the spec to avoid
>>> all that. We could restrict the PRM GUID to the one currently used to
>>> avoid other PRM handlers coming up (if platforms adopt this at all).
>>> Please consider that.
>>
>> No, please no coexistence of alternatives. Direct PRM is shipping, catch
>> Linux up with this singular reality, close the door on future changes in
>> this space.
> 
> Understood.
> 
>>
>> If there is ever a "next time" for a different platform concept,
>> strongly prefer a static table + native driver enabling approach.
> 
> The translation algorithms are not trivial, see around AMD_ATL and in
> drivers/ras/amd/atl/. For CXL, PCIe comes into play in addition to
> handle that.
> 
> Anyway, thanks for your quick response. Will send a v5.

Hi Robert, if you can get that sent out by tomorrow, lets get your series merged and call it done. Thanks.

> 
> -Robert
> 

