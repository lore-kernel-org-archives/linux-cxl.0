Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F3188713;
	Fri, 14 Feb 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539570; cv=none; b=DuSg/URDtenz/h3PA1mTfhU73UXm2SI4+EeisBRl4qshl3I4QACiQZRTSjvA9FvcSNmwWIjdSMu6nRtSVFbnyVPFEOQ1tqcZadufR7m9/sKweEOiSs1Td8KNs8Qoc6pKonQ4eq/sbj3Emb/uVu5/tNhyI7qtmp6efxpYCy/+V5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539570; c=relaxed/simple;
	bh=EYemIGMwSIAtzbCHLsILvSyOT3im2qY676XifWU/t58=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/AiFJjBT4k6STEbu5Nt1gvMcbCNwCmhRIlK6++JpEwWMqpwQAR+No/pcwzPHGB/+rLH+TMjVBumAoyA1JFHmasC4rQfiYGeVivz6ziBYAIBpcbvy9hgrdEcA5OZodatw7qk3IWKFIzXmGHsdl1+/aDKfWrGtypB1qt0Ng63p2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvXn56HRJz6M4cp;
	Fri, 14 Feb 2025 21:23:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 28D491400DA;
	Fri, 14 Feb 2025 21:26:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 14:26:05 +0100
Date: Fri, 14 Feb 2025 13:26:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chenbaozi@phytium.com.cn>
Subject: Re: [PATCH v2 0/1] cxl/pmem: debug invalid serial number data
Message-ID: <20250214132604.000078c0@huawei.com>
In-Reply-To: <20250214030952.4047438-1-wangyuquan1236@phytium.com.cn>
References: <20250214030952.4047438-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 14 Feb 2025 11:09:51 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Background
> ==========
> In Qemu environment, the default serial number of cxl-type3 device
> is UI64_NULL.

Doesn't matter but technically it's just not presented by QEMU unless
specified.

The internal default is UI64_NULL but if we match that when creating
the config space stuff we just skip the serial number capability.

I'm glad to see some hardening around this as I ran into same thing
long ago (that's when I realized we were missing serial number support :(

Jonathan

> But we could still use it to create a nvdimm pmem region
> and set a non-zero cookie of nd_interleave_set, for example:
>   1. create a cxl pmem region interleaved with 2 devices (one with
>      serial number 0 and the other with serial number 1), and the cookie
>      would be non-zero/valid.
>   2. create the second cxl pmem region by 1 device with no serial number
>      and this region would have a non-zero cookie because the offset of
>      dpa is non-zero.
> 
> Problem
> =======
> In a nvdimm interleave-set each device with an invalid or zero
> serial number may cause pmem region initialization to fail, but in
> cxl case such device could still set cookies of nd_interleave_set
> and create a nvdimm pmem region.
> 
> CXL Pmem Validation
> ===================
> This patch adds the validation of serial number in cxl pmem region creation.
> The event of no serial number would cause to fail to set the cookie
> and pmem region.
> 
> cxl-test
> ========
> A mock serial number is set from the platform device id and 0 is a valid
> platform device id. For cxl-test to work properly, always +1 on mock
> device's serial number.
> 
> Yuquan Wang (1):
>   cxl/pmem: debug invalid serial number data
> 
>  drivers/cxl/pmem.c           | 7 +++++++
>  tools/testing/cxl/test/mem.c | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

