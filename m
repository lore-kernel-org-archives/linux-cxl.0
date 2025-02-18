Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28A26B96E;
	Tue, 18 Feb 2025 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739899450; cv=none; b=qkXTXUySs2RWlLym152SEvBWp3zDWwvjeOTl4RMVVvDwBqyxKtYQKXxghoRR0zKMicMCHnO2iar5kkYdjKqZDZ50TlHu5I8wSrMUajyjmUtE0e3jl+xSeo5pMtg3bxNR9iXWX4HFavlmnq+ajBdjNVvmBl3TEf7R0BwNCAO5XZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739899450; c=relaxed/simple;
	bh=Q5YalVs0cvhQnUAdv1hQ6QKnTvIsfIFq2dRK64d4dko=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StyFW54BcJE5CVR8FFMg1wMNzutM+zDGvUDVl7C4idxlE33kWa8h2WxAUc+E2VA4JH/S1YLQ6VYZ/Kmqz1xUvs/Sj+AMZGqmC/7lQe99JHz2J1Hae8nHvvb5RURqtOpWci+jlvb31S6qGiqQbm4d8xg9fvqWsvhGrvmayAJXBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yy5rs0hpVz6L56r;
	Wed, 19 Feb 2025 01:20:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0205B1400DD;
	Wed, 19 Feb 2025 01:24:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 18 Feb
 2025 18:24:04 +0100
Date: Tue, 18 Feb 2025 17:24:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] cxl/region: Drop goto pattern of
 construct_region()
Message-ID: <20250218172403.00000084@huawei.com>
In-Reply-To: <20250217144828.30651-8-ming.li@zohomail.com>
References: <20250217144828.30651-1-ming.li@zohomail.com>
	<20250217144828.30651-8-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 17 Feb 2025 22:48:28 +0800
Li Ming <ming.li@zohomail.com> wrote:

> Some operations need to be protected by the cxl_region_rwsem in
> construct_region(). Currently, construct_region() uses down_write() and
> up_write() for the cxl_region_rwsem locking, so there is a goto pattern
> after down_write() invoked to release cxl_region_rwsem.
> 
> construct region() can be optimized to remove the goto pattern. The
> changes are creating a new function called construct_auto_region() which
> will include all checking and operations protected by the
> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
> and up_write() in construct_auto_region().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

