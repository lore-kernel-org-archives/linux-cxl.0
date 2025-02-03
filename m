Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CB201267
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 06:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649582; cv=none; b=V2QHeKZLWxaETzeoOuVcN7k20OK0W8j5Y8aeW0duwIlJqTaqTQHJPWOXebK5SY8yxlUqhPB3yJPcOkuMcX2V2NVNK3LvomALOG+TN/Kh44rdRTikNISRl5wB/teIj5g2GVEcif09NDLrNEo40W398+9qkSegWxak4gBEWUi3uWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649582; c=relaxed/simple;
	bh=aCf+V1fajhUvB2f0KbCximYBeNydAKc99N2ryDz9KjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=BiuXnuv0YQ7SSpKqkjIDKrORqA3sQ0cENP/DKRcUInz8iEFW5cx6FijM/ZqXaSfx+omKHfSoif0tJ0f8gUVmVypXiMWYGm4aelTiWpoFNKKKrw0zLqflzCkhgzg9DoW9l+N8Ifs5jbjDIPr01Db93/zoz7RZ3F6OgEijdg34EWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mdoXahCj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mdoXahCj"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250204061257epoutp031acbf27051e1a3d0aafbd873c3aa3799~g7JRPKzJ22564825648epoutp03b
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 06:12:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250204061257epoutp031acbf27051e1a3d0aafbd873c3aa3799~g7JRPKzJ22564825648epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738649577;
	bh=4aXhgDy+GveCJKRwZHUcVcqwoTnwr5AvBjR5R5ffQL0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=mdoXahCjRxTqkj3XWyzVbDNNcAYXxnN57pMpt4i4XnpAApJ5Kn4S9ARdj4IIDTZWn
	 JV3w2rsvfsnCy3SKGlbRQGgybyEc9d5lKbpX/hZloGYnn8dastT3RPGy0C8HT+o1r7
	 t6rvU3J2cva85vX5oyPjZ0omuoOYgnAJVDiy44YU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250204061257epcas5p17ef8d137eb2cdfb48a19ad0b7d1f64ff~g7JQmju9p2596925969epcas5p1r;
	Tue,  4 Feb 2025 06:12:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YnChl3nWpz4x9Px; Tue,  4 Feb
	2025 06:12:55 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.DA.20052.7EFA1A76; Tue,  4 Feb 2025 15:12:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc~gnVZGWNKt0221502215epcas5p3K;
	Mon,  3 Feb 2025 06:00:50 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203060050epsmtrp1aca86f738022d075d5c44b31a5c43bb9~gnVZFhsVj2494724947epsmtrp1q;
	Mon,  3 Feb 2025 06:00:50 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-d9-67a1afe71b35
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.DE.23488.19B50A76; Mon,  3 Feb 2025 15:00:49 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250203060048epsmtip22533c88914fa3b474827be87d90e40f2~gnVXprEBf2702127021epsmtip20;
	Mon,  3 Feb 2025 06:00:48 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 0/3] CXL CCI Log Commands implementation
