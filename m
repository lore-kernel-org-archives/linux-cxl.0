Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31220B1EA
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525753; cv=none; b=AjocB60tIwEm/1D+q9degTBF1KwPLcLu1KBQo2le2XKAAqyA3soXMCWAu+sJsY4XGtjUUEOGt4dVkkLl7KBHjjSgnd6S6vZhUAtWtE7Y994Evhv8m8ZnpuuK2Ha2yBxA008XaEccy+fG7xp7cl7TiWETCfh1rGpK1Yy6wb5khEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525753; c=relaxed/simple;
	bh=49Cq05jvKpvgPjLZeLuYwaYJr31Nl2ZdeptcrFeCuBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=qKS7nBrbo1nxaxVLOu+sySvsLOQhxwIpEhIjQkjBFUsEtQJfM92va9qJFuLZQNB1k1M/G82igdGFYXGvoWIkHTuDJzIYGMQpiVzMHM8nJWw07jm07pLKUYewBvvYsLf1lXc5311qrZ9zSHZA4jIS1cINaiSZYRBy/rD0pED5IJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MZ2kjvFD; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MZ2kjvFD"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250214093547epoutp039f890c51473cd35eb2bc76e68c0fe5ef~kCXNiMPdO0699506995epoutp032
	for <linux-cxl@vger.kernel.org>; Fri, 14 Feb 2025 09:35:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250214093547epoutp039f890c51473cd35eb2bc76e68c0fe5ef~kCXNiMPdO0699506995epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739525747;
	bh=6u2ec4HZlFgEdfaEdHv9kpNbb1MXfilSNcxiYqMArPE=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MZ2kjvFDL0+QeeApPnyDBjoC6bLTULLn/iGQlf9yX/E7v5genTskOQoHOSR2nGY7j
	 coCZu3Tue46znXlBLmsQsoHPYfMJe6HMVp2R3yBOzOTvxREG/dowIJvHwrA1CPHkW1
	 ydhkCGhiRntLVpEf4u2INL57PT9H3DU45gOu6i1U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250214093546epcas5p26f3bfda81550485851792a747b1bc52b~kCXMso-5p2589725897epcas5p29;
	Fri, 14 Feb 2025 09:35:46 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YvRk82Yncz4x9Px; Fri, 14 Feb
	2025 09:35:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B5.DC.19710.07E0FA76; Fri, 14 Feb 2025 18:35:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250213091628epcas5p31ec87df7fc4ce2d47db40b693239d7ad~judDp1wSH1363713637epcas5p3G;
	Thu, 13 Feb 2025 09:16:28 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213091628epsmtrp1a59b67dfe448d52937837bd6f64e0b73~judDpJg4k2265622656epsmtrp1Y;
	Thu, 13 Feb 2025 09:16:28 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-ae-67af0e704e7b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.CC.23488.B68BDA76; Thu, 13 Feb 2025 18:16:27 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250213091626epsmtip183dcd405a89a1af930b9313be2e2944b~judCM2YZ82148921489epsmtip1W;
	Thu, 13 Feb 2025 09:16:26 +0000 (GMT)
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Vinayak Holikatti
	<vinayak.kh@samsung.com>
