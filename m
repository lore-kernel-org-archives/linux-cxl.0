Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7483B13D882
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655172; cv=none; b=VVsoxuPkNLYTwFcGHV+4OAS2Zl0BbtLE2q917fg6zdoFpB0sPCS5/CUWQ+2j2wtVpcv0Xr8TYybdNbvhX5/pQXPGHX0/M2/tNLKLXn6g8Ok2byG8my/J2ZyU/pgpsdux3vIC0SuSvuW4nHyLZ7Cs8f7st8lVIGdYIVemXXgxp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655172; c=relaxed/simple;
	bh=dAMaj1xziBsrnKwhA5M6/sdQsBN+D3fH7B2eOdn/OJY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sss6I6Tv6A7tm04btk+tBvECqm7SCXu9P0TTw2W3U6gx4Nkxbawq4tcsN9ShA1JLtwhVzfh85cOyXAqzLaEMgfZPRabZjrldxx1yoRfqUQ1yZsPUKDe9IjKtSs34FeFbkEzC4LsYu/pzMv5X2vK0CwAU7DohAVvHBbj66xr1unA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf7vD499vz67LSb;
	Fri, 24 Jan 2025 01:57:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 01F97140119;
	Fri, 24 Jan 2025 01:59:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 18:59:25 +0100
Date: Thu, 23 Jan 2025 17:59:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 09/19] cxl: Setup exclusive CXL features that are
 reserved for the kernel
Message-ID: <20250123175924.00004a3f@huawei.com>
In-Reply-To: <20250122235159.2716036-10-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Certain features will be exclusively used by components such as in
> kernel RAS driver. Setup an exclusion list that can be later filtered
> out before exposing to user space.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Nice
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This also finally led me to the footnote I'd lost in the spec
that says that row sparing is preferred to PPR where possible :)

Jonathan

