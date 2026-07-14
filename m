Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5BE13AD1C;
	Tue, 14 Jul 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047847; cv=none; b=KrcW1QEdrfoyLygOQtW/C8kel8+ql+JnqMojniRIOYN8Uaiub/+JnktUG+t6X3gR2cDj/whaOutV/tCTd6FHQC1lFY5oUJt/Cl85GufJfh3ZGU/PIUM3DLujK4P4tchMPCJuvBEo9NRoiYukplmIKOym4rW+eHkr5S3WdRAkuqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047847; c=relaxed/simple;
	bh=fA7ZD5XNSiuUuHDvWxpdWt3MZogeSGNby7HFGRTcRDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coI8t1FZ6qpfTkeLBuLY/uzsvX0PVsPqkzqn5ASUvpgFZFCofjlu71+guWCnRhE3hOci+qvxUuL7lNhIKq9zRsT+YVen3mLFrir5YpPi4k3C5jg/yHKDCvFKDk0hQeVVg7KVlgsQch+XnHoR2nHO6pME0gijfgDNli1bTK0aJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fkq0xeGZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fkq0xeGZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784047846; x=1815583846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fA7ZD5XNSiuUuHDvWxpdWt3MZogeSGNby7HFGRTcRDg=;
  b=fkq0xeGZvkHezZXND0f9/VPzP/wEKaeDfeBDI1GR/4ngvFHALWAeyv7c
   Oatea1nVj04yf1bxWIslrPkt+Zhj6c8seON1GZVJXSTk+4gu6B6Jb/BMC
   LspmwTlDIU1to0GBme05/k9yJDOMiMswygBf3dsvgv63n6I6zS1Flgqjo
   wMSEyhJJgGc3WKdEOlLgVwHcawOZ3wt3+lH4lHDSEF9C2TpiQu6JHpbxM
   GHwjbBLCJ93RfUE2rwgssOJXPSA/icHLMxJuvd5/7peThDc5olMhO8Z1+
   hIxv676S5dbC3WtX75dWkla9tfU++7v4mC6eFYQG81qgFyxZf00GKGRbj
   g==;
X-CSE-ConnectionGUID: xYIpjqC3QriMRoIQSWD5tw==
X-CSE-MsgGUID: B1h1PHRITquVgbuYNkhl5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84530974"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="84530974"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:50:45 -0700
X-CSE-ConnectionGUID: bX84TrLyQ/K5BaBQMPMkIg==
X-CSE-MsgGUID: oXA6uTW7QQy7//cFEgeFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252519112"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.131]) ([10.125.108.131])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 09:50:44 -0700
Message-ID: <b41cdb78-e861-4d12-82f9-a647a194bf08@intel.com>
Date: Tue, 14 Jul 2026 09:50:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/memdev: Fix firmware upload exact-fit handling
To: guzebing <guzebing1612@gmail.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org,
 iweiny@kernel.org, ming.li@zohomail.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713112744.2543829-1-guzebing1612@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260713112744.2543829-1-guzebing1612@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/13/26 4:27 AM, guzebing wrote:
> From: Guzebing <Guzebing1612@gmail.com>
> 
> cxl_fw_prepare() classifies a firmware image as a one-shot transfer
> only when its Transfer FW input payload is smaller than the mailbox
> payload size. An image that exactly fills the payload is therefore
> treated as a multi-part transfer.
> 
> The firmware loader invokes cxl_fw_write() only once for that image.
> Since both offset == 0 and remaining == 0, the multi-part action
> selection sends INITIATE, never sends END, and then attempts to activate
> the target slot.
> 
> Include equality in the one-shot classification so exact-fit images use
> the FULL action.
> 
> Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
> Signed-off-by: Guzebing <Guzebing1612@gmail.com>

Applied to cxl/next
af5035e1b3e4

> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 33a3d2e7b13af..45e7d2be17e09 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -921,7 +921,7 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
>  	if (!size)
>  		return FW_UPLOAD_ERR_INVALID_SIZE;
>  
> -	mds->fw.oneshot = struct_size(transfer, data, size) <
> +	mds->fw.oneshot = struct_size(transfer, data, size) <=
>  			    cxl_mbox->payload_size;
>  
>  	if (cxl_mem_get_fw_info(mds))

