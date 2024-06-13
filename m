Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5A1411D6
	for <linux-cxl@vger.kernel.org>; Thu, 13 Jun 2024 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291303; cv=none; b=rzFQJtZMNdWJVse9aKPjsJ2PxhUzPXryLAm3MPxYMF8izMyhocg0rRy0OY/M9iG7Tm1e1fqHN5zCNGCkGXMWQFGjhwpATD3m5njfkfhnWHFf0JlMfcN/r1dfIE+frmGh6eErrxIoaYR0kg7QTtZUj1mJm2uDNj4VdbrgSpt5Xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291303; c=relaxed/simple;
	bh=6d9hkcztxWoNex6+TUwby0XwgI0pwiknb+ykCWyRR6k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TI9TCBllFlrboY6zJkjOSupiUHn40PFDdmHlzR7/XAw5DfHgbJqHVfu9Jc/pHgCGm6+FnYXtdWFCGLxla2PZ3skA9Sco3NTcnCYkkWiZYJqgR5ugSlaEf854ISuo3MyeHB7cz3L/nzfQ05Qwy3pebrse44CdZUOElPCvYWLA+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0Qf121X3z6HJXW;
	Thu, 13 Jun 2024 23:03:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 932751400CF;
	Thu, 13 Jun 2024 23:08:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 16:08:18 +0100
Date: Thu, 13 Jun 2024 16:08:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <mj@ucw.cz>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v11 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240613160817.0000520a@Huawei.com>
In-Reply-To: <20240612075940.92500-3-kobayashi.da-06@fujitsu.com>
References: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
	<20240612075940.92500-3-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 16:59:39 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the
> link status and control registers invisible to existing PCI user tooling.
> 
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

