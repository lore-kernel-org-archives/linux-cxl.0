Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5F34AB1F
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886462; cv=none; b=e7t4D914UrRiNERI4tORQZAKNY1obRj2Qc+LTCqDMxW9IoKcGZxXadnoq/l36jqlH6ikEGonNLrOGcs44I3sObuCj4FUsCqKQy1EoqHR91GCQh/sBktPsgFahUsCIfdHnd2ZXU48qLheypxh8XSvO2SyNcsaSqnASN3RnWY6+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886462; c=relaxed/simple;
	bh=0tmQPcfqKRcoAO8esKFDpttLg22kU3u/N08g9jzaXd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iArz6lhExugJrYOq7SUtYf1qopmbIXcb38f9VGWRjjit07hvIVMjUgGHD7petgU2eXtGOeLaeZ/WGgKJKHEu2sZYpIMqzKeQpWNzHssKFp7RWqeRiUH5pqhy3T7JxkISk4OoWMfZMEDTLXjI7Iziz7DL4t8NHUAKULDLRJ4e2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ppcwth8G; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ppcwth8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771886461; x=1803422461;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0tmQPcfqKRcoAO8esKFDpttLg22kU3u/N08g9jzaXd8=;
  b=Ppcwth8GHRkQmNNooUAOR772SRtpXetaFhlMJzvQ9dg+uQNd+JSOZtdv
   YMJ5Cp0f6s+uBahKQsLK9vrnPVhDRqGguDzadEVl//LfcSTPgx23aOlWz
   I35l5ScIHEz+RLdGJM5IIF1b1Qht2DBELUKlHrREI4Y3iUkaHqAbCObh0
   U4UZOPOZXFZkuNPpSZsCE4nyL6wdzx6n1AFPhue2olH2d26RNmxUvSovv
   /0lMRRLiubD8KA8iUV9vjv2mMwYvLIKjXh3EREP6mbfCaJ65TtYuDH7Bn
   kjf4l8+T2ngUmXfrnaeaLFq/GSaT2aM9tT0dRF8y2QDM0cEMDWWAZjsQ0
   w==;
X-CSE-ConnectionGUID: HtsWZQc4Sg6+AUBw8iz/zA==
X-CSE-MsgGUID: 3ygOMIW9SCq9H6nvvSXnJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84348050"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84348050"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:41:00 -0800
X-CSE-ConnectionGUID: N3J7pUepRHmv4LdTDApfWQ==
X-CSE-MsgGUID: 203Q5mknRLWcS6pP71bM8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214778048"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.227]) ([10.125.110.227])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 14:41:00 -0800
Message-ID: <d1852c63-16b9-41a8-a9da-a3e240fd5532@intel.com>
Date: Mon, 23 Feb 2026 15:40:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl/mbox: return appropriate error in
 cxl_payload_from_user_allowed()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260220001618.963490-1-dave@stgolabs.net>
 <20260220001618.963490-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260220001618.963490-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/19/26 5:16 PM, Davidlohr Bueso wrote:
> Make cxl_payload_from_user_allowed() return int such that the it can
> distinguish between different errors. The payload size failure is not
> well represented by EBUSY (exclusive access by the kernel).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Since this isn't a fix, I'm going to wait and apply it to cxl/next later after the fix goes in 7.0-rc2. Please remind me if I forget.

> ---
>  drivers/cxl/core/mbox.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index e7a6452bf544..164da335fa33 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -314,8 +314,9 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>   * @in_size: Size of @payload_in in bytes.
>   *
>   * Return:
> - *  * true	- payload_in passes check for @opcode.
> - *  * false	- payload_in contains invalid or unsupported values.
> + *  * %0	- payload_in passes check for @opcode.
> + *  * %-EINVAL	- payload_in is too small for the opcode.
> + *  * %-EBUSY	- payload_in contains unsupported values.
>   *
>   * The driver may inspect payload contents before sending a mailbox
>   * command from user space to the device. The intent is to reject
> @@ -326,40 +327,44 @@ static bool cxl_mem_raw_command_allowed(u16 opcode)
>   *
>   * The specific checks are determined by the opcode.
>   */
> -static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
> -					  size_t in_size)
> +static int cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
> +					 size_t in_size)
>  {
>  	switch (opcode) {
>  	case CXL_MBOX_OP_SET_PARTITION_INFO: {
>  		struct cxl_mbox_set_partition_info *pi = payload_in;
>  
>  		if (in_size < sizeof(*pi))
> -			return false;
> +			return -EINVAL;
>  		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
> -			return false;
> +			return -EBUSY;
>  		break;
>  	}
>  	case CXL_MBOX_OP_CLEAR_LOG: {
>  		const uuid_t *uuid = (uuid_t *)payload_in;
>  
>  		if (in_size < sizeof(uuid_t))
> -			return false;
> +			return -EINVAL;
>  		/*
> -		 * Restrict the ‘Clear log’ action to only apply to
> +		 * Restrict the 'Clear log' action to only apply to
>  		 * Vendor debug logs.
>  		 */
> -		return uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID);
> +		if (!uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID))
> +			return -EBUSY;
> +		break;
>  	}
>  	default:
>  		break;
>  	}
> -	return true;
> +	return 0;
>  }
>  
>  static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  			     struct cxl_mailbox *cxl_mbox, u16 opcode,
>  			     size_t in_size, size_t out_size, u64 in_payload)
>  {
> +	int rc;
> +
>  	*mbox_cmd = (struct cxl_mbox_cmd) {
>  		.opcode = opcode,
>  		.size_in = in_size,
> @@ -371,12 +376,13 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
>  		if (IS_ERR(mbox_cmd->payload_in))
>  			return PTR_ERR(mbox_cmd->payload_in);
>  
> -		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
> -						  in_size)) {
> +		rc = cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in,
> +						   in_size);
> +		if (rc) {
>  			dev_dbg(cxl_mbox->host, "%s: input payload not allowed\n",
>  				cxl_mem_opcode_to_name(opcode));
>  			kvfree(mbox_cmd->payload_in);
> -			return -EBUSY;
> +			return rc;
>  		}
>  	}
>  

