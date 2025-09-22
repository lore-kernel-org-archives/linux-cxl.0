Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCF30DEAF
	for <linux-cxl@vger.kernel.org>; Mon, 22 Sep 2025 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556388; cv=none; b=nVDXwJkSiE5K4eKnfHw2qkS+xjdT8au4JBzy5fswphQftC/IpA6HFn90AFXKsGDwLV/aVr5FmYo2lAb+frQ99BxTjQ59dxaEj3VknikdQwmMnqEU844wnJKIk2K74fkzENI8S8Q1MFQp9FM6xBvLxXQbcquku4DcBdrXQ+218Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556388; c=relaxed/simple;
	bh=8SEjtJkR1/QQGTb33RuQl+wFIsWRN+uRNGbRS1qOw2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=GAqIzemzaq8opI4jgTxg968ZUPPaIRyGRE3bzE+je6Wo5O70NaBJEVFhrBO3qUt/THa0Xvh+yEh6tN8AN4ustlypzJ6nqH6LIsxEAHtve/g4ac1k52idgfFPM35hY5zVWrtI4Md/fHW9P4UBz7baSxCgF79xIKFedWtdtolRY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=stD218Td; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="stD218Td"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250922155302epoutp02903d7598942bde9308f997ead8c932b1~npbaEgsWy2557725577epoutp02W
	for <linux-cxl@vger.kernel.org>; Mon, 22 Sep 2025 15:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250922155302epoutp02903d7598942bde9308f997ead8c932b1~npbaEgsWy2557725577epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758556382;
	bh=nc4HWbzks6zhlSuczii+f3QofCotvzcWDnaQo6EtSvw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stD218Td0elRP7NI8Nr4PZ92onNxA7xQ/vrvm765SZF7CqPC4ebKgAlvSY38r8UoR
	 WTdiY9/v7j5O3JuPrjh2i2HAYbMUyGNUSCOBk5zjjrxgCw6ss5WWNtrUZAnzs5sTM8
	 ISr1z8svCy2PxR5HGzXejsll3RyVBjPKvFEpEUu0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250922155302epcas5p4587782eb24be033a3dd04584d97ca36e~npbZzcNdq1175111751epcas5p4x;
	Mon, 22 Sep 2025 15:53:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cVngy3hQVz6B9m4; Mon, 22 Sep
	2025 15:53:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250922124446epcas5p3d8583bdee0d74ae4306b46d22c920b09~nm3BGCDfX0848608486epcas5p3Z;
	Mon, 22 Sep 2025 12:44:46 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250922124444epsmtip194a409310d64ea59eb73a9c33bdeb98e~nm2-8ST-R2872528725epsmtip1b;
	Mon, 22 Sep 2025 12:44:44 +0000 (GMT)
Date: Mon, 22 Sep 2025 18:14:40 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V3 03/20] nvdimm/label: Modify nd_label_base() signature
Message-ID: <1296674576.21758556382506.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7622b25c-a0d8-47b6-910b-9b2e42e099e4@intel.com>
X-CMS-MailID: 20250922124446epcas5p3d8583bdee0d74ae4306b46d22c920b09
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----soDBqDLjZY69.qOUSh5c6eSvt.JbqG5U1KsulcNjaVs9ke29=_26d06_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20250917134134epcas5p3f64af9556015ed9dfb881f852ea854c4
References: <20250917134116.1623730-1-s.neeraj@samsung.com>
	<CGME20250917134134epcas5p3f64af9556015ed9dfb881f852ea854c4@epcas5p3.samsung.com>
	<20250917134116.1623730-4-s.neeraj@samsung.com>
	<7622b25c-a0d8-47b6-910b-9b2e42e099e4@intel.com>

------soDBqDLjZY69.qOUSh5c6eSvt.JbqG5U1KsulcNjaVs9ke29=_26d06_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/09/25 04:34PM, Dave Jiang wrote:
>
>
>On 9/17/25 6:40 AM, Neeraj Kumar wrote:
>> nd_label_base() was being used after typecasting with 'unsigned long'. Thus
>> modified nd_label_base() to return 'unsigned long' instead of 'struct
>> nd_namespace_label *'
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
>Just a nit below:
>
>
>> ---
>>  drivers/nvdimm/label.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> -static struct nd_namespace_label *nd_label_base(struct nvdimm_drvdata *ndd)
>> +static unsigned long nd_label_base(struct nvdimm_drvdata *ndd)
>>  {
>>  	void *base = to_namespace_index(ndd, 0);
>>
>> -	return base + 2 * sizeof_namespace_index(ndd);
>> +	return (unsigned long) (base + 2 * sizeof_namespace_index(ndd));
>
>Space is not needed between casting and the var. Also applies to other instances in this commit.
>
>DJ

Thanks Jonathan, Ira and Dave for RB tag. Sure, I will fix this in next
patch-set.


Regards,
Neeraj

------soDBqDLjZY69.qOUSh5c6eSvt.JbqG5U1KsulcNjaVs9ke29=_26d06_
Content-Type: text/plain; charset="utf-8"


------soDBqDLjZY69.qOUSh5c6eSvt.JbqG5U1KsulcNjaVs9ke29=_26d06_--

