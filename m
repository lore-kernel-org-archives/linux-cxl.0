Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC7136349;
	Tue, 15 Apr 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744725716; cv=none; b=jfUpSrvkMhYZXq4tAOe4ZBdUhCHPMj5bslVZ5eURwQqOVbBL3ObkaBrWRIZSTWjEPzB7ITYC/BicWJWKEvKXwviL4Xr41XaZi96/bbxekdcsPKwLTwGmRt+DoVCFIEaCIh2NGvRBxOmFtWSZR+LbfQOj451fZCIjpGnxt/CfDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744725716; c=relaxed/simple;
	bh=ZDZ3kTOH3WzYKYGM1zYcLDGYv1+7JCX43o7jH6uQRt0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoscjNMjSWZSMGVPzxWcP+WkSbHeOMxr/naFVIV5eqB3Ht7Cgn34tDgbz/82BCD757gUM6W3cBb3z38M14uUHbfpxk7oe6PHUDcBqn0F9eRLqRJdM9H0SN12/PIwXlmukQYPFoC7jRct70hGM3u2W1TFhBmim7oucV+0skl8jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZcQhx62xNz6LD6T;
	Tue, 15 Apr 2025 21:57:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CCDB140144;
	Tue, 15 Apr 2025 22:01:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Apr
 2025 16:01:50 +0200
Date: Tue, 15 Apr 2025 15:01:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] cxl/feature: Update out_len in set feature
 failure case
Message-ID: <20250415150149.00006116@huawei.com>
In-Reply-To: <20250410024521.514095-1-ming.li@zohomail.com>
References: <20250410024521.514095-1-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Apr 2025 10:45:21 +0800
Li Ming <ming.li@zohomail.com> wrote:

> CXL subsystem supports userspace to configure features via fwctl
> interface, it will configure features by using Set Feature command.
> Whatever Set Feature succeeds or fails, CXL driver always needs to
> return a structure fwctl_rpc_cxl_out to caller, and returned size is
> updated in a out_len parameter. The out_len should be updated not only
> when the set feature succeeds, but also when the set feature fails.
> 
> Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Seems reasonable and well explained.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
