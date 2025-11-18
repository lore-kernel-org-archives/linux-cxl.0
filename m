Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995D31E0FA
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508887; cv=none; b=YPMBwCajPQrvRqX3X9IIC3z+swcmCtKzqOVTOOZa0j8nMb4KMaq5Wnvst75Gt7zdWMvQ1+QZfOnMLiTA8CPsmHfTb8zn2PZPS/Jowsm5agpZVhRbSIOso4u615bl/Cey+KkIjpaNzHJOMXNI7PXY+pV/P16moYZMaO2IQi4d+nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508887; c=relaxed/simple;
	bh=5aGHugYm3md/oMzkO49jp6WnR/RhdSIVZMsEYi54zPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcdMXDx210PzM0dZSNVxmO1SH7CltNri1BKYfZHdc4VZf+ELrMuG35STc3oFEBX+8R6fs2OJ3VsCu1WdbR98HiNXxg12KMfz6zVIqA0iW57GVT+5LqW4Huy1b/FNcJrooqT4o0Ntw81I15cXV5uCH8clH750gJhZhdajCqunsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlMMVrFX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlMMVrFX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763508887; x=1795044887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5aGHugYm3md/oMzkO49jp6WnR/RhdSIVZMsEYi54zPM=;
  b=MlMMVrFXro1LGk0Bn3205KF+3cGWYnVMGD2pjePVHXeaHZvfT7c+ZMxG
   Lfo5Z0Rax+KaUfwQlo9bvChlfflk6Adbxt4/eaGN/kMfUeEFA/ESQx5ug
   xL8FkbMW9amJHk0AmmD0YIgYhKac38Nakj+Dv83zaOupaKhLBQtId4Frq
   F0joLxtlprwfWKkFdf0hhxyxGuZm0GTPGNZKJ9k5TG3qHTO2MTjHYTIKI
   EnC+w3/TryWTj6kblv6wbSDodFHi2QYuI+rslR7qeudn1Ai+neMRLXlCt
   BjLExhQ4HcCl+hnqzy0s1O6PQHgVobQxdUDpojMJd89dXZX+YAxDOA2qT
   A==;
X-CSE-ConnectionGUID: ntmkxynWRMmsFcWYJPIRmg==
X-CSE-MsgGUID: r1I0JHSXTfqOtabouzh6kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76648867"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76648867"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:34:46 -0800
X-CSE-ConnectionGUID: aE8VBDmTQnmmO/nsLl2pPA==
X-CSE-MsgGUID: irJfDMuiSoeB9GxSi2894A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191026240"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:34:45 -0800
Message-ID: <8625eb71-103c-438a-be86-2e2fce30fab0@intel.com>
Date: Tue, 18 Nov 2025 16:34:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Assign overflow_err_count from log->nr_overflow
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20251116013036.1713313-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251116013036.1713313-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/25 6:30 PM, Alison Schofield wrote:
> mock_get_event() uses an uninitialized local variable, nr_overflow, to
> populate the overflow_err_count field. That results in incorrect
> overflow_err_count values in mocked cxl_overflow trace events, such as
> this case where the records are reported as 0 and should be non-zero:
> 
> [] cxl_overflow: memdev=mem7 host=cxl_mem.6 serial=7: log=Failure : 0 records from 1763228189130895685 to 1763228193130896180
> 
> Fix by using log->nr_overflow and remove the unused local variable.
> 
> A follow-up change was considered in cxl_mem_get_records_log() to
> confirm that the overflow_err_count is non-zero when the overflow flag
> is set [1]. Since the driver has no functional dependency on this
> constraint, and a device that violates this specific requirement does
> not cause incorrect driver behavior, no validation check is added.
> 
> [1] CXL 3.2, Table 8-65 Get Event Records Output Payload
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next
f1840efdb2bf cxl/test: Assign overflow_err_count from log->nr_overflow

> ---
>  tools/testing/cxl/test/mem.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index d533481672b7..9853bccfa185 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -256,7 +256,6 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_get_event_payload *pl;
>  	struct mock_event_log *log;
> -	u16 nr_overflow;
>  	u8 log_type;
>  	int i;
>  
> @@ -299,7 +298,7 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  		u64 ns;
>  
>  		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
> -		pl->overflow_err_count = cpu_to_le16(nr_overflow);
> +		pl->overflow_err_count = cpu_to_le16(log->nr_overflow);
>  		ns = ktime_get_real_ns();
>  		ns -= 5000000000; /* 5s ago */
>  		pl->first_overflow_timestamp = cpu_to_le64(ns);
> 
> base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c