Date: Mon,  3 Feb 2025 11:29:47 +0530
Message-Id: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU/f5+oXpBlNmiFtMP6xo8eX0HjaL
	3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
	vi2rGD2mzq73+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gmJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2xqot85gKjrFXfG3kaGBcydbFyMkhIWAisa3vFCuILSSwm1Gi5YRD
	FyMXkP2JUeLAsTfMEIlvjBInLqbANLT/W8UEUbSXUeJh+wZGCKeBSWLh1wNgHWwCOhLnb88F
	WyEiICnxu+s0M0gRs8AbRokHVxcAORwcwgIWEjN/2oDUsAioStzsmA1WzytgL7GmsY0RYpu8
	xP6DZ5kh4oISJ2c+YQGxmYHizVtng82UEHjELnHxwASoBheJ2c9mMEPYwhKvjm9hh7ClJF72
	t0HZ2RJ/5rdD/V8gsejnTKi4vUTrqX6w25gFNCXW79KHCMtKTD21jgliL59E7+8nTBBxXokd
	82BsNYn2HfOhxshIvPm1GGq8h0Tz5J/Q4I2VmP76JMsERvlZSN6ZheSdWQibFzAyr2KUTC0o
	zk1PLTYtMMxLLYdHa3J+7iZGcMLU8tzBePfBB71DjEwcjIcYJTiYlUR4T29fkC7Em5JYWZVa
	lB9fVJqTWnyI0RQYxhOZpUST84EpO68k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6Yklqdmpq
	QWoRTB8TB6dUA5NxZpWv6RWvKfOKZSMruz/YZu4Rm323uyJyJf+lIM3cNMn7RaVe0+evf31u
	8bGr/lE7Up//Uu2JKJBnbcpb7C14vya04oDsp6VMWYJ6xcsWGH95WLDRVM+ySjDfSDZjXS/3
	XCfT879qjM8cniS4fbHwPQ/BNd2KYTzi9ow5kY+Wrp/ssEn7fBj3/GPTc9kyp8y32LDaROTQ
	84oNDg81d62d+2r5Ysbc5VNkp8zY1Hcx41fj5F6dCTlF06bG9EXusqz3f663gKFj0nHtbdOn
	Pl7599FsebNdjMHTevObtmiyvXvzdWJXHXu2OvuvR3s3OT36db/rxOQ3Dx1mq0yx9dm65dSe
	nSe0dF6WtiUfnCGgxFKckWioxVxUnAgAwrzNPyEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvO7E6AXpBl/uW1hMP6xo8eX0HjaL
	3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
	vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugStj1ZZ5TAXH2Cu+NnI0MK5k62Lk5JAQMJFo
	/7eKqYuRi0NIYDejxJkljSwQCRmJizMfQ9nCEiv/PWeHKPrHKLHm4XZ2kASbgI7E+dtzwSaJ
	CEhK/O46zQxSxCzwjVFizq0XrF2MHBzCAhYSM3/agNSwCKhK3OyYDVbPK2AvsaaxjRFigbzE
	/oNnmSHighInZz4BW8wMFG/eOpt5AiPfLCSpWUhSCxiZVjFKphYU56bnJhsWGOallusVJ+YW
	l+al6yXn525iBIevlsYOxnffmvQPMTJxMB5ilOBgVhLh5Tg8J12INyWxsiq1KD++qDQntfgQ
	ozQHi5I470rDiHQhgfTEktTs1NSC1CKYLBMHp1QDk62p77Irot7a+Ve33zEKvDVnTfUcVkGP
	LQ135e59yrp/qfbpsisNrbcrPrzouem+zzRx72omf9tMVffNaU1sVv0SFybqvGUP2jQrOjUk
	9SDHT8N5j/58XBP0pT/f9tBTCbe/Ov1n7upa3fn95frl7259+m0b0/8Gnq2sSrjwasqiXfeS
	8k9oLTrhyBQpHW654f19BYf0D84Tj96brcbffueV7H5Ndpe+mZdDlOU2339Qd3bD3h8FXIJf
	TumWLBXd82rmKdXZ3mt3swaxeErKeZ80lhA6G960+43NLq1vh/ZpH1zAMkND4aHPsaSq+3zS
	K+xnrhXe8N2uY+dplUt7/r9drrI59ezDLoacei/JgmNKLMUZiYZazEXFiQAf8HE3zgIAAA==
X-CMS-MailID: 20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc
References: <CGME20250203060050epcas5p38f556047edbdedd98b6ac2d1d496a3dc@epcas5p3.samsung.com>

CXL CCI log commands implmented as per CXL Specification 3.1  8.2.9.5
1) get_log_capabilities (Opcode 0402h)
2) clear_log (Opcode 0403h)
3) populate_log (Opcode 0404h)

The patches are generated against the Johnathan's tree
https://gitlab.com/jic23/qemu.git and branch cxl-2024-11-27.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>

Arpit Kumar (3):
  hw/cxl/cxl-mailbox-utils.c: Added support for Get Log Capabilities
    (Opcode 0402h)
  hw/cxl/cxl-mailbox-utils.c: Added support for Clear Log (Opcode 0403h)
  hw/cxl/cxl-mailbox-utils.c: Added support for Populate Log (Opcode
    0404h) as background operation

 hw/cxl/cxl-mailbox-utils.c   | 186 +++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h  |  33 +++++++
 include/hw/cxl/cxl_mailbox.h |   5 +
 3 files changed, 224 insertions(+)

-- 
2.34.1

