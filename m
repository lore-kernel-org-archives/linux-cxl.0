Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8733101B7
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507420; cv=none; b=VWs98b0qXAkhdzRUFRnWbM0487D0c1mqM0FCRsLSxM3kUA6FnKhBkxOD/xf41B/3SnqFutCKvWeBdvRvOgR0wY/h14T3cy2xY2TtTpxFE2+TC95IkWRr7wOmD+ajxOQVEPOd4/oz9o24i405AeffDtYdb4Xje+0QX0Q06hgZpPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507420; c=relaxed/simple;
	bh=NN/DVmBOrnR8Sh74P2+yKiOHXD9/7sjtCijyiWGvteI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ61JCWATfK4Lz+BGfh6P4phC10jHQF7QX26NvwjVNaxxl+Dbc1DGMt8zK1DTqVLM+6JsJZDCwFgEtDibkHk2IXqhw945/5SqkXNXbmM5O3EegMnP4kHJayduiT6ArJbN1iM4ijk4ytLqCcn2kaSs6Rjqmrm9eO7JrD1gZ5JhxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHv64aqr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHv64aqr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763507420; x=1795043420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NN/DVmBOrnR8Sh74P2+yKiOHXD9/7sjtCijyiWGvteI=;
  b=ZHv64aqrzF+Im1AqXTrYQHgjoLE2lzvyN6JH2hSmQqRMUOk2Obmiui3Q
   GMGgVgRqKIZAxVfRIWPGeFhmw5hCJA0/FPk7MBFtSbc0raxHWc8mfzyF7
   STsuQ2J7Fm6o453jLeq5+MIaLe7wGeyKjBY8L2q93zAqjai9gEoRfOPJp
   9NjWHTyqGgIeX6rPcR9DO7AK8pijwGVY5bJys+lZZ/wDMDW2OK0Z4pKqd
   e/rFJJZ8tZnwbVYrW+HqK5BpA6008WR4NPEq1BZXoPFs9L44kpL5LPxlH
   4teXbe7aW5TO/ZL3VzxEubaBjIe3BVD29ATzzlL9jfYbkjiUCheuTyI3J
   w==;
X-CSE-ConnectionGUID: s4O7aBcQQjiQjtLpYK3CGg==
X-CSE-MsgGUID: 3sdWdISfR2aWNUOoreMPUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65577614"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65577614"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:10:19 -0800
X-CSE-ConnectionGUID: 8hE/pEaEQIepfynR2BJaHA==
X-CSE-MsgGUID: nlvA0114Sr67vllQAynnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190545436"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:10:17 -0800
Message-ID: <bd8809bc-ce79-40e9-b062-d5ae883fd485@intel.com>
Date: Tue, 18 Nov 2025 16:10:16 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
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

