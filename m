Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814F47F6A
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216976; cv=none; b=iJ+smtCxW89nxfbx/CCgPX1eCcYPMqxJwGnLGe7mxkubtEwhlCaPk0Rl6x0I2DtVx47dvs8pHed8MbgphDkec97SCXv/R/sNa+LSbfK/Ug5g4SwzRcSaXVgmuAG3MnoFt+IBgHEqvAYAvN5ojLYd1FcdkJlg+FjFKkBRAmmLSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216976; c=relaxed/simple;
	bh=oKb41GYKfrLnqEe5UgPnXyUak8pJuc+TUCVitnq9tqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Trh3E9EqxBUOL8k7Keu7dstUuefg1qN7vhwUP4sdm0aRtFniL84ErCDZ+3ITtTcVqazG56PClEnaOzO/j3ojwUOx0HhbdMXsEh3Ymkte0Hx3dGqhM93zUAZ1IGLfSWaN/R6qTW6iNFxYF9TvDd347d/YO3y0+oLnRVKS0ED67wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbYxCYbQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbYxCYbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718216975; x=1749752975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKb41GYKfrLnqEe5UgPnXyUak8pJuc+TUCVitnq9tqQ=;
  b=IbYxCYbQOXNLMErLG6I/qAJDteyhGz18wYuroagkDHgqDTwF6E+2/Wka
   8TaQ4EHcXgqN02e+d1cHaz+P0ECABsHywNOpNO3LFiDXc3Kg2LtpofFSA
   RuEFzR3Um4LaqtCBkPRb2cVvUe8odJd4cb/qKEddKAKT9NoKrYalTyc2m
   Ih266lXb3X1zkrdByceSbmY2anQ05a+H51WOwprQEhk94PHuOhLYWgoYf
   5qb48oysMla3I3DLN1ZVZ0+YgCbzvQx/4KpWMDLU5rso9f309++qsNF5+
   U4iYAc6lPxdzHT47CpIVdNIMo9oIkJTj80E+NsTtiL8Gt7PcGk7C3TPim
   A==;
X-CSE-ConnectionGUID: s7runxmjS4eHM34QGk9mkg==
X-CSE-MsgGUID: eLbos6kPTy+26AQyGoOUig==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26401978"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="26401978"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:29:35 -0700
X-CSE-ConnectionGUID: GFKYvJ32TnKbvcuZMW8TLA==
X-CSE-MsgGUID: E6A0iZaOQW2NVqQvF/XFgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44817925"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 11:29:34 -0700
Date: Wed, 12 Jun 2024 11:29:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: alucerop@amd.com, linux-cxl@vger.kernel.org,
	pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
	dinan.gunawardena@amd.com
Subject: Re: [RFC PATCH 02/13] cxl: add type2 device basic support
Message-ID: <ZmnpDD94rMsfkOQs@aschofie-mobl2>
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-3-alucerop@amd.com>
 <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6669278d7fea_3101294e7@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Jun 11, 2024 at 09:43:57PM -0700, Dan Williams wrote:
> alucerop@ wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Differientiating Type3, aka memory expanders, from Type2, aka device
> 
> s/Differientiating/Differentiating/
> 
> ...actually to make this imperative tense don't use gerund phrases, so:
> 
> s/Differentiating/Differentiate/
> 
> This "imperative tense" preference is borrowed from the x86 tip tree
> patch recommendations [1], which reminds me that CXL should create a
> document like that to make the grammar expectations known.
> 
> [1]: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> 

Hi Dan,

Imperative tense is the default expectation thoughout the kernel, so
'we' in CXL don't need to create any special rules around that.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

-- Alison
> 
