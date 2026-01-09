Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB132500966;
	Fri,  9 Jan 2026 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975968; cv=none; b=XDLvQLfvtwRxY2Hw84mSgOl3pSICNe2B0856uQScSQM26L+c2Hj8Q6+3jaG3jCdi31V77Fd/ufAuoEG04Tc0ona8wEjlULSOR7C6KNNGF3uTmG64VJrKZnTB+L7xDqui7Hok11PDHKLOSX6wtpW7W12lRJQLphytHQUwnVDPoBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975968; c=relaxed/simple;
	bh=LrZyutZ8Udr/tTzMlG0q5qUzDCnWOXgWkF/XORpSORE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxmkNa2wJEw0nHBFsmt7SeeRz+LDaY1kvopmPOIQJT0M6aapI+xOqzUliGgeoLGvamki26N7AOkmypgNfKzZ7nT03G2IjxjRZ+aV1hiDAnaPhc1/L4y/iKPUaWbkijWvE84wQkcWvP2118WQ7iLNP4gbzSFFoX7B9Tu9J37Pixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMuWoTJa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMuWoTJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767975967; x=1799511967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LrZyutZ8Udr/tTzMlG0q5qUzDCnWOXgWkF/XORpSORE=;
  b=XMuWoTJaJwZKfo/4jVUCZOJ5+gwUHYdW5KtXBF7MsooKaCDZmxkPiuqJ
   bAII+/B8VE+YPkyDjMD8hYmWI1tJ4bVRN1OGwQ5mk4Z5PjOOeUMI9KUlm
   L3EdRbP/e9H1NRbG2xZHKx/IGLl4HlhiyUAOj6Pm/y8PO+gSrvkK8id+c
   pPVMUBS7Y37YwIuiwiw6IHJXXhFO9S3OyRadTsf0+uLXPQxXNGnnQNYvX
   z9uXJZKlcYb2/i4euDqOSnSNE4TJPcMQS1ox7vuqz+nU3QQlCqtFCPARO
   ZkcYnpHRnENu1NxAzu0qDvVnyW2j9ipAXN/GMbh6wwEkmMAEmMxPhMlWK
   Q==;
X-CSE-ConnectionGUID: Cjsw8m7uSDWZ57A+ENUvYQ==
X-CSE-MsgGUID: vyOuh88FQZSRaz4krlbbBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="79653511"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="79653511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 08:26:07 -0800
X-CSE-ConnectionGUID: MNZvt25CQCGBi682Fv3byA==
X-CSE-MsgGUID: 2fDWcl23SBSzfGDxQO0fuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="202629512"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.110.37]) ([10.125.110.37])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 08:26:06 -0800
Message-ID: <72565e61-138e-4a17-946b-40f32abffcd2@intel.com>
Date: Fri, 9 Jan 2026 09:26:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/port: Fix target list setup for multiple decoders
 sharing the same dport
To: Robert Richter <rrichter@amd.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260108101324.509667-1-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260108101324.509667-1-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/8/26 3:13 AM, Robert Richter wrote:
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
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Applied to cxl/fixes
3e8aaacdad4f66641f87ab441fe644b45f8ebdff


> ---
> v2:
>  * updated sob-chain,
>  * added fixes tag (Dave).
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
> prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021

