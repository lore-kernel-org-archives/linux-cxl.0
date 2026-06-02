Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C383033DE
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417216; cv=none; b=J50jAQYcGHB+yMNg/S64ECHlqjCGB8ixN4obwdvFdzLvsOY/FuqwIQJUSOQwvqPwmuJQffTc/BJ466+21j8xEFo9OuBeQbMKU3PfbHEi7rGjypH51jC+mFn3KL/tFOJ2cljsyHV/514X2qWo3N9xTbsUlSDUqCvl9CCLh0NLd4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417216; c=relaxed/simple;
	bh=mHmflXwuLEdSrh7dPnPIBJ7HReleEwBfQC9ZPT0VK0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1dom+WWG/ErqvQ3MDPFLzV+wu2ZJ6YSLrxqQGd0iHXfPFDdxQy6P4yWfzW1f5fcsXbQmeIbytgNxHWTfzs0hgI45ve/sD25ATDIDn1/qQaMgIqswPuBvktmCGOD9v8fTydd3XxGz9H/DPJZRugqbSFb3F9nK04/K1A5nDjyPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6K3oNzR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6K3oNzR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780417215; x=1811953215;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mHmflXwuLEdSrh7dPnPIBJ7HReleEwBfQC9ZPT0VK0c=;
  b=G6K3oNzRzfg8LvJJzq8BkJuJ79dNxl49YDBitP94F1ZyNeaBjE410fqD
   LgFNRle9ngk2iBCYX0MX2dffyve1uy72xkYA9bWxtubZ/39A+eVXg/By4
   0CnllSpBSJWgfEeloZTUmCZ3U6nESaeyK6fMBndVNXkE0p/c33hTTPN7W
   fUELDr0pTbmDjuPHLFXVbSZOTJoMGC3OVXZ0Y0SY7ys/vPqOZozVWhM1q
   Q0WKym5Q2qNi4Ne1JWCtmqovX9c9MFHjlq3EIZDDcmtVLSrJIoX8rWouj
   MMFmAjdzKyWLledA4AYwXf4/KhBP1ZDFoCAa5fsTFNdnSGKZ6EkSBcaBC
   g==;
X-CSE-ConnectionGUID: W/gV2TYxTeWIK0ytHPILCg==
X-CSE-MsgGUID: 2/OWENKWQpWmbB9hl9eWnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80350349"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80350349"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 09:20:15 -0700
X-CSE-ConnectionGUID: 5Lfxn24YRlmJD+H5lK4W7w==
X-CSE-MsgGUID: ZlhsmGabRBek9d4AbR3haQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="282064804"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.56]) ([10.125.108.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 09:20:14 -0700
Message-ID: <bbfc1e4b-5eaa-43d1-b804-9259b711160b@intel.com>
Date: Tue, 2 Jun 2026 09:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl: fortify string fixups
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
References: <20260519221204.1517773-1-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519221204.1517773-1-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 3:12 PM, Dan Williams wrote:
> It seems nobody is running cxl_test with CONFIG_FORTIFY_SOURCE=y. A
> couple instances of __fortify_panic can be triggered.
> 
> Move some counted_by initialization before associated buffer /
> object-array access so that it does not falsely assume a buffer overflow
> is occurring.
> 
> Dan Williams (2):
>   cxl/fwctl: Fix __fortify_panic
>   cxl/test: Fix __fortify_panic
> 
>  drivers/cxl/core/features.c            | 2 +-
>  tools/testing/cxl/test/cxl_translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8

Applied to cxl/next with commit 2 commit log fixed up.

b882b0ca9bf8
5c00984479bb

