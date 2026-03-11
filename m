Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10263D0923;
	Wed, 11 Mar 2026 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225912; cv=pass; b=MJ7hs6Dt0Sgb/vXTF6JX1jy4DxrWu2ASA5yrKQXjkf2Db1+tOVc+3sbgERYFci9ZO1EjJLiSiQBxjfcqwknW/180zzUTEPTKmbnUhq7L+N9E5Ws9xKbQe8h3E+amG/CE7mptdxAMe0Y+q8RH4J5UThM81wKK/LLZJfPksiudGMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225912; c=relaxed/simple;
	bh=LIxcnHlZcUF9fwUjtkCMlYYE6Ra9b241DrYMMIb+y1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKBN4QkmckWFx54Uz0CFHejibB3oSdGYAtN3LrJFVaTzoOWZrxK/BtIRUYwzdaqxYAIOPtXKpcDVZWI6WrG/4iZ4AkTdz1MUfbaeeZXfOdqrP0OV8ESf3s3HEkksmgzrM9nYFtTOt1V8678D36KqPoDSlTxd0/1eS+vXPdVmHp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=fZzUOxtI; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="fZzUOxtI"
ARC-Seal: i=1; a=rsa-sha256; t=1773225891; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cnb8GHFCK0vIj6D47IY3JBKBznzlgW0EAZ/HK7bAy7rXu3yKlT49oByXfcnAKql11bvJAQcuGFk/roW2XwFHc9F05E9aQGt+kNN4HQWNSTLFh0gH8kqPGTdVfdQzWZmLS/Hm2sP59EQvK8nHzI2z4srts44IKaFcGAkMNgiQlyQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773225891; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qmE7Ip5S86Jn/C03rqv2fhaJ3G8+mLyntPnSvEQ4LwA=; 
	b=fssp8E/tGZX/k4IkiVt1QxeLzrw3jNtGgpFuxv2CziQj1sMGJkv3LQh82Kktpl+5+KfH2fUPG4IoTm1KXRPLk4Y7YJuNKGP8BZHInaNtg74u3Z61yneEwQriA2a6H1GmaS4F6aoSkdj3dnGxVZayrLeRvHUDSG4BtLuKtQ3d3Tk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773225891;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=qmE7Ip5S86Jn/C03rqv2fhaJ3G8+mLyntPnSvEQ4LwA=;
	b=fZzUOxtIa+bn5jrSihIwbxq3Bzna8NKPJblaqVH5NYeh9vfLo9t4eALZmYaIoBnS
	IOA8JNVMXt+uP7vCGVLxawnjhO4t/Zmvf6mgf2stAejjocDkMV4YLYJEzrbCIs2SGBJ
	jK0ovOLMeFdDcKfFeXo8V8YG8CQ6E+7nJNgv+h+E=
Received: by mx.zohomail.com with SMTPS id 1773225889026338.01111610954024;
	Wed, 11 Mar 2026 03:44:49 -0700 (PDT)
Message-ID: <f8c6a566-eaa3-405d-a62f-3d7d95a1f26e@zohomail.com>
Date: Wed, 11 Mar 2026 18:44:43 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cxl: Consolidate cxlmd->endpoint accessing
To: Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <69b08021288c7_490a1004d@dwillia2-mobl4.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <69b08021288c7_490a1004d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228f9f888cb6fc7e0880b707eed0000197c550ce40c12c2022b54573b1b909e68859f05fa42a4469331:zu08011227c8b9a86bad3a3c2979b944bf0000ecb2ccddb066dfddc6e653438260e8a2b61cdaf652fd5ea304:rf0801122d39f56d043dfef216d81d95e9000091e740bc0d129f54159421011a233985d6f6847b803a51bc43139be6beed6e:ZohoMail
X-ZohoMailClient: External


在 2026/3/11 04:33, Dan Williams 写道:
> Li Ming wrote:
>> Currently, CXL subsystem implementation has some functions that may
>> access CXL memdev's endpoint before the endpoint initialization
>> completed or without checking the CXL memdev endpoint validity.
>> This patchset fixes three scenarios as above description.
>>
>> 1. cxl_dpa_to_region() is possible to access an invalid CXL memdev
>>     endpoint.
>>     there are two scenarios that can trigger this issue:
>>     a. memdev poison injection/clearing debugfs interfaces:
>>        devm_cxl_add_endpoint() is used to register CXL memdev endpoint
>>        and update cxlmd->endpoint from -ENXIO to the endpoint structure.
>>        memdev poison injection/clearing debugfs interfaces are registered
>>        before devm_cxl_add_endpoint() is invoked in cxl_mem_probe().
>>        There is a small window where user can use the debugfs interfaces
>>        to access an invalid endpoint.
> This is the justification I wanted to see in the changelog of the
> patches themselves. That is a reasonable theoretical window.
>
>>     b. cxl_event_config() in the end of cxl_pci_probe():
>>        cxl_event_config() invokes cxl_mem_get_event_record() to get
>>        remain event logs from CXL device during cxl_pci_probe(). If CXL
>>        memdev probing failed before that, it is also possible to access
>>        an invalid endpoint.
> Makes sense, please put this in the changelog.
>
>>     To fix these two cases, cxl_dpa_to_region() requires callers holding
>>     CXL memdev lock to access it and check if CXL memdev driver bingding
>>     status. Holding CXL memdev lock ensures that CXL memdev probing has
>>     completed, and if CXL memdev driver is bound, it will mean
>>     cxlmd->endpoint is valid. (PATCH #1-#5)
>>
>> 2. cxl_reset_done() callback in cxl_pci module.
>>     cxl_reset_done() callback also accesses cxlmd->endpoint without any
>>     checking. If CXL memdev probing fails, then cxl_reset_done() is
>>     called by PCI subsystem, it will access an invalid endpoint. The
>>     solution is adding a CXL memdev driver binding status inside
>>     cxl_reset_done(). (PATCH #6)
> Makes sense. I jumped into the patches first since I was familiar with
> the problem space, but happy to see you did this analysis. Just
> cover-letter analysis can typically get lost in teh shuffle.
>
Thanks for review, Will do you mentioned above.


Ming

