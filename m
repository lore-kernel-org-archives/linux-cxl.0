Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29337700
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361545; cv=none; b=E/9lnHkCIbndcf+qzQLSSaf412TKfEIl4QKMjdOzRGCVMkWwljoIa7JBgmOl5uFa7kG+51TH44K5eK30a5mxPcQy5ZDXUSOn34rYpFhZrd7jb7j47r+8msWGM7ubqcSetBXGQoX7wfOKAzOhJUVcGXDORFz63DW25/WMMFRMHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361545; c=relaxed/simple;
	bh=jLOnTIYM/r5C9HHw0XMW5Wg8GPSMZBRnz7R2B01/6tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTLD0ULrK7QUqwSMmpPW9BYLnzCaO6SBzOrjpjBt0NbDXsp00li2zBkBQmYw64V35bWDHSzUd/Y5+Tp27y/4cDXx+hnxTupuu6cLnHp5VVNdhqBOqYU8BKafD675/QACoYQfRG5wVkxSIDlsuvRGeJbvMG2GM72mJrGmO/BxOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLN+9ZV/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLN+9ZV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712361544; x=1743897544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jLOnTIYM/r5C9HHw0XMW5Wg8GPSMZBRnz7R2B01/6tc=;
  b=gLN+9ZV/JKxSqdw/sgeArfggK1BnisUSY1f/MfMeZXDwZJ6mxEVD5cZy
   LBaB/v7aNjsXV9SYO+M4OF9HTbDubPKmgySuitD5rTzuJy/KbIOezMaAR
   TYHyh90sDX3lP8xzFatqNrQd60NBtQYONoYFQkQT2m/rIVoUXPBz2MCkf
   bR7/vLLadH6Jqb1h691Va29Q1Ocl62YvIldBtibVMsOS2HmRnN7+G33ZG
   /Db0HpH2PMFOj4KY3BqQC9AdcQw7ftYcZXxcm1xLPI9DE46/TzwTGguPC
   +oy9T+1/pJWvVS0oj1TU/rJ+hn/mrmPmYhDCBFuwT0nH5gbqCfrUQU6py
   Q==;
X-CSE-ConnectionGUID: GFnOtF7HT0eGfPbn08ThYA==
X-CSE-MsgGUID: aKzckMxyR4+clvqa4XcJKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7565986"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7565986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:59:03 -0700
X-CSE-ConnectionGUID: SgwN8fRVQjyE9WCjK1KBTQ==
X-CSE-MsgGUID: qtWNLr4WQNq7NTee5lLxKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19229489"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.142.219])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:59:02 -0700
Date: Fri, 5 Apr 2024 16:59:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, Kwangjin Ko <kwangjin.ko@sk.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core: Fix potential payload size confusion in
 cxl_mem_get_poison()
Message-ID: <ZhCQRHjEUCWF53FF@aschofie-mobl2>
References: <171235441633.2716581.12330082428680958635.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171235441633.2716581.12330082428680958635.stgit@dwillia2-xfh.jf.intel.com>

On Fri, Apr 05, 2024 at 03:00:16PM -0700, Dan Williams wrote:
> A recent change to cxl_mem_get_records_log() [1] highlighted a subtle
> nuance of looping calls to cxl_internal_send_cmd(), i.e. that
> cxl_internal_send_cmd() modifies the 'size_out' member of the @mbox_cmd
> argument. That mechanism is useful for communicating underflow, but it
> is unwanted when reusing @mbox_cmd for a subsequent submission. It turns
> out that cxl_xfer_log() avoids this scenario by always redefining
> @mbox_cmd each iteration.
> 
> Update cxl_mem_get_records_log() and cxl_mem_get_poison() to follow the
> same style as cxl_xfer_log(), i.e. re-define @mbox_cmd each iteration.
> The cxl_mem_get_records_log() change is just a style fixup, but the
> cxl_mem_get_poison() change is a potential fix, per Alison [2]:
> 
>     Poison list retrieval can hit this case if the MORE flag is set and
>     a follow on read of the list delivers more records than the previous
>     read.  ie. device gives one record, sets the _MORE flag, then gives 5.
> 
> Not an urgent fix since this behavior has not been seen in the wild,
> but worth tracking as a fix.
> 
> Cc: Kwangjin Ko <kwangjin.ko@sk.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Fixes: ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
> Link: http://lore.kernel.org/r/20240402081404.1106-2-kwangjin.ko@sk.com [1]
> Link: http://lore.kernel.org/r/ZhAhAL/GOaWFrauw@aschofie-mobl2 [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks Dan -

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  drivers/cxl/core/mbox.c |   38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f0f54aeccc87..65185c9fa001 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -946,25 +946,22 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>  	struct device *dev = mds->cxlds.dev;
>  	struct cxl_get_event_payload *payload;
> -	struct cxl_mbox_cmd mbox_cmd;
>  	u8 log_type = type;
>  	u16 nr_rec;
>  
>  	mutex_lock(&mds->event.log_lock);
>  	payload = mds->event.buf;
>  
> -	mbox_cmd = (struct cxl_mbox_cmd) {
> -		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> -		.payload_in = &log_type,
> -		.size_in = sizeof(log_type),
> -		.payload_out = payload,
> -		.min_out = struct_size(payload, records, 0),
> -	};
> -
>  	do {
>  		int rc, i;
> -
> -		mbox_cmd.size_out = mds->payload_size;
> +		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
> +			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> +			.payload_in = &log_type,
> +			.size_in = sizeof(log_type),
> +			.payload_out = payload,
> +			.size_out = mds->payload_size,
> +			.min_out = struct_size(payload, records, 0),
> +		};
>  
>  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  		if (rc) {
> @@ -1297,7 +1294,6 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_mbox_poison_out *po;
>  	struct cxl_mbox_poison_in pi;
> -	struct cxl_mbox_cmd mbox_cmd;
>  	int nr_records = 0;
>  	int rc;
>  
> @@ -1309,16 +1305,16 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  	pi.offset = cpu_to_le64(offset);
>  	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
>  
> -	mbox_cmd = (struct cxl_mbox_cmd) {
> -		.opcode = CXL_MBOX_OP_GET_POISON,
> -		.size_in = sizeof(pi),
> -		.payload_in = &pi,
> -		.size_out = mds->payload_size,
> -		.payload_out = po,
> -		.min_out = struct_size(po, record, 0),
> -	};
> -
>  	do {
> +		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd){
> +			.opcode = CXL_MBOX_OP_GET_POISON,
> +			.size_in = sizeof(pi),
> +			.payload_in = &pi,
> +			.size_out = mds->payload_size,
> +			.payload_out = po,
> +			.min_out = struct_size(po, record, 0),
> +		};
> +
>  		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  		if (rc)
>  			break;
> 
