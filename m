Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808145F866
	for <linux-cxl@vger.kernel.org>; Tue, 13 Feb 2024 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843117; cv=none; b=MXMAtqcioYpYui0RktmvFw7ZuNUgHZEG6jW2TZFAPDqPUTKJudHvjhC7V5gFpWJivagDh+kqvo9sikkwfK4O6OJmhM+tknI6MPpEm5188X5bLx8ydHbETLSeDhwqaa4xs2AXi9b47Jk4vnqs91d0Oew3nCRtyiuaOMrkymu4zgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843117; c=relaxed/simple;
	bh=YygFM8jyP0RcWWEnKHlGPI2R7zXH39Fc2CNzlAUSAX4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFDDSWmjLqnj5SlZ25h2Sjj/F/IC4vr3OiEcjFHenvDefAWBFK3TO9aOa5uRJjFwdInoCifmzx1/0td2oFyYmdDbVYto3krTFz4qGqtFESDB+c2fbWvFGsyisCIT7dEoTTgdGRDXC+6C/KsiNfATBUbIrOl+xhm3/tfmO3GRNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ6hY2j0Lz6K5d1;
	Wed, 14 Feb 2024 00:48:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BB4A91400D9;
	Wed, 14 Feb 2024 00:51:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 16:51:51 +0000
Date: Tue, 13 Feb 2024 16:51:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 5/5] cxl/core: add poison injection event handler
Message-ID: <20240213165150.00006d9a@Huawei.com>
In-Reply-To: <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
	<20240209115417.724638-8-ruansy.fnst@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> +
> +void cxl_event_handle_record(struct cxl_memdev *cxlmd,
> +			     enum cxl_event_log_type type,
> +			     enum cxl_event_type event_type,
> +			     const uuid_t *uuid, union cxl_event *evt)
> +{
> +	if (event_type == CXL_CPER_EVENT_GEN_MEDIA) {
>  		trace_cxl_general_media(cxlmd, type, &evt->gen_media);
> -	else if (event_type == CXL_CPER_EVENT_DRAM)
> +		/* handle poison event */
> +		if (type == CXL_EVENT_TYPE_FAIL)
> +			cxl_event_handle_poison(cxlmd, &evt->gen_media); 

I'm not 100% convinced this is necessary poison causing.  Also
the text tells us we should see 'an appropriate event'.
DRAM one seems likely to be chosen by some vendors.

The fatal check maybe makes it a little more likely (maybe though
I'm not sure anything says a device must log it to the failure log)
but it might be Memory Event Type 1, which is the host tried to
access an invalid address.  Sure poison might be returned to that
error but what would the main kernel memory handling do with it?
Something is very wrong
but it's not corrupted device memory.  TE state violations are in there
as well. Sure poison is returned on reads (I think - haven't checked).

IF the aim here is to say 'maybe there is poison, better check the
poison list'. Then that is reasonable but we should ensure things
like timer expiry are definitely ruled out and rename the function
to make it clear it might not find poison.

Jonathan
