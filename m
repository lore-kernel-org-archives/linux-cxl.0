Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1818E3A0B0A;
	Wed,  7 Jan 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809311; cv=none; b=WiQTsBSMui2T90M0+zWkUH8XlUY0w6ak0Zs4qkTYJDt9rN405Y6lO6rZUTUuurRbaYxMHFMsGoqt3z9hNx1Ffxxdo21Bzh/SnGlQFukCmcpGJuOhex0JUQWubed2XOOZJ8A78KbmIHYHy7k2dQS8c6j2R2Y8nLopZ4MJ0d9hCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809311; c=relaxed/simple;
	bh=h3diFW+6swCdQwulrfxNuv36O/MywyrOiDWDmax+1eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6P7q4MRomCJhsmrBJW6Uucv3+ACfIZopPDAUNpSx2JS7b3wRWyfahUUGDOeVNZ8V/RtI0bdUe32CXL+n1An8ncSSSLnjXSUZqpRWWft3OXrEh2wHDQw8hCAXVkpNiPgt2BQPowfX2UbhUyFLXXt3gE00f5eAcvwEIOGo9OmBg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVQLfaYh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVQLfaYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767809310; x=1799345310;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h3diFW+6swCdQwulrfxNuv36O/MywyrOiDWDmax+1eY=;
  b=YVQLfaYhevZU0EhuFLtn5tQ4zTzdtKU1ow+O21526i43wjX/4ckrPjEz
   VOudX/mOtgAB5fReMB3bRYqPCnrYiKCpYMSmxLCNdiXu/5gf0svQbrkXK
   GJAPZTa5iGuTjdTiQF2f66q/hlXfwOgHXu22VwHGs0ST+HmMREFxzsGQb
   5HYuhrWIrCabvq8DWUer+N0oTRzNy9gkWYrf7DF2n7EvB9KWRltqf8bGU
   eZ9PYZj8ViAFc38pW3jjKxdUZb7KixM0WH2jeQ3lmpJY0bkcbppDrCZ6V
   RdIWK95RQwibj9EqXf/lJ1Hqvm+dWDq6HdmjNGbo1grR+r9yDf+cdTgpj
   g==;
X-CSE-ConnectionGUID: kF+llbLCSPq1xOkZCbJyXA==
X-CSE-MsgGUID: RAPTHQDuRv+FRrWfiv/Mkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80299589"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="80299589"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 10:08:29 -0800
X-CSE-ConnectionGUID: YUsRkDezQ6GGYDrdpTlo9Q==
X-CSE-MsgGUID: w+/cUEI1SsOjIE6BDQgpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207133629"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.157]) ([10.125.109.157])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 10:08:29 -0800
Message-ID: <261e2dde-de8f-4d19-b5df-7e65eb3a994d@intel.com>
Date: Wed, 7 Jan 2026 11:08:28 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cxl/port: Fix target list setup for multiple decoders
 sharing the same dport
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260107100356.389490-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260107100356.389490-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/7/26 3:03 AM, Robert Richter wrote:
> If a switch port has more than one decoder that is using the same
> downstream port, the enumeration of the target lists may fail with:
> 
>  # dmesg | grep target.list
>  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
>  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
>  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
>  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
>  cxl_mem mem6: failed to find endpoint12:0000:00:01.4 in target list of decoder2.1
>  cxl_mem mem8: failed to find endpoint13:0000:20:01.4 in target list of decoder4.1
> 
> The case, that the same downstream port can be used in multiple target
> lists, is allowed and possible.
> 
> Fix the update of the target list. Enumerate all children of the
> switch port and do not stop the iteration after the first matching
> target was found.
> 
> With the fix applied:
> 
>  # dmesg | grep target.list
>  update_decoder_targets: cxl decoder1.0: dport2 found in target list, index 2
>  update_decoder_targets: cxl decoder1.0: dport0 found in target list, index 0
>  update_decoder_targets: cxl decoder1.0: dport3 found in target list, index 3
>  update_decoder_targets: cxl decoder2.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder2.1: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.0: dport3 found in target list, index 1
>  update_decoder_targets: cxl decoder4.1: dport3 found in target list, index 1
> 
> Analyzing the conditions when this happens:
> 
> 1) A dport is shared by multiple decoders.
> 
> 2) The decoders have interleaving configured (ways > 1).
> 
> The configuration above has the following hierarchy details (fixed
> version):
> 
>  root0
>  |_
>  | |
>  | decoder0.1
>  | ways: 2
>  | target_list: 0,1
>  |_______________________________________
>  |                                       |
>  | dport0                                | dport1
>  |                                       |
>  port2                                   port4
>  |                                       |
>  |___________________                    |_____________________
>  | |                 |                   | |                   |
>  | decoder2.0        decoder2.1          | decoder4.0          decoder4.1
>  | ways: 2           ways: 2             | ways: 2             ways: 2
>  | target_list: 2,3  target_list: 2,3    | target_list: 2,3    target_list: 2,3
>  |___________________                    |___________________
>  |                   |                   |                   |
>  | dport2            | dport3            | dport2            | dport3
>  |                   |                   |                   |
>  endpoint7           endpoint12          endpoint9           endpoint13
>  |_                  |_                  |_                  |_
>  | |                 | |                 | |                 | |
>  | decoder7.0        | decoder12.0       | decoder9.0        | decoder13.0
>  | decoder7.2        | decoder12.2       | decoder9.2        | decoder13.2
>  |                   |                   |                   |
>  mem3                mem5                mem6                mem8
> 
> Note: Device numbers vary for every boot.
> 
> Current kernel fails to enumerate endpoint12 and endpoint13 as the
> target list is not updated for the second decoder.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Can you add a Fixes tag pls?

DJ
> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fef3aa0c6680..3310dbfae9d6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1590,7 +1590,7 @@ static int update_decoder_targets(struct device *dev, void *data)
>  			cxlsd->target[i] = dport;
>  			dev_dbg(dev, "dport%d found in target list, index %d\n",
>  				dport->port_id, i);
> -			return 1;
> +			return 0;
>  		}
>  	}
>  
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> prerequisite-patch-id: a92b04b164c158c7f0f0dcde957bf5c02ffb3918

