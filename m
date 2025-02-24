Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42332571B6
	for <linux-cxl@vger.kernel.org>; Mon, 24 Feb 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398973; cv=none; b=ocD8K9UHFYJd7O0Qy9yDQZv0qbfn82z2ZPHvRUE3Co1sQwvbJzAyGvDdxUdR9W+siXrsnrE7HJwz7uKlOZLE4vIOAVFv29HDfxR1ON4Dtoi+0StVdtbWrcdiE0fI6ZpT73AabTarKAuhiUa7kI2JXc5AbnC1+VHaGlmdLrzne/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398973; c=relaxed/simple;
	bh=QUxvXD/lqa4kewkovEL8x4VQ8lhLWejloKN/XvKR2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=oFecz74a7YYHVgd+vaaaqlaibplR1fyGq+Qr1hx58Xl48Dy/6YnAg51VRXMfupQ7+0JlwrJZFwCxMTfg41jwyGeagk/skzD7WFdLM+fq6qVGZu6/1pKaOvt3vrf7/N1L0gOUb8SM61vzrc4rrtNBP4q+7RHsn4+DxeF3pbUZVc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=T+1xLOJF; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="T+1xLOJF"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250224120920epoutp03d108932b350adf8de9615ff0aa716cb8~nI6IXGGzy1135011350epoutp03a
	for <linux-cxl@vger.kernel.org>; Mon, 24 Feb 2025 12:09:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250224120920epoutp03d108932b350adf8de9615ff0aa716cb8~nI6IXGGzy1135011350epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740398960;
	bh=1NUcUQzLB4jSDqrWTmTrd9HIrmpyHzp0hL88WCVOg3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T+1xLOJFTrcXtnp7Wfp7dFc3Aiti03Q/ob2sfO4G7Gb8dZxITsFmAJYMROky/HbBt
	 NFQltDMiW4dWt80cRZ1G0+DrSW8+RHt29Qp9oq2PXujTdLe9pSjRBiPK182FMJ3c0I
	 8Oe0n58Ox3Hyome8hksA/8Ro7XCCMNWgulEKafc0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250224120919epcas5p1a9f2363b6727dae763f0827d0982ca52~nI6H5gw-R0499204992epcas5p1c;
	Mon, 24 Feb 2025 12:09:19 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z1ffj5LMWz4x9Px; Mon, 24 Feb
	2025 12:09:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.E2.19710.D616CB76; Mon, 24 Feb 2025 21:09:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250224115417epcas5p17e6d29167d3398ae896fab2ea6470e16~nIs-jxtf00884308843epcas5p16;
	Mon, 24 Feb 2025 11:54:17 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250224115417epsmtrp24c206b77d9789587af7f9a426e2b7bc5~nIs-i-GjU2202222022epsmtrp26;
	Mon, 24 Feb 2025 11:54:17 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-c4-67bc616d0bdf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	99.66.23488.9ED5CB76; Mon, 24 Feb 2025 20:54:17 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250224115415epsmtip1afebfc676ab6f5c6064d406add1d8568~nIs_FcorM2341623416epsmtip13;
	Mon, 24 Feb 2025 11:54:15 +0000 (GMT)
Date: Mon, 24 Feb 2025 17:24:01 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
	nifan.cxl@gmail.com, dave@stgolabs.net, vishak.g@samsung.com,
	krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com
