Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F051FDD
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320170; cv=none; b=O1QzNxX+1Zi3kuNao/8txNmNk9tTWaeenNBH7qz5gAFvpctHa5XTEra3m63hLh+RZIKay4OSVrWC80F9PvT6Pmg8W19us6jW7rJ4UvHloAgzAc4DjJ5S4gU7TESENtXzZ1Sg359gPEwZuw4mIxodjDOzOzaus+gPPqoYqLpjWhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320170; c=relaxed/simple;
	bh=SbWg+e9oOqvGB5FecG3uUV0eQ2/4T1C2djw5yF8cyu4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U1QlhBK+dmGfClwaPLDpWu2DoA7r3MeOA8o0gxssJHH1J0iMYDbOLccj4TYE3SZ3KSBQ0hTr6Sd6vtrdLoWLrpGAw2NxnTm5eJdTDmwfhx3VXJsx6MlBuuui9ZhQcRyJ6Ff6YYPg/7ttuPr0b1xP8TxcocGCyXOEY0XzcfoaKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9ySJ2SWhz688yX;
	Fri,  5 Apr 2024 20:28:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F44F14065C;
	Fri,  5 Apr 2024 20:29:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 13:29:24 +0100
Date: Fri, 5 Apr 2024 13:29:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <20240405132923.0000313b@Huawei.com>
In-Reply-To: <20240325190339.696686-11-nifan.cxl@gmail.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-11-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 12:02:28 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> All dpa ranges in the DC regions are invalid to access until an extent

Let's be more consistent for commit logs and use DPA DC HPA etc all
caps. It's a bit of a mixture in this series at the moment.

> covering the range has been added.
I'd expand that to 'has been successfully accepted by the host.'

> Add a bitmap for each region to
> record whether a DC block in the region has been backed by DC extent.
> For the bitmap, a bit in the bitmap represents a DC block. When a DC
> extent is added, all the bits of the blocks in the extent will be set,
> which will be cleared when the extent is released.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

