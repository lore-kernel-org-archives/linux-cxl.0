Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187175FDA7;
	Fri, 22 Nov 2024 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732248879; cv=none; b=BOmPWCnjB5EQU4WrEur1Kh11aa2XblZOoDroHAWCxDN2CAf60g/3u6l5DQbO66uuhH9KmwKHrh9l1sZJv7ihrMF7R9ZNaw7Aa3dWyfUKcc17H3L0m9fydkE8PnX24RuaneKlwhFeZhCwPDWiIf4W8OgOnMbY8R+yGQH0IqYHeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732248879; c=relaxed/simple;
	bh=smySI+BdEC2vzepGUTO2YSU1TF3UuQDU90O6JCQKLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR4wOaXZyASALvmY+MKOHizBF7iwhhIXyPNBx3A91Ps86Pi74gDy3ZMJDVC+aZ1NA8wCzwXG7qAtLlMXyyVlabYI7G7gxIXSLg/S7tCoFnnMvjz7GsWqjtoqT0mK/spf9DkexgYEr/6o39ZGzpOf9feqqg0CZhToYIZz8GouNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDVn67qY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDVn67qY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732248877; x=1763784877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=smySI+BdEC2vzepGUTO2YSU1TF3UuQDU90O6JCQKLGg=;
  b=kDVn67qYI2UwL3YiFOIYRJ0l+NhYDpq0xGZPhcY4jsvIEro5e4xvQ3+n
   KcPZZYeU8ASy8BchfpxOI/IUDbkcd0eckUtnsmpQdYrAqJiwjKK2Or0k1
   1pdXCf05Snw7pps0HW4/8oZ+Pno6fZXYc6P++gVk+ZuTm4esncisH08Xe
   AyoKUcWnVzOJO9tke1bKiyEMDPDEdXrm9xXoWQCe/MY7saMaYOoUJIjIp
   wHzaAcGNRiSpOVn6Z8TcN5dghsVEB8Y86Prt6/d5dqnR3igOr5efXNrmg
   uLQLp7d6yeyQcvDLpEUPUD8nKVZ0HKuv4k6PzyDSittVtXWyyB59284XH
   w==;
X-CSE-ConnectionGUID: l/WC/ErgQneQ8+8nyQDmMA==
X-CSE-MsgGUID: +WDcDoELQEehdvG0oXxsxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32451420"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="32451420"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 20:14:36 -0800
X-CSE-ConnectionGUID: iQD20e/oR5uNrXfdvDEWHQ==
X-CSE-MsgGUID: kjiaJzk8QOyq3Msa7lbrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="121330368"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.38])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 20:14:36 -0800
Date: Thu, 21 Nov 2024 20:14:34 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dan.j.williams@intel.com,
	martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH v5 00/27] cxl: add type2 device basic support
Message-ID: <Z0AFKglNSHCw7BEn@aschofie-mobl2.lan>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <Zz6qFaLNs0XmdhMw@aschofie-mobl2.lan>
 <cbaefe66-a5de-47bb-a0ca-ff96fb4a5077@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbaefe66-a5de-47bb-a0ca-ff96fb4a5077@amd.com>

On Thu, Nov 21, 2024 at 09:27:34AM +0000, Alejandro Lucero Palau wrote:
> 
> On 11/21/24 03:33, Alison Schofield wrote:
> > On Mon, Nov 18, 2024 at 04:44:07PM +0000, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
> > > 
> > > v5 changes:
> > Hi Alejandro -
> 
> 
> Hi Allison,
> 
> 
> > What is the base commit for this set?  (I'm trying to apply it)
> 
> 
> I'm not using the CXL tree but Linus one, and using 6.12-rc7
> 
That would've been my next guess ;)

I applied w the intent of trying cxl-test but was not able to
build image including the cxl-test module because of a circular dependency:
cxl_core -> cxl_mock -> cxl_core

That happens at Patch 1. I'll comment a bit there...

-- Alison

> 
> > In future revs please include the base commit. I typically get it
> > by setting the upstream branch and then doing --base="auto" when
> > formatting the patches.
> 
> 
> Apologies for the inconveniences. I'll do so for v6, which will use 6.13
> 
> Thanks
> 
> 
> > 
> > Thanks!
> > Alison
> > 
> > ..snip
> > 
> > > 
