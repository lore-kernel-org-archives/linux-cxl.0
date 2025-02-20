Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8D29D0D;
	Thu, 20 Feb 2025 01:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015758; cv=pass; b=AvN1ruXvrV7wgX1BKFh+UEED6SRehLkKsH7nikNz554PS/NAzj+ijM4JEn5V4VoKgrebQLpm0KAo04N0DjCafNWOp0IEvRFYrqbjnTiarmfiDGcRjKZlSnifLjEmnPul8b51U2nDZceRpZv2Z7EFdN+GktTf7LBCr+/PmVbeazY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015758; c=relaxed/simple;
	bh=zFNbcqKh5rsboW8gsA3IUH6XZSvliopp2lNve/OTK0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z48MkU2pq+DoZM4Zt8V2jx7TMI98cbmq9g/K/XvntN5bKDgrlD+OY6M9gAKrn1Ej2hKfJcpr7+O+1gwVcgNDEsReEK/j9WjPZt1j87Zc3YisaPvnn+NYy7RCradMXsuKkT47/0ycceZKHarmYICSd72PFaDrGn35rSTQ641oiw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=NP/tPj6i; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="NP/tPj6i"
ARC-Seal: i=1; a=rsa-sha256; t=1740015747; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R9XHGTDcorqZmWQEYzabkGQRjAL7fkhJD+pXNP9MTWNAtHLGU5KeuGYSsuv0whmZpSO0j2GfcsYOifczGQF96erxO7h8Y+Xu2omCZwCy5SdVcMgnDw3kTZnzQy42o1IDCowlKKBc/LmXxVwFkNzww/wzwcqaSL1mkN+B2ta9BCs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740015747; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uZwfI69b4MxD4n/d6i4oZ1tFnkBKhIzMhzj+nwnoqTc=; 
	b=ipZtSqKuc/9SCgMfmtOTSQrz6GFt9nzOBWi9t9K8ormxoLmuY1WH1mzvGg2Sn5FlpVzgnC4TFKxnqieXkCc7+nNBW93R9Uf930+W6uiRp+WfyaBV1wxwT2+ULIel/F0CPy4Iv0KYuAYjWgQG25gaM5C/ppG5B7n9rAvAJfOS1iw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740015747;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=uZwfI69b4MxD4n/d6i4oZ1tFnkBKhIzMhzj+nwnoqTc=;
	b=NP/tPj6idhgjkHihdW71oHupql5Eanm/LVxvFnT5XJ9hIOn6fi/NzRM2wJ5GQuQT
	Z/Uy+DQDYDp4Wm+EMKGnBCpnY7z9pYjjGrtfNDzu6+nDf/4/CR0ju7FOxKiTMV6jN1r
	8/x6lkoKGbPyETxHfhQDU1R0WqZFa1RMnyGpGNVI=
Received: by mx.zohomail.com with SMTPS id 1740015743937664.1925940226711;
	Wed, 19 Feb 2025 17:42:23 -0800 (PST)
Message-ID: <c2388b52-fba1-43a2-93c8-0700dd5aea92@zohomail.com>
Date: Thu, 20 Feb 2025 09:42:23 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cxl/region: Drop goto pattern of
 construct_region()
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 jonathan.cameron@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-8-ming.li@zohomail.com>
 <67b67f9d670d1_2d1e2947@dwillia2-xfh.jf.intel.com.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <67b67f9d670d1_2d1e2947@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227788f0509d750d4c7c3768cdd0000ff26b77b22ba79e96a9c37242129125d16643b780af16d106c:zu0801122718c71f38a234954100f57c0b00009843a68b46768c7933f4099e15c020441e0cb686d19a900e4b:rf0801122d1c750ac6637da0df73689e9a00003ab4bc8609cc9a4ae2eaa5bf6cf34a32bdd19b7d3ebfa9cc601c53d7329bf7:ZohoMail
X-ZohoMailClient: External

On 2/20/2025 9:04 AM, Dan Williams wrote:
> Li Ming wrote:
>> Some operations need to be protected by the cxl_region_rwsem in
>> construct_region(). Currently, construct_region() uses down_write() and
>> up_write() for the cxl_region_rwsem locking, so there is a goto pattern
>> after down_write() invoked to release cxl_region_rwsem.
>>
>> construct region() can be optimized to remove the goto pattern. The
>> changes are creating a new function called construct_auto_region() which
>> will include all checking and operations protected by the
>> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
>> and up_write() in construct_auto_region().
>>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> v2:
>> - Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)
>> ---
>>  drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
>>  1 file changed, 39 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 320a3f218131..7a9e51aba9f4 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3216,49 +3216,31 @@ static int match_region_by_range(struct device *dev, const void *data)
>>  	return 0;
>>  }
>>  
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static int construct_auto_region(struct cxl_region *cxlr,
> ...probably would have called this __construct_region() since there is
> little distinction that merits adding the "auto" qualifier.

Sure, will revert this renaming, continue to use __construct_region(), thanks for review.


Ming

>
> Other than that, for this and the others you can add:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>


