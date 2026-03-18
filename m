Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384F39446D;
	Wed, 18 Mar 2026 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835224; cv=pass; b=HNY21IYbgYH9+tM8HkkoV6djZBtoIoGx/yTgqlm2M8G2x5nr6IonK043UpREjXnvt0/vshc00YkEQ0BYykLBZBDMd0GI30Wo+Wp+h4Yv+YEbJqZgP9K2WSUmqGu/O3Y8jODb8E+K9MAMT72vdMrU6yJ6S2RUGpjSp/DkW1iQa5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835224; c=relaxed/simple;
	bh=fB7e1ryITjaN9kQNp1POYNgCCJLXzUQNpEpEM9Iqpk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpRJPrlqmr0pDmzaSpsrvcyI6DssCEq9Jsk7I+YcL9epz8olGMeuKlwJ8ZqmvGhJNY367vhYf0U33fI1blg4yo9iQB1ZvgmpzVabYnJcg0z2CScycferc7w/JrV9Pd14B0SFVUABT5tAtR+7pQzbmhHBLrr+t9Xc05z0ufIwGlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=M2CI//FR; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="M2CI//FR"
ARC-Seal: i=1; a=rsa-sha256; t=1773835198; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RLQA4z6qi5/BxchbR6Fe1xYJPgyxBc7aUBiKqP2KihkLMtLh0aWwu77hE6poQPfB1/g/p4xQvrW/dfe0kr7B/vb7vkM/0aESyowiSGK0RL+aXUszJ8YeAb3PH+45wNxltk39/9lcZgz++RZbe04f2uMkm8+YchT1Gw61EQGatn0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773835198; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LYxpeDn1Wic2IKVtKMN7clbjlBnxLyqE/PirHDTALtY=; 
	b=mksFqS6iWkpVAfPnLQl+4dtXkhs4Hf8G0ZmH1pZdKwYOlCjtK5BWdBIoz8AWYR31dOXCNegYZ6lbul3rlwIJ90/rvoQg6pVoBvJT0Um2In1rTdXwOLXXHa7bhnkdXOz/CLocmhtMJ6qWfZA7jJmBejsRafY9pdAbGOoLNO8HODc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773835198;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LYxpeDn1Wic2IKVtKMN7clbjlBnxLyqE/PirHDTALtY=;
	b=M2CI//FRc0GefdcdqZdDGYYnPqQ60kVd/MnFf1WVdA17Kh80yT/Ce2hMDR2RtjnX
	nCAJuMHaKvSsagTdotM2YFwpqlJsp0oBSUKHUzq1nk6OcDDHrexr0MMWRsvxaIshEj0
	9qQUwPacQSRFZVT2nX/vkIKx4GNubox4n5OP7Xy0=
Received: by mx.zohomail.com with SMTPS id 1773835197042291.28080643367605;
	Wed, 18 Mar 2026 04:59:57 -0700 (PDT)
Message-ID: <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
Date: Wed, 18 Mar 2026 19:59:50 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
 <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228aea97446e2ba651cfe32a29000007067405a3dccab45aa6734dbd4ff9790bcdd50f4cc8b92a265ea:zu0801122774197e770c6792889bd5368200004cac4d67773206924b69d5caccc15db3b55efdc38a6ebe8b1a:rf0801122d394129d3cab9744d58cdbbb20000630c5c5c565db6cb0d2af22bed2a268874aed982476e00869046a31cea1493:ZohoMail
X-ZohoMailClient: External


在 2026/3/17 23:00, Dave Jiang 写道:
>
> On 3/14/26 12:06 AM, Li Ming wrote:
>> CXL memdev poison injection/clearing debugfs interfaces are visible
>> before the CXL memdev endpoint initialization, If user accesses the
>> interfaces before cxlmd->endpoint updated, it is possible to access an
>> invalid endpoint in cxl_dpa_to_region().
>>
>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>> interfaces until CXL memdev probing completed.
>>
>> The following patch will check the given endpoint validity in
>> cxl_dpa_to_region().
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Hi Ming, I dropped this patch with Dan's comments [1] and updated cxl/next. Please check and make sure everything looks ok to you. Thanks!
>
> [1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwillia2-mobl4.notmuch/

Hi Dave,

I think there is no change needed in this patch, just need a independent 
patch for holding memdev lock in cxl_region_debugfs_poison_inject/clear.

Or you want to review this patch again?


Ming

>
>> ---
>>   drivers/cxl/mem.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index fcffe24dcb42..ab88eaa31d1d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -48,6 +48,11 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
>>   static int cxl_debugfs_poison_inject(void *data, u64 dpa)
>>   {
>>   	struct cxl_memdev *cxlmd = data;
>> +	int rc;
>> +
>> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +		return rc;
>>   
>>   	return cxl_inject_poison(cxlmd, dpa);
>>   }
>> @@ -58,6 +63,11 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_inject_fops, NULL,
>>   static int cxl_debugfs_poison_clear(void *data, u64 dpa)
>>   {
>>   	struct cxl_memdev *cxlmd = data;
>> +	int rc;
>> +
>> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
>> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
>> +		return rc;
>>   
>>   	return cxl_clear_poison(cxlmd, dpa);
>>   }
>>
