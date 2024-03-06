Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC49713BAF1
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747458; cv=none; b=rT5bW9hNOuCIs1S97DBCEXNfh2OCVQUNBWi5HdjiB1Tli0SjcG9rY17hDs0Kf+aGrrCFLi/zQwG+T8NRrUCsUYI3IQmGTuIb4zOQn4QG0mVE/ShKyBfcD5FYfPkbLKtnCb8OvhqFk7P6EUqf0NY7agolL+P8DknxTMwspCVJV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747458; c=relaxed/simple;
	bh=DviYSC7rbsaPr0qBFp652Zf5kCt1LMXU3IBTJu6Zb/c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbC5IPUCVzgX8sL0VpC2E2Bd5qQPNSxxuyqV6baiR5wpDBMf6elkfoaRLkcqUAsVlj6iio2O+7UAYjmdERYE07l2Tg/PExEqwhLBf3nGOZr7WJC6DJOGzACTk55VrC5huyj3TCUa6yBqwZI93M4qteSt9wEn9saQutGIZiubJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqg2h0Wdzz6J9St;
	Thu,  7 Mar 2024 01:50:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CB845140AA7;
	Thu,  7 Mar 2024 01:50:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 17:50:52 +0000
Date: Wed, 6 Mar 2024 17:50:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 10/13] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <20240306175051.0000252d@Huawei.com>
In-Reply-To: <20240304194331.1586191-11-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-11-nifan.cxl@gmail.com>
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

On Mon,  4 Mar 2024 11:34:05 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Not all dpa range in the DC regions is valid to access until an extent

All DPA ranges in the DC regions are invalid to access until an extent
covering the range has been added.

> covering the range has been added. Add a bitmap for each region to
> record whether a DC block in the region has been backed by DC extent.
> For the bitmap, a bit in the bitmap represents a DC block. When a DC
> extent is added, all the bits of the blocks in the extent will be set,
> which will be cleared when the extent is released.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


