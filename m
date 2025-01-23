Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6626F1E884
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655832; cv=none; b=e2FF2vLapJcKu7Mk/m+IIecQYSoMl+xeKXPmMSOoTe1+aJDoq91kmGFyM0CwryTnPqds0+tPiH4k7WMuIHQZ5917ZRF5RZzI39j5DM5Pog1lzsEtKKQsbZKMwvp8v2FD/Njh7Lg77IDZc92ei4bVjXuV4GydH67lw7nnQ1mzv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655832; c=relaxed/simple;
	bh=BbYZBZoyuLNV5gMP37+BAnBZOjtB/3ZdKFb6YLzupTs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nMO4yUNskgkXz1C8Y/86TwmxeV306wMKMjJ+4/z6/PjMe5h0atUa7VWBWBLaFj6SO0mL1uyfOc4gP3eOGSoQQwfrqlGGD4mZ7zPRGjHaP+aFVH30UuVrTN5UMtdUhoGvzpQ90oRxU+pv8WxjVaQ6D9ze9vBfvfElCZDeJD0EJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf89r4jlLz6K5pM;
	Fri, 24 Jan 2025 02:10:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E6810140736;
	Fri, 24 Jan 2025 02:10:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 19:10:27 +0100
Date: Thu, 23 Jan 2025 18:10:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [PATCH v1 12/19] cxl: Move cxl_mem.h under uapi to cxl
 exclusive directory
Message-ID: <20250123181026.0000390a@huawei.com>
In-Reply-To: <20250122235159.2716036-13-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
	<20250122235159.2716036-13-dave.jiang@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 16:50:43 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> In preparation of more cxl headers, create a cxl directory under
> uapi.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



