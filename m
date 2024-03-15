Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270D1863C
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498384; cv=none; b=Ar/M/q6ZqLMy81GBvkJU0rHRWjPLq5Nk8mvuVZC79aKPsuLLsuuVjl9IjqWXCNTRIsTBrPucvLHVTRvhNpMfrs/RTy2ZkOd5FRk21VBFoK0pCHDUUHzPT3DVaOT9mvjuHp9D/a1h9omlf3y4HFy5Ru5ZmT6byCl7nQhuWRmX0XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498384; c=relaxed/simple;
	bh=MTCMp6Vv+J9Bm2SC4D8ZwyEx/G8J49iDRE1TBEAeZh8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wn1t5rpmP25z2VSPgTVZnO54HwIFrPFAH5prTiCB4tMkEsrq+ULaX4FQjrjw6jtOxVFPQodB9fkmliug0/XDVxADv6Ffs/X6ii5l/sz0fy7XX1KJxf5dyP9mtzZF9bdk07n9NwLEUjFkZiB1s/68n4X8alntVC0mzHLsSUyE1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tx0kz3F8vz6D8gl;
	Fri, 15 Mar 2024 18:25:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E67BC141D79;
	Fri, 15 Mar 2024 18:26:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Mar
 2024 10:24:15 +0000
Date: Fri, 15 Mar 2024 10:24:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dave.jiang@intel.com>, <fan.ni@samsung.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v9 0/7]  QEMU CXL Provide mock CXL events and irq
 support
Message-ID: <20240315102415.00004476@Huawei.com>
In-Reply-To: <20240315015228.307512-1-wangyuquan1236@phytium.com.cn>
References: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
	<20240315015228.307512-1-wangyuquan1236@phytium.com.cn>
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

On Fri, 15 Mar 2024 09:52:28 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hello, Jonathan
> 
> When during the test of qmps of CXL events like "cxl-inject-general-media-event", 
> I am confuesd about the argument "flags". According to "qapi/cxl.json" in qemu, 
> this argument represents "Event Record Flags" in Common Event Record Format.
> However, it seems like the specific 'Event Record Severity' in this field can be
> different from the value of 'Event Status' in "Event Status Register". 
> 
> For instance (take an injection example in the coverlatter):
> 
> { "execute": "cxl-inject-general-media-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "dpa": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "device": 5,
>         "component-id": "iras mem"
>     }}
> 
> In my understanding, the 'Event Status' is informational and the 
> 'Event Record Severity' is Warning event, which means these two arguments are
> independent of each other. Is my understanding correct?

The event status registers dictates the notification path (which log).
So I think that's "informational" here.

Whereas flags is about the specific error. One case where they might be
different is where the Related Event Record Handle is set.
An error might be reported as
1) Several things that were non fatal (each with their own record)
2) In combination they result in a fatal situation (also has it's own record).

The QEMU injection shouldn't restrict these combinations more than the spec
does (which is not at all!).

This same disconnect in error severity is seen in UEFI CPER records for example
where there is a containing record with one severity field, but more specific
parts of record can have lower (or in theory higher) severity.

Jonathan


> 
> Many thanks
> Yuquan
> 

