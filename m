Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01425335B;
	Tue, 11 Feb 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295169; cv=none; b=C6emNA75E+wKy+9QM95WoROT80x1zqt08mkDt/RfFTMyTafasJIpvtRvzXsXyjcArzeSe4bJXNj721Z7wnKa1YyVOdiengsCw1UIMGM6pddhjYZjU4RACnC7XquptFbU56Gq9sB7wR0ffWqgTOCYfPxzCTEjkzJmTv/QOpqGb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295169; c=relaxed/simple;
	bh=rI7T8WnpBzeKsqvBkGYKfhpiHnE39g5VGFUv6lsO9MA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asf2mKrFn19iJH+Vd1UMI/hjRdArLB6+0kGDfAeKjftBB1jzj6UwkvFPIJ8r78r8T6H367FoHpE17Hq9P3oOklc0xj+IhTLn+Fii6s2GTLJUYjKqICP/kfJL7Nfn2MVfp0HSPfk0jmwNkCRkg3W+l3Rdf6DQSfOjkVC+HNMYeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspQX343qz6K5kT;
	Wed, 12 Feb 2025 01:31:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C4CBF1400DD;
	Wed, 12 Feb 2025 01:32:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:32:45 +0100
Date: Tue, 11 Feb 2025 17:32:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] cxl/region: Drop goto pattern in
 cxl_dax_region_alloc()
Message-ID: <20250211173244.00001c5d@huawei.com>
In-Reply-To: <20250211075727.351895-7-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-7-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:57:26 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxl_dax_region_alloc(), there is a goto pattern to release the rwsem
> cxl_region_rwsem when the function returns, the down_read() and up_read
> can be replaced by a guard(rwsem_read) then the goto pattern can be
> removed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
