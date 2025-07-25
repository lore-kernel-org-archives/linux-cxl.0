Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BB2EF9D6;
	Fri, 25 Jul 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464507; cv=none; b=D9Yk6nj6+I0NUDE+qrG7dYPHQINi6UbxQiEHoxxgWsx4NsMzPUUun99Yv4LpYa6R9p3s447j64QTfEjucsXgnfp1Lb+Lta7SyuyFuvakcrNEcP0MxgSNOZaCduX6pcg5qvJNGTKmkvg0RhtDHj3LSuecdxoG7DWCWZZL7hbIxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464507; c=relaxed/simple;
	bh=feXgilG/ggjMCLsfTaEvMyNkjo00TFhT9KPuFkC+9U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpgkBML+8f9UIkyfhKjqzNlSzWp62acOJXlbhlOxIiWY69b7SmkqLsgAiC/Wr1bnWOr6E6P/IYAubgog2AFPWz0r3aeNjvrX6UMADuLwKB4EebAxBVS8ckb6zkZUy+H51iYEIIAWv0tI9UJCEoFUN+REuY8AdM9y3PzP+0k81nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCjS9YpJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCjS9YpJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753464507; x=1785000507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=feXgilG/ggjMCLsfTaEvMyNkjo00TFhT9KPuFkC+9U0=;
  b=DCjS9YpJBjAIbPUeXP+elFBCz0SscQTMrt3yBL5K+vHPDID7FELXtQSB
   9moRR3/Avh8m9Zc/aY1zLbVIknXn9W+wWdcYE0PMX87swleN3+RBJ6eZ1
   ScfploDRAPgqoLbvvJysb6Dt9oXCTSRfoZdio60xb2EpWoGzOw7wzTQzy
   uSEhCYCclN+EJGxKoW1Lf0cjYpgYYFUeQuI5ZoCBWelV9ABD7wsfziufr
   09cpWbmptyTOBlW57SnqOarCj9BIu2Q2t9T373FXkIf3ua0g9HWeh00s+
   fLtQN3eoApU8A2fzYVA8TmZX+2uZj9r3cC70YCIbxFZVKdCT1p6cLTuC7
   A==;
X-CSE-ConnectionGUID: XAFZ/OYcT3+/o49pqNMXuw==
X-CSE-MsgGUID: cUIpGMJ6TRaQhlkDc3x8qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="55955243"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55955243"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 10:28:26 -0700
X-CSE-ConnectionGUID: wAocdJGmSECSJh+e6z8X4A==
X-CSE-MsgGUID: EsFNZlTJS2uoOYRzRUhAeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="161354188"
Received: from bvivekan-mobl1.gar.corp.intel.com (HELO [10.247.118.216]) ([10.247.118.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 10:28:23 -0700
Message-ID: <da9b15a5-ca1d-468d-9460-bb64b3b39c42@intel.com>
Date: Fri, 25 Jul 2025 10:28:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/ABI/testing/debugfs-cxl: Add 'cxl' to
 clear_poison path
To: alison.schofield@intel.com, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
References: <20250724224308.2101255-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250724224308.2101255-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/25 3:43 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> 'cxl' is missing from the path to the clear_poison attribute. Add it.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next

> ---
>  Documentation/ABI/testing/debugfs-cxl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
> index 12488c14be64..e95e21f131e9 100644
> --- a/Documentation/ABI/testing/debugfs-cxl
> +++ b/Documentation/ABI/testing/debugfs-cxl
> @@ -20,7 +20,7 @@ Description:
>  		visible for devices supporting the capability.
>  
>  
> -What:		/sys/kernel/debug/memX/clear_poison
> +What:		/sys/kernel/debug/cxl/memX/clear_poison
>  Date:		April, 2023
>  KernelVersion:	v6.4
>  Contact:	linux-cxl@vger.kernel.org
> 
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41

