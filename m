Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7712DC328
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871382; cv=none; b=AW7Wun9+3IBXM/QFBQ/HIs7J9Htn3OLs8ahhvf2sZmD5GZ0QMXm6iIi6Ni49yt+y0S81g7uGXC151xZBzv3h2QX9LLeYlVdAssbbxxc9oIj1X7jARsn8Cj4LV6pEdalYhr0NW9tuS4XXHHxOgjVCoYTRcESCbFmhK1avkQ+W2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871382; c=relaxed/simple;
	bh=hAOfOhwOt/2EVO2kbyHtLVOV86nwrcrANF6vkxtZvzs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8hCarM88yRGX6tbMcqUvY+xeIlpLOqRNTFHoZc5DIwwcLVOsjGV6wWLS+Ch+WL0hCnx/DT25U2knHvyd8HPX8rk5hc5bxTbLtOJ1susB+whyVldli6WjFjC68l1ftYTHziG8aHYPs02O9NOgc26TwSKUh0nB0JHU/EFvvWdhfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5TSH03GnzHnGk1;
	Tue, 11 Nov 2025 22:29:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 40554140370;
	Tue, 11 Nov 2025 22:29:36 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 14:29:35 +0000
Date: Tue, 11 Nov 2025 14:29:34 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v3] cxl: Add handling of locked CXL decoder
Message-ID: <20251111142934.000030ad@huawei.com>
In-Reply-To: <20251105201826.2901915-1-dave.jiang@intel.com>
References: <20251105201826.2901915-1-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 5 Nov 2025 13:18:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When a decoder is locked, it means that its configuration cannot be
> changed. CXL spec r3.2 8.2.4.20.13 discusses the details regarding
> locked decoders. Locking happens when bit 8 of the decoder control
> register is set and then the decoder is committed afterwards (CXL
> spec r3.2 8.2.4.20.7).
> 
> Given that the driver creates a virtual decoder for each CFMWS, the
> Fixed Device Configuration (bit 4) of the Window Restriction field is
> considered as locking for the virtual decoder by the driver.
> 
> The current driver code disregards the locked status and a region can
> be destroyed regardless of the locking state.
> 
> Add a region flag to indicate the region is in a locked configuration.
> The driver will considered a region locked if the CFMWS or any decoder
> is configured as locked. The consideration is all or nothing regarding
> the locked state. It is reasonable to determine the region "locked"
> status while the region is being assembled based on the decoders.
> 
> Add a check in region commit_store() to intercept when a 0 is written
> to the commit sysfs attribute in order to prevent the destruction of a
> region when in locked state. This should be the only entry point from user
> space to destroy a region.
> 
> Add a check is added to cxl_decoder_reset() to prevent resetting a locked
> decoder within the kernel driver.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
