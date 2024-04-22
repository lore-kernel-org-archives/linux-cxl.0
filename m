Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E5146A67
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713786745; cv=none; b=rg7GJk/fKmiw0xkpqTocsuQvDC5DOOsJJ5ftkriHIURDAGNjg8FjPb+z9MvxON11QdUU4unBRpRW3ygVBkjzYH9RqBc/2WJHTG3DQPn9npDPzTcYh9xexrfMyLzDe/BvKf3+z+JDue94zHP/mOo60RA0wuxhgE1jKGfefC2R9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713786745; c=relaxed/simple;
	bh=7SfGvkQshLJmyJJ6oVEeDgPMtBjbHt1z0w/kLQ0k0YY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGGYaKzwjw9aGvyJucjGILWOAYSMe6QMxErh5++hGMDn4L3kIfRy2/WLpuUjcAFSDjfL+a0bja5FEqQqCOHbnTN2evBs6lcRHxuFe4do37lZ3Zv3Y+Bw/GgD0xXa66bglMW4JfCKQuI4KBIaXctv49bo1Eg14ApW7srgliczqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNNpj0qK5z6JBTZ;
	Mon, 22 Apr 2024 19:50:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C5E93140AE5;
	Mon, 22 Apr 2024 19:52:18 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 12:52:18 +0100
Date: Mon, 22 Apr 2024 12:52:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240422125217.0000767f@huawei.com>
In-Reply-To: <20240418232902.583744-7-fan.ni@samsung.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-7-fan.ni@samsung.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Apr 2024 16:10:57 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend for DCD. All the dynamic capacity
> regions will share a single, large enough host backend. Set up address
> space for DC regions to support read/write operations to dynamic capacity
> for DCD.
> 
> With the change, the following support is added:
> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all DC regions share one
>    host backend;
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
One fixlet needed inline.

I've set range1_size_lo = 0 there for my tree.

> @@ -301,10 +337,16 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                               (ct3d->hostpmem->size & 0xF0000000);
>          }
> -    } else {
> +    } else if (ct3d->hostpmem) {
>          range1_size_hi = ct3d->hostpmem->size >> 32;
>          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                           (ct3d->hostpmem->size & 0xF0000000);
> +    } else {
> +        /*
> +         * For DCD with no static memory, set memory active, memory class bits.
> +         * No range is set.
> +         */

range1_size_hi is not initialized.

> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3;
>      }
>  
>      dvsec = (uint8_t *)&(CXLDVSECDevice){

