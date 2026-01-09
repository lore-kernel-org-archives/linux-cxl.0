Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3A34C140
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768145299; cv=none; b=Q5Zv3QH6w2u+eF25qh5L1JgQuvLACX4XRe1U2IO9UBMLCueAVikgMlDoPfd3qhiiMU1KqelFZQ1rpz2pZMyC66HyjWd5uAOl6KOdRor28I48BJkjvRaRjezm+ebrPrYjL4+Okf4GHNlJCDN9sEpGE6pB3udo3ZmoB5an8mPaV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768145299; c=relaxed/simple;
	bh=0D+FNr2bG8b5B5w0z3f5TeV9XFZmQd1KX4Qt/WyZaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UtPHOzs1bSwERLhAbQU+myrkqh7acdedXjvVSDHoeeVfirKcfxJRLfoGlsTXkjCX9Dm2dgwcUV39E1DmSYCN3QQcx821dnJkYALDmeRDO5WGA3fv/rBtRg6ofAhpKgyPYU0WRidgsgoWb3JoSAcesieDgZ/CEljnQGm1ljgi4hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JbjiCT/n; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JbjiCT/n"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260111152803epoutp012c4aec98667aaf8f74d19b29cb7d3a3f~JtsR_xy_K0553105531epoutp01P
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 15:28:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260111152803epoutp012c4aec98667aaf8f74d19b29cb7d3a3f~JtsR_xy_K0553105531epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768145283;
	bh=WMDclQIdZXDxp4yTsyCovBDtmRqF44kRaCmY8TINjRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JbjiCT/nCESWGZQu7Okf403XVJfGFxBdu0adj8RZ4bmu+3NpeoWFJYFSYRnnZz9bc
	 nASzt2ofnwePe0p4FtWgSCnGC848CU7HaJXp0PVM670zRKBsxQDpDIhG1YJ+CZ1S+B
	 bqDUHdD2p8/VvNOQevzPSeo4p9SZdRd/nXQC7RgM=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260111152803epcas5p4372934e462dbd2ede21b4a6be76755d1~JtsRn_Tye1673516735epcas5p4o;
	Sun, 11 Jan 2026 15:28:03 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dpzsv2ZK1z6B9m5; Sun, 11 Jan
	2026 15:28:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260109121357epcas5p450705a822781a84f58556d3771a2f0e4~JDwOnAn3V1579015790epcas5p46;
	Fri,  9 Jan 2026 12:13:57 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260109121355epsmtip135484a096d9ec12edd77c5fdac296efe~JDwNWRzM92195921959epsmtip10;
	Fri,  9 Jan 2026 12:13:55 +0000 (GMT)
Date: Fri, 9 Jan 2026 17:43:48 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V4 11/17] cxl/region: Add devm_cxl_pmem_add_region() for
 pmem region creation
Message-ID: <1931444790.41768145283345.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <80883937-a993-4f73-b719-18ec9a06014e@intel.com>
X-CMS-MailID: 20260109121357epcas5p450705a822781a84f58556d3771a2f0e4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_e5640_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20251119075327epcas5p29991fec95ca8a26503f457a30bb2429a
References: <20251119075255.2637388-1-s.neeraj@samsung.com>
	<CGME20251119075327epcas5p29991fec95ca8a26503f457a30bb2429a@epcas5p2.samsung.com>
	<20251119075255.2637388-12-s.neeraj@samsung.com>
	<80883937-a993-4f73-b719-18ec9a06014e@intel.com>

------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_e5640_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/11/25 02:33PM, Dave Jiang wrote:
>
>
>On 11/19/25 12:52 AM, Neeraj Kumar wrote:
>> devm_cxl_pmem_add_region() is used to create cxl region based on region
>> information scanned from LSA.
>>
>> devm_cxl_add_region() is used to just allocate cxlr and its fields are
>> filled later by userspace tool using device attributes (*_store()).
>>
>> Inspiration for devm_cxl_pmem_add_region() is taken from these device
>> attributes (_store*) calls. It allocates cxlr and fills information
>> parsed from LSA and calls device_add(&cxlr->dev) to initiate further
>> region creation porbes
>>
>> Rename __create_region() to cxl_create_region(), which will be used
>> in later patch to create cxl region after fetching region information
>> from LSA.
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>
>small comment below, otherwise
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks Dave for RB tag.

>
>> ---
>>  drivers/cxl/core/core.h   |  12 ++++
>>  drivers/cxl/core/region.c | 124 ++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 131 insertions(+), 5 deletions(-)
>>
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>>
>> +static ssize_t alloc_region_hpa(struct cxl_region *cxlr, u64 size)
>> +{
>> +	int rc;
>> +
>> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
>> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
>> +		return rc;
>> +
>> +	if (!size)
>> +		return -EINVAL;
>
>Why not do this check before acquiring the lock?
>
>DJ

Fixed it in V5.


Regards,
Neeraj

------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_e5640_
Content-Type: text/plain; charset="utf-8"


------on9-joxjuqL8vLZJsXK9p6vuNy0FCcc_Bo-VMubfWYorGk78=_e5640_--

