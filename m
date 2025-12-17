Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34033F38B
	for <linux-cxl@vger.kernel.org>; Wed, 17 Dec 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988079; cv=none; b=UhwvWeKCtklvWeY7qwXZRahARQeGKv9eWoPVU3NiqyOX0O3jTDjMBr9BSRueJiVlnpDP7YkEG4oOvOnllozhbuAx/o/rpXKR+hCYursVULUi2d/bCLsJeN85X65CQD8QbwMfQBRr8jxHlTdMaM6aY5MfMGqrxV23VV3hv6tRVLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988079; c=relaxed/simple;
	bh=LJT3w1/sOerDAl2OzObo14iGHcVVaQSey5cowoTR2do=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=algWhK1SxnrHUEoV80+xXnOC20kPZeizDyDSQOJs8qGaVa+AAUwUwUagt8alCztue5ROl955aHxtrMonSpEoYYdkjjK8TMWCvquQQWZiRIAUf3WAbL+LSkopRVmA96nLxYZ6+2wWbohRIpXWJPZvrcGJR5n4C2E2f1TdUGOhwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWf4b1P24zHnGkV;
	Thu, 18 Dec 2025 00:14:07 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A675540577;
	Thu, 18 Dec 2025 00:14:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 16:14:32 +0000
Date: Wed, 17 Dec 2025 16:14:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 04/17] cxl/core: Add CXL.cache device struct
Message-ID: <20251217161431.00007baa@huawei.com>
In-Reply-To: <20251111214032.8188-5-Benjamin.Cheatham@amd.com>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
	<20251111214032.8188-5-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 11 Nov 2025 15:40:19 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add a new CXL.cache device (struct cxl_cachedev) that is the cache
> analogue to struct cxl_memdev. This device will be created by
> endpoint vendor-specific drivers to enable and manage the cache
> capabilities of the endpoint.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Pretty standard stuff - so even at this early stage I'm fine with:
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
