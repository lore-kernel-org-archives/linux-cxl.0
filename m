Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796425DF2D
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W6tdYUhk"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240112092203epoutp04520adfab26b9cb54a98681222000ad91~pjyUL0tS92287322873epoutp04h
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jan 2024 09:22:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240112092203epoutp04520adfab26b9cb54a98681222000ad91~pjyUL0tS92287322873epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705051323;
	bh=4jtHcT9tSJUCEFikmXmbUNVIvOiUbXSr+jYDOu5VeTs=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=W6tdYUhkQHoNts6CfhSjsasweCsL1BaR8Goi/NRKL1JiYg9WdBh4sjoM1oCVmVYRg
	 n5+J7PraQcaXdTD4FBuZXCYPSN939xq00D+g4nZ3Z1WIkf2e+VbBP/xMct8QYk2AMU
	 cWRV9aJcaxRy65LA/sXRsE1F0GnQz6TMQRSpzhXc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240112092202epcas2p3dd24a90ee283999b34be5430a47a8bb1~pjyTznyrX1981619816epcas2p3Y;
	Fri, 12 Jan 2024 09:22:02 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TBGJV21xFz4x9Q1; Fri, 12 Jan
	2024 09:22:02 +0000 (GMT)
X-AuditID: b6c32a43-721fd700000021c8-46-65a104ba8784
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.7B.08648.AB401A56; Fri, 12 Jan 2024 18:22:02 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Question about CXL region initialization
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "alison.schofield@intel.com" <alison.schofield@intel.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, Jeongtae Park <jtp.park@samsung.com>, Hojin Nam
	<hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5>
Date: Fri, 12 Jan 2024 18:22:01 +0900
X-CMS-MailID: 20240112092201epcms2p577b3c979bdc694a370e5952edc091f68
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmhe4uloWpBgfe8FrcfXyBzeLDm38s
	FkfWXmWyOLqHw+L8rFMsDqwei/e8ZPLo27KK0ePzJrkA5qhsm4zUxJTUIoXUvOT8lMy8dFsl
	7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygjUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
	/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzuA83MBS0yFftnrWVpYDwv1sXI
	ySEhYCIx7d8H9i5GLg4hgR2MEkvOz2XqYuTg4BUQlPi7QxikRljAUKL/6B9WEFtIQE7i7u1T
	TBBxTYk301axgNhsAuoSPzpPgsVFBKwlJjQsYQOZySywgVFi6uGnrBDLeCVmtD9lgbClJbYv
	38oIYWtI/FjWywxhi0rcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktJfD3xF+wBCYFmRonV
	x/pZIZwGRomOmYehtulLNF5/zwZi8wr4Smz7cwasm0VAVeJj116oGheJrTuugNnMAvIS29/O
	YQaFBDPQm+t36YOYEgLKEkduQVXwSXQc/ssO89eOeU+YIGwliSltR6Buk5BoaNzKBmF7SExc
	cZ8REoiBEjP3nWWZwKgwCxHUs5DsnYWwdwEj8ypGsdSC4tz01GSjAkN47Cbn525iBKc+Lecd
	jFfm/9M7xMjEwXiIUYKDWUmE9+DzBalCvCmJlVWpRfnxRaU5qcWHGE2BPp7ILCWanA9Mvnkl
	8YYmlgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTBdrwtNF1p5XuR/4M3L
	u7+rXUpJ13JdMeFjbuhzLotN2/YclArMsPT8Uqi7ZFOU5rkEmY8zn3eeOH7/vfXs4/tYL51O
	rfgz+bHdbvOwytNvys98b4ucmxn4z6zuc4x5qM58u+VexyramR69k/7X6fw5jKvX/lOMoUL9
	3EDPGOOFboEnuPf4+a+4biDJJm2zXGfXVJkP4jPuZIcc8Lveca1UyeMlQ1/IHUV9lV+qt5L7
	P+37Y/B2V9DXd8+Pv3dYI3203X3hjZfed758NlzTeDI90OF0YO+EnCoft4pthmunvk5mebI8
	7UJrnayXj/x54R/RPOduyX135L+sNzvHeA+nt8ImhfIKoyznVfdmT+5TYinOSDTUYi4qTgQA
	bPXY3gYEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240112092201epcms2p577b3c979bdc694a370e5952edc091f68
