Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406519CD15
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jul 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926489; cv=none; b=MFtQ/0HifgbQ0/hCapaDKZiB3NABdmQt1YkbdujVumJ0D5RFFLc0BsMKruhY2KtHToaXbWRAf0vWjg15ndH3NS2ru/hPmP8Jaqn2K3yMqDBqZGQaOg23AcZT3Hn0DUFk8ipjZLsuF096/0JdZCl/ESw7MEPokT3Xfl6kEA1yF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926489; c=relaxed/simple;
	bh=AurTfS9wOJhr+M6Xg7gs5pcvQxuS7AXFUmEK243iqrM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNP9DAi8SufW86mX408RXPpMFuzGlSIQOmkyfxoTntSt8B+jia0WpSJFXzv/f/MArs0sXoxTEix4T2RI9W+OWG3RX7RQ+t/T345OrJvVP1fOyqgSl+DFOftw4WKvw2XegxcVlP+Ri8GIs6AB2EKD1eQExpkzZK5g1ey8V0WK7XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVH3z6ysMz6K9GJ;
	Fri, 26 Jul 2024 00:52:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F206140A34;
	Fri, 26 Jul 2024 00:54:42 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 25 Jul
 2024 17:54:41 +0100
Date: Thu, 25 Jul 2024 17:54:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <mst@redhat.com>, <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
	<linuxarm@huawei.com>, Zhao Liu <zhao1.liu@linux.intel.com>, Xingtao Yao
	<yaoxt.fnst@fujitsu.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 1/3] hw/cxl/cxl-host: Fix segmentation fault when
 getting cxl-fmw property
Message-ID: <20240725175440.00005ed4@Huawei.com>
In-Reply-To: <1c89931e-d800-452b-8dbd-5c433149f723@tls.msk.ru>
References: <20240705113956.941732-1-Jonathan.Cameron@huawei.com>
	<20240705113956.941732-2-Jonathan.Cameron@huawei.com>
	<1c89931e-d800-452b-8dbd-5c433149f723@tls.msk.ru>
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

On Wed, 24 Jul 2024 07:53:48 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 05.07.2024 14:39, Jonathan Cameron via wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > QEMU crashes (Segmentation fault) when getting cxl-fmw property via
> > qmp:
> > 
> > (QEMU) qom-get path=machine property=cxl-fmw
> > 
> > This issue is caused by accessing wrong callback (opaque) type in
> > machine_get_cfmw().
> > 
> > cxl_machine_init() sets the callback as `CXLState *` type but
> > machine_get_cfmw() treats the callback as
> > `CXLFixedMemoryWindowOptionsList **`.
> > 
> > Fix this error by casting opaque to `CXLState *` type in
> > machine_get_cfmw().
> > 
> > Fixes: 03b39fcf64bc ("hw/cxl: Make the CXL fixed memory window setup a machine parameter.")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
> > Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
> > Link: https://lore.kernel.org/r/20240704093404.1848132-1-zhao1.liu@linux.intel.com
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Is this a stable@ material?

Yes please

Thanks,

Jonathan

> 
> Thanks,
> 
> /mjt
> 