Subject: [PATCH v2 0/3] CXL CCI Media Operations
Date: Thu, 13 Feb 2025 14:45:55 +0530
Message-Id: <20250213091558.2294806-1-vinayak.kh@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmlm4B3/p0g28TBC2mH1a0+HJ6D5vF
	6ptrGC1uHtjJZLFw4zImi/OzTrFY/N22l9HieO8OFosTJ7ezA8XmsDtweeycdZfd48m1zUwe
	fVtWMXpMnV3v8XmTXABrVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
	qq2Si0+ArltmDtBNSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
	dL281BIrQwMDI1OgwoTsjKMT37MUzOGo2HHzJksD4w22LkZODgkBE4kzM6azdjFycQgJ7GaU
	eHngHzOE84lR4szmnSwQzjdGib7GM6wwLcumToNq2csoMfd7C1RLA5PE/1ntYFVsAgYSD5qP
	s4PYIgKSEr+7TjOD2MwCHxglFj3VBbGFgWqmP9sHFmcRUJV4v2MmWC+vgK3E9FkdUAfKS+w/
	eJYZIi4ocXLmExaIOfISzVtngy2WELjFLtG65TELRIOLxMc1L6FsYYlXx7ewQ9hSEi/726Ds
	YolzFz8xQtg1Eq+7VjBD2PYSraf6gWwOoAWaEut36UOEZSWmnlrHBLGXT6L39xMmiDivxI55
	IDYHkK0isfRtJsymL8+aoaZ7SLzvmQt2jZBArETL5w2sExjlZyH5ZhaSb2YhLF7AyLyKUTK1
	oDg3PTXZtMAwL7UcHrHJ+bmbGMFJU8tlB+ON+f/0DjEycTAeYpTgYFYS4ZWYtiZdiDclsbIq
	tSg/vqg0J7X4EKMpMIgnMkuJJucD03ZeSbyhiaWBiZmZmYmlsZmhkjhv886WdCGB9MSS1OzU
	1ILUIpg+Jg5OqQYm/eKp+vYM2tMN9hj82im8bckO2x75/jUiYtmL+d+etbKV2fVvxa/NXuxX
	Lq0V/fzwALfEGh/9lbUCnMoVG89HrFuimfuOd3kGm6p1s8i1xbv6RVKE5pYbvHLcG9L565Pm
	72yZn7xXpD9c3nRXT+fwUZ+7SqlHjZv9y4WWb0i7p/yIxbTa2TApeqnzlxPTN/jsUTtXYZP9
	6MnuVbVv7SMb2Oastz9dE7LNXvHBrkyHectbLjw5vdK56nB18KXpf14F8dpt2sel5NYW4WTl
	p+b9c8vxVJHU9/vC/xk7MpjzJ3jfM771yy7wg1JL0PR9q9N6rB/NPv5DfN0z7rYk+fQ1nzSc
	/NV3nUvcbCXBNve1EktxRqKhFnNRcSIAJT9XviMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsWy7bCSnG72jrXpBpMWmltMP6xo8eX0HjaL
	1TfXMFrcPLCTyWLhxmVMFudnnWKx+LttL6PF8d4dLBYnTm5nB4rNYXfg8tg56y67x5Nrm5k8
	+rasYvSYOrve4/MmuQDWKC6blNSczLLUIn27BK6MoxPfsxTM4ajYcfMmSwPjDbYuRk4OCQET
	iWVTp7F2MXJxCAnsZpTYtm4OI0RCSuLYzp9QRcISK/89Z4co+scoMePMA3aQBJuAgcSD5uNg
	toiApMTvrtPMIEXMAr8YJZ7uvg+WEAYqmv5sHzOIzSKgKvF+x0xWEJtXwFZi+qwOqA3yEvsP
	nmWGiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyrGCVTC4pz03OTDQsM81LL9YoTc4tL
	89L1kvNzNzGCQ1hLYwfju29N+ocYmTgYDzFKcDArifBKTFuTLsSbklhZlVqUH19UmpNafIhR
	moNFSZx3pWFEupBAemJJanZqakFqEUyWiYNTqoEpgJ+zvlv31WkRlT4u474wSdU6vf9J9vUV
	gUpTWqacnpOwx8Xfm4mhQUFi455yq+RixbqU/j6mhKw7bw4+3r7MwWxJ14yioqlP088rejCo
	TL077dAELRnheZnHU/IK9lYp75cLfZwoacDw0/iumNAt3k7GXO+f66+WfLlyQE6mxuPRSv4c
	lVOGO3bxsMyPWXlop/Xh4EKPy6IxrNkLgpZmXQuZuujMfNXIKqmpbWstHrw9WzXx7Rn7bcXO
	daVHF0+8YldzhnXbz4M3eALvO1ocE/Gok6u8cEikaE7+68XBBdF5tzrNpjLMFLtV//FWQcnM
	Gb/KmIuDyu3lNaRlEmvZSm8KT0l7fsrPO+7sRSWW4oxEQy3mouJEAGpgwvLQAgAA
X-CMS-MailID: 20250213091628epcas5p31ec87df7fc4ce2d47db40b693239d7ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213091628epcas5p31ec87df7fc4ce2d47db40b693239d7ad
References: <CGME20250213091628epcas5p31ec87df7fc4ce2d47db40b693239d7ad@epcas5p3.samsung.com>

CXL CCI media operations commands implmented as per CXL Specification
3.1 8.2.9.9.5.3
1) General(00h) - Discovery (00h)
2) Sanitize(01h - Sanitize (00h)
                  Write zeros (01h)

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Changes V1->V2
1) Addressed the review comments from Jonathan Cameron.

2) Modularied the media operations class & subclass handling
into separate functions.

Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>

Vinayak Holikatti (3):
  hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery
    commands (8.2.9.9.5.3)
  hw/cxl: factor out calculation of sanitize duration from
    cmd_santize_overwrite
  hw/cxl/cxl-mailbox-utils: Add support for Media operations Sanitize
    and Write Zeros commands (8.2.9.9.5.3)

 hw/cxl/cxl-mailbox-utils.c  | 404 +++++++++++++++++++++++++++++++++---
 include/hw/cxl/cxl_device.h |   4 +
 2 files changed, 382 insertions(+), 26 deletions(-)

-- 
2.34.1

