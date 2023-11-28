Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QsS56Cj0"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20BE1A5
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 02:53:53 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231128105349epoutp03500ce7f165dcf2854413a7f36c08af20~bxAmh3ywh0459804598epoutp03d
	for <linux-cxl@vger.kernel.org>; Tue, 28 Nov 2023 10:53:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231128105349epoutp03500ce7f165dcf2854413a7f36c08af20~bxAmh3ywh0459804598epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701168829;
	bh=TYz1sWNTabUKV183Aq3zscGxLOboxEimK/trgMz9R4Q=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=QsS56Cj0Sv5F9/xVuRTrD80MlAczZAlF8ZfoSkIqPNgx1b0QTmF/M/ODORYLvwvQE
	 Zexe9GHfyWgloE9CzQpPfES9Z3KmHsG5QpgSvKObf4w0Zk9+fYAByByLFcTEL4nVyT
	 Pyoean4f7/OUavFRN/EnFgH2RjUEbVG2wO3rbcfY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231128105348epcas2p3bd74a8e5573fc73750a95ef2aa782e00~bxAlglmkR0458704587epcas2p3o;
	Tue, 28 Nov 2023 10:53:48 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.90]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SffT82K0Kz4x9Pw; Tue, 28 Nov
	2023 10:53:48 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-bb-6565c6bcf398
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4E.56.10006.CB6C5656; Tue, 28 Nov 2023 19:53:48 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Device Detection
Reply-To: wj28.lee@samsung.com
Sender: =?UTF-8?B?7J207JuQ7J6s?= <wj28.lee@samsung.com>
From: =?UTF-8?B?7J207JuQ7J6s?= <wj28.lee@samsung.com>
To: NISHAD TAKSANDE <nishadtaksande@gmail.com>
CC: =?UTF-8?B?6rmA6rK97IKw?= <ks0204.kim@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAOzEdP__7TU4ES=3gVpCfiBMOChU+x_f-PUNYM8=RUGF-11ckA@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231128105347epcms2p40977dc9bf5b4cca6a19a1a907d71d562@epcms2p4>
Date: Tue, 28 Nov 2023 19:53:47 +0900
X-CMS-MailID: 20231128105347epcms2p40977dc9bf5b4cca6a19a1a907d71d562
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmhe6eY6mpBpMm81sc3cNhcX7WKRaL
	G3cOsjowe+ycdZfdo2/LKkaPz5vkApijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
	LS3MlRTyEnNTbZVcfAJ03TJzgPYoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgrM
	C/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzTn1tYS14xFvxafon9gbGb1xdjJwcEgImEu3TOlm7
	GLk4hAR2MEq8mPqevYuRg4NXQFDi7w5hkBphAVmJu+efMoHYQgJyEndvn2KCiJtLLPkxkxHE
	ZhMwlZh26BI7iC0ioCfx7/NnVhCbWaBAYtvpBlaIXbwSM9qfskDY0hLbl28F6+UUCJSYefMa
	M0RcQ+LHsl4oW1Ti5uq37DD2+2PzGSFsEYnWe2ehagQlHvzcDRWXkvh64i9UfbFE18rTbCCv
	SADd8OpDPURYX6Lx+ns2iA99JdZc9gQJswioSnyb/4AJosRF4u7lhewQ18tLbH87hxmknFlA
	U2L9Ln2IgcoSR26xQFTwSXQchtnJK7Fj3hOoKUoSU9qOQN0lIdHQuJUNwvaQuLf/K+sERsVZ
	iFCehWTXLIRdCxiZVzGKpRYU56anFhsVGMIjNjk/dxMjOLlpue5gnPz2g94hRiYOxkOMEhzM
	SiK8eh+TU4V4UxIrq1KL8uOLSnNSiw8xmgJ9OZFZSjQ5H5he80riDU0sDUzMzAzNjUwNzJXE
	ee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYIo0VdrsxaxafmjtH7WZi3I1nhe3VvFuCTWpzjGY
	WRP6Zr2anr/eKfm9J4UeKVrKNGzb8PjXHk+dfSvb355s1OqOrKo/FvlSdnLFwpwbV7PL7Nuq
	C/YnlXyv/L4wjlMt54eYaeTfArGeSZfvPVjc6LLXZ1ms6ESO9+kfmpNTdtfvOa/2bk/elY0q
	ll9CjjNcqTLRLbv1/17qlb4XCWua0sLMLe9G7+mZWeex/Ud1VVGc3Kxdv3RTTZov+LobtZvz
	3lt9unRiDUeplGxuSQfTy7wlmztjrgeLf3LkYZ0mGa05+XbD2ke25w9t2sN1f6NQzXUziXdJ
	Hy/MV/piIuAx/e/DFVXn5HeanJmwIfpqrRJLcUaioRZzUXEiAB4r4vr3AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231123105943epcas2p2fc20911196eb1e064c0f9e8c110c7ed1
References: <CAOzEdP__7TU4ES=3gVpCfiBMOChU+x_f-PUNYM8=RUGF-11ckA@mail.gmail.com>
	<CGME20231123105943epcas2p2fc20911196eb1e064c0f9e8c110c7ed1@epcms2p4>

On Thu, Nov 23, 2023 at 04:29:19PM +0530, NISHAD TAKSANDE wrote:
> Hello,
>
> We are currently in initial phase of working with CXL technology and
> we are facing issues while enumerating our CXL 1.1 device,
> The CXL device is connected to AMD EPYC 9004 series motherboard. The
> device is not getting detected as a CXL device and it is not viewable
> in lspci,
> We wanted to know the steps we can perform for enumeration or what
> capabilities to include so that it gets detected.
>
> If anyone could suggest what can be done from the CXL driver package
> available in the kernel source (we are using kernel v6.7-rc1 &
> v6.6.2),
> then we can implement it and get useful information through kernel
> logs, as to what is stopping the device from getting enumerated as a
> CXL 1.1 device.
>
> Please also suggest if there are any CXL specific utilities we can use
> for device detection / Enumeration.
> Currently we have tried cxl-cli utility from ndctl and also Samsungs
> SMDK utility
> but we cannot see any cxl device getting detected.
>
> Please suggest if we could provide any information which could be
> essential for this investigation.
>
> warm regards
>

Hello,

In our experience, if the device is not visible via lspci after the OS boots,
it is helpful to verify that the device enumeration was successful in the BIOS.
As you know, you can use the pci command in the uefi shell to check if the
device was successfully enumerated during the system firmware phase. You can
also use memmap to check if the device's memory range is visible.

In some cases, especially depending on the BIOS version, the device may not be
recognized. A detailed log would be helpful in identifying the cause.

Thanks,
Wonjae
