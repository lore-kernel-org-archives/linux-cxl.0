Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A682951DA;
	Tue, 15 Apr 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731712; cv=none; b=Vm7+kDDBIJmTkxWe+n0/EWaWQqKRVeeMnrs2MUTQrQXIuiPHJcIJVRxE3Aa5LiiMXuhhHFOit1MWDltXXkoUBLBZVNJ89xqTqDtqw9nROu/EFwWwXwdkOubIxUCmFpDqYbEhmuIgo+cUgZQQbrhQb5RGyLrYMe3cgFW+QO2A4Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731712; c=relaxed/simple;
	bh=i6AcF56rN0OTnT7+UqsnBfMpLBFmknaLmAFiv0j/WJs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVuXnabWYj1eFnTeiuTi3kXUNvu2CVcqc80zo6t7cXMXIwD+75evfGxkxCUcyOXFUe4YiywvrFI61ilT5L5rnam7I5EkBDVku4HcJuKr2fgWaQOleQRFcGAH9i/sR4J7CBKBPDvjVxgWdg0/WAp/1ryCNebg1WkaikbaLGqEoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcSzJ6jVTz6FGWg;
	Tue, 15 Apr 2025 23:40:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 40710140144;
	Tue, 15 Apr 2025 23:41:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 17:41:46 +0200
Date: Tue, 15 Apr 2025 16:41:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rakie Kim <rakie.kim@sk.com>
CC: <akpm@linux-foundation.org>, <gourry@gourry.net>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<joshua.hahnjy@gmail.com>, <dan.j.williams@intel.com>,
	<ying.huang@linux.alibaba.com>, <david@redhat.com>, <osalvador@suse.de>,
	<kernel_team@skhynix.com>, <honggyu.kim@sk.com>, <yunjeong.mun@sk.com>
Subject: Re: [PATCH v7 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <20250415164145.00005b6f@huawei.com>
In-Reply-To: <20250408073243.488-2-rakie.kim@sk.com>
References: <20250408073243.488-1-rakie.kim@sk.com>
	<20250408073243.488-2-rakie.kim@sk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Apr 2025 16:32:40 +0900
Rakie Kim <rakie.kim@sk.com> wrote:

> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with proper `kobject_del()` and `kobject_put()` sequences,
> ensuring correct teardown and preventing memory leaks.
> 
> By explicitly calling `kobject_del()` before `kobject_put()`,
> the release function is now invoked safely, and internal sysfs
> state is correctly cleaned up. This guarantees that the memory
> associated with the kobject is fully released and avoids
> resource leaks, thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
