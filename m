Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F63377003;
	Thu, 21 May 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366361; cv=pass; b=pYKHOPUVIxQtrjDOKUMl2t/eqDPfSpAIn4178HX1sOg2iGPz4P/l3sRdXuNBQ2TUOadEddo0Tr5oQ03/yZnHiDc235ThxFJynxqVx2GShQDYfLa9v/rQJEdF2VReGtifzaBGq61sNQVls8jybkMcoGLIzAOs/pzpLnG0uYP53Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366361; c=relaxed/simple;
	bh=pweoEtZJzdwOEsw4zpDEp/CDyy7hYNo1I53TDsSHXyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNcYsVnBGpGixohv0xzjAWHrIOS5K/QftpnuuROhAQbKU2qOCJ9q0qBPprctvyXb23ElEfylYHyhoGipve0OvJ9ug6swQ8btpGthhHsMXXCyEGks4vX9COkvg+biDwlEp/NTY5UvoTmgoRWWy45XR2tDIl+rXmvlVYlF91uDrOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FhKrIZew; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FhKrIZew"
ARC-Seal: i=1; a=rsa-sha256; t=1779366343; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fJ5Koy/Sj+plR0Ju1tVCqOGp6wBN+U5U+WjKEFmBDIpDMMIjMpTl3UkBAJSj62X4vGkqj96Q9a6rdVmZ1F2g6u7kpnKMeJB+W5ozzzh3jlp8cVprlJ8UaBoNcI7cr04fwiEebdpdAEBFuunpqHN9Pzn/RTyIH10P2bMRFH+McnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779366343; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6+agQnC/0wBcqrjwlM6G8qV2CKS9GBDTOVdLrhMQPFA=; 
	b=YetADDFeBLvdOIIxu25vJ6lgJclrqDYEid4hnDax6XDxR0DWkmrn5M53WVEr/X41GgOewyhP2zYlsRpc/ryZH2wayJYtP/BkfLduyHx8oksm3t4IU+8oVSzoiGx6tmsm8wu4e1HRwFbvCYkNzAisK1QXI5Rm5gaB+g1iFRLO+pc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779366343;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=6+agQnC/0wBcqrjwlM6G8qV2CKS9GBDTOVdLrhMQPFA=;
	b=FhKrIZewj1xOuX7Am6Qpk5OzvatHcVEIcEgDEB3cvY2ko0DGdKwhL7+mzGFZeSVR
	FLXpp7nNv4XdQYULDXCehghNz/DwIod0xyFDiRnNZAbIOQLhOvh/eFDmtFcE0pMGX+7
	S3PeBLE4lLaGd0oBHtQdI079FQhv6iErW53lUebU=
Received: by mx.zohomail.com with SMTPS id 1779366340832574.5204486863552;
	Thu, 21 May 2026 05:25:40 -0700 (PDT)
Message-ID: <082c7b2d-e9dc-443a-b385-79585cf8e48d@zohomail.com>
Date: Thu, 21 May 2026 20:25:36 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/test: Update mock dev array before calling
 platform_device_add()
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520121457.234404-1-ming.li@zohomail.com>
 <ag6zbJFdvxkf6Q9I@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ag6zbJFdvxkf6Q9I@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112278150d11514914ee8ab2e16a7000044c9f796ae931728a4678d79e8fddf36648df26c206b95f8ca:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/21 15:25, Alison Schofield 写道:
> On Wed, May 20, 2026 at 08:14:57PM +0800, Li Ming wrote:
>> CXL test environment hits the following error sometimes.
>>
>>   cxl_mem mem9: endpoint7 failed probe
>>
>> All mock memdevs are platform firmware devices added by cxl_test module,
>> and cxl_test module also provides a platform device driver for them to
>> create a memdev device to CXL subsystem. cxl_test module uses
>> cxl_rcd/mem_single/mem arrays to store different types of mock memdevs.
>> CXL drivers calls registered mock functions for a mock memdev by
>> checking if a given memdev is in these arrays.
>>
>> When cxl_test module adds these mock memdevs, it always calls
>> platform_device_add() before adding them to a suitable mock memdev
>> array. However, there is a small window where CXL drivers calls mock
>> function for a added memdev before it added to a mock memdev array. In
>> above case, cxl endpoint driver considers a added memdev was not a mock
>> memdev, then calling devm_cxl_endpoint_decoders_setup() for it rather
>> than mock_endpoint_decoders_setup().
>>
>> An appropriate solution is that adding a new mock device to a mock
>> device array before calling platform_device_add() for it. It can
>> guarantee the new mock device is visible to CXL subsystem.
>>
>> This patch introduces a new helped called cxl_mock_platform_device_add()
>> to handle the issue, and uses the function for all mock devices addition.
>>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>

Hi Alison,


I missed that you mentioned putting platform_device_alloc() into the 
helper. I will send out v3 for that.


Ming

>
>
>> Fixes: 3a2b97b3210b ("cxl/test: Improve init-order fidelity relative to real-world systems")
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>> Changes from v1:
>> - Rebase to v7.1-rc4.
>> - Introduce a new helper to handle the issue. (Alison)
>> - Use new helper for all mock device addition.
>> ---
>>   tools/testing/cxl/test/cxl.c | 105 ++++++++++++++---------------------
>>   1 file changed, 43 insertions(+), 62 deletions(-)
>>
