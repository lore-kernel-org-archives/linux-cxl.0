Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677D2D24BC
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433467; cv=none; b=un+a31xQcxWtQkJ+7MEPNAINPUMRbN3dh2vjQwuWTlvWAhzub70q1kfKLS48yBNpuSHR063NsoPocyKYmBdCjWSQjj/fhhCtu8xCEAXNXAUXlUHT2zO/cfn3TH+p/TcyZmoQrSOwXXrI7F+PQyA69ySawZ3YQuRvotAmMAXXrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433467; c=relaxed/simple;
	bh=G4NmB8GJQ0NgEfNzLfE8rqVx2QtjYm7elvZAZLQDtNc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAJxaUEQgXZi2g0XmilTf4z26ocb/5V7wo2JgOFAxoYt0DwuI6+mW4q4OZFbO14vMcVE/uknHApUqm+u9B9rjHJft4lmjECkWAbMUlqdC73vEx96h2C9NBAidwG6DdtwyfCwhvzd7+kCo9LAtHYH3M/9uMk96CgdqLhLLTJFmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLpN05BG7z6K9lP;
	Tue,  9 Sep 2025 23:56:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B06451400CA;
	Tue,  9 Sep 2025 23:57:42 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 17:57:42 +0200
Date: Tue, 9 Sep 2025 16:57:41 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v9 08/10] cxl/test: Adjust the mock version of
 devm_cxl_switch_port_decoders_setup()
Message-ID: <20250909165741.000034e6@huawei.com>
In-Reply-To: <20250829180928.842707-9-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
	<20250829180928.842707-9-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 11:09:26 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> With devm_cxl_switch_port_decoders_setup() being called within cxl_core
> instead of by the port driver probe, adjustments are needed to deal with
> circular symbol dependency when this function is being mock'd. Add the
> appropriate changes to get around the circular dependency.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Looks fairly standard.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
