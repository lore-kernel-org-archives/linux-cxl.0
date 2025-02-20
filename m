Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1D211A0E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071081; cv=none; b=hVGEticdLsJ4C6ktQKd4mCH+bnpHov7gYnNi/4/wGQXfGctEFoC79ecuNodj85ChcD0pTf0KvXAfY7lhQZ4493jcWBfTEMMQx6si8tyLHYndVMHR8BQiA+kHdPoPNiCJEiZl8jS8VUL4yW0iBHs7rg4rvy++4icQ2r0FKdVkfPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071081; c=relaxed/simple;
	bh=nlDaK0ReenB8suNVwv7nZn2LI2PAAY9G5NDu2CQHVLc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6uxm0PTQitV872+aZFWvRtYGne2QjTw0QM1GlagKuFvxfB9xrWH9LmSnlSzsnq+IG70orOQlM4/snTBeAqmyxWIkJDIChWorKmp3pkiTkwreraOc3kqrzzI/TkJV1y4TeiCPS08e8E+/CeAM7mLAsVAI69sBkFKZ/8Gpun1sHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzKLG2NSwz6M4bt;
	Fri, 21 Feb 2025 01:01:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 300CD1400D9;
	Fri, 21 Feb 2025 01:04:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Feb
 2025 18:04:35 +0100
Date: Thu, 20 Feb 2025 17:04:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<alison.schofield@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <seven.yi.lee@gmail.com>, <ming.li@zohomail.com>,
	<a.manzanares@samsung.com>, <fan.ni@samsung.com>, <anisa.su@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] cxl/pci: Introduce cxl_gpf_get_dvsec()
Message-ID: <20250220170434.00004583@huawei.com>
In-Reply-To: <20250220013604.263489-2-dave@stgolabs.net>
References: <20250220013604.263489-1-dave@stgolabs.net>
	<20250220013604.263489-2-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 19 Feb 2025 17:36:01 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add a helper to fetch the port/device GPF dvsecs. This is
> currently only used for ports, but a later patch to export
> dirty count to users will make use of the device one.
> 
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Maybe an enum for the port vs device thing would have been nice but
I'm not that bothered and a single use enum is bit nasty.
