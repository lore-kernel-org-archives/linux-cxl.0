Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8B3D333B;
	Thu,  1 Oct 2026 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886711; cv=none; b=u5zqSo2l/LIplgGYZ6c72gS3r7R0cE5RSjcjKtm2quDPqhmg/t8YSVhqkLZPLIMcpU23rJ7O9xH4yumqfvvtDiJfwyksVOM/v+We7WypLc5GIfQHXROi44KYwVslrB1DampVcT8rjEBJ/ZrOz3uToEU78FRpExY9Y2MyZXwwe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886711; c=relaxed/simple;
	bh=4s/gJcgoZvyPCX2D7wtKHquIiLK9UfjRj6xgW5iHeHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVxEgQ1A7KWTDLk2O10TM8c3NxufN7KBl7rb86lRva5CbmeR5ogUajhLGH1yux7G3WhL6vf+93fjiF1J5peUIKhTLnjZP+r/r1idvwJ3XY4ecY2THYqj1c3ImZUpQQ3OcQ/N8MUjKYHQNKfU9F14ap7vwbkTdtxKqGilE/2R+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LM3SASvV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LM3SASvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790886709; x=1822422709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4s/gJcgoZvyPCX2D7wtKHquIiLK9UfjRj6xgW5iHeHs=;
  b=LM3SASvVRRT7O0AzsdPP5ZhfZtmSPx7qwpHpL7Ue5GejEfHtJ9L0P4Vo
   EHD3GliUMqrcPUPdRo/NpLXXV61v5XPgGHun1JUnhkbBf6I/zB6h6i7Bw
   whdIHA9E7x46ow4aM8KAq/nxD0d6c/gvp8QScirGbgEjlJYYMzFCo9fBL
   tb6sCkNJDWuh5YqcMsZrAtN+0tB2rB8ISL9fObAsJaCnCR7ZagjNTocL/
   qdDlo5phznizfWVN1DBz41TAvhzDriqItqOgfR/37B7a11eAc5+z6VKhD
   llvMYWGnjGh/rKm6XoO52GP8esSzftGmF0kyTntwoWoKGGCkUUATUUq59
   Q==;
X-CSE-ConnectionGUID: peFozmapR7aaN9eOlEVGCg==
X-CSE-MsgGUID: FQKXVxbFS8ScrKqh+W5xGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90689789"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90689789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:31:49 -0700
X-CSE-ConnectionGUID: vLeN4aevQA6H4R2hs2ndrQ==
X-CSE-MsgGUID: qbJXPm1SQOS3eM/SZRztLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="275616583"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 13:31:48 -0700
Message-ID: <9e8a45df-1755-495f-8e80-52c65b832dc9@intel.com>
Date: Thu, 1 Oct 2026 13:31:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] driver core: Check for supplier requiring PM at
 link creation
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-2-alucerop@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001132023.17032-2-alucerop@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 6:20 AM, alucerop@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> PM initialization could not be necessary for some devices.
> 
> Avoid checking for supplier PM initialization if so.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4c0c373998a1..bf0513beafad 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -840,7 +840,7 @@ struct device_link *device_link_add(struct device *consumer,
>  	 * SYNC_STATE_ONLY link, we don't check for reverse dependencies
>  	 * because it only affects sync_state() callbacks.
>  	 */
> -	if (!device_pm_initialized(supplier)
> +	if ((!device_pm_not_required(supplier) && !device_pm_initialized(supplier))
>  	    || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
>  		  device_is_dependent(consumer, supplier))) {
>  		link = NULL;

A no PM supplier can now be linked at any point: before device_add(), while it fails, or after device_del(). Maybe replace with a helper like this?

static bool device_link_supplier_ready(struct device *supplier)
{
      /* no PM devices never enter dpm_list, so check registration directly */
      if (device_pm_not_required(supplier))
              return device_is_registered(supplier);

      return device_pm_initialized(supplier);
}

...

      if (!device_link_supplier_ready(supplier) ||
          (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
           device_is_dependent(consumer, supplier))) {
              link = NULL;
              goto out;
      }

