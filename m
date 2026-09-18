Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0233D512
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746094; cv=none; b=dcIoLPZU0QU79Upq3QwPrbG7o4sgodOVdELInmrnWfrLoS0+HZ+PPNmFZg/HJq56tNvf7aloykdiAsU5II55pQoS1hN/58jozm4g/v/SXKzhbXql7UZElU/6s7sXCEPAl4VGo7PeYennbgOWOtV9M9+emRYw2tMFLBdKohBVhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746094; c=relaxed/simple;
	bh=BXc40hl8edIGQaTrGuBV+UxPmykecZKhCMsV7XlBK40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7IgeNxVqSgWg87ENojOYbYIrbi2btxyCNPJmQWMi/hofCZxY8tJb7xVouhx9GoQHmzJNtERNumBWLRY5BYQ6qZPEhFGaTa3kTqs+aBxCIvzwciJHKZCZOm3up0I9MiUBydvcnRuW8Feu/aqKWs0QiO0gwIqjSog4mF4bquioVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bt2vW3Mg; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bt2vW3Mg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789746092; x=1821282092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BXc40hl8edIGQaTrGuBV+UxPmykecZKhCMsV7XlBK40=;
  b=Bt2vW3Mgo9rJZtg7k/NhP/GKsFmUdoX+Qd3wVl7nvZwK0OF1Yr27e5aI
   fbJA+ISdJjIo3fKhzN3nz6YQjm8r4oED0NfxMGXHcLp1rp2Ahpfh1D5x4
   qWWx9cLRe2zQXDq6+dUOEwhoBH52XGPhJQ/2ZeTvMUAxClfCT5YQBHdd+
   lDbnt3IMd0QSQxJmp1ORHDaasnY5aLCRRuPsT04xooLT8zFGeZQElwKXE
   MvoHFGo8Im27odWq47ciSOjZE1mNL5lt8lwAJFMhj6AJ/50uztjybhHl2
   p22ld7qwC7WPObp1bxfU9uxfAW0AXmsLnFoSgLudHPu0WHhesqaQtHTO9
   g==;
X-CSE-ConnectionGUID: YmFXs0TzRry9qzUie35v/Q==
X-CSE-MsgGUID: MJuWlxbXT2yafb0a/qP8CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="759913"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="759913"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:41:31 -0700
X-CSE-ConnectionGUID: jnBzmdoDQCWXTFiWfBGUrQ==
X-CSE-MsgGUID: qy5V2QRgRt2AKheTfBAc0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="297908925"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 08:41:31 -0700
Message-ID: <c2792074-d37d-49e4-979a-335dc4240502@intel.com>
Date: Fri, 18 Sep 2026 08:41:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Skip einj_inject creation when
 devm_add_action_or_reset() fails
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260915060138.2007974-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260915060138.2007974-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/14/26 11:01 PM, Guixin Liu wrote:
> cxl_debugfs_create_dport_dir() ignores the devm_add_action_or_reset()
> result and creates the einj_inject file below @dir unconditionally.
> 
> When the devres allocation fails, remove_debugfs() has already run
> before devm_add_action_or_reset() returns, i.e. debugfs_remove() has
> released @dir. The subsequent debugfs_create_file() would then use
> that dentry as its parent although its final reference was dropped in
> the removal and its memory is subject to call_rcu() delayed freeing.
> 
> Skip the file creation in that case, consistent with how the rest of
> the helper tolerates debugfs failures.
> 
> Fixes: 9185b1a3043c ("cxl/core: Fix dport use-after-free via the einj_inject debugfs file")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Applied to cxl/next:
b25af6afd2f2

> ---
>  drivers/cxl/core/port.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 8d715739995b..95c0be57ed53 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -837,7 +837,8 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>  
>  	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
>  
> -	devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir);
> +	if (devm_add_action_or_reset(dport_to_host(dport), remove_debugfs, dir))
> +		return;
>  
>  	debugfs_create_file("einj_inject", 0200, dir, dport,
>  			    &cxl_einj_inject_fops);

