Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7E64A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Aug 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775099; cv=none; b=boI0pPjUc96trWPRBlzV8dqx5njbYqfR9uO+Ecb/xBpJOXwKp8m0RxnbVhFAf7b+IpPOwRzsqtO9Lhz9MIT5wIdePANppivAn1poeZCu6WG3Gn0f88cGpkzXKI+GqZVGebfR/tJCghf8Di4D2d1I09lhdsHrwIGTSFL7w2+jZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775099; c=relaxed/simple;
	bh=kRCZTSC3wKlhxotChuHU6pNHYzoBGKxZkjv5z6Th66M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxS/bxoGezcLfCwR2epIb2sAJZL8YpkZTvpxHE1/COXrnhRiwIyVRsdpsl7ZA2sXL8EEHK7mFjLEOHV/RH2VzyvNk+yqtGKF2slwmADnaLJL/2z2+klVcEDYF4/01RIAlJ5XNWoGCRU6HL1H/sxH7FgBRvXyRJhYDTQR3OkJH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtXX3179lz6DBjb;
	Wed, 28 Aug 2024 00:08:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EECD140447;
	Wed, 28 Aug 2024 00:11:34 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 17:11:33 +0100
Date: Tue, 27 Aug 2024 17:11:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yanfei Xu <yanfei.xu@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <ming4.li@intel.com>
Subject: Re: [v3 1/4] cxl/pci: Fix to record only non-zero ranges
Message-ID: <20240827171132.00003212@Huawei.com>
In-Reply-To: <20240813110532.870869-2-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
	<20240813110532.870869-2-yanfei.xu@intel.com>
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

On Tue, 13 Aug 2024 19:05:29 +0800
Yanfei Xu <yanfei.xu@intel.com> wrote:

> The function cxl_dvsec_rr_decode() retrieves and records DVSEC ranges
> into info->dvsec_range[], regardless of whether it is non-zero range,
> and the variable info->ranges indicates the number of non-zero ranges.
> However, in cxl_hdm_decode_init(), the validation for
> info->dvsec_range[] occurs in a for loop that iterates based on
> info->ranges. It may result in zero range to be validated but non-zero
> range not be validated, in turn, the number of allowed ranges is to be
> 0. Address it by only record non-zero ranges.
> 
> This fix is not urgent as it requires a configuration that zeroes out
> the first dvsec range while populating the second. This has not been
> observed, but it is theoretically possible. If this gets picked up for
> -stable, no harm done, but there is no urgency to backport.
> 
> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>

LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


