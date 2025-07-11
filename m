Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF317A30F
	for <linux-cxl@vger.kernel.org>; Fri, 11 Jul 2025 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752200806; cv=pass; b=evTszASjgBBcRWyal7aT2zpvqbRtbiyz4E7fH8KaDbv01t8IP/rfa3UVp/2z01JtbXclvWgJCS1jKDWzQDyW9MMgGMnGC81XOWiKaieoEzV/IJ3ztwMWbI/cSP5l00z1BvmhWrGsKgMdDpdQ47H3yfqzJdinP0GR7FlI6iArcKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752200806; c=relaxed/simple;
	bh=7H4oLsk/lYg4AVantgSiEL+C14x+2zsX28anU9dYLVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtEcNFFs3Esqqr8WXZzGrKQDd/d0VMJV+GeiwQ+6TqcTCm47hQbvwOpE6PC4oAB0js2iDRzxnU8bbPocYPxh11sOVBgNwjj0LQzg6cxh9/TQfHclaG9CFWQSAsVWKhMxu11kY++YeMAWHKbwCm+anmMG4Gzc38KDXCqFd/M4dE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WDjEjYYx; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WDjEjYYx"
ARC-Seal: i=1; a=rsa-sha256; t=1752200796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KNmGh7tQhc0dD3M7qn/kTovaYfCgrou1DSip9HajyRur1+AwAZaLL+mhTCE9TIjCq3NDZd447bSWqoLXaCUZmtLgYw06F4K/wRFGooYJCSM/zCcIpKNpbIaz0fkxEwyd6GbOwAAfiVJk7Gns/S21MdROovex3vzD76RS7ohgL1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752200796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7H4oLsk/lYg4AVantgSiEL+C14x+2zsX28anU9dYLVI=; 
	b=TNeXbf5an0F2OarhLpuE8K6Fk1NDn+dcZoMOhwvp1HssWp5VcKeJ393j+Cn7Y3x40gSIx0SImUew1K1Gov2BIvr3hv/d32ckR86zvxzF7sLTo0wKCodQehvPQsDsGPieghRRaSIQ+4ybTqsuh0EsT8vDijzQbsdvrHueW6FmtPA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752200796;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=7H4oLsk/lYg4AVantgSiEL+C14x+2zsX28anU9dYLVI=;
	b=WDjEjYYxS9JGg49h6yp7kRceXy/KtE8l0vStWPjvigPYYw2Oxwu3886zSkzcNiPC
	LxPuPFYrdIt/+/Ty76YskhBf7HMHt2/gtrfoCIBYlC4/2qQaMEkM9wTNXYtswMIavd8
	D17D67w7iVzZTOAx58uIRBmtAt2gegc7aorXSe2A=
Received: by mx.zohomail.com with SMTPS id 1752200795105679.214548914937;
	Thu, 10 Jul 2025 19:26:35 -0700 (PDT)
Message-ID: <554a7a89-e14b-4c80-9235-13b1d2f358bc@zohomail.com>
Date: Fri, 11 Jul 2025 10:26:31 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] cxl: Create an xarray to tie a host bridge to
 the cxl_root
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250709203619.2607133-1-dave.jiang@intel.com>
 <20250709203619.2607133-9-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250709203619.2607133-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227a3371db32e88a3576f5e47a600006e3f7684a1279eb86c0cd851afb90904fd2ba848ace08e418e:zu08011227b3523443172dcf465064d7a400004886a379e2966fdabf3b9a8b8f9d6af5eaf8592795d95cf3b4:rf0801122d82b42f5e6952699bf8074653000040f553aced92ab6d2f778cb0f4e56730dee5708b34c8f11824947130dd2cce:ZohoMail
X-ZohoMailClient: External

On 7/10/2025 4:36 AM, Dave Jiang wrote:
> Add helper functions to setup association of a host bridge device to a
> related cxl_root. Functions are in preparation to support the moving
> of host bridge ports creation from cxl_acpi to cxl_memdev probe path.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
[snip]
