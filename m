Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394A22DF8D
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870080; cv=none; b=spDpQ73dK9Pj9S3xy1XF2P3e6q42OjAk/MciIrfBbA3qjmQEsVF2vU945m06DPxywQ9asD+bAdUPMIFSR6RsbgyJM70bm3Kjw+gHypGdoi+T+qCPjf9Ps/HdZ9Sw1w+yKg8J6HRSz7dMSfWRAtgTGhSWPjL/3BajK2Lt5IKICls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870080; c=relaxed/simple;
	bh=MEPYn1/vX8bmcjW+qkqFUZ7T13Tg6WwK+/YuksHuxL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=nXnnygKbKNoTBZVOexox01tTsz+kGc/bTIFQtbokl5DoCopoDO82WIUZrKxkmhv2PmPatU4GlJqWdgqM6JpQRo11C910NPR8lyAyEhEuRS/K6Kg0ZLPLSEX91q1yc0mWY1HKSlZV7pq91pIiU9Q0oLgO3YcNkE/5aHl/WNxN8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S3IfXngG; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S3IfXngG"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250218091428epoutp0430f6b06c215c85f6153862e44339878b~lQpvzmXds0607106071epoutp04f
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 09:14:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250218091428epoutp0430f6b06c215c85f6153862e44339878b~lQpvzmXds0607106071epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739870068;
	bh=h1bwEdr1e1HxH8m7hOirkZz1UbVnQfD+YMJM86ENTwY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=S3IfXngGAdgvcBMz89+wdDzbRQzHuCK42tPx1KGy18PNUyy4pWCFKVAhnFzUlB/HN
	 Tkq2mhTCAuw2D/xt0EpNoBqG6vb6YUb6onzlb1bTaKq7GEK5TDV5wsriaPjMTSdy8y
	 3dOiMeEeRhIQAOHycFTuuOr7b+cB25YWsJN9qZzc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250218091428epcas5p4f51a4b14f86dbaf3bb031ac9676047c7~lQpva95582298422984epcas5p4P;
	Tue, 18 Feb 2025 09:14:28 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Yxv3f5f3Wz4x9QB; Tue, 18 Feb
	2025 09:14:22 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.79.29212.D6F44B76; Tue, 18 Feb 2025 18:14:21 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710~lQbfiwxdH1165411654epcas5p3z;
	Tue, 18 Feb 2025 08:58:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250218085809epsmtrp162440506b74db4ea10b1f1d06817db8a~lQbfiAbvR0197301973epsmtrp1F;
	Tue, 18 Feb 2025 08:58:09 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-ab-67b44f6d8c35
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.E6.23488.0AB44B76; Tue, 18 Feb 2025 17:58:08 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250218085807epsmtip111b5730951297720722c39b280630de1~lQbeIVmIg1080010800epsmtip1r;
	Tue, 18 Feb 2025 08:58:07 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH v2 0/3] CXL CCI Log Commands implementation
