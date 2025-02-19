Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383D2862B2
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985002; cv=none; b=bDxtg5BC0W0JZx7Nspmlwu0nSGK8/gaogc19KGRfD6Sn3p8kw5iZ/vwHPNqUwj+zOMQ8Y259HpLl5O0Zn6w7lVXvYuUNI8r9MGSxIQX+aNdyEWT7v6ZuNH3cYdPgS4/k4JzTEktoIshiRFSg2xuIPU8HKFZ87XhKGuCmkJKLAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985002; c=relaxed/simple;
	bh=nMqnOt0m28f9DajUxVKkeaSnJkbo+FPvEYTudBUwI6Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0i6pvFWqipXOtcIhH5XhhNgClMPhhzO7RvBos708YyE6WPxULFxpxjBd+Wc2bl2ji/haioN4urUdnWNFefbg5jiYUTPs58P1Dbrwb2tZWN3H1R1wnoiV+rgpMj4mziUu3JmqIBzGSXVyRxs9SIY/VvMzQjuz6knPDvflIi/jeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YyjV04TLkz686xP;
	Thu, 20 Feb 2025 01:06:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A11331400D4;
	Thu, 20 Feb 2025 01:09:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 19 Feb
 2025 18:09:54 +0100
Date: Wed, 19 Feb 2025 17:09:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, <saeed@kernel.org>
Subject: Re: [PATCH v6 07/14] cxl: Add FWCTL support to CXL
Message-ID: <20250219170953.00004f0b@huawei.com>
In-Reply-To: <20250218225721.2682235-8-dave.jiang@intel.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
	<20250218225721.2682235-8-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 15:54:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add fwctl support code to allow sending of CXL feature commands from
> userspace through as ioctls via FWCTL. Provide initial setup bits. The
> CXL PCI probe function will call cxl_setup_fwctl() after the cxl_memdev
> has been enumerated in order to setup FWCTL char device under the
> cxl_memdev like the existing memdev char device for issuing CXL raw
> mailbox commands from userspace via ioctls.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

