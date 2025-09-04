Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A33F2FF15B
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993236; cv=none; b=Oui+nLzzl3rPgmFUsol4yIdfr/Ftu6OD1ZdU+qDwez8Z+UT4PqTuKXn2xO+LkW+3ZN75e9lbIbqcKJlNO0SjLtPpKqIuuCPqUni9QwTbuZk39StA9MjaanUT4P3jLU7yJzIaPN6ZnfQ/Kr3eqBVBPVJPZvpJNqq4gTU2SYbgNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993236; c=relaxed/simple;
	bh=f0VKvfcxcqp6prwvyDR7E5paWoWsKVNqtJ8vYx0WMOM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=EW+50RSShYetKL3DrDAeEx88vw3UOroZ9ePxGywQBoXj9B1UCImBSvFOmLcAf79JYqD45tV5AQwTqydW4z5eoJOfyVPy7ZoQLMkpurxrzRtP1ePLHsY8fpYsyQWk1fdjThL+wi9BMn6qaV4Tzqmv+9rOy+9eRgKVHLhdyvI1o7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZYbtmyMh; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZYbtmyMh"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250904134031epoutp012fb30758f69f419cf0e2a3d96000528a~iGAj0aQRc0228802288epoutp013
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 13:40:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250904134031epoutp012fb30758f69f419cf0e2a3d96000528a~iGAj0aQRc0228802288epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756993231;
	bh=BsBfJR+lA4TmjoPLX9AyfVs1Y1K/0YN7XGIQ6qD5wcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYbtmyMhohI6V0zRtFPGIg2THoiqTMLNj+CV7wZedK3BhK+2+kKegPeQVZ0Gj/D4a
	 cheK5xAUKkRDT286PMBkxF16AyQi/Y0v7lCoiKiTRB0yOpE7LnIuIkwg9PFMCufzxO
	 G8i9qb6Ja9qUdGyen21Uf7KrC526DGpgZXx51Lf0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250904134031epcas5p2c7edf218537964b19c77cfc72621e3ee~iGAje4_cH3238132381epcas5p2P;
	Thu,  4 Sep 2025 13:40:31 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cHgbL0WVNz6B9m8; Thu,  4 Sep
	2025 13:40:30 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250904134029epcas5p32f6c7fdc7639a9f437c50c4d86f8465e~iGAh1avU70152001520epcas5p3z;
	Thu,  4 Sep 2025 13:40:29 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250904134028epsmtip1e10c078d10c7ced3365c7af827d3c277~iGAgsO5op0826108261epsmtip11;
	Thu,  4 Sep 2025 13:40:27 +0000 (GMT)
Date: Thu, 4 Sep 2025 19:10:22 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V2 03/20] nvdimm/namespace_label: Add namespace label
 changes as per CXL LSA v2.1
Message-ID: <20250904134022.he22bcwbulwvaxf6@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250813142737.00005b0f@huawei.com>
X-CMS-MailID: 20250904134029epcas5p32f6c7fdc7639a9f437c50c4d86f8465e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_ea964_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250730121225epcas5p2742d108bd0c52c8d7d46b655892c5c19
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121225epcas5p2742d108bd0c52c8d7d46b655892c5c19@epcas5p2.samsung.com>
	<20250730121209.303202-4-s.neeraj@samsung.com>
	<20250813142737.00005b0f@huawei.com>

------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_ea964_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 13/08/25 02:27PM, Jonathan Cameron wrote:
>On Wed, 30 Jul 2025 17:41:52 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>> CXL 3.2 Spec mentions CXL LSA 2.1 Namespace Labels at section 9.13.2.5
>> Modified __pmem_label_update function using setter functions to update
>> namespace label as per CXL LSA 2.1
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>
>> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
>> index 61348dee687d..651847f1bbf9 100644
>> --- a/drivers/nvdimm/nd.h
>> +++ b/drivers/nvdimm/nd.h
>> @@ -295,6 +295,33 @@ static inline const u8 *nsl_uuid_raw(struct nvdimm_drvdata *ndd,
>
>> +static inline void nsl_set_alignment(struct nvdimm_drvdata *ndd,
>> +				     struct nd_namespace_label *ns_label,
>> +				     u32 align)
>> +{
>> +	if (ndd->cxl)
>> +		ns_label->cxl.align = __cpu_to_le16(align);
>
>The bot caught this one, it should be __cpu_to_le32(align);
>

Yes Jonathan, I will fix this in next patch-set

Regards,
Neeraj

------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_ea964_
Content-Type: text/plain; charset="utf-8"


------6Bw0j5KOoRaxZeQKOp2dAcC2OKT3No9WZFWhMG37wfGsvvbi=_ea964_--
