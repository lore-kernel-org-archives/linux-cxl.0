Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00126BD8E;
	Tue, 11 Feb 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294858; cv=none; b=t6rEKIFUMG12QtnTmYGBHxE+t3JG/m9BOtqnlxYxjj2nLrg9gS2RXjgOkG6PdOsedqaaYHaqfF31vN4UR/6X85hKbIjQCi9zmybSZ8xVruybDHx4LRWzU0Y7OHBIA7P/88MtEuim6mKnBeIBKBKbsOP2MUv3wPAk5HqsLDLXzOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294858; c=relaxed/simple;
	bh=FZOH6OyHDBjJg9xVmcoCeBQFziGAhzbgWVCBsPq3hvg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFn+zRQOqmyIqOKvEoED5Jn/QU3Sylkfur2XvduO3PmaNbnmPPzGXVRMAbWSk7DG2I8Nu/ylBOKVacijRPHSIo/7j3Ay5WFhAe5rNpD0mAiwqULNBPibaowjD6EBXL5GH9BlGkDt/0S96hKO4iXOlp//TlvkXdIID94SDlxrwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspH906RMz6H8Yh;
	Wed, 12 Feb 2025 01:25:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 187D41400DD;
	Wed, 12 Feb 2025 01:27:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:27:32 +0100
Date: Tue, 11 Feb 2025 17:27:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/7] cxl/core: cxl_mem_sanitize() cleanup
Message-ID: <20250211172731.00003d4a@huawei.com>
In-Reply-To: <20250211075727.351895-3-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-3-ming.li@zohomail.com>
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

On Tue, 11 Feb 2025 15:57:22 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxl_mem_sanitize(), the down_read() and up_read() for
> cxl_region_rwsem can be simply replaced by a guard(rwsem_read), and the
> local variable 'rc' can be removed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
