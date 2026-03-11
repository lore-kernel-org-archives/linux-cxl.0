Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9178329C73;
	Wed, 11 Mar 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227727; cv=pass; b=WQbTkgEqjpGlcfP2D2m+0+IbSKt9z2pd+5OVncfrfMR0uyDkiavAwjImi6tvGQVeNw526NUhvMZTfG9ZqmV9b9giLsaee8YKYkR/mkbTtCGlqoDy4fHJivnsY22FZPOM1TYGSVBGYe9Zq7183so4DhzzObIFB7K+Yv9ZdL1uRKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227727; c=relaxed/simple;
	bh=oQ9AY8yyQkzL7aPCR0fgTcLgHESCks1t3Sdwu+AzGh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1JDvhsHKemHTzr1h2e9cDv+Z0ik8XVZsrnHD4kOwR74O5ZJ5MWmaPEB8zG/NvYxuT5pR7P8MGfJKIFSZUfmnXfCf5Q++l64uSV/3AFE/09sUSX8EiwbDd9t2DOBx9qIx6ubRPbb+lZnfjNKdRjacI+xlmipYdd65kKMW4ZnRD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eGW4Apr1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eGW4Apr1"
ARC-Seal: i=1; a=rsa-sha256; t=1773227548; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HKxz33duucArsuXaLMF4ks6fU68zQPb6ghOzK9209b/3w62NPIGDCrReEES6udOzt33Zus6Iq30+WsyNj/Z0a87/C6RyfmnorhZii9jtIZEeamCTHmrO7ncQZjh0tWxOCZramAlOD3+l4gARrfiI/BHb3XVgSrS+M9+YIOlwra4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773227548; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oQ9AY8yyQkzL7aPCR0fgTcLgHESCks1t3Sdwu+AzGh0=; 
	b=CZ9vcYJv51xiFzecBEvxvhqMsrFBjUEVORlUpA9SvLOVHpl+eIaRM7P4JJVFGdg+PmQ45GHtVZnUAiGpqRuoZ1ZXxD966xkyGvubGLUeBxKKe5suc/v45Yhhq5jXGBxcO79iFW8Vy11FjqX5iVgYjIxbrxFt3nRR2J3t1CJHhzI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773227548;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=oQ9AY8yyQkzL7aPCR0fgTcLgHESCks1t3Sdwu+AzGh0=;
	b=eGW4Apr16LkMDhre1XcCWZKnXfJRM+0jaVfkoTMvjP/hgcWGsTDrIDxRJgl8u386
	UjGERYk1HFESsN43/+Bsk4tjnJpMlcVd4F4T2/E2DQxZEQ0x3J99dP0VPTQK+M7QHWO
	qvTp+vE6JIkYytMDrlr+DmN6yTahq7r3C2+LTvnM=
Received: by mx.zohomail.com with SMTPS id 1773227548047581.9752619810631;
	Wed, 11 Mar 2026 04:12:28 -0700 (PDT)
Message-ID: <a9e76776-66ca-432b-9e09-0d16a09b8d5b@zohomail.com>
Date: Wed, 11 Mar 2026 19:12:24 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cxl/pci: Hold memdev lock in cxl_event_trace_record()
To: Dave Jiang <dave.jiang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-4-94fe919a0b87@zohomail.com>
 <b348fe73-401a-4352-a6b7-adb42e0e4641@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <b348fe73-401a-4352-a6b7-adb42e0e4641@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122895a4557629c712e89d6db0220000d8bbfbdf6360d400233b83c4d462fba8db33537bc0b6ef679e77:zu080112279c22be99a643eb8349959d7b000029a178ff6205152be5157bae46d13b5c6509ae8f0002a87668:rf0801122d0553cd34dc0163f8c29826f9000041fbbc16fcdc759d254883a60042dcf9de77e9f69239fe2a4b7cf5fce23864:ZohoMail
X-ZohoMailClient: External


在 2026/3/11 04:52, Dave Jiang 写道:
>
> On 3/10/26 8:57 AM, Li Ming wrote:
>> This is a preparatory patch for the following changes.
>>
>> To enable endpoint validity checks in cxl_dpa_to_region().
>> cxl_dpa_to_region() has to require caller to hold CXL memdev lock to
>> ensure the CXL memdev probing is completed.
>>
>> So holding the given CXL memdev lock before invoking cxl_dpa_to_region()
>> in cxl_event_trace_record().
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> With what Dan said,
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks for review.


Ming

[snip]

