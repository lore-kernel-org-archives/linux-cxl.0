Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC4334372;
	Mon, 20 Oct 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995360; cv=none; b=sHSY+Aji7cYTTGWJ60H6yHSwplgMySyUHC6G5skmHx/nvebW/bB+JF3jkNuxPGsE8HcslDQkPABLEze44klOpLBoMktfYMQjLqokMzWYSRKnhOIBCf0Y3sDqj3SrVKvH/JQylGzlttd1N6DbUlp+HrcW5AsCBvtoP9Uajfzi4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995360; c=relaxed/simple;
	bh=qYY1qLufeY1f3EgZKySLUuTNayjNH8pPG4M0+/NEz38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqoTUoCJRfrdu4gQq/C5OU0Zl+388MjONNEWzKXoVBvMrquYC0OBh4av4rYO5DwB96IKeM/LzVO250QM1csj6kPZG9g7itcq4LFsAC+/my7eB/FKOye3471lrlTW8FZkskW+rdFEdlus48AoJ4yryAQSn8IZgPEsD25meSi/Jw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Caamiasd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Caamiasd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760995359; x=1792531359;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qYY1qLufeY1f3EgZKySLUuTNayjNH8pPG4M0+/NEz38=;
  b=CaamiasdZnal1/P7o8xlteCrTUl22/3CBjNd27mHxXZTgiyhP8S3qHrV
   0/2CF/QSsJkT8tyWBsIFOsnI5OcBtscb+mnDnT6Nh0XWjDZneK1js5R/z
   dKyFa6DXmCLlzbmPC72EdFAKlDR75SLyaPU5IseWDpq+hd36doZAKscUa
   //1V0YzBYbmWHl0BBoMKo98Yddnuo4MrrjZAYesVjKNLdNYfHcBlwmfhh
   hhcZ24HFgiESimKGpron5rQjobQbcLQf8LySrnkX6xkeaTq76ehY4LENW
   Y8J4smgScwsndvKKdH7V/G+O+TOHK69qw5Wq8G/7YK9krihZOikkJc4MB
   A==;
X-CSE-ConnectionGUID: wFpi56kSTxCJmpf0yy2pUA==
X-CSE-MsgGUID: PYhwAYBiQVWG8rXn5tscXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63027346"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="63027346"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 14:22:38 -0700
X-CSE-ConnectionGUID: EeYIFcZZSAWV9W04YExiTg==
X-CSE-MsgGUID: GUpku4krSyW7QNn1N2/BCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="188528968"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.123]) ([10.125.108.123])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 14:22:37 -0700
Message-ID: <2393460e-aed6-44ac-9f11-f5b9a1f29e6b@intel.com>
Date: Mon, 20 Oct 2025 14:22:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] cxl_test: enable zero sized decoders under hb0
To: Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>
Cc: Vishal Aslot <vaslot@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
 <20251015024019.1189713-2-vaslot@nvidia.com>
 <aPXgLp1Em6wKlx0t@aschofie-mobl2.lan>
 <aPZE3Spas-IvHmfd@gourry-fedora-PF4VCD3F>
 <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aPaNzeGqUHf6gGIu@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/20/25 12:30 PM, Alison Schofield wrote:
> On Mon, Oct 20, 2025 at 10:19:09AM -0400, Gregory Price wrote:
>> On Mon, Oct 20, 2025 at 12:09:34AM -0700, Alison Schofield wrote:
>>>> This patch updates cxl_test to enable decoders 1 and 2
>>>> in the host-bridge 0 port, in a switch uport under hb0,
>>>> and the endpoints ports with size zero simulating
>>>> committed zero sized decoders.
>>>
>>> Decoders 1 & 2 - those are after decoder 0, the autoregion.
>>> That's a problem ATM, when we try to teardown the autoregion we
>>> get out of order resets. Like I asked in the other patch, if there
>>> are rules about where these zero size decoders may appear, that
>>> may make the solution here simpler.
>>>
>>
>> I think this is going to require a quirk-doc like other deviations.
> 
> Really need to hear more about spec here. You mention quirk, but is it
> really a quirk or spec defined behavior?
> 
>>
>> A committed decoder must have a base address, and with 0-size subsequent
>> or previous decoders would also have an address that covers that address
>> as well.  This is on top of the ordering issue if the 0-side decoders
>> come after a programmable decoder.
>>
>> I'm not convinced this even makes sense as a security thing if you can
>> reset the bus and re-activate everything (after a graceful teardown).
>>
>> Seems easier to just report the decoders as unavailable and then not
>> probe them.
> 
> Users see a memdev in the topology and want to use it but find no
> available endpoint decoder. We'll probably want a mechanism to show why
> that is so, hence the suggestion to add to topology and show as locked.

I think the kernel driver should be fully aware of what is and isn't fully present and handle them appropriately. And on the user side, 'cxl list' should show a decoder in a zero size state so the admin knows why things are the way they are.  > 
>>
>> ~Gregory

