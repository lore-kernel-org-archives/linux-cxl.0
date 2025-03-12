Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A81BD01F
	for <linux-cxl@vger.kernel.org>; Wed, 12 Mar 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803603; cv=none; b=XuMlpnbFxFxvbyvgHK6N/mJEFaz1h68Vxg5cV45khsQnqi1Qq18SO4qM0J+9GMoYjbdXdDaJWDhCIMqsjmdDAddiGjJAUkluY7GETPS+PMyD6LeJknQEj/mi3o35YhCNVxH+Z74+FuWmkqyJ0lVxu9IyjDqK3Pt+NsgRzQqA43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803603; c=relaxed/simple;
	bh=h6d91TuSHZBsGpwBXpaRIEO8Cq0odzTtgpsSYuxtbhY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhZhXHC/hn+Q+/tY5mNRtMwKudLZzduvZN4PudCmkoMSB+S2ywySFmERTH+0nHkgPg6yGsGxYk88p//YbYn0Notq34L015zMBv2pQlRHkjI2zIKshRxYwnk0OhDQfN0amGDy8s2fAZDYCkRYxjKL1jim8U76HzOPpog3xphIc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCf3Q2p3Mz6M4MX;
	Thu, 13 Mar 2025 02:16:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F2FF6140D26;
	Thu, 13 Mar 2025 02:19:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Mar
 2025 19:19:58 +0100
Date: Wed, 12 Mar 2025 18:19:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <jgg@nvidia.com>, <saeedm@nvidia.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v8 2/9] cxl: Move cxl feature command structs to user
 header
Message-ID: <20250312181957.00003fb1@huawei.com>
In-Reply-To: <20250307205648.1021626-3-dave.jiang@intel.com>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
	<20250307205648.1021626-3-dave.jiang@intel.com>
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

On Fri, 7 Mar 2025 13:55:32 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In preparation for cxl fwctl enabling, move data structures related to
> cxl feature commands to a user header file.
> 
> Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>

Oops. Guess I probably can't type.

> 
> Link: https://patch.msgid.link/r/20250220194438.2281088-9-dave.jiang@intel.com
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
