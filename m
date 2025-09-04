Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B463218A7
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996321; cv=none; b=A05j5x7sRdkj87F+L83cnYgpOPVAO0KoGSO19QFWCFAlIQm9Jf5ZRBIauTuRd45iTvKx8TJ3cmDhKiFhwJ54VDvc2nuzhd7J83uHhsIBH8NCSTJhxYihbB856Xp5qdFf7ZczQ5RVDxrlwn+4Sx0nwPj39qEENMhGWis8KlbQSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996321; c=relaxed/simple;
	bh=pOYzpNvEXfcm0qpIrYMCDV44pd/YqH0tr1BQn22KkZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Q+sB2+8jNyuUDaLGnI+l/QuVbEa+CqUH9LvEgheTuFfIhFsOhh5aQlPMB2wNUMwtiyq1nOkmKIFxLKXobFGX3ddXxe8zD0WNhfARw3B8Y8BoTnqLqlqJWhcriXdxIdav5L0qLUpR8mfTqY4E99xRYdpnUXL/EKArH4iyBGvSrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TD+/1NJZ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TD+/1NJZ"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250904143156epoutp010514baada66fd1a1b789f0d3a6b053f6~iGtdWOS_a1307513075epoutp01H
	for <linux-cxl@vger.kernel.org>; Thu,  4 Sep 2025 14:31:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250904143156epoutp010514baada66fd1a1b789f0d3a6b053f6~iGtdWOS_a1307513075epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756996316;
	bh=/dCjz648ZMWWscvrximJ+HPN0rRyOBvUSp8nmPnE2Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TD+/1NJZ31JjTz5nkhBeH3xwu1CUO/45hHkDrCmQcd7THY/c7j+QK89Qb4Cb6fBik
	 WBXRuMPkL601nyMGs7/55wgE7z0mYvzKUDzinVBJjk2qDb8L0Iaxdk02oHVtu5KuG6
	 oR1MbZJCYHon6B9jAWo/ep8WIF93DtZjfXpeZfn4=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250904143155epcas5p4c781c9d12c51e66d84b2ad5d2681e0a2~iGtb-yaca1643116431epcas5p4M;
	Thu,  4 Sep 2025 14:31:55 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cHhkf2wlpz6B9m4; Thu,  4 Sep
	2025 14:31:54 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250904143153epcas5p3be47c3d064aa6a0143f28ffda269c0bc~iGtaou6GP0637606376epcas5p3D;
	Thu,  4 Sep 2025 14:31:53 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250904143152epsmtip1876f9cefe9bfe18804dbf941dafbaa7b~iGtZetsv50745407454epsmtip1D;
	Thu,  4 Sep 2025 14:31:52 +0000 (GMT)
Date: Thu, 4 Sep 2025 20:01:48 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V2 09/20] nvdimm/namespace_label: Skip region label
 during ns label DPA reservation
Message-ID: <20250904143148.yqv5ialvoruzf5po@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250813160925.000015c8@huawei.com>
X-CMS-MailID: 20250904143153epcas5p3be47c3d064aa6a0143f28ffda269c0bc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_ea748_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250730121234epcas5p2605fbec7bc95f6096550792844b8f8ee
References: <20250730121209.303202-1-s.neeraj@samsung.com>
	<CGME20250730121234epcas5p2605fbec7bc95f6096550792844b8f8ee@epcas5p2.samsung.com>
	<20250730121209.303202-10-s.neeraj@samsung.com>
	<20250813160925.000015c8@huawei.com>

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_ea748_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 13/08/25 04:09PM, Jonathan Cameron wrote:
>On Wed, 30 Jul 2025 17:41:58 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>> If Namespace label is present in LSA during nvdimm_probe then DPA
>> reservation is required. But this reservation is not required by region
>> label. Therefore if LSA scanning finds any region label, skip it.
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>> ---
>>  drivers/nvdimm/label.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
>> index c4748e30f2b6..064a945dcdd1 100644
>> --- a/drivers/nvdimm/label.c
>> +++ b/drivers/nvdimm/label.c
>> @@ -452,6 +452,10 @@ int nd_label_reserve_dpa(struct nvdimm_drvdata *ndd)
>>  		lsa_label = to_label(ndd, slot);
>>  		nd_label = &lsa_label->ns_label;
>>
>> +		/* skip region label, dpa reservation for ns label only */
>Confusing comment and not clear if skip applies just to region label or
>to dpa reservation as well.
>
>		/* Skip region label.  DPA reservation is for NS label only. */
>
>or something along those lines (assuming I have understood this right!)

Sure Jonathan, I will fix it in next patch-set


Regards,
Neeraj

------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_ea748_
Content-Type: text/plain; charset="utf-8"


------CDBSwZz52MZUMeM1Rx6lI.cEW_5b_YZAAzr3v09AM7rvldzc=_ea748_--
