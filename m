Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A53313550
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296617; cv=none; b=UkTpP7V0CGpNwWza7HbOwywT3WDke4DdjS5kFt68DOsuU3sDDFPlefqPP9L/SQey/bi3oAiTUGhiMDZ+Fn9xTmmr9IvQYlLqF2jTPk5QDcW4I7g/FBvStEuapIObNyIIapumNJyaRBoRkTSzSDOtvbrmsXAr5D1lYexZGKHYC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296617; c=relaxed/simple;
	bh=zVgoSOAS0/2F/Rd+jjakikb46SMD0A85mgpmhFng1sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=qXg60gqS/2Jf5ljzKv5wYVA5P/Z11L+yWKDrqcBjKCmy7cLzmBFVB4JVlJeRmeDWaRsQ7uRaHYHvlcX9TbHOqgZKZmEYPYTywfrdt/SXWesoF1zyo0bDxt0WHE1Aw8wPGE/D3D/7YJbgTl8BW7JIEJjZLe6pXaHxCSQsoFQ9aWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ITaBrYl9; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ITaBrYl9"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260113093003epoutp0266f3c2dce3edcdc8fedbae102d968c19~KQGRvd90l1279812798epoutp02S
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:30:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260113093003epoutp0266f3c2dce3edcdc8fedbae102d968c19~KQGRvd90l1279812798epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768296603;
	bh=zVgoSOAS0/2F/Rd+jjakikb46SMD0A85mgpmhFng1sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ITaBrYl9t/lMVva7WK5CsVczDalVFaSuqW3cwRLRy2zWJ/jlqsFudaBOHj+K4Dyxv
	 8XznTfVrQOfxKjATFDWk8AdGyzkjSJ/pyEvF3dXzK+NbjR3tQOw6Nr5maRPA3z9v4I
	 fwSk8PRC8bUnAFp5AFAw8TyLbmsbh594oxDsBfkY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260113093003epcas5p30a07b321ce7386f00f6dd3cdfd324ace~KQGRUTjQA1987819878epcas5p3N;
	Tue, 13 Jan 2026 09:30:03 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dr3qv1ntFz6B9mD; Tue, 13 Jan
	2026 09:30:03 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260113091259epcas5p454c34f4e65bfce46b67cadf73e1a8fcb~KP3XjBawe3213732137epcas5p4E;
	Tue, 13 Jan 2026 09:12:59 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260113091255epsmtip15b1219d46af612c9a1394666b24a6d72~KP3Ty-Qn60613506135epsmtip14;
	Tue, 13 Jan 2026 09:12:54 +0000 (GMT)
Date: Tue, 13 Jan 2026 14:42:42 +0530
From: Neeraj Kumar <s.neeraj@samsung.com>
To: Gregory Price <gourry@gourry.net>
Cc: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, gost.dev@samsung.com,
	neeraj.kernel@gmail.com, cpgs@samsung.com
Subject: Re: [PATCH 3/6] cxl/core/region: move pmem memctrl logic into
 memctrl/pmem_region
Message-ID: <664457955.21768296603246.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aWV8jSUoCG5Yxv_v@gourry-fedora-PF4VCD3F>
X-CMS-MailID: 20260113091259epcas5p454c34f4e65bfce46b67cadf73e1a8fcb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f2702_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260113091259epcas5p454c34f4e65bfce46b67cadf73e1a8fcb
References: <20260112163514.2551809-1-gourry@gourry.net>
	<20260112163514.2551809-4-gourry@gourry.net>
	<1b9d3e1c-7b8a-4c9d-8788-4f901f985079@amd.com>
	<aWV8jSUoCG5Yxv_v@gourry-fedora-PF4VCD3F>
	<CGME20260113091259epcas5p454c34f4e65bfce46b67cadf73e1a8fcb@epcas5p4.samsung.com>

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f2702_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 12/01/26 05:58PM, Gregory Price wrote:
>On Mon, Jan 12, 2026 at 03:10:47PM -0600, Cheatham, Benjamin wrote:
>> On 1/12/2026 10:35 AM, Gregory Price wrote:
>> > Move the pmem_region logic from region.c into memctrl/pmem_region.c.
>> > Restrict the valid controllers for pmem to the pmem controller.
>> > Simplify the controller selection logic in region probe.
>> >
>> > Cc:
>>
>> May want to forward this to whoever this Cc tag was meant for :).
>>
>> One nit below, otherwise this looks good to me:
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
>
>doh, meant to send this to Neeraj at samsung because they've been poking
>at pmem stuff. Thank you.
>
>~Gregory
>
>Neeraj:
>Link: https://lore.kernel.org/linux-cxl/20260112163514.2551809-4-gourry@gourry.net/

Hi Gregory,

Sure I will use this new infra for LSA 2.1 Support.


Regards,
Neeraj

------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f2702_
Content-Type: text/plain; charset="utf-8"


------bVwHse4Nykw-L2c5iRRXKf-G.8k0lxUwrpcTFjGaDb9lfltx=_f2702_--

