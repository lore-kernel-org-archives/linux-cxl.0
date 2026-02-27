Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CE21423C
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198507; cv=none; b=toT5lL5kL5H5ZrJAHMkceuBKfwVy9ajofYTGnkf6/2ggkQ/7Mx7LDLYiM40YfsaWB3YTV5ShDoWwYqZ7eBxWtUuW5bGcf79FtxpJKqHrfBmzh2+R5OsiADy23GPqVlkA9SFWxZP8cwW3IPsjwu09li1i1I7g3sBjrlSAflLItMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198507; c=relaxed/simple;
	bh=Pxs4dTz5HSeClQQ1pHe3rH1bYemkaSKZnQwjGETqO4A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klDeQggjTz4a3OnQKGVFNkA9Xs4qEez9c5UJM/UV7lyfkDJ72liUzeR6X8eoQGbY7KGbozp4AfNfbYphaD8yUWHIaXsLO8y+V86BiPptFpO5pB+fzUAQUVSlYlAiiKsIk48OoDl1RbUSlqdC64m7DpgfkScgmiZriyqWU6kZmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMpqW2nTHzHnGhW;
	Fri, 27 Feb 2026 21:20:55 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D69240585;
	Fri, 27 Feb 2026 21:21:41 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 13:21:40 +0000
Date: Fri, 27 Feb 2026 13:21:39 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
Subject: Re: [PATCH v2 3/3] cxl/region: Factor out interleave granularity
 setup
Message-ID: <20260227132139.00004f18@huawei.com>
In-Reply-To: <20260225122223.3841889-4-alejandro.lucero-palau@amd.com>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
	<20260225122223.3841889-4-alejandro.lucero-palau@amd.com>
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
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Feb 2026 12:22:23 +0000
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices can be triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup forinterleave

for interleave

> granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
