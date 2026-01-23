Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E63033F5
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166505; cv=none; b=lFhR8o8hVlm4PWScv2fTebLp8AKHMKwwY0zv8xJDadU8JzytXXtpMk6Ofhxya3/csxX/QQtrWzQx0hSkeGoQkaEo4li5ifQd5oA3vvcp6HmmZWMRg4n/2Dzdg+h5EMaGKs+Y2siten0GCYttNXa3dR+CnD6lmDdNWuF4ziOTwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166505; c=relaxed/simple;
	bh=LPc2NiGKVvEmAZeu7nENKjO1fv0CZcYIWQ9vn50Qpjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UdBjUaA4RDjsc9Edd/pIh022FVWbgSmAHiEH7PxUyS3oHPBaOpm41BcXFqXBUOQEkcIIWk0MCDGMOwiBm6ydqSBv+cz8/9xriwZdWe8/r8avG7C2V6UPuPDJv6i3uwHO1VkTq02KCprMam71Sa/wzeqasZWYxft7nw3MBP3UJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y450oHsA; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y450oHsA"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260123110821epoutp02c701385f02f86a59b6ffc531891d7b23~NV48xxb5V1388213882epoutp02i
	for <linux-cxl@vger.kernel.org>; Fri, 23 Jan 2026 11:08:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260123110821epoutp02c701385f02f86a59b6ffc531891d7b23~NV48xxb5V1388213882epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769166501;
	bh=BJevo3itpVwBXmRCoQ1NVwoohIqbNpQuwb62OvK2wo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y450oHsAvsbM4fMXQ3j18Qp8JVnTBKhynQlb9JTkFEWNx3Dv4NTXCk4qxoVACWbCe
	 tgQGr2ssuMi90GfmX/S6v1922ahAhwIvRc3CmEUUC5esoJ9pnj4pBMmC6UXJMW/tcU
	 kCVvAxPi2jSbvN6bVZQAzzdZ4m8DgQ93jthRgaEo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260123110820epcas5p2e8a8de3054c2c7354271a8085f748b16~NV476zJ0J1063610636epcas5p2f;
	Fri, 23 Jan 2026 11:08:20 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dyFXg2zWFz3hhT4; Fri, 23 Jan
	2026 11:08:19 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260123110818epcas5p48f8a30d6f91523b9f800fdcd19f8acd9~NV46fW7hs2910829108epcas5p4z;
	Fri, 23 Jan 2026 11:08:18 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260123110817epsmtip1ef2bf544c5d964e14a63939e2087feef~NV45CBoRK0323103231epsmtip1Z;
	Fri, 23 Jan 2026 11:08:16 +0000 (GMT)
Date: Fri, 23 Jan 2026 16:38:07 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V5 08/17] nvdimm/label: Preserve cxl region information
 from region label
Message-ID: <20260123110807.yyzfhvb3vps3vzll@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260115180316.000023fe@huawei.com>
X-CMS-MailID: 20260123110818epcas5p48f8a30d6f91523b9f800fdcd19f8acd9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_11ed93_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260109124521epcas5p299cea0eaef023816e18f5fd32d053224
References: <20260109124437.4025893-1-s.neeraj@samsung.com>
	<CGME20260109124521epcas5p299cea0eaef023816e18f5fd32d053224@epcas5p2.samsung.com>
	<20260109124437.4025893-9-s.neeraj@samsung.com>
	<20260115180316.000023fe@huawei.com>

------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_11ed93_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 15/01/26 06:03PM, Jonathan Cameron wrote:
>On Fri,  9 Jan 2026 18:14:28 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>> Preserve region information from region label during nvdimm_probe. This
>> preserved region information is used for creating cxl region to achieve
>> region persistency across reboot.
>> This patch supports interleave way == 1, it is therefore it preserves
>> only one region into LSA
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>
>With change to import for getting the region uuid,
>Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
>> index 2ad148bfe40b..7adb415f0926 100644
>> --- a/drivers/nvdimm/label.c
>> +++ b/drivers/nvdimm/label.c
>> @@ -494,6 +494,42 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
>>  	return 0;
>>  }
>>
>> +int nvdimm_cxl_region_preserve(struct nvdimm_drvdata *ndd)
>> +{
>> +	struct nvdimm *nvdimm = to_nvdimm(ndd->dev);
>> +	struct cxl_pmem_region_params *p = &nvdimm->cxl_region_params;
>> +	struct nd_namespace_index *nsindex;
>> +	unsigned long *free;
>> +	u32 nslot, slot;
>> +
>> +	if (!preamble_current(ndd, &nsindex, &free, &nslot))
>> +		return 0; /* no label, nothing to preserve */
>> +
>> +	for_each_clear_bit_le(slot, free, nslot) {
>> +		union nd_lsa_label *lsa_label = to_lsa_label(ndd, slot);
>> +		struct cxl_region_label *region_label = &lsa_label->region_label;
>> +		uuid_t *region_uuid = (uuid_t *)&region_label->type;
>
>Another case where I think we should be importing.
>I'm not entirely sure why that's the convention for these but we
>should probably stick to it anyway.
>

Fixed it accordingly. Thanks Jonathan for RB tag



Regards,
Neeraj

------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_11ed93_
Content-Type: text/plain; charset="utf-8"


------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_11ed93_--
