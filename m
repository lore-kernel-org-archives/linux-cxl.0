Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463D3002A6
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452871; cv=none; b=eqlH9lb1qKi5eGz00G48l3ZzaO7f3TgqTr61xin6XeyRUDYUiG/ZDGGn8G71mwh2wNUrJjiJGBG4FkXgfMpoeOFC6LTWJt25fXNZejxhk8rJMJfAZVP3pBoJVtKGnB0zPrbBvxoNewk34GAAqbuZbrwNuRYMDPXNXrWjhFzfVpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452871; c=relaxed/simple;
	bh=y+90vcGB/pkFQr26kduKzyPfDN83e0EYRPAB+CbNWtQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QWs2fG2KHC7Rt+8OT5gw0xswrb11q+Ij1ulRjhDzrz9J5MI30KBlO1yQkt8P/tJzuYrZPlVMpV5VSJhLZAbj1vY7oYNq1Wbw5TpF79l74/5QYrTmGoAF3eulYv98ZxkqHbZSbgkUlQXSdOxxj8y5o27RJz5TKjQ1JgnItL91Dgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XM8qmOLk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XM8qmOLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760452870; x=1791988870;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=y+90vcGB/pkFQr26kduKzyPfDN83e0EYRPAB+CbNWtQ=;
  b=XM8qmOLk1a9TWsD8jJHBaGqwtkDuiCIAxIEC3Edn2j6JxRf5JmU04Sye
   uNNh52AFNKea3flOzihz1c+12q9G5QqcBYMMKm3v0BuphfENwhD3xVci9
   dkZJJmwnyeb8pZUfDVo0S9XHD375OVaBOXjbpuvrVZ7Bl2P4G+9Xd9ay/
   x7/h/O2pEHcLakfau6Shlt8eiP6WPrSFd0j4zjq/q9mS6/k5dwquwlBUU
   i1335z9df6iHZW/E5W2z3CIeyKyk3CFKh28BSUOsUDKthobmrv0RoHVpO
   5UiP32ad87Zts0ZIDlfl5E0uVr6aA2qkbpIC99yHvY7Bgt5PIERVtsTj1
   A==;
X-CSE-ConnectionGUID: R4a8EsQUSg2X/tzDXauDPA==
X-CSE-MsgGUID: IWjTWLHFQR2x6Apfz6Hm9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="80247264"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="80247264"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:41:09 -0700
X-CSE-ConnectionGUID: XzAkjfvUR2WId6KT3LjptA==
X-CSE-MsgGUID: QGO59i5xT6O7B9nMbsCKpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="181848962"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:41:08 -0700
Message-ID: <71991290-7c1b-4f4c-875a-8ed67a801e38@intel.com>
Date: Tue, 14 Oct 2025 07:41:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/features: Add check for no entries in
 cxl_feature_info
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20251009154001.2660917-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251009154001.2660917-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/25 8:40 AM, Dave Jiang wrote:
> cxl EDAC calls cxl_feature_info() to get the feature information and
> if the hardware has no Features support, cxlfs may be passed in as
> NULL.
> 
> [   51.957498] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [   51.965571] #PF: supervisor read access in kernel mode
> [   51.971559] #PF: error_code(0x0000) - not-present page
> [   51.977542] PGD 17e4f6067 P4D 0
> [   51.981384] Oops: Oops: 0000 [#1] SMP NOPTI
> [   51.986300] CPU: 49 UID: 0 PID: 3782 Comm: systemd-udevd Not tainted 6.17.0dj
> test+ #64 PREEMPT(voluntary)
> [   51.997355] Hardware name: <removed>
> [   52.009790] RIP: 0010:cxl_feature_info+0xa/0x80 [cxl_core]
> 
> Add a check for cxlfs before dereferencing it and return -EOPNOTSUPP if
> there is no cxlfs created due to no hardware support.
> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/fixes

> ---
>  drivers/cxl/core/features.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 7c750599ea69..4bc484b46f43 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -371,6 +371,9 @@ cxl_feature_info(struct cxl_features_state *cxlfs,
>  {
>  	struct cxl_feat_entry *feat;
>  
> +	if (!cxlfs || !cxlfs->entries)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	for (int i = 0; i < cxlfs->entries->num_features; i++) {
>  		feat = &cxlfs->entries->ent[i];
>  		if (uuid_equal(uuid, &feat->uuid))
> 
> base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
> prerequisite-patch-id: e3c6c0e3b81959629a6ffecd3994f683d0d530e4

