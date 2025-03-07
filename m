Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3291448E0
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366133; cv=none; b=uTqIvWSc4p7HpPtEvpZteLV1Yda6IWJSYIikgN9T0ePksivaBFatNNEOVv34ATmpTMsL/CkzYF+ugNlG5bJB00qU5wzAIOkHKGdhA1nxRPmpVEPM5resYfbkuoJzbXzshcyPCGPuVop46GnECLECAfyZ/1LN/wWNRgnu5tyJ/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366133; c=relaxed/simple;
	bh=3n2tFHtsGDdAg/ZLU1qhRdO6FsuQIMsXUIesozpy+9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJeDu2BPbMVvb3Q/zEyvJ3MARjSQA2jJ9kgWi7n6cZ1WWw/cDEMgDqPFcM3vhMsNbjzyV+23ZnVD5cMBnfIKekbrlOU6o5Pq4CctMQUUbpqR1ZrjtdckkoZYLSrApQEEUyEboEkiyqWNWn1RqEk6qUtJVJOjEX9BlDwt8J9WnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivsZQX9X; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivsZQX9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741366132; x=1772902132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3n2tFHtsGDdAg/ZLU1qhRdO6FsuQIMsXUIesozpy+9s=;
  b=ivsZQX9Xbf16ASFZOn8JgCMguxbHVhribjl6J0esWtwQGIgP8kF9fbT+
   0XoFbXv3Q0aKRUQVaUEu5xBDxgYz49NoCItclMpPpPawSpeaRWnjPrEJY
   jlYzDRkHMthRZYlQIUFidF5yqJkzEauGTcjuavUX5QZ0fklwswhVnmkh6
   vjp8che4Vg/Ze9QMMKT6S0Jiar+PiRNzkT786regleVfB91mx3j6QzdW1
   t66Goxl3iTkrUZ0FgQ6nUyJP4ITqFPW/Y/6IfLMgVYu0HxC2sYU/JBE9p
   r9IOhFPMDRlUovMSxE5IOaRc9MGCDJLRzyJRDK7zFWwOnQrCpvu4HKEUZ
   A==;
X-CSE-ConnectionGUID: 5hG/ddaRTvOboWQ2KyiKaQ==
X-CSE-MsgGUID: /fQLm+MKQ5G2Jm9Sj5szrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42455861"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42455861"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:48:01 -0800
X-CSE-ConnectionGUID: kQrTrKPXTuGW0ZrSyK9IeQ==
X-CSE-MsgGUID: R3le9pqxQ9G5toaDblgkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119358847"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:48:01 -0800
Date: Fri, 7 Mar 2025 08:47:58 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "Fontenot, Nathan" <nafonten@amd.com>,
	David Hildenbrand <david@redhat.com>, Fan Ni <nifan.cxl@gmail.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH v2 1/4] kernel/resource: Introduce managed SOFT RESERVED
 resources
Message-ID: <Z8sjPkLpcmM8G93K@aschofie-mobl2.lan>
References: <cover.1737046620.git.nathan.fontenot@amd.com>
 <1800b17449d1c231292c85f59b226aff39a81552.1737046620.git.nathan.fontenot@amd.com>
 <4e556200-c790-4e0a-b103-2a1529c81927@redhat.com>
 <3c7c5b87-f241-482b-9b00-98e2e53d8e9c@amd.com>
 <Z5CKN57paDmGJH9A@gpd>
 <5067fda1-c2de-4a20-9025-ebdf90ebba8e@amd.com>
 <9b0fa1f7-4133-4111-9142-143c36c42f8d@redhat.com>
 <69701a1b-8cec-42e5-90dd-1b1c67c91823@amd.com>
 <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f46e35-c3a8-42f1-ba30-b7c43d2bdd89@fujitsu.com>

On Fri, Mar 07, 2025 at 05:56:25AM +0000, Zhijian Li (Fujitsu) wrote:
> Hello Fontenot,
> 
> I hope this email finds you well.
> 
> Thank you very much for this patch. We've encountered the same issue in our product,
> and your patch works.
> 
> We do hope this issue will be resolved in the upstream kernel soon.
> 

snip

> 
> 
> I noticed your earlier discussions about designing a new approach to solve this problem,
> which I'm pretty excited about. Do you have any idea when you might post the updated
> version? We'd love to help out with reviewing and testing..
> 
> If you run into any roadblocks and need a hand, just let us know. we'd be delighted to help.
> 
> As far as I know, this issue usually arises on Real CXL machines, but for ease of testing
> and validation, we modified QEMU to simulate the intersection of 'Soft Reserved' and
> the CXL region, which would aid in verification.

Hi Zhijian,

Wow - I want that! Can you share that QEMU branch?  With QEMU cmdline too.

Thanks :)
Alison
> 
> 
> Thanks
> Zhijian
