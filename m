Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93664156C53
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 17:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165094; cv=none; b=L2TTSSUErYpmkNTXTeNCkyN1zFNvEW1YNwmnvA0HRkII+15ipnQQXKUPktTZpkObaZBH4nJJPCIZ9u/QZZ8gvtZfY0XlH6yynMUmGEclu7UnwpxuAxYTQb8pUnb6+jj+v3iM0zurWLK2DqrLWeyG+rk2aevk8XtunfFvircLygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165094; c=relaxed/simple;
	bh=uCYJtpqe7os+h8/O2AJKN4UkHVWPTfBqBBoxUGczksI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaW3pkH6xLpG+VPHLvBYxTVAuc5mBChRg2SPvUXEO38GtjYjalBVPjTHZWCXG5rca41svkz3MQt/kjWNuXwwpD3jrfz+SdVMJX++ok7EuWjzLVv0YrQ/zd2ZtXMuC41TxxebZXwso3EA+DuTo9nDlFb0tn0VxlHjijku9jshmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8s6911cXz6D8c3;
	Thu,  4 Apr 2024 01:23:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 084D9140257;
	Thu,  4 Apr 2024 01:24:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 18:24:48 +0100
Date: Wed, 3 Apr 2024 18:24:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/region: Move cxl_dpa_to_region() work to the
 region driver
Message-ID: <20240403182448.00003c79@Huawei.com>
In-Reply-To: <e62889d00f883b804e46a1840454b0c06323fedf.1711598777.git.alison.schofield@intel.com>
References: <cover.1711598777.git.alison.schofield@intel.com>
	<e62889d00f883b804e46a1840454b0c06323fedf.1711598777.git.alison.schofield@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 27 Mar 2024 21:36:30 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> This helper belongs in the region driver as it is only useful
> with CONFIG_CXL_REGION. Add stubs in core.h for when the region
stub

> driver is not built.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Otherwise, does what is says on the tin.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

