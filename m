Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F317BB03
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015822; cv=none; b=tmjNw4kN29LrQk0Lmjn1YF8UQfAQC0E+L9SVx2faEd+UKeeTQhRUq11yUgg7Oi7wKWWF9V9bRPIyvt2SAOOteVv9G+mBW38svzZzUCXpT0NZ7wejcxx7OMr/OBNUaP42QBgIALFDnUbnXUa7W2tCyEr7Z0T+kIysk9Ioqle83vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015822; c=relaxed/simple;
	bh=L8pCLOiKouLwh/5yHx1xrYSHies/YZ+7k3sH60SOxsE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjqCqFs1U5/FYlgJ7boo5DNCyFv6DKMZlG/aRUXXEJLEsqPd72KDo47u8ZOdkwoApudTFrwmYwA27BmWhX1qN2tSZwHfleo/Y5TFr3mQBKmLC65vRs6iu19fBHP6r7DDpqGXwmKhP7FmX9N+tBzHPgJJf09itg4GbXZcuJzVXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFXL5spvz6K6Cx;
	Fri, 30 Aug 2024 18:59:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5450A140A08;
	Fri, 30 Aug 2024 19:03:38 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 12:03:37 +0100
Date: Fri, 30 Aug 2024 12:03:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Li Ming <ming4.li@intel.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] cxl/pci: Rename cxl_setup_parent_dport() and
 cxl_dport_map_regs()
Message-ID: <20240830120337.00002479@Huawei.com>
In-Reply-To: <20240830061308.2327065-1-ming4.li@intel.com>
References: <20240830061308.2327065-1-ming4.li@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 06:13:06 +0000
Li Ming <ming4.li@intel.com> wrote:

> The name of cxl_setup_parent_dport() function is not clear, the function
> is used to initialize AER and RAS capabilities on a dport, therefore,
> rename the function to cxl_dport_init_ras_reporting(), it is easier for
> user to understand what the function does. Besides, adjust the order of
> the function parameters, the subject of cxl_dport_init_ras_reporting()
> is a cxl dport, so a struct cxl_dport as the first parameter of the
> function should be better.
> 
> cxl_dport_map_regs() is used to map CXL RAS capability on a cxl dport,
> using cxl_dport_map_ras() as the function name.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