Subject: Re: [PATCH v2 0/3] CXL CCI Log Commands implementation
Message-ID: <20250224115401.scb6hmf55pb4e3uy@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250220160850.00003016@huawei.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmlm5u4p50g3tr1CymH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFq4TU2i4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu0XLkLavH
	k2ubmTz6tqxi9Jg6u97j8ya5ALaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoMOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZ705+ZirYIFyx69MzlgbG7/xdjJwcEgImEvduz2fuYuTi
	EBLYzSjx+tYzKOcTo8SBm1+ZQKqEBL4xShzayQvTsW7KbHaIor2MEjdnNzLCdVyfP4cRpIpF
	QFVidvcVMJtNQEfi/O25bCC2iICRxLsbk8AamAVuMko0TnoGlhAWsJdY8ekRmM0r4Czx4uAz
	VghbUOLkzCcsIDangKHEu0enWUCaJQR6OSS+vfnGDHGTi8SfhXeZIGxhiVfHt7BD2FISn9/t
	ZYOwsyX+zG+HsgskFv2cCVVjL9F6qh9sDrNAhsT7T2tZIOKyElNPrWOCiPNJ9P5+AjWfV2LH
	PBhbTaJ9x3yoOTISb34thprvITHlyQl2SNjtZJT426E7gVFuFpJ/ZiFZB2FbSXR+aGKdxcgB
	ZEtLLP/HAWFqSqzfpb+AkXUVo2RqQXFuemqyaYFhXmo5PJaT83M3MYITq5bLDsYb8//pHWJk
	4mA8xCjBwawkwqtbsiNdiDclsbIqtSg/vqg0J7X4EKMpMIImMkuJJucDU3teSbyhiaWBiZmZ
	mYmlsZmhkjhv886WdCGB9MSS1OzU1ILUIpg+Jg5OqQam6/5aygyLncOqtDYp2YRUPf0m71q8
	teDs2YmndP7fe/PN1c+K9eaaaW/1+pWbOlXuL547MyQ+9vuLT9tOc3NxKKSmRAfqpU3I09hu
	/eP6uxUFDVuUnayfn+f93zujaPWDx696bDI6D5W5b7uy0f7Yh7mnTm+RveUZXFVa8I272urM
	pgqtQ93cZ91VjHYYbCyfZBB8IPHF3/kr/ubP6piw70HcRfEOB5UbLfYv9S7u4VmxPkF408Le
	DXqidTsPFjXPMgwrf61579LEiokiWv0FYW+8Lu65Jnjkp2rU6p077m/02W7Wv0WZcXHi9tXz
	Ys1t4/NrfznWRZstfLlUVMdp85FHeSsWRXhJb+m6fjunUImlOCPRUIu5qDgRAEkHwsQ1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnO7L2D3pBqfec1pMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLVwmtsFgs3LmOyOD/rFIvF3217GS2O9+5gAXLnsDtweeycdZfdo+XIW1aP
	J9c2M3n0bVnF6DF1dr3H501yAWxRXDYpqTmZZalF+nYJXBn9u7ewFDwSqGib3c7cwHiYt4uR
	k0NCwERi3ZTZ7F2MXBxCArsZJXYt7maHSMhIXJz5mAXCFpZY+e85VNEHRomVl4+ygSRYBFQl
	ZndfYQSx2QR0JM7fngsWFxEwknh3YxIjSAOzwG1Gid+774FNEhawl1jx6RFYEa+As8SLg89Y
	IabuZJToft3OCpEQlDg58wlYA7OAmcS8zQ+Zuxg5gGxpieX/OEDCnAKGEu8enWaZwCgwC0nH
	LCQdsxA6FjAyr2KUTC0ozk3PTTYsMMxLLdcrTswtLs1L10vOz93ECI4JLY0djO++NekfYmTi
	YDzEKMHBrCTCq1uyI12INyWxsiq1KD++qDQntfgQozQHi5I470rDiHQhgfTEktTs1NSC1CKY
	LBMHp1QDU5L51len5+78pzV17qbdxktbXslNnVK94cQr34UitjPmC7/flbq0+e8LEx928yzO
	QAvOY3ci/LM59mQ6rzKv/aRQ7bJ4tkvC2nXSzxu/lK9zP/TilO4lh6sBl91XSM+XWjxL8H6h
	wPdpYdYr/tlUaCd8Neu37nhp6fypu0dccMIfsZURxROl7nAuZPnZMeXKYqYTRw5x3zkep85m
	r7RVVfIs8xrxX1am9znOdod7XtwvPfHVkWML77P2fHicsMTPu6ffPqum9Ov2I9GPbrrtrjGd
	U/NvteG9Lbu2JM5alLMhcLvA1c//T8goVv6S1G7ZuSZiyQGLRXZLpQ0Yyv3rt0oYPX06Sbhd
	sKLQ+DNDvpMSS3FGoqEWc1FxIgD4bHyU+AIAAA==
X-CMS-MailID: 20250224115417epcas5p17e6d29167d3398ae896fab2ea6470e16
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_7e4f3_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710
References: <CGME20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710@epcas5p3.samsung.com>
	<20250218085731.550029-1-arpit1.kumar@samsung.com>
	<20250220160850.00003016@huawei.com>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_7e4f3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 20/02/25 04:08PM, Jonathan Cameron wrote:
>On Tue, 18 Feb 2025 14:27:28 +0530
>Arpit Kumar <arpit1.kumar@samsung.com> wrote:
>
>> CXL CCI log commands implmented as per CXL Specification 3.2 8.2.10.5
>> 1) get_log_capabilities (Opcode 0402h)
>> 2) clear_log (Opcode 0403h)
>> 3) populate_log (Opcode 0404h)
>>
>> This v2 patch addresses the feedback from the v1 patch and include some new changes.
>
>I'll apply these to my staging tree, but it is a little odd
>to have the last two commands without any logs that they actually apply to.
>
>Maybe we should make up a component state dump?
>I think that currently the populate only really applies to that
>one (or the vendor defined one).
>
>We can also look at wiring up the ECS logs and some suitable error
>injection as clear log would apply to those.  I like the idea
>of having media test longer term as well as the use cases for that in
>kernel are interesting to explore.
>
>Jonathan

Thanks for the suggestion Jonathan. I will go in depth of stated log 
commands and will plan the same.
>>
>> Changes in from v1 to v2:
>> - Added descriptive text for each patches
>> - Added reference from CXL spec 3.2
>> - Updated naming for better comprehension
>> - Modified find_log_index() to return supported log
>> - Handled array of log capabilities as static const pointers
>> - Replaced bit fields for param_flags with defines for individual bits
>> - Disabled support of clear & populate log command for command effect log
>>
>> The patches are generated against the Johnathan's tree
>> https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.
>>
>> Arpit Kumar (3):
>>   hw/cxl/cxl-mailbox-utils.c: Added support for Get Log Capabilities
>>     (Opcode 0402h)
>>   hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log (Opcode 0403h)
>>   hw/cxl/cxl-mailbox-utils.c: Added support for Populate Log (Opcode
>>     0404h)
>>
>>  hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
>>  include/hw/cxl/cxl_device.h  |  20 +++++++
>>  include/hw/cxl/cxl_mailbox.h |   5 ++
>>  3 files changed, 125 insertions(+)
>>
>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_7e4f3_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_7e4f3_--
