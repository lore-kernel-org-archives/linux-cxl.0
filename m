Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301462652B0;
	Fri, 14 Nov 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134324; cv=none; b=ReoETTPG+Y/SYlmVkngeG/51vvBEW+Be1Vdw6fX6AFsZf8/8W4IwVWNGLxWLSijatPLsgpDxSu2cIekOrsPhBE2bPTXQLytRaGTEUvlRZc9es2O1K71xU3eELLMrBMdFp3KZpYAbz1IEaPeucRxE9yPltcoz/sxf5C9jo2d7UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134324; c=relaxed/simple;
	bh=8oZtx4yRjIBXc8p6/YnU8uLukTq9bffqZo/UZiAgU1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMzxm6wiMk3fDjFG393wHc8BKae9Ujjs53H0Zi/YzcqddqUpv8OPuHaBftZGmSPKa9nbySuythyouJzr5yFaTZF9aMZYQbJGI/waT41ct/EiXaKLtgHDQIVLD2MbtydsjJZTvln/0iyp5vT5tX4xLgIo2xR214SCRr2sxZqEZGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tn7U+/sM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tn7U+/sM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763134323; x=1794670323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8oZtx4yRjIBXc8p6/YnU8uLukTq9bffqZo/UZiAgU1k=;
  b=Tn7U+/sMMoaNHXAhG+GIYYHEpNoUf/mkNCQfghfIJlKYQo0fK+TK8uxT
   xNg9Ieijgrn8w+dQmxHwkSoBRYcubT8Ix00M0vJxE7eGeFF9hzSYukdN9
   143WFLG0w+P4nZ2iIiEWePBAoGXvKrt3zhYVlQQC6ntHLjMSBdrwO+Sm/
   LGvTxQKjF7tw1YqmEYdO5qDtaUbPdgIF4ciReM7sUhmyjfwmTo8WoD85q
   WTU7apODZoCzwdeTNidF6nkyRAJtri2vXx5SilAQAJGMp+zDdJ+s7YR2L
   SROk2CPS5FZxNqkQQCHaLCpNmgsfmEOBod7O/0/Z9BJdJfkOR1SCkNXWR
   Q==;
X-CSE-ConnectionGUID: tXpr8R9ERBCGTA8Zr7YSPQ==
X-CSE-MsgGUID: uhIcHZ4bSD+7fJCF1cGR3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="82862357"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="82862357"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:32:02 -0800
X-CSE-ConnectionGUID: Hv5tu/8lQWmhUCYJfxV7CA==
X-CSE-MsgGUID: vyhvpjjzSA+34+IPhhgd2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="213210409"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:32:01 -0800
Message-ID: <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
Date: Fri, 14 Nov 2025 08:32:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] CXL updates for v6.19
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain> <aRbx1EbsGqUDY3Rd@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRbx1EbsGqUDY3Rd@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 2:09 AM, Robert Richter wrote:
> On 13.11.25 21:36:16, Robert Richter wrote:
>> On 13.11.25 13:10:56, Dave Jiang wrote:
>>> On 11/13/25 9:45 AM, Robert Richter wrote:
> 
>>> So currently we want to apply the 3 patches ahead of time right? Can
>>> you 1. post the series against 6.18-rc5, 2. provide a public branch
>>> (github or kernel.org) that merged this branch with cxl/next (given
>>> there are expected complications) that I can reference? That's
>>> really my preference.
>>
>> Ok, thanks.
> 
> I sent you a delta patch as I don't have a public git tree at hand
> right now.

That works. Have you sent it yet? I don't think I've received it. Or I can give you push permission to my github repo if you can give me your github user name.

https://github.com/davejiang/linux

> 
> -Robert