References: <CGME20240112092201epcms2p577b3c979bdc694a370e5952edc091f68@epcms2p5>

Hello,

To test that regions are initialized correctly for different combinations of
capacities, I connected two CXL devices with different capacities to a CXL v2.0
compliant system and enabled CXL Interleaving in the BIOS settings. When the
system boot with Linux 6.7, I noticed something strange. it succeeds in
initializing region1 but fails to initialize region0 and displays an "HPA order
violation" message.

Does anyone have any advice on this? Below is the log for your reference: 

1) iomem
480000000-AAAffffffff : CXL Window 0
  480000000-XXXfffffff : region0
    480000000-XXXfffffff : Soft Reserved
28400000000-BBBBfffffff : CXL Window 1
  28400000000-YYYffffffff : region1
    28400000000-YYYffffffff : Soft Reserved
      28400000000-YYYffffffff : dax1.0
        28400000000-YYYffffffff : System RAM (kmem)

2) dmesg - some relevant logs with CXL DEBUG enabled
...
[] cxl_port port1: decoder1.0: range: 0x480000000-0xXXXfffffff iw: 1 ig: 512
[] cxl decoder1.0: Added to port port1
[] cxl_port port2: decoder2.0: range: 0x480000000-0xXXXfffffff iw: 1 ig: 512
[] cxl decoder2.0: Added to port port2
[] cxl_port port2: decoder2.1: range: 0x28400000000-0xYYYffffffff iw: 1 ig: 256
[] cxl decoder2.1: Added to port port2
...
[] cxl_port endpoint5: decoder5.0: range: 0x480000000-0xXXXfffffff iw: 2 ig: 256
[] cxl_port endpoint5: decoder5.1: range: 0x28400000000-0xYYYffffffff iw: 1 ig: 256
[] cxl_pci 0000:64:00.0: mem1:decoder5.0: construct_region region0 res: [mem 0x480000000-0xXXXfffffff flags 0x200] iw: 2 ig: 256
[] cxl_pci 0000:64:00.0: mem1:decoder5.1: construct_region region1 res: [mem 0x28400000000-0xYYYffffffff flags 0x200] iw: 1 ig: 256
...
[] cxl region1: mem1:endpoint5 decoder5.1 add: mem1:decoder5.1 @ 0 next: none nr_eps: 1 nr_targets: 1
[] cxl region1: pci0000:63:port2 decoder2.1 add: mem1:decoder5.1 @ 0 next: mem1 nr_eps: 1 nr_targets: 1
[] cxl region1: pci0000:63:port2 iw: 1 ig: 256
[] cxl region1: pci0000:63:port2 target[0] = 0000:63:02.0 for mem1:decoder5.1 @ 0
[] cxl_region region1: region1: register dax_region1
...
[] cxl_port endpoint6: decoder6.0: range: 0x480000000-0xXXXfffffff iw: 2 ig: 256
...
[] cxl region0: mem0:endpoint6 decoder6.0 add: mem0:decoder6.0 @ 0 next: none nr_eps: 1 nr_targets: 1
[] cxl region0: pci0000:3d:port1 decoder1.0 add: mem0:decoder6.0 @ 0 next: mem0 nr_eps: 1 nr_targets: 1
[] cxl region0: endpoint5: HPA order violation region1:[mem 0x28400000000-0xYYYffffffff flags 0x200] vs [mem 0x480000000-0xXXXfffffff flags 0x200]
[] cxl region0: endpoint5: failed to allocate region reference


Looking at the old history, there was an issue with "HPA order violation" and a
patch was applied, could this be related?
: https://lore.kernel.org/linux-cxl/20230905211007.256385-1-alison.schofield@intel.com/


FYI, As an experiment, I tried deleting the below error handling code in
cxl/core/region.c and both region0 and 1 are initialized successfully.

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3e817a6f94c6..ed08ce7840df 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -771,7 +771,6 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
                                "%s: HPA order violation %s:%pr vs %pr\n",
                                dev_name(&port->dev),
                                dev_name(&iter->region->dev), ip->res, p->res);
-                       return ERR_PTR(-EBUSY);
                }
        }


Any help would be appreciated.

Thank you,
Wonjae
