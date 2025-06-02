Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA021423C
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880139; cv=none; b=OpJKEDKbO64ym/huMIhwnGSO3iHCtHh2A/TF/a5c3rv+z2oaK3DVir+R7QXN7FPWQKNK17qdjL2z1ZO2LuWQ02llpDpTehMonhHWIZDrACIzntvdNlv0BPvmnfAyDGMmrnk7wYSxSbPn4csTkERZoU1mvj0SaxdfzMcHBMn4SHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880139; c=relaxed/simple;
	bh=w/aWm3PvuzhVVCNEVQHW1+Pjd3BV9AWiTNgwl2ewx/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=T/vOQYVdheXAmp4kmBraYVJaUhhM1Lx9z9IrMn8Lk3dJO+3/bkyuXv3DytYLEI/1AJVsWrHFmVGCpS7XnUlGrgopPx3PYEW4E0Vuuf5KXr5nNd79QoWIGJbmbmLeNg4oyMDvAdiknt4AFjXb+msigxWv3Pc4p37APVqxT/QjoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OQ795Kid; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OQ795Kid"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250602160215epoutp0173cf791f0ddbd9aa37518c75f5cab57e~FRTenOR8X0130201302epoutp01Z
	for <linux-cxl@vger.kernel.org>; Mon,  2 Jun 2025 16:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250602160215epoutp0173cf791f0ddbd9aa37518c75f5cab57e~FRTenOR8X0130201302epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748880135;
	bh=SeY7Pv4lQ5JZZ16sZo+eurikBf+a8HytnZGpjMK39rA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=OQ795KidH17Jr/zozuy4yPN80uZ/ZpItMq1kjcdnZmHfhj+d6GOxrCyO8mKeMcYVj
	 kUWZ0x6hNBpDOCtBnc6cq6E4gILkYEt02nit9Orz1UhDfiuyMQ7uPvYBqtnM+lcFyr
	 DR5rJQYQT5gjxpblhRwu+EuhgX4QNBam/a5HtZQE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250602160215epcas5p20ee02b7dcc2b72c16ac479cb8026c7cf~FRTeCcafW0935009350epcas5p2D;
	Mon,  2 Jun 2025 16:02:15 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.177]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b9zBF5NHCz3hhT8; Mon,  2 Jun
	2025 16:02:13 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc~FPo225dSR0204302043epcas5p2N;
	Mon,  2 Jun 2025 14:00:08 +0000 (GMT)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250602140007epsmtip2a8638a39fd2c53f4d5cea03826b71d3d~FPo1h48sV2410124101epsmtip21;
	Mon,  2 Jun 2025 14:00:07 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 0/3] FM-API Physical switch command set update
Date: Mon,  2 Jun 2025 19:29:39 +0530
Message-Id: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc
References: <CGME20250602140008epcas5p25fce01492de105da3cdc0aaa533f6ebc@epcas5p2.samsung.com>

The main purpose of this patch series is to enhance existing support
(Identify Switch Device & Get Physical Port State)
as well as add new support (Physical Port Control)
of FM-API based physical switch command set
as per CXL spec r3.2 Table 8-230:Physical Switch.

[Patch 1/3] stores port info during enumeration for both mailbox
and mctp based component command interface (cci).
This not only simplifies command support of Identify Switch Device (Opcode 5100h)
and Get Physical Port State (Opcode 5101h) but also provides necessary
physical port information for future additions hence [Patch 2/3].

[Patch 3/3] and final patch adds command support of Physical Port Control(Opcode 5102h).
This includes assert-deassert PERST and reset PPB based on the
requested physical port as response payload.

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2025-03-20.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

Arpit Kumar (3):
  hw/cxl: Storing physical ports info during enumeration
  hw/cxl: Simplified Identify Switch Device & Get Physical Port State
  hw/cxl: Add Physical Port Control (Opcode 5102h)

 hw/cxl/cxl-mailbox-utils.c  | 423 +++++++++++++++++++++++++++---------
 include/hw/cxl/cxl_device.h |  36 +++
 2 files changed, 352 insertions(+), 107 deletions(-)

-- 
2.34.1

