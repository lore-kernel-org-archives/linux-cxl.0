Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377749550D
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jul 2026 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047892; cv=none; b=oBc3prJE0Znr1tAVWJlL8EpHCgxwi5B//au/f+tHSfjrt09vLjaFV08jeXZmwUYJcl0PDnaDQMLx2uta3CALlXdLGIBLis65SFf+a+ozmelLLU28uQiYIDCOH6qrYs2yDPgEAYBa7V4J9OeFsEfHvJIJuE27FGo7WSo+c5hhQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047892; c=relaxed/simple;
	bh=d74L1mmWwjnAMMz+nvfmmN52eZ1DPCJcwWj96DFgW8o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltqbsqdoAvEgvBKwvK0r12pJTaM/Kq8Yo8fafeXGKIynWb6KvOXnsIYlO2vRIvDy+ssMV7/5Kfk2IU1yLthIKuoLtYzM4IdAD2paqs9Hl2deEXIqDbfgS7cdYvkZFhEr1P76lW1KDuSPSOp7RksUAT0GspQpSKcLODdcdhn+CgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNTam7k0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNTam7k0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784047891; x=1815583891;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=d74L1mmWwjnAMMz+nvfmmN52eZ1DPCJcwWj96DFgW8o=;
  b=TNTam7k0+AX0cL7y1AuV/qapfM5BDWR1y3mFnV4dsA+vgpbrxo/rmv8A
   AE6UwAh2YNu0MZzSu/NTHDXIVfZ88rFX8vSPDOYicGvMd4NwfNncx7u/d
   Um5DOVYJYLHxWgWykZCImb9OW2v/4Vu0FEc47d3IykX9eVW4wnUcpqTKX
   lr0B1FoGRtvv6M3u3y/MSxDDJnWqT1ycroSc5Bb3rtzvPpEAOtzaYXjtD
   parLx2Y8WI9NgM7RAJHUUpO/7uHce/IgBLUOk2KSPIXuV22wCnzYAYKoP
   LD1j0wvkrTxTLzR3o5zUhbogPBBemCAG2MFELWvz8sIjD8nA2FCdqSCPR
   w==;
X-CSE-ConnectionGUID: W+GwB+9VQZWaSLQj5SJENQ==
X-CSE-MsgGUID: LszCo0WFQbqiXNlMoW9fHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84794946"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84794946"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:51:30 -0700
X-CSE-ConnectionGUID: Ow4PWdnnS/GmoH8rlahOsQ==
X-CSE-MsgGUID: HH7CAT1HRZm2jJtL1V6CTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="249553463"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:51:30 -0700
Message-ID: <da59ff1d-597a-4e17-aac8-523f28bbe5c7@intel.com>
Date: Tue, 14 Jul 2026 09:51:29 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mbox: Break poison list loop on an empty payload
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260709155714.1893280-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260709155714.1893280-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/26 8:57 AM, Dave Jiang wrote:
> A device that returns count == 0 with CXL_POISON_FLAG_MORE set on every
> iteration never advances nr_records, so the max_errors guard never
> trips and the do/while loops forever while holding poison.mutex. That
> hangs the sysfs-triggered scan thread and blocks all subsequent poison
> operations on the device. The existing "Protect against an uncleared
> _FLAG_MORE" guard was intended to bound a misbehaving device but does
> not cover the count == 0 case.
> 
> Stop the loop on an empty payload so a malfunctioning or malicious
> device cannot wedge the poison scan.
> 
> Link: https://sashiko.dev/#/patchset/20260702090849.47501-1-icheng@nvidia.com?part=3
> Fixes: ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
8b301c4afbce


> ---
>  drivers/cxl/core/mbox.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..c09fae2cae9f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1455,6 +1455,11 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		if (rc)
>  			break;
>  
> +		if (!le16_to_cpu(po->count)) {
> +			dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
> +			break;
> +		}
> +
>  		for (int i = 0; i < le16_to_cpu(po->count); i++)
>  			trace_cxl_poison(cxlmd, cxlr, &po->record[i],
>  					 po->flags, po->overflow_ts,
> 
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda

