Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978303E1232;
	Mon,  6 Jul 2026 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369724; cv=none; b=YyS5K87ZZhayYE+TPN0c8beSjIENYieAu6zLcM8vLDXi3/4hYRUEFNI8OdD+QwHsHk6huSXZfqSbS2jTNMrPos3kjf6iU+8bMo9iBuw543t633fJOJZdXCkfWJOoElZMWutVAwrBnarUEORSUV/aQ8m2/sTdDHBQbUDDB1ficdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369724; c=relaxed/simple;
	bh=YdjHhiKI/9GDmO2IAIQLv/UxvVCUYkPfz+H8bPBIZBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxsETIZOJ9ydPSgSrQI/blwd8/IxdHsbfO4IDxLLHoDwOsQT/tUP17Fp7EJQCMgzXPiX2o6Kpf5nvPED0B60R8n1xOHlXs8mOxts0T9xP2HyTC8BiiRRdeJ1jMPsA+v+/SJl47GINruLKTgISGgev9SivAlkNM8683pVxoAn+E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSUfl1zC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSUfl1zC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783369722; x=1814905722;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YdjHhiKI/9GDmO2IAIQLv/UxvVCUYkPfz+H8bPBIZBg=;
  b=ZSUfl1zCu1lT3/o3OWLiXZ5IK6FhsuSFZwXRbFN0dNM/tjJHBkceACbb
   tBH3rhahs7JapXFU799JCDB3tYRuN9S6z1v4V2BihDXJ6+px0WV0BA4uL
   IgjO+B8Y+3y7KgsnuqhwzhU9Bd8BRxchFrFtgSSlAJKA3Vq6TsALqJXY3
   Ym4Vfzf1v3q9Msid0rDmX4tQTGTuZLxmrvsnfbNmshE19sVJREgejJWdb
   zwBAX1pMh3ePVdNoqcZ0JWrdCMfIlTrQWsErXDUOsk6Fx3qZj5/BdAU0o
   7auDNvFpYRtYle8MTRCm3wDbNIvNtxSE3CUzYRhpY6WApnHUCnqLCxD2h
   Q==;
X-CSE-ConnectionGUID: 8R2TeFcFRfiF79LMOOyOpQ==
X-CSE-MsgGUID: Gqj3I3E2QtOpOg+BjE+vOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="95526706"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="95526706"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:28:42 -0700
X-CSE-ConnectionGUID: Ui+um8LUQimBWuReJy8LXw==
X-CSE-MsgGUID: 7UchEyBkQ7+qYiWVYjEHvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="283909385"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 13:28:42 -0700
Message-ID: <3cbc9816-e067-4b9b-a35c-19c7310809b1@intel.com>
Date: Mon, 6 Jul 2026 13:28:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: bound fwctl command payload to the input
 buffer
To: Zhenhao Wan <whi4ed0g@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>
References: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/19/26 9:33 PM, Zhenhao Wan wrote:
> fwctl_cmd_rpc() copies cmd->in_len bytes into inbuf = kvzalloc(cmd->in_len)
> and passes inbuf and in_len to ->fw_rpc(). The CXL callback cxlctl_fw_rpc()
> ignores in_len and never checks the user-controlled op_size against it.
> 
> cxlctl_set_feature() bounds op_size only from below
> (op_size <= sizeof(feat_in->hdr)) and then reads op_size - sizeof(hdr)
> bytes from feat_in->feat_data via cxl_set_feature(). With a small in_len
> and a large op_size the first memcpy() already reads past the
> kvzalloc(in_len) buffer; the out-of-bounds bytes are placed in the mailbox
> payload and sent to the device, and a large enough op_size can walk into
> unmapped memory and oops the kernel. The Get paths pin op_size to a fixed
> size but likewise read the input struct without checking in_len.
> 
> Reject, at the single dispatch point, any request whose fixed header plus
> op_size does not fit in the copied-in buffer. The lower-bound test guards
> the subtraction and ensures op_size was copied in before it is read.
> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>

Applied to cxl/next
f687394af983

> ---
>  drivers/cxl/core/features.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 3435db9ea6b1..a76142b72935 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -649,7 +649,13 @@ static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
>  	struct cxl_memdev *cxlmd = fwctl_to_memdev(fwctl_dev);
>  	struct cxl_features_state *cxlfs = to_cxlfs(cxlmd->cxlds);
>  	const struct fwctl_rpc_cxl *rpc_in = in;
> -	u16 opcode = rpc_in->opcode;
> +	u16 opcode;
> +
> +	if (in_len < sizeof(rpc_in->hdr) ||
> +	    rpc_in->op_size > in_len - sizeof(rpc_in->hdr))
> +		return ERR_PTR(-EINVAL);
> +
> +	opcode = rpc_in->opcode;
>  
>  	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
>  		return ERR_PTR(-EINVAL);
> 
> ---
> base-commit: a48671671df5158a0b8e564cd509e04a090a941b
> change-id: 20260620-cxl-fwctl-oob-97adb2864c5c
> 
> Best regards,
> --  
> Zhenhao Wan <whi4ed0g@gmail.com>
> 

