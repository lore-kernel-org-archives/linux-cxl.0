Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B135137907
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741004; cv=none; b=l9MhtkRF94jTDI90xEwPvzDsozW+ozHpy8ik/8YELBeuubLl1YO5RpRVi3u+cy+0s0a9l0h8KSDIW6dteVxk+6f7VoBXfGXMPgSITIHy/Qwst97KicCknrk48W3675HIYTxB3DXAhChkMNjmIIgekpTEKHxEbXavYChGr8FEeug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741004; c=relaxed/simple;
	bh=qPyxrYfuEdlgR3yMMWcS5rPr/zfW9Tg64Y1XcGbp3Gs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJnPO6XLsLRvSbHEBVowzLjzjaoJ/kPZRUmtlwkaKBC/sx78F55TN2NLjpGkq6US0X5FnUHOLMAm5zyybArgjS09RIlQmKeHQ8JgmneFJo73dG2dmAob4KaWtO5Wktk7HL1xFFKnTAeqO0Tc/HJO1vrRvxegs8hZkWvqv5MCoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqcfY1ywMz6D8rL;
	Thu,  7 Mar 2024 00:03:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CFB61140CF4;
	Thu,  7 Mar 2024 00:02:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 16:02:48 +0000
Date: Wed, 6 Mar 2024 16:02:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 05/13] hw/mem/cxl-type3: Refactor
 ct3_build_cdat_entries_for_mr to take mr size insead of mr as argument
Message-ID: <20240306160247.00002e63@Huawei.com>
In-Reply-To: <20240304194331.1586191-6-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-6-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:34:00 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> The function ct3_build_cdat_entries_for_mr only uses size of the passed
> memory region argument, refactor the function definition to make the passed
> arguments more specific.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
