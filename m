Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB4C22B8C5;
	Thu,  8 Jan 2026 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889242; cv=none; b=McxjVO1+4pjrusZm/PNXt0Fuz1I7AZ3bVzXUZhYK9bg2nrrG8IYkvClavA+NVkgH975IfMUk+Mmz56bQFme36CgkZQxnjpZHOd6b8yjZxx5iEIY8y6wgrNAEjl0Y0OK27A0+Rwy4Psj11U64vFbNnc3P9lu3e+2v0kdsYz8HQnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889242; c=relaxed/simple;
	bh=mn7dIHoVZXOcawSNLGmGGj3H6uv5naxasqA9DwCTiD0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfdKQOosO3BQKO2w2oA5Ju2nWSe8oFlF9BYM26mQ0UbZMPx8dFa3TSMYLmvfkGRpbV14s+T5o81n5qsTlhlOTGQ0EoyEykSvR2Uhe7QgQD0clRuYMuchDrbJLLQD0NLHG2KwkrdBc8yS+qfG1ep34Pyz13gFRt1gxMhFIbSyito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn99n3vV5zHnGfD;
	Fri,  9 Jan 2026 00:20:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EE78140563;
	Fri,  9 Jan 2026 00:20:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 16:20:37 +0000
Date: Thu, 8 Jan 2026 16:20:35 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	<dave@stgolabs.net>, <lison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pci: Remove outdated FIXME comment and BUILD_BUG_ON
Message-ID: <20260108162035.00002c56@huawei.com>
In-Reply-To: <56cc995d-9b5a-41f5-a719-92835f376d13@intel.com>
References: <20260105203833.1604585-1-samasth.norway.ananda@oracle.com>
	<56cc995d-9b5a-41f5-a719-92835f376d13@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 6 Jan 2026 10:55:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 1/5/26 1:38 PM, Samasth Norway Ananda wrote:
> > Remove the outdated FIXME comment about switching to struct_group() and
> > the associated BUILD_BUG_ON check. This work was already completed in
> > commit 301e68dd9b9b ("cxl/core: Replace unions with struct_group()")
> > which converted struct cxl_regs to use struct_group_tagged().
> > 
> > The BUILD_BUG_ON was checking that anonymous union layout was preserved,
> > but since struct_group() now handles this correctly, the compile-time
> > check is no longer necessary.
> > 
> > Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
