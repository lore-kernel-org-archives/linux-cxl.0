Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D711267B91;
	Tue, 11 Feb 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294927; cv=none; b=CflzS7//KKeVOHf3BayUtprNN4VZRVYEvMF9HduXrcaJhuPMyRFS8P7PD3I2YRaqrgOidLp/oB38CNoJtCFGTYB/bDvQ34tSNXZZcyApa0AxoWQ36LRfwqtc4JybVftsU/j8gm0s8FZN/6qNGQM2lx7CzqWemANMZ2ye38csPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294927; c=relaxed/simple;
	bh=O5GKAX2PkOI18oPbwmjgjpUqZcfwLNdfeZ7BHlYSKe4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPAvW3KOjsMLqY5Ekaa9RiRK0sjvQbtSryjAdZGtEmRZAabEXMDoAKmnn3AcHiVAGqc4qDjBYVCpy+Xkwzz1By5DpKoY6TFZ1eekwiUN53qF7lFb59bFt6QM2mYGeqEOMyUkpR6MPCGEcihm3F0/Tgr6tVjjWpt/0VV0n+jEWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspKr2nvgz6K91Z;
	Wed, 12 Feb 2025 01:27:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B18E21402A4;
	Wed, 12 Feb 2025 01:28:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:28:41 +0100
Date: Tue, 11 Feb 2025 17:28:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/7] cxl/memdev: cxl_memdev_ioctl() cleanup
Message-ID: <20250211172839.00005435@huawei.com>
In-Reply-To: <20250211075727.351895-4-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-4-ming.li@zohomail.com>
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

On Tue, 11 Feb 2025 15:57:23 +0800
Li Ming <ming.li@zohomail.com> wrote:

> In cxl_memdev_ioctl(), the down_read(&cxl_memdev_rwsem) and
> up_read(&cxl_memdev_rwsem) can be replaced by a
> guard(rwsem_read)(&cxl_memdev_rwsem), it helps to remove the open-coded
> up_read(&cxl_memdev_rwsem). Besides, the local var 'rc' can be also
> removed to make the code more cleaner.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
Seems reasonable to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
