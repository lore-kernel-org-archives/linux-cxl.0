Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0524A047
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111831; cv=none; b=m24sNQ4hdIpS+dw7a+iQ4qyDWUgWdv8QhyBtykarHwYlg5W9AVXpxjWwISh0pBaDxa72QXlVicUXRxzok6ow4GQQkS7H26vYRKq7+5rIMcogv1luABpv48kYClv+vAzcvpIj132YH/ujkGO1ugXSPzkABbjVw3Az63Om6FB487E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111831; c=relaxed/simple;
	bh=q3BMoKMggf/VtNptA6Sitygy13Y0cpxUq7wIZ3JReus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjzRcGeo2Qpn56m1j8QlshlljeSQaxleUW9L7+xZeZXq/WNrLbr2b7/i5TX9evOPKg6r3JsvrdBUGtctWcRZsfSjZClYFWGTa4gMJVsE0pYMjnChqTwsEl8NwhB8Mh53T9mXyKFeHnWZgVo8DTTGSHDtoSIcFZnnKSeG37JXhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAJxtP9H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAJxtP9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781111830; x=1812647830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q3BMoKMggf/VtNptA6Sitygy13Y0cpxUq7wIZ3JReus=;
  b=gAJxtP9HPiU87gNjSwdDuGOO2iAyIgwY9cxXrkRRLoqAs48alk1uBo6p
   3tcJPFSByvLiJUPMKz2u0Y+SxG4FdlwxDoAH3+BbvwOWfqAqhmGVAaPWZ
   0K4+SHhU9/ihEy/BKnIh4MRVUhZXsWM29jd/O/KbKlRLgSv+i2SglSTQ8
   LqVQBt9/VFK1rFRvaUeIrEe5HM04546A168cX6vPFym4aUuCJNML9B4LL
   7cDGAc7IMwY5irduGpJcyvX3dDqxXa8ZlB8Fas8yKIGSkXGud66ygDgSk
   FilV4U6TFXlAqOJID2XpUo4xnAVzjbzkPK3LGJOqGfzaQ5KOIMap/0fjO
   g==;
X-CSE-ConnectionGUID: P74BKRD9Rz2Y+GdysGv5cA==
X-CSE-MsgGUID: hPIXZQQ+SCCd0J4/iZSfpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99491174"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="99491174"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:17:09 -0700
X-CSE-ConnectionGUID: 9Tp/DLTAQVaPCTz7p458Lg==
X-CSE-MsgGUID: fB5G25uDTnueQNiRp9gbWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246088197"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.25]) ([10.125.110.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:17:09 -0700
Message-ID: <e1a87053-d582-4e96-88d8-4299d8f0325c@intel.com>
Date: Wed, 10 Jun 2026 10:17:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: update reference to removed
 CONFIG_PROVE_CXL_LOCKING
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>
References: <20260610042101.222349-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260610042101.222349-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/9/26 9:21 PM, Ethan Nelson-Moore wrote:
> A comment in drivers/cxl/port.c refers to CONFIG_PROVE_CXL_LOCKING,
> which was removed in commit 38a34e10768c ("cxl: Drop
> cxl_device_lock()"). That commit switched CXL subsystem locking to
> custom lock classes, which can be validated via the standard
> CONFIG_PROVE_LOCKING option. Update the comment to reflect this.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Applied to cxl/next
f9f82e97d9c5411c2cb3b8338a21be91148ff18b

> ---
>  drivers/cxl/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..99cf77b6b699 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -18,7 +18,7 @@
>   * firmware) are managed in this drivers context. Each driver instance
>   * is responsible for tearing down the driver context of immediate
>   * descendant ports. The locking for this is validated by
> - * CONFIG_PROVE_CXL_LOCKING.
> + * CONFIG_PROVE_LOCKING.
>   *
>   * The primary service this driver provides is presenting APIs to other
>   * drivers to utilize the decoders, and indicating to userspace (via bind

