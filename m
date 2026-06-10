Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A202E62B4
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111862; cv=none; b=j3i0z3wnjDB9LqCdIfBZKTQ2cdGhaBYHBV88w6mKRe4K+154BekJyjzc+7MPsqKsJNy+MH2wBCXsUrt132JmFR3sKGDuADI0E7nNb1mNEoLI26TOaDO776XZZZadGhvMVEj1nxqYRx4ODMIpfelg3HsaKIvo6GJVmi6F2vLRobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111862; c=relaxed/simple;
	bh=0tvmtdJpyvJPjZ5aYF+wKO2h0SF5JVGw6daHxeGwjII=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y/ITKZOg76UpEQ5LWIvTmnIPsK8fAuZ/L/8sP46hYUlR8icfEwRY53A/h1WmG8LRj3w6mFA+iAmW4b4eXHf2VirNjNTxhK/L6Ev8RYszggCL0ZjgltkwZTLWJ2XMB97CHEvxFYyxedOMmm6kDymfR38WzxqDFmqTRpe82fXjPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nv3p7UQa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nv3p7UQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781111861; x=1812647861;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0tvmtdJpyvJPjZ5aYF+wKO2h0SF5JVGw6daHxeGwjII=;
  b=Nv3p7UQa5/1nO4FftPJ/y52BaFVe0J7dFB9p9fFINv2u+loQPxiPVx2c
   SmikPf0fWlIoEePUcOnbkyDqo8xxk6Te8Wc2zKtqT4ret0JBMhdoF5gTa
   Dr/5IWtkEcWhYUhgJkBSl4sa3LgT1AAouiU9InoMRePT2CYP5aUzSz2tB
   LahHnPo4xBtfW97AnoocHtRNfFC0PKTTM3TvTpYLIx++3LhmZTtV4SR6Q
   ZDIrFioDXdb/FBheYnrp1O+2+iuCY8UWfjINFiy/I5nhrXiPpBmo6zZ3P
   jS+tW4O5cmXYz2A9UwpSFOU8x12c7b7Eqp1EU4FMXesLQT2rKl1GidsEw
   Q==;
X-CSE-ConnectionGUID: BRWil5qbTQCSCXgzZQydsw==
X-CSE-MsgGUID: +LH4Ur0qS/ezMsznU+M/Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99491271"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="99491271"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:17:40 -0700
X-CSE-ConnectionGUID: TQXgyj0STNmmgAn/ZPXvLg==
X-CSE-MsgGUID: V53raZ1ESkOjOLyJq5qHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="246088414"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.25]) ([10.125.110.25])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:17:40 -0700
Message-ID: <5d745f35-af3c-4b85-9377-39bbd7d858f2@intel.com>
Date: Wed, 10 Jun 2026 10:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Zero out LSA backing memory to avoid leaking to
 user
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 djbw@kernel.org
References: <20260605184426.4070913-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260605184426.4070913-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 11:44 AM, Dave Jiang wrote:
> Memory through vmalloc() is not zeroed out. When this memory is copied
> into output payload, it leaks memory content to user. Use vzalloc()
> instead to zero out the memory.
> 
> Suggested-by: sashiko-bot
> Link: https://lore.kernel.org/linux-cxl/20260605173146.2B9A31F00893@smtp.kernel.org/
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
b6d9860c11b8f3331c08f650ccf5ff24c61745e2

> ---
>  tools/testing/cxl/test/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9a7cd3f46a1e..739343cd5802 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1724,7 +1724,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	dev_set_drvdata(dev, mdata);
>  
> -	mdata->lsa = vmalloc(LSA_SIZE);
> +	mdata->lsa = vzalloc(LSA_SIZE);
>  	if (!mdata->lsa)
>  		return -ENOMEM;
>  	mdata->fw = vmalloc(FW_SIZE);
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> prerequisite-patch-id: a09fa1bd37ae9ee663117e196f1b8c49c55365e4
> prerequisite-patch-id: 75202ea281daa3b091090369ada6eabcaefc6671

