Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833614883F
	for <linux-cxl@vger.kernel.org>; Thu, 21 Nov 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210450; cv=none; b=riBs6eDPAl5hqBI1yPNGlQhVIyW4CVPJQIbX3iFZNgENegIvuOj2lJov5AZHYOv4bBuAi4TTu3kG7eJz6WmPhbXvNovD3c6rary42XX4xAWkYOwKI+w+/yI/XlJ+Vr5rEk/3c54MSungt9kArN3PElG+IytADl3FWrweVOtivik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210450; c=relaxed/simple;
	bh=zBMUX3gwOCl+LPWDRtF4A9jsr+66daj95uj55vgFuu0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUBffSzJgpWrFaY0KJIt4cl0UvoyrS2FAYQqnCuc7xkbsNOVZkbfmy/o/QetT8WPNI98b5GCQKTin+PmaGvU+CGr/g3erhbanht+WqxxAwAtqUcOnoU5LH/pXfT/JFOei+aldjucQKtqw8d/pXS/Vfvsu1tFVu/8o39++8GJRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvQLn0JgPz6LCf0;
	Fri, 22 Nov 2024 01:33:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 547961400F4;
	Fri, 22 Nov 2024 01:34:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 18:34:00 +0100
Date: Thu, 21 Nov 2024 17:33:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 01/20] cxl: Refactor user ioctl command path from
 mds to mailbox
Message-ID: <20241121173359.00006952@huawei.com>
In-Reply-To: <20241115212745.869552-2-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
	<20241115212745.869552-2-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 15 Nov 2024 14:25:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With 'struct cxl_mailbox' context introduced, the helper functions
> cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
> rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
> directly.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To me this stands on it's own as a good change.

