Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967913B298
	for <linux-cxl@vger.kernel.org>; Tue, 29 Jul 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802061; cv=none; b=HEY1/rRzsXdOO6k0y62Gmz+ouhPGypiEA+OQvDmTuRHJnNcDN3Vb0oJOYL/wWI/EwZ85b8DFy9uWI5X/HO87dwi9ngShioL+coW5NCtsZLDF+5IhxpZTXVlzx+ILbh4+cshJGNqsQaooSa9lD7IoNpWw4C9FWZxo+9ycaiqLhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802061; c=relaxed/simple;
	bh=BUEESWeE6xLm5I64Xq3gmJuj//dqBzAN5GflIxxD3RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xh5Faz9W3JzJ6bOZy6sZABaqk6MR5OS/TVk/zHHbPVkODGM0HfdHlPJ8BnEtP2jorYyCzDfPhiUvsgnseSqhkCyGdd8zlfj39qYGkNOC1FGk7+14juerCLID+rQupNjpRwQN15mANj1Vt2YSoR9Ptev11+IRqQAmm3ylEMROdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lijwcD5s; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lijwcD5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753802058; x=1785338058;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=BUEESWeE6xLm5I64Xq3gmJuj//dqBzAN5GflIxxD3RE=;
  b=lijwcD5slpWqk8p9HlINWzoRIogxbrm+tA/mVPOamApXxYWDNImQ+cxL
   YXs+cbo5OCI6ZFYVieQUCaUzIIRkND4IIhNxBIn/mdC1eGWUlovsBj64j
   DCma8/Nk79LjTkMLRPfXYG1+71LBRGBpsCCpxCFhXjip1V+3Mpr9lVcmL
   M4s1eOIW7uCVp52TJ8gZW9au19taVHODtzYdFme4PvkMTgFm/42v0s7B9
   BbLlWhMIsgoM7D5REnY6rxCNt1SXMLDmSg1NRSeQjyl+5lM3V4Mwyn6CP
   vTmN5EUZ5EZpejmWvpmi9D06SoTNL74sVSvv0td4Kt1A/Z/jUyXcGRI8W
   A==;
X-CSE-ConnectionGUID: 0OK5PqpbTYm+kQKCTr0c6w==
X-CSE-MsgGUID: gFd0WWnXTCCuIFkF+UemZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="43680243"
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="43680243"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:14:18 -0700
X-CSE-ConnectionGUID: CII+nkzyTYC34tXuviE06A==
X-CSE-MsgGUID: 3gPCP+04RVuY5mnXIqXunw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,349,1744095600"; 
   d="scan'208";a="162611163"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.118.247]) ([10.247.118.247])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 08:14:15 -0700
Message-ID: <c797ab06-2e83-48b4-9e0e-852323ff13e8@intel.com>
Date: Tue, 29 Jul 2025 08:14:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH 1/3] test/common: add missing quotes
To: marc.herbert@linux.intel.com, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, alison.schofield@intel.com, dan.j.williams@intel.com
References: <20250724221323.365191-1-marc.herbert@linux.intel.com>
 <20250724221323.365191-2-marc.herbert@linux.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724221323.365191-2-marc.herbert@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 3:00 PM, marc.herbert@linux.intel.com wrote:
> From: Marc Herbert <marc.herbert@linux.intel.com>
> 
> This makes shellcheck much happier and its output readable and usable.

Probably should mention what exactly you are changing.

> 
> Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  test/common | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/test/common b/test/common
> index 75ff1a6e12be..2d8422f26436 100644
> --- a/test/common
> +++ b/test/common
> @@ -4,7 +4,7 @@
>  # Global variables
>  
>  # NDCTL
> -if [ -z $NDCTL ]; then
> +if [ -z "$NDCTL" ]; then
>  	if [ -f "../ndctl/ndctl" ] && [ -x "../ndctl/ndctl" ]; then
>  		export NDCTL=../ndctl/ndctl
>  	elif [ -f "./ndctl/ndctl" ] && [ -x "./ndctl/ndctl" ]; then
> @@ -16,7 +16,7 @@ if [ -z $NDCTL ]; then
>  fi
>  
>  # DAXCTL
> -if [ -z $DAXCTL ]; then
> +if [ -z "$DAXCTL" ]; then
>  	if [ -f "../daxctl/daxctl" ] && [ -x "../daxctl/daxctl" ]; then
>  		export DAXCTL=../daxctl/daxctl
>  	elif [ -f "./daxctl/daxctl" ] && [ -x "./daxctl/daxctl" ]; then
> @@ -28,7 +28,7 @@ if [ -z $DAXCTL ]; then
>  fi
>  
>  # CXL
> -if [ -z $CXL ]; then
> +if [ -z "$CXL" ]; then
>  	if [ -f "../cxl/cxl" ] && [ -x "../cxl/cxl" ]; then
>  		export CXL=../cxl/cxl
>  	elif [ -f "./cxl/cxl" ] && [ -x "./cxl/cxl" ]; then
> @@ -39,7 +39,7 @@ if [ -z $CXL ]; then
>  	fi
>  fi
>  
> -if [ -z $TEST_PATH ]; then
> +if [ -z "$TEST_PATH" ]; then
>  	export TEST_PATH=.
>  fi
>  
> @@ -103,7 +103,7 @@ check_min_kver()
>  #
>  do_skip()
>  {
> -	echo kernel $(uname -r): $1
> +	echo kernel "$(uname -r)": "$1"
>  	exit 77
>  }
>  
> @@ -147,7 +147,7 @@ check_dmesg()
>  	# validate no WARN or lockdep report during the run
>  	sleep 1
>  	log=$(journalctl -r -k --since "-$((SECONDS+1))s")
> -	grep -q "Call Trace" <<< $log && err $1
> +	grep -q "Call Trace" <<< "$log" && err "$1"
>  	true
>  }
>  

