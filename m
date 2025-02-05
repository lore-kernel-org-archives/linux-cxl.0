Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBEE21578B
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777290; cv=none; b=iqTfPTq2h7Ybn9ViUevRQk063jgPMvVmmCNUwh8vwPvPTL8nlnkdV9jfXMbrSmaGQyUPYM8ssJjrthiukJEn7H+mA0wxDeLV15FaqmY0Ho8diOKX5G/P75j8ibsdvfxfLSkCGb+WhMfWO7+FVePU8KTiaHEzfGDE3rvF7jyRUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777290; c=relaxed/simple;
	bh=FZ/f0caM8B0DQRyRUjb2SqD/sMwdGSY98zNeXLmoPRE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2IAM7n8G8md1BPnW2RG+nxyWERte1KbJewDuVNLGYjjvYESO8dcbrQgNVHjRyaAafhAKuioy16cpntfGwvxIJhdSPwo49hxJcfynBZGB4VEUoNdFt5/IecaU+nne3uwIwnbqhvHHYDA96Pjjfb0pD9CbCxb2PLrIOdbr3Izipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yp6sf4jS8z6L4tD;
	Thu,  6 Feb 2025 01:38:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A1DCB140B38;
	Thu,  6 Feb 2025 01:41:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Feb
 2025 18:41:24 +0100
Date: Wed, 5 Feb 2025 17:41:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v3 01/16] cxl: Refactor user ioctl command path from mds
 to mailbox
Message-ID: <20250205174123.00005885@huawei.com>
In-Reply-To: <20250204220430.4146187-2-dave.jiang@intel.com>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
	<20250204220430.4146187-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 4 Feb 2025 15:03:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With 'struct cxl_mailbox' context introduced, the helper functions
> cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
> rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
> directly.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Dave, maybe it's worth nibbling this one off the front of the series
and applying? 

Jonathan
