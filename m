Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109595661;
	Wed,  9 Jul 2025 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032758; cv=pass; b=LCBCZFGC1NPt3EdvOBs1WpNYILJvTXBJLbzPFnszDDd3TqlsA9f9tEny7DnmkB4vFOU7sIqK5t7ouvk8Kzh1fIdS0G0o2seUWMVgngIrUTFkNA5Nf4BZRc9OxcLwCnknfKAYwuiq2FLINBinjWbpGpGBTasvunAFh4WH14P7d2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032758; c=relaxed/simple;
	bh=CoqcBRDeH+ltv+XhyS/Kww+RtCdtJB9Y0YQ/df8CR/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBQZW2ivAmDRyhRNH4taznM7x1S0abxBOz9hccJ8MAvXoQ3xuf2enbDlDGomkWrqmINJqtOWNax8xfxMAM2eybnt57TF6zFJ14ACm8hWAEOSiVcmr/sjp47Fl8oQph8lOLKzFX+CW38TvufmIlNumnEyC55lCbYp0yHQXJGxueE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VxSD3Hvq; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VxSD3Hvq"
ARC-Seal: i=1; a=rsa-sha256; t=1752032740; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kFqNtl9IpdIg6IMfiO3qZJTD1z2F6jiBcJAr0f6qxn9LyUFeMhb5IBguSbCrXhk+J5ebnebKP6DeMicN/csu+RNSsVrpFg1gzBGbWRwufcThdIBU4GxHklN6Z1U2dfC9tJPUeCM4wSbMyRY2HhjfGU9GVAC4ntSaOKs40NxB+1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752032740; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6h01kddoKngdD1ADu2AP8obsaEwlXaKbdKeuNkqGjN0=; 
	b=KKNKr10OABIamJTtJEnmWHtNfP6XOpVSFZuRQs8YB/6mzgPw0vN+w3Xf+clPbj1CoHOHvxZEgQE73w+5hAScvFOs77se5H75SSIAy41HMHe0HsYM/hbO4kCrNKhJnyW0q9EbJVC/OGRpkqcUt7xYGaH3lJnhKSsTOxrXOaUKQdw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752032740;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6h01kddoKngdD1ADu2AP8obsaEwlXaKbdKeuNkqGjN0=;
	b=VxSD3Hvqe1cMKJQa5cRqj5AUHVfoih6dQjR9gUbmHom4ywES3+p9PQaYbujDn0HM
	4sU4nJFN00kM8oNjI6vsRb3EbPjanTz+10IebjdWGgmF0QbLHmeJjWs+dhJBsfTbc8g
	87spp577qzzts4NrKjWT0VjiGOVLPOTJEBOk3Zt4=
Received: by mx.zohomail.com with SMTPS id 1752032738121925.2385401013482;
	Tue, 8 Jul 2025 20:45:38 -0700 (PDT)
Message-ID: <d8ea29f9-6ea6-4952-8c89-853e8c8ccb1d@zohomail.com>
Date: Wed, 9 Jul 2025 11:45:33 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] cxl/core: Introduce a new helper
 resource_contains_addr()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250708051536.92119-1-ming.li@zohomail.com>
 <20250708051536.92119-2-ming.li@zohomail.com>
 <aG0bB2hrIZkq3Uv1@smile.fi.intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aG0bB2hrIZkq3Uv1@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122773db6b5ee53b61c587d4a66400005f73233c3b47b5c6700df9556a998810f788214fcb50701e5f:zu0801122750552c0e87a797654dc7a2870000719af2a6001f8da3535176d1593ac3b8286c721040f3298475:rf0801122d9ea494f92891d2df80261401000093f5b3ab3bf2bbd962306a9ef04b732019ec3f7244e2bee43d67f57baf086a:ZohoMail
X-ZohoMailClient: External

On 7/8/2025 9:20 PM, Andy Shevchenko wrote:
> On Tue, Jul 08, 2025 at 01:15:34PM +0800, Li Ming wrote:
>> In CXL subsystem, many functions need to check an address availability
>> by checking if the resource range contains the address. Providing a new
>> helper function resource_contains_addr() to check if the resource range
>> contains the input address.
> ...
>
>> +bool resource_contains_addr(const struct resource *res, const resource_size_t addr);
> Right, the problem is that it collides with the resource namespace. Please, add a prefix.
>
> bool cxl_resource_contains_addr(const struct resource *res, const resource_size_t addr);
>
> ...
>
>> +bool resource_contains_addr(const struct resource *res, const resource_size_t addr)
>> +{
>> +	if (res->flags & IORESOURCE_MEM)
> resource_type() ?
>
>> +		return res->start <= addr && addr <= res->end;
>> +
>> +	return false;
> I still think using DEFINE_RES_MEM() with resource_contains() is a better
> approach.

Will do all you mentioned, thanks


Ming