Date: Tue, 18 Feb 2025 14:27:28 +0530
Message-Id: <20250218085731.550029-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmum6u/5Z0g4Uv+CymH1a0+HJ6D5tF
	7+IlrBarb65htLh5YCeTxcKNy5gszs86xWLxd9teRovjvTtYgNw57A5cHjtn3WX3eHJtM5NH
	35ZVjB5TZ9d7fN4kF8AalW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
	aqvk4hOg65aZA3STkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQv
	XS8vtcTK0MDAyBSoMCE748jvhWwFvzgrGtoXMjUwTuHoYuTkkBAwkZjXs4Cpi5GLQ0hgD6PE
	xclH2EESQgKfGCV6j0tAJL4xSvTteQeU4ADr+PEjCCK+l1Fi+eMrzBBOA5PE5sW7WUG62QR0
	JM7fnssGYosISEr87joNVsQs8IZR4sHVBcwgCWEBa4m9syezgNgsAqoSx372MYHYvAJ2Ei9n
	TGaDuE9eYv/Bs8wQcUGJkzOfgNUzA8Wbt84GGyohcI9dYtrWP6wQDS4S2z5PYYawhSVeHd/C
	DmFLSbzsb4OysyX+zG+HWlAgsejnTKi4vUTrqX5mkDeZBTQl1u/ShwjLSkw9tY4JYi+fRO/v
	J0wQcV6JHfNgbDWJ9h3zocbISLz5tRhqvIfElCcnoEEaK9G3v4l1AqP8LCTvzELyziyEzQsY
	mVcxSqUWFOempyabFhjq5qWWw2M2OT93EyM4bWoF7GBcveGv3iFGJg7GQ4wSHMxKIryHujak
	C/GmJFZWpRblxxeV5qQWH2I0BQbyRGYp0eR8YOLOK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4k
	kJ5YkpqdmlqQWgTTx8TBKdXAtDVvrlhUw4P5sy7H/ezweN5RP/PYdg21uFQnLp/fPnufO64/
	fuzilBqn5d9+bPj6xrUv7b3wgS3Ks9y53lxWi9Z6fffoM/b7EQE3Gm6ceW+l5Mb3/0KJZd+s
	Sal/LK6l7lezutaz0mhfyEW3z4ePTP2vmrrV0Jp/16OSwn2N55TdYnOM5sROvsjyksVyX1ra
	HpZ1TVq/k49zBHkGrzNbM+0L47tqvYksVUnLjF5o7NHW3G60pMyOw+LR49AvkVGhl05xxKxo
	XNdo1Wmj/a5YN0//25dlOlM9v5fftM6eprYveu237SZnKl0uHfy+9ZaEc1XAqs8Llmi65ExJ
	9lQ+kBy8II61ZJbFvx2fgtJfMiixFGckGmoxFxUnAgAi/lgmJAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnO5C7y3pBue9LKYfVrT4cnoPm0Xv
	4iWsFqtvrmG0uHlgJ5PFwo3LmCzOzzrFYvF3215Gi+O9O1iA3DnsDlweO2fdZfd4cm0zk0ff
	llWMHlNn13t83iQXwBrFZZOSmpNZllqkb5fAlXHk90K2gl+cFQ3tC5kaGKdwdDFycEgImEj8
	+BHUxcjFISSwm1Fi+YsjbF2MnEBxGYmLMx+zQNjCEiv/PWcHsYUE/jFKHOzhArHZBHQkzt+e
	C1YvIiAp8bvrNDPIIGaBb4wSc269YAVJCAtYS+ydPRlsEIuAqsSxn31MIDavgJ3EyxmToZbJ
	S+w/eJYZIi4ocXLmE7B6ZqB489bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PTfZsMAwL7Vcrzgx
	t7g0L10vOT93EyM4eLU0djC++9akf4iRiYPxEKMEB7OSCO+hrg3pQrwpiZVVqUX58UWlOanF
	hxilOViUxHlXGkakCwmkJ5akZqemFqQWwWSZODilGphMvs7naL8RP0sy9P3arZ+9e9/bp6Sq
	vbWtEjJxjAlpeXuW42rVORfRJcvTJqT9cHozubb3bLVDOYtaq+OX1uevGa0in9yUzVi+YWfE
	eZXFh9/2xF9nPVaWM82ZK9PP+kufX2X5so6DxbyGh9cfL5+9QX9peWSsj3X3QyPOv9ZuPzQf
	CbBlvVkYc2Izz7UkXyZtjZ6rZwPlr5t2Ku4R2h6iOP/11U7Xf4Xz7FJTnlyS/6Jzcwsft/wi
	26K2pRP+Vu425TszJU9mY1dCUlH/vd/7Lyrybj0yo8Xs+9/yt9KMIeuenzM9e9HShY/tgtPh
	usb4Rgtm5gBn9u5gya2q35/PT3e3fH69J0vxq9pVXyWW4oxEQy3mouJEAMEst2PNAgAA
X-CMS-MailID: 20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710
References: <CGME20250218085809epcas5p3ee3d79ffec77b13bb097c6d15bb24710@epcas5p3.samsung.com>

CXL CCI log commands implmented as per CXL Specification 3.2 8.2.10.5
1) get_log_capabilities (Opcode 0402h)
2) clear_log (Opcode 0403h)
3) populate_log (Opcode 0404h)

This v2 patch addresses the feedback from the v1 patch and include some new changes.

Changes in from v1 to v2:
- Added descriptive text for each patches
- Added reference from CXL spec 3.2
- Updated naming for better comprehension
- Modified find_log_index() to return supported log
- Handled array of log capabilities as static const pointers
- Replaced bit fields for param_flags with defines for individual bits
- Disabled support of clear & populate log command for command effect log

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Arpit Kumar (3):
  hw/cxl/cxl-mailbox-utils.c: Added support for Get Log Capabilities
    (Opcode 0402h)
  hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log (Opcode 0403h)
  hw/cxl/cxl-mailbox-utils.c: Added support for Populate Log (Opcode
    0404h)

 hw/cxl/cxl-mailbox-utils.c   | 100 +++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h  |  20 +++++++
 include/hw/cxl/cxl_mailbox.h |   5 ++
 3 files changed, 125 insertions(+)

-- 
2.34.1

