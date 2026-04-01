Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAB47D935
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775063993; cv=none; b=nWkrjG35JguaRiVlNU7I9KuwQQ007B+wG/aG4hjNim06QRPzdvbe1ZRzQZow0FVxW/0YcM/DpLx6gEWeoS2sohmc1H8ddYdfB0MzjA95opBRcHxNU5gbK3wgisvgur184YpcGJYIMI3csfOOJCji/ZGq0o3e1cVJ7pT+Dgm3wpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775063993; c=relaxed/simple;
	bh=s3SELhmmAQHlMG96dlFeNW8NpFrjb83Pzs4QuO+bLwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUFZKs0+a2/f9yO73e4vvfaVsSXLcoO+4uPMqSpyu1ctdWzdcz251y/i+Rr9PDD7nPyiUkHvw+rwqHDEEwz7kN1VCeVfmZQK9HTPnJKJMNiYklNQnAHrVkVcBe7n9AAXcyloX8g7vRp9MS8DHpBk1b0DXByy1Yl4nDRbnqX2P9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lbg1TPMe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lbg1TPMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775063992; x=1806599992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s3SELhmmAQHlMG96dlFeNW8NpFrjb83Pzs4QuO+bLwU=;
  b=Lbg1TPMe45lU499WttMsPlrjGTgF39YNlKnci8d5Kp1IsK2viYA1FGvi
   A2mNeK03j89UJvk17K8oYZiDOBXG4HqFsYpDoMKHFd9tSg4UuSt7P0Iko
   9HouunsclBE+FhSXOXMXbni6bUTSB+CA+7vp1WdcfnWFw4pnbubFCWaMB
   j6VUGeaGH296kPwF87BGfpxnUijwWJ1+vBH+7wVCPs20hS5jX8wWIKJgs
   iBZ4bd6yX8mWhHw8yDCkx3WA8v/ZQPdsr2YIdf4tHzkot8OcIM00oe/gG
   CaqhLNwa5oZBFb+bs2V1EUfdhphu6LrnrFqeJ2NMJoZlSUCU5lIuI0Efq
   Q==;
X-CSE-ConnectionGUID: kASMeDJrRzOeCfhJUpp3Bw==
X-CSE-MsgGUID: +M5b6sVDQISFlR+lDhGIGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="78707014"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="78707014"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 10:19:51 -0700
X-CSE-ConnectionGUID: JPJD6rkuRZm9A1PxZLTwnw==
X-CSE-MsgGUID: EB+B415ARR+995m1CxqVJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="225883459"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.111.126]) ([10.125.111.126])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 10:19:51 -0700
Message-ID: <bb403342-6dba-4656-88ff-c69ad3779abe@intel.com>
Date: Wed, 1 Apr 2026 10:19:50 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Check existence of cxl_memdev_state in poison
 test
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <20260331005047.2813980-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260331005047.2813980-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/30/26 5:50 PM, Alison Schofield wrote:
> Before now, all CXL memdevs were assumed to have a mailbox-backed
> cxl_memdev_state, so poison command checks could safely dereference
> the @mds.
> 
> With the introduction of Type 2 devices, a memdev may not implement
> a mailbox interface, and so there is no associated cxl_memdev_state.
> Guard against this case by returning false when @mds is absent.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
261a02b93d9b

> ---
>  drivers/cxl/core/memdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 273c22118d3d..591425866045 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -204,6 +204,9 @@ bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
>  {
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	if (!mds)
> +		return 0;
> +
>  	return test_bit(cmd, mds->poison.enabled_cmds);
>  }
>  

