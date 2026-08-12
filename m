Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC83655E7
	for <linux-cxl@vger.kernel.org>; Wed, 12 Aug 2026 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517094; cv=none; b=amvUBcmo+LQPsbIu2mnOTMCddxlw1zUaHuJlQ9nUBMEr3oI0IaDu9t/sP2QaLH+eYJkbStvcmsUTuq1H0hy86UInnDihkQLlFU0WqlVJG3T2SFMnBo1cfZJ41E0W5UhIki7xsLxnRnGsBdlMrTeGWDTkb65IsJ2DBuqE9J3bfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517094; c=relaxed/simple;
	bh=ZehznD972PzSThMLyX1XlWT4oAwUULRCWERaE2CRksg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ib2PoIvAeJsTznJJKdWECy0PrKMg+xoFk0uxdLHnLW8xNBNZKNHlLHnpy6a/ZnXawyi3WUfxGVwGb6wlLLCPtH5t4/AQ823tkoYGST+TknR+JTRvXqod1BZBqdGHU2SZjFxggR3w9FTNFcTxKqINfAHvc0iL6CjPA4wO/cVzSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HY+PuBWx; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HY+PuBWx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786517087; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OFUQvK7sq6uJFUWt0Md1Hq5RBKP1XgwUdLYssyYVU6E=;
	b=HY+PuBWxp9dO7IgRV3AZzlkiZRF3SPqf4xOeoDZCKa0fzXdR21SRN+2vlo2tnP09FVmRMsIFWsNm+w/in93CJC/ZJzKKP6JchqFubXKZQvZ4Xsps8CrV+JlDs//mz/SuVeKSoECrWdFPRiBE6ejzq3eS6GRGnh/JmfndchmNGbQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X8qe3m-_1786517086;
Received: from 30.178.83.207(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8qe3m-_1786517086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Aug 2026 14:44:47 +0800
Message-ID: <b78fa489-8ef9-4cc7-a8a1-c3b7996db7c2@linux.alibaba.com>
Date: Wed, 12 Aug 2026 14:44:46 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint
 bandwidth gathering
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260812060912.54932-1-kanie@linux.alibaba.com>
 <20260812062241.570631F000E9@smtp.kernel.org>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260812062241.570631F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/12 14:22, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Uninitialized stack memory use in cxl_switch_gather_bandwidth() during access coordinate combination.
> - [High] Uninitialized stack memory leak into QoS class calculation for Restricted CXL Devices (RCDs).
> - [Medium] Pointer aliasing in `cxl_coordinates_combine()` causes bandwidth calculations to incorrectly ignore zero bandwidths from downstream hops.
> --
>
> --- Patch [1]: [PATCH v2] cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering ---
> commit 1627473a040a741d578311d820959582436220a3
> Author: Guixin Liu <kanie@linux.alibaba.com>
>
> cxl/cdat: Fix uninitialized stack use in endpoint bandwidth gathering
>
> cxl_endpoint_gather_bandwidth() declares three access_coordinate arrays on
> the stack - pci_coord, sw_coord and ep_coord - without initializing them,
> and relies on its helpers to fill every member. None of them does.
>
> Link: https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 5c9f072625135..3c6a1537f89b8 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -633,9 +633,9 @@ static int cxl_endpoint_gather_bandwidth(struct cxl_region *cxlr,
>>   	struct cxl_port *endpoint = to_cxl_port(cxled->cxld.dev.parent);
>>   	struct cxl_port *parent_port = to_cxl_port(endpoint->dev.parent);
>>   	struct cxl_port *gp_port = to_cxl_port(parent_port->dev.parent);
>> -	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX];
>> -	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX];
>> +	struct access_coordinate pci_coord[ACCESS_COORDINATE_MAX] = { };
>> +	struct access_coordinate sw_coord[ACCESS_COORDINATE_MAX] = { };
>> +	struct access_coordinate ep_coord[ACCESS_COORDINATE_MAX] = { };
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> [Severity: High]
> This is a pre-existing issue, but cxl_switch_gather_bandwidth() has a similar
> uninitialized stack array:
>
> drivers/cxl/core/cdat.c:cxl_switch_gather_bandwidth() {
>      ...
>      struct access_coordinate coords[ACCESS_COORDINATE_MAX];
>      ...
>      rc = cxl_pci_get_bandwidth(pdev, coords);
>      ...
>      cxl_coordinates_combine(coords, coords, ctx->coord);
>      ...
> }
>
> cxl_pci_get_bandwidth() leaves latency members uninitialized, and then
> cxl_coordinates_combine() unconditionally sums them.
>
> Should coords be zero-initialized here as well to prevent reading
> uninitialized memory?
Yes, will be changed too in v3.
>
> [Severity: High]
> This is a pre-existing issue, but uninitialized stack memory can leak into QoS
> calculations for Restricted CXL Devices (RCDs):
>
> drivers/cxl/core/cdat.c:cxl_port_perf_data_calculate() {
>      struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
>      ...
>      rc = cxl_endpoint_get_perf_coordinates(port, ep_c);
>      ...
>      cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
>      ...
> }
>
> For RCDs, cxl_endpoint_get_perf_coordinates() returns 0 early without
> modifying the array:
>
> drivers/cxl/core/port.c:cxl_endpoint_get_perf_coordinates() {
>      ...
>      if (cxlmd->cxlds->rcd)
>          return 0;
>      ...
> }
>
> This causes cxl_coordinates_combine() to merge uninitialized stack data into
> the region's coordinates, which is later passed to QoS class calculation and
> exported to userspace sysfs.
>
> Should ep_c also be zero-initialized?
Yes, changed too in v3.
>
> [Severity: Medium]
> This is a pre-existing issue, but does pointer aliasing in
> cxl_coordinates_combine() cause bandwidth calculations to ignore zero
> bandwidths from downstream hops?
>
> drivers/cxl/core/cdat.c:__cxl_coordinates_combine() {
>      if (c1->write_bandwidth && c2->write_bandwidth)
>          out->write_bandwidth = min(c1->write_bandwidth,
>                                     c2->write_bandwidth);
> }
>
> When called with aliased pointers in cxl_endpoint_gather_bandwidth() and
> cxl_switch_gather_bandwidth():
>
>      cxl_coordinates_combine(ep_coord, ep_coord, sw_coord);
>
> If sw_coord has 0 bandwidth, the operation is skipped, and ep_coord retains
> its previous non-zero bandwidth instead of being updated to 0.
>
> Should the bandwidth be updated when one of the inputs has 0 bandwidth, or is
> retaining the previous value intended?
It is intended.

Best Regards,
Guixin Liu
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>   	struct pci_dev *pdev = to_pci_dev(cxlds->dev);

