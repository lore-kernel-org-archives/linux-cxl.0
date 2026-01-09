Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9633C52A
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959606; cv=none; b=K8lITJDaRgVPqqOH9S6krdgqyVlOQ3mIUuEOPlXMeIx4EHwDzxXVbBKT+BzRUUF5NqQh78oZkYYDJDk4O1mFybgHGEPgY8CIES0yrZNYQvURh9myZytMnmTr3ed+FjiEmBBSRESiMr4MpJF8OBq+TFY6682ywWBlgd0bJdpdSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959606; c=relaxed/simple;
	bh=icu3AxhyZbhaMGE5j+pkHkS98biryn6ZpnGHiV3BKD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=IAf689bErJxDohFD6aA1ITNFmJTvW05vG9lCL9SEUUzfhbm0nIeFo9GHdDCRaRdCbYz9OSXga5LdFfdlQckKRIE+ffJc+6H3/GDFEpffX79BVnWNQtiDY2nxDbygf2O46FUTsGZXAnlsD1izdHAfbkn/xEEv7LOgazh2hFvNZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Xy+3v3QU; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Xy+3v3QU"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260109115322epoutp02978aeede9a257032a283e8d9d48dfb6f~JDeRD9Iz11049310493epoutp02j
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 11:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260109115322epoutp02978aeede9a257032a283e8d9d48dfb6f~JDeRD9Iz11049310493epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767959602;
	bh=icu3AxhyZbhaMGE5j+pkHkS98biryn6ZpnGHiV3BKD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xy+3v3QUyxy95BSlfu9FOMtqsIfQK48u3fhW0sHUialkLhB9In8WVwbQ/x2SVUF12
	 E9EwJK5a6adRmGejM9Xioi0Hr4uqqoZlxpHX2Iycpc4B3zTpKqjmNYZPjbyFmMYfYG
	 KpqkF+cE+hhtVxztvQi3ryZOk7DFcPZLfc7ZbzYE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260109115322epcas5p334bfdc533804e41bc23a3e9e7e19662a~JDeQzPV4W0080600806epcas5p3Z;
	Fri,  9 Jan 2026 11:53:22 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dngC545Mwz2SSKb; Fri,  9 Jan
	2026 11:53:21 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260109115321epcas5p38098f78587cafd7f93e05e9a316e2eac~JDePdqFPk0080600806epcas5p3X;
	Fri,  9 Jan 2026 11:53:21 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260109115319epsmtip2a4146bae16c094af52ba20ce18169315~JDeOSPmbK1843718437epsmtip2a;
	Fri,  9 Jan 2026 11:53:19 +0000 (GMT)
Date: Fri, 9 Jan 2026 17:23:13 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V4 05/17] nvdimm/label: Skip region label during ns
 label DPA reservation
Message-ID: <20260109115313.r2ei4ymjtbkbkpy6@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251217143308.00006144@huawei.com>
X-CMS-MailID: 20260109115321epcas5p38098f78587cafd7f93e05e9a316e2eac
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_e5c06_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251119075315epcas5p2be6f51993152492f0dd64366863d70e2
References: <20251119075255.2637388-1-s.neeraj@samsung.com>
	<CGME20251119075315epcas5p2be6f51993152492f0dd64366863d70e2@epcas5p2.samsung.com>
	<20251119075255.2637388-6-s.neeraj@samsung.com>
	<20251217143308.00006144@huawei.com>

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_e5c06_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/12/25 02:33PM, Jonathan Cameron wrote:
>On Wed, 19 Nov 2025 13:22:43 +0530
>Neeraj Kumar <s.neeraj@samsung.com> wrote:
>
>> If Namespace label is present in LSA during nvdimm_probe() then DPA
>> reservation is required. But this reservation is not required by region
>> label. Therefore if LSA scanning finds any region label, skip it.
>
>It would be good to have a little more explanation of why these two
>types of label put different requirements here.
>
>I'd rather not go spec diving to find out!
>
>Otherwise LGTM.

Thanks Jonathan for review, I have added further explanation in commit message


Regards,
Neeraj

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_e5c06_
Content-Type: text/plain; charset="utf-8"


------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_e5c06_--
