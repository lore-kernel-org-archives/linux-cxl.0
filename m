Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0820DD57
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672373; cv=none; b=CfKDN3zw+lKFcfVUsXuwhe4wU/T5nQHgbJtqhXF7sBb/ZQ9ZaPEKp9njiJt/YlOn3ve5jzpxx7a3KfZBl5VHgDL5HgEckopE2CpvOOygEP+ThHeM6NS7SexhI4FhKjcsLw7K94YElAJX4Dj+ve7pzE93Xb1MhylCQ+1pWCh5KJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672373; c=relaxed/simple;
	bh=d6icRWYXudRBZ3valWgUgVrtaDEsWRhuzz4+RLRKtQw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TL5FsHGA0D5W6BQIL4XiUrPk5S7IvEZmEyGI53PEqApYxXD/aIDfUC8PGOD3zZBvMFYtwEnxGXlrhWZvSvLYrXZkx76xiOlEmPeHH2JU5ZJyeYU5VYFh78+VBENBFTCeEXyNOLupJ6GoRr/mzh2/1tlMJNDpZQnZXJe0oT6aFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YnN636x8wz6HJRn;
	Tue,  4 Feb 2025 20:31:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8040D1400CA;
	Tue,  4 Feb 2025 20:32:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Feb
 2025 13:32:48 +0100
Date: Tue, 4 Feb 2025 12:32:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 6/6] cxl: Cleanup partition size and perf helpers
Message-ID: <20250204123247.000000d1@huawei.com>
In-Reply-To: <173864307519.668823.10800104022426067621.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
	<173864307519.668823.10800104022426067621.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 03 Feb 2025 20:24:35 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Now that the 'struct cxl_dpa_partition' array contains both size and
> performance information, all paths that iterate over that information
> can use a loop rather than hard-code 'ram' and 'pmem' lookups.
> 
> Remove, or reduce the scope of the temporary helpers that bridged the
> pre-'struct cxl_dpa_partition' state of the code to the post-'struct
> cxl_dpa_partition' state.
> 
> - to_{ram,pmem}_perf(): scope reduced to just sysfs_emit + is_visible()
>   helpers
> 
> - to_{ram,pmem}_res(): fold into their only users cxl_{ram,pmem}_size()
> 
> - cxl_ram_size(): scope reduced to ram_size_show() (Note,
>   cxl_pmem_size() also used to gate nvdimm registration)
> 
> In short, memdev sysfs ABI already made the promise that 0-sized
> partitions will show for memdevs, but that can be avoided for future
> partitions by using dynamic sysfs group visibility (new relative to when
> the partition ABI first shipped upstream).
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Ok. This might make my earlier suggestions about not special
cases ram regions less effective, but I think perhaps worth considering
none the less.

Anyhow, this patch is fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



