Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951E34D934
	for <linux-cxl@vger.kernel.org>; Thu, 20 Nov 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651240; cv=none; b=Lk0T3bfQtgN+Rj4Sqy8qxcb6Tcb0sBVK2JW7tS6RGxBjadrvBV3sdfVDNozpREyAXI+VS5ETpoL+PM2Zb9Fi01HJBJBC8o0Qhyk68vhA59l6nVX90oPq74LobPmuECxC6vfXETvriytw1TJ5klpY6epfjeQtwVAnOycIntfEJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651240; c=relaxed/simple;
	bh=1bWlZJsYohIFTNUpNYNhevZ13fi4R2sorKkXYA7iT+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jwuUbcj1Q9VgwgrB/tg06fpo9X6q+qt9gpqbzzUS7jpcaemlk1uKqYKglZN5fvfWQEhtch1D4Xtba9bL/D/I+ro/azw6rfK4DaiYJPy0Jc4IlZ1m3FQH4sAa+HwJCvLJ1Npw3cd+61H0HPI+FMaUm9yh/jtVhiUqqVrmq6YA2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVKcg44u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVKcg44u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763651239; x=1795187239;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1bWlZJsYohIFTNUpNYNhevZ13fi4R2sorKkXYA7iT+s=;
  b=SVKcg44uOkVStDTBgfwuJ3yXVS7KfNyu3A0j4OP0yB0G7Eaa2EDLnF6d
   8PwRQJfg8d0V9CjdlH3X7mtpG43E9IRGx9uz1KIvjoN5kZI657d56u0q4
   Jh7gTEfvlq2nzIp4mri4vqy5aEyWQucLv448iTRG4v9ECpQucSTurw0gf
   RJyOL3vvRIaKq6hV2Ka8M3Q75HjZsIqhPcBS2Me7QiYexTpQHJGxX6OXm
   A7zlBAWeiNgBwQiS+bQP8a3vRcwsI/wjHTQBVo+3p8GiLlqdmKpoSHNja
   nazrpE0IsRB69NO950MufoiA1itIWYs1UsTSB8TAMwoCj/PRgvjFCb8lU
   Q==;
X-CSE-ConnectionGUID: QfX7hDP/St6gkzKDSYp37w==
X-CSE-MsgGUID: R7MCYjaeTCm71YpfzQv2lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="68329026"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="68329026"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:07:18 -0800
X-CSE-ConnectionGUID: XX7p6iXzQQOIP29BUb4Hzw==
X-CSE-MsgGUID: 3Oj9RXTERU6inJnwsHsX5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="195861947"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.233]) ([10.125.109.233])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 07:07:17 -0800
Message-ID: <cd3a11f8-88a1-4c9e-9ebe-2675bb292c93@intel.com>
Date: Thu, 20 Nov 2025 08:07:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Interest in contributing to the CXL community
To: Arvind Nanjundaswamy <nanjundaswamy.arvind@gmail.com>,
 linux-cxl@vger.kernel.org
References: <CAK8XrEWTauMKpWpuzfnpxGuY3gbr8EuuoAgaHm+awyhZnZ3EiQ@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <CAK8XrEWTauMKpWpuzfnpxGuY3gbr8EuuoAgaHm+awyhZnZ3EiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/20/25 5:04 AM, Arvind Nanjundaswamy wrote:
> Hello All,
> 
> I'm Aravind, ex-HP-UX kernel developer and have worked in virtual
> memory solutions during 2002 - 2010. I have a decent understanding of
> system architecture and its programming aspects related to VM. I have
> worked on ccNUMA extensions, memory Online/offline solutions and
> enabling largepage support.
> 
> I have ventured elsewhere since 2010 and want to get back to VM
> development, especially about CXL implications on VM operations.
> 
> I'm open to taking up small beginner-friendly patches since this is my
> first time contributing to the community. I'm looking for mentors who
> can help me through the process.
> 
> Kindly help.
> 
> Thank you,
> Aravind Nanjundaswamy
> 

You should just start contributing on topics of interest and we can go from there. Also take a look at the maturity map [1] and see what areas need work. And if you are new to Linux patch submission, please take a look at this [2] doc.

[1]: https://docs.kernel.org/driver-api/cxl/maturity-map.html
[2]: https://www.kernel.org/doc/html/v5.17/process/submitting-patches.html

