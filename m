Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F2B448BAE
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920408; cv=none; b=gPNdex1fBB6jhUlWFjNwyK0ZksEFbyK+Ccg9hYgtaF01hC5KRvPFTtfqP5c+hFgBsHgoJzKZr4ORk4d5iFV8BYL2hQET5087J0DgD1+nxQgUvC2K9LwGsMdOAliTq6XS7eRgs+Wk6hGObVOr1U5PVDxsYcPUac01fwVTkNmLQ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920408; c=relaxed/simple;
	bh=6PzGwrbwxGDM9b/o5ExEtJReeQfJWFYhaV5V7f6BuMk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M0zFttz2JoYTD5hDC6b00FSbo6UrVnaF1mx5/uO599FTj4eb5DxbQT4IT+r8KcmzdtL7Axng0Zv2aQWfduthXOZURStj1SfJddJip5/2xIQvC5Xx/ofqGI6Ghk3lAVAjGpKktQDKSAtZSex2yofvcdj3zwIxQRZJPfqKcuhQaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh6ZRC7i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh6ZRC7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784920407; x=1816456407;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6PzGwrbwxGDM9b/o5ExEtJReeQfJWFYhaV5V7f6BuMk=;
  b=Nh6ZRC7ilxZTw+JJnTHrgugunvKbTq7cascFChH/295nGc1pnt0YbJiF
   j9Iu3E4GB4ac6S1ef9H6Q/h2p3zC6D+MFN1wKcxvtGyi7vMnRII82SbPA
   YExQ7uw9Jt/QGZ8Gc5g+ktX1D3KEzJRlh/Ul+uiRxRe3BqzOjqtBEn3ex
   iTmGUEr3LuM0ZS3wZVp5LBiR1Of2BSxef3eaQLmGRkIZMbTkHq+4qjOUl
   FAwzRumDOVUzizdYjYdPK0TSObgYaBXtoKaYPi/fuieIeEIrdkPMcTev7
   zD+iea8+NyqgikIjjeTFmkBM+sG2ko/vKzIBLivCKux4+3+FNkoPRrqFY
   A==;
X-CSE-ConnectionGUID: cpBJpXbxRLCGVQjDnDVe2w==
X-CSE-MsgGUID: 69gMr/UMRVC/ZEp2ue+DLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96185943"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="96185943"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 12:13:26 -0700
X-CSE-ConnectionGUID: HKEdjUfyRJ6pQ726r4ERbA==
X-CSE-MsgGUID: p7IPYPcdTtaSFX1z8bscCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="288770544"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.193]) ([10.125.110.193])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 12:13:26 -0700
Message-ID: <0e35df1b-fb6c-4609-8033-497bd3be3e23@intel.com>
Date: Fri, 24 Jul 2026 12:13:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Deny Features commands on the RAW mailbox path
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, icheng@nvidia.com
References: <20260715155126.1629178-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260715155126.1629178-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/26 8:51 AM, Dave Jiang wrote:
> The RAW mailbox command path allows user to issue arbitrary opcodes
> to the device. The FWCTL interface was introduced to support the
> CXL Features commands where access control is provided depends on
> what the CEL indicates.
> 
> Add the Features commands to cxl_disabled_raw_commands[] to ensure
> that all Features commands are only accessible through the FWCTL
> interface.
> 
> The cxl_raw_allow_all debugfs override knob bypasses the disabled list
> if the user is aware of the risks and wants to use the RAW path for
> Features commands.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next
fac9275820a3

> ---
>  drivers/cxl/core/mbox.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a5..6dea70a1ff95 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -91,6 +91,10 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>   *
>   * CXL_MBOX_OP_[GET_,INJECT_,CLEAR_]POISON: These commands require kernel
>   * driver orchestration for safety.
> + *
> + * CXL_MBOX_OP_[GET_SUPPORTED_FEATURES,GET_FEATURE,SET_FEATURE]: Features are
> + * accessed through the fwctl ABI, which applies scope-based access control.
> + * The RAW path would bypass those checks, so it is not permitted here.
>   */
>  static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_ACTIVATE_FW,
> @@ -102,6 +106,9 @@ static u16 cxl_disabled_raw_commands[] = {
>  	CXL_MBOX_OP_GET_POISON,
>  	CXL_MBOX_OP_INJECT_POISON,
>  	CXL_MBOX_OP_CLEAR_POISON,
> +	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +	CXL_MBOX_OP_GET_FEATURE,
> +	CXL_MBOX_OP_SET_FEATURE,
>  };
>  
>  /*
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa

