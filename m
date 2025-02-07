Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CEE17F7
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738907272; cv=pass; b=QO1/wYd0coepo267Z2qR6U8kxqo+ruPpmrefwT5hLIr9Lop521G7AcVjh+PQxRHgDDS8MDUDIoFm6k7tObi30K1L0t5Djm7lfy+umpaorksflt67E/grASWRWlzh6Grnqba/CZZoCpP0jy7lRx4+Xz1ngQzUNTlgNuZaCp8Axuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738907272; c=relaxed/simple;
	bh=erXeSFBbgUZfwBSCfrBGuoTW4M8scGaxFKQJkTE/zRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvfYLORKYxapfWQMlU5RwmcbffLN1tRlgp+v23P02ydK8j5JfpxwKC0EuMOkmrx24z1Pn5OffoDuWibSAO32w9IPOFPdLMZmNgD//wDqotrV3/UKXlvGWUDu7Kd9N4UTRH9YcQcw3Z7o3vVYUTU3B5PXiH1RI9SzCe4YwCgcNj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=LyxC9Pqq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="LyxC9Pqq"
ARC-Seal: i=1; a=rsa-sha256; t=1738907252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D+I2gq+Kd5FZberXz61IRvRH8lK7W44EMUMKSxmaUCQfu7aDUw6514xjTAc7jxykq8hOV+n0WjcCsm6gi/ou7Xo+fJaRVr0gDjjApCKNl2fyw3z6h079TPXlODr5sYqq1whWEQR4SohL9yfhp65d+YFagHfYN9jPgYbjp7UvChA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738907252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=erXeSFBbgUZfwBSCfrBGuoTW4M8scGaxFKQJkTE/zRk=; 
	b=cQDx+YOsJJvOnsXkT3Iv2m+PFyVxmJVONLfjx8rq2S1ndEW2LiNTmsqtf1Hesm2GUzpq+OsLvRfup2L7DwEDloLk7hVycFIVdRoc+qB/jpZ0BepjDjZlmP6VmeBXdiX3es5GenBoQ/kpo5E+Xj0t9A4AV4RNXKQiBhfSZ8TPsp0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738907252;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=erXeSFBbgUZfwBSCfrBGuoTW4M8scGaxFKQJkTE/zRk=;
	b=LyxC9Pqq1MOqlpZ627iJJLGdbljTuw+XAvbB+23FcbjZ9P5h9JQuBuWhPgR81s7F
	x+BHcfd6+FhbpJgwEJGqx49KZSik5RZGFXGIa5ONKU/xXXzNH+RYqRSRa3bFcgQSAtP
	pJyqBFrQDFtxGl1hY55YguELSUMOO+KuO/xLHGqE=
Received: by mx.zohomail.com with SMTPS id 1738907250233611.2284754631473;
	Thu, 6 Feb 2025 21:47:30 -0800 (PST)
Message-ID: <3f223adf-89fd-4064-9fa3-7584845736f7@zohomail.com>
Date: Fri, 7 Feb 2025 13:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] cxl: Refactor user ioctl command path from mds
 to mailbox
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20250204220430.4146187-1-dave.jiang@intel.com>
 <20250204220430.4146187-2-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250204220430.4146187-2-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr080112278f0eb8470ee161f80701fa0a0000c86ce76fa67227fe430f9e1951b612fe520f9ba0ba04d962a1:zu08011227391cfcdf7affe2f27c0b83f800005b0c594f6475dd236664b96a4009aa06c18a24ef3ac4b605bb:rf0801122de2849b621ba4e0550f97698f0000ee62c0fc378dbd91b443aadafd3fa1c7b0b5d1ca1825ba6039650bb5b01f53:ZohoMail
X-ZohoMailClient: External

On 2/5/2025 6:03 AM, Dave Jiang wrote:
> With 'struct cxl_mailbox' context introduced, the helper functions
> cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
> rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
> directly.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Li Ming <ming.li@zohomail.com>


[snip]

