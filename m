Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F99A1BFE00
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774899; cv=none; b=kSQR6EA7I7DOSathq8pWP6p7hMxz4rAlFe+6UduH40NZNOA49CuqvtHwZ7JKJyZ3v02PCPvttXFRuDH7jRNGtTVPTFUXT2HyA8jiYVPAQuzXlPvpGcehrmKt/+t0/5wA8sBTqv3gDH/A1ARWmrkB9NxnVQvOhlVf7pmgOU8ERNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774899; c=relaxed/simple;
	bh=/VBgyY67wYFjChARbHxtFsLs6Wj2VDZMnzJm2hBckzc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndIqWyYngOsxO2SEmYuotjArV8Ssv3DKWvUD8gsQ1mRy3a27zREyiHgDFCmYlmoiWkpA2hk5HazggPYsgSu2+fsPDmLbDdhhDUavK/cse+38deAT3DOZ6/Mp6tAarPmHQdZPCVNWhq/UvDq2YNZ4t8jHnB2SY12F1Uu62CklS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXRN0dwQz6J7BY;
	Wed, 28 Aug 2024 00:04:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B2B6B1400D1;
	Wed, 28 Aug 2024 00:08:14 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:08:14 +0100
Date: Tue, 27 Aug 2024 17:08:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yanfei Xu <yanfei.xu@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [v3 0/4] Fixes for hdm docoder initialization from DVSEC ranges
Message-ID: <20240827170813.00004d7c@Huawei.com>
In-Reply-To: <20240813110532.870869-1-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Aug 2024 19:05:28 +0800
Yanfei Xu <yanfei.xu@intel.com> wrote:

> The first and third patch are intended to fix potential issues regarding to
> retrieve and record DVSEC ranges. The second and fourth are cleanup.

typo in patch title.  decoder


Also, good to include cxl: as prefix to the patch title.

> 
> v2->v3:
> - improved the commit message of patch1 to indicate potential impact of
>   the change.  (Dan)
> - Dropped un-appropriate "Fixes" tag. (Dan)
> - Dropped the patch2 which is a code movement in original patchset.
> - Separated the original patch3 into cleanup one and logic change one which
>   are corresponding to patch2 and patch3 in current patchset. (Dan)
> 
> v2:https://lore.kernel.org/linux-cxl/20240809093442.646545-1-yanfei.xu@intel.com/T/#t
> 
> Yanfei Xu (4):
>   cxl/pci: Fix to record only non-zero ranges
>   cxl/pci: Remove duplicated implementation of waiting for
>     memory_info_valid
>   cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
>   cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()
> 
>  drivers/cxl/core/pci.c        | 74 +++++++++--------------------------
>  drivers/cxl/cxl.h             |  2 +-
>  drivers/cxl/port.c            |  2 +-
>  tools/testing/cxl/test/mock.c |  4 +-
>  4 files changed, 23 insertions(+), 59 deletions(-)
> 

