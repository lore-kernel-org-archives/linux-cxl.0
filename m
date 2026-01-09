Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5634B661
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768145114; cv=none; b=q3Olaqzf7QFFUvye9xb+rCACUFE0wzYWPZwpJ3hnKClfQkCsIZ8y4XfzdvF7av5+Rladbdntv7/C/G+ft/AMR/Wv4CS6idiMk8nEDR5k+i4QfOzQ1lXOFcrqvTrCjscZlun3WzNltXHnlZwvr/zuyAAe28hH1+DUFqW0IdgSxZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768145114; c=relaxed/simple;
	bh=9j/8kdLGpil/VIB+d2Yn82mNnf/7PeoplPI99zTTrAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=mzDB/G1++LPUkNMoT9wwmN1By+gR52TvCBtPGZMPbGYYqgsZhpZvmCEPpfL7roIYIdZjm1aPQxTU1HJ6g7ST1DlttJrEYBCyg8B/EUImOYkPCVIYkUl5TTyc5MzjEqeIGRyKLCARfic7wP5JyVvmK0wHwKneOkoTr+3wByTn5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NQuKFh9G; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NQuKFh9G"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260111152503epoutp02786f0d3287c11fdbccaa2865504c4f76~JtpqB69H20376203762epoutp02h
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 15:25:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260111152503epoutp02786f0d3287c11fdbccaa2865504c4f76~JtpqB69H20376203762epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768145103;
	bh=MHVDd4pa1j4KDmNX9wkuTMLEU+gEEFa+A5Ya+Xln8IY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQuKFh9GWm4LQq49bQIDhTyHPQtsM7BMxan+F8Br2Q3SRcO7RgEpUDrjg2SZrDsVh
	 ozosN0AaRa/uTsMQqIylQ/UH9LNJJGc2fadNCf/sWw/A8xXdfzn/DL1hxAW+n8azPr
	 G8iFYVpkq1oGhwUjn59cS/T913275mfMlRI5bwKA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260111152502epcas5p11365dd5ca332d72b953a83a94b49da1a~JtppWYdBg1468814688epcas5p17;
	Sun, 11 Jan 2026 15:25:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dpzpQ4q1Tz2SSKX; Sun, 11 Jan
	2026 15:25:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260109115641epcas5p24f39a149c8e2a50396fb2248d91bf199~JDhJ-DV2f1667016670epcas5p2M;
	Fri,  9 Jan 2026 11:56:41 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260109115640epsmtip16955f99afb0febcad3f347b124b3660c~JDhIxLOis1138711387epsmtip1V;
	Fri,  9 Jan 2026 11:56:39 +0000 (GMT)
Date: Fri, 9 Jan 2026 17:26:33 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, gost.dev@samsung.com,
	a.manzanares@samsung.com, vishak.g@samsung.com, neeraj.kernel@gmail.com,
	cpgs@samsung.com
Subject: Re: [PATCH V4 07/17] nvdimm/label: Add region label delete support
Message-ID: <1296674576.21768145102661.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0df5e529-e9bf-4fd5-ac54-4d9853f8e79a@intel.com>
X-CMS-MailID: 20260109115641epcas5p24f39a149c8e2a50396fb2248d91bf199
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_e5890_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20251119075319epcas5p2374c721a42a68cfb6f2b17b17c51c0ea
References: <20251119075255.2637388-1-s.neeraj@samsung.com>
	<CGME20251119075319epcas5p2374c721a42a68cfb6f2b17b17c51c0ea@epcas5p2.samsung.com>
	<20251119075255.2637388-8-s.neeraj@samsung.com>
	<0df5e529-e9bf-4fd5-ac54-4d9853f8e79a@intel.com>

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_e5890_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/11/25 12:50PM, Dave Jiang wrote:
>
>
>On 11/19/25 12:52 AM, Neeraj Kumar wrote:
>> Create export routine nd_region_label_delete() used for deleting
>> region label from LSA. It will be used later from CXL subsystem
>>
>> Signed-off-by: Neeraj Kumar <s.neeraj@samsung.com>
>
>Just one small thing below, otherwise
>Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
>> ---
>>  drivers/nvdimm/label.c          | 76 ++++++++++++++++++++++++++++++---
>>  drivers/nvdimm/label.h          |  1 +
>>  drivers/nvdimm/namespace_devs.c | 12 ++++++
>>  drivers/nvdimm/nd.h             |  6 +++
>>  include/linux/libnvdimm.h       |  1 +
>>  5 files changed, 90 insertions(+), 6 deletions(-)
>>

<snip>

>>
>> +int nd_region_label_delete(struct nd_region *nd_region)
>> +{
>> +	int rc;
>> +
>> +	nvdimm_bus_lock(&nd_region->dev);
>
>You can use the new nvdimm_bus guard() now.
>
>guard(nvdimm_bus)(&nd_region->dev);
>
>DJ

Hi Dave, Thanks for RB tag, I have fixed it in V5.


Regards,
Neeraj

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_e5890_
Content-Type: text/plain; charset="utf-8"


------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_e5890_--

