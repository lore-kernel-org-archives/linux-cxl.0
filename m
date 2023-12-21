Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D151C27
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oR5xiLu/"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231221092033epoutp0453254dd308aaa2345fd39f9df059a8dd~izkuxLg-31561515615epoutp04p
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 09:20:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231221092033epoutp0453254dd308aaa2345fd39f9df059a8dd~izkuxLg-31561515615epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703150433;
	bh=jPPzNat8dlaCUbTHzYg/vZyrMzjCl6S48Mx8JFajvlE=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=oR5xiLu/sl0gjKkEnUbI+mdrtCnkIaIwuNl8annOmT03oSnU48ryAudc1cjmeK0fe
	 mx0cTz2AR6fE6T0oZ5Y2UoRuSiTqg8UbuiOhb4DTBAF0zHd76EmFiU2TowJ/F/9dOm
	 aUovnVwNuGkzlX3hJPcMVqwcexTLmp6C4GF3VAiU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231221092033epcas2p1b5a572ad3bdbdd99043ba56c978cf296~izkuibM-f2742427424epcas2p1W;
	Thu, 21 Dec 2023 09:20:33 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SwlJw5kHdz4x9Pv; Thu, 21 Dec
	2023 09:20:32 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-7f-65840360159c
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.A6.10022.06304856; Thu, 21 Dec 2023 18:20:32 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) Device Detection
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: NISHAD TAKSANDE <nishadtaksande@gmail.com>
CC: KyungSan Kim <ks0204.kim@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAOzEdP9v7t6aAZ2guJRmT_HnJs5TVJPjPok5enG4sHErLmf=ug@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231221092032epcms2p6eb5d7b85669242aa4823c50324de3bd3@epcms2p6>
Date: Thu, 21 Dec 2023 18:20:32 +0900
X-CMS-MailID: 20231221092032epcms2p6eb5d7b85669242aa4823c50324de3bd3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmuW4Cc0uqwaeLMhZH93BYnJ91isXi
	xp2DrA7MHjtn3WX36NuyitHj8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11D
	SwtzJYW8xNxUWyUXnwBdt8wcoD1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALz
	Ar3ixNzi0rx0vbzUEitDAwMjU6DChOyMNxuOMxW85a+Y0/aRvYFxOU8XIweHhICJxJ4fVl2M
	XBxCAjsYJR5+W8wKEucVEJT4u0O4i5GTQ1hAQeJTex8riC0kICdx9/YpJoi4psSbaatYQGw2
	AXWJH50nweIiAnoS/z5/BqtnFkiR2LluBxuILSHAKzGj/SkLhC0tsX35VkYQm1MgUOLfsy9Q
	NRoSP5b1MkPYohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLiUxNcTf9lBfpEQaGaUWH2s
	nxXCaWCU6Jh5GGqzvkTj9fdsEE/6Sqw7CbaYRUBV4vTrbVDLXCRWzdzDBPGAvMT2t3OYQcqZ
	gR5ev0sfEmzKEkdusUBU8El0HP7LDvPijnlPmCBsJYkpbUegTpOQaGjcCvWih8TKbx9YJjAq
	zkIE9Cwku2Yh7FrAyLyKUSy1oDg3PbXYqMAYHrXJ+bmbGMEJTst9B+OMtx/0DjEycTAeYpTg
	YFYS4d3b2ZQqxJuSWFmVWpQfX1Sak1p8iNEU6MuJzFKiyfnAFJtXEm9oYmlgYmZmaG5kamCu
	JM57r3VuipBAemJJanZqakFqEUwfEwenVAPT5Gfz/Wyy9h6aFvxn+/OvR4w6M1blMRzg919+
	Y+WW24vP1Mys2J72zt3OevV1iWNqx0zyHmyRuPSwbsLkRy0XE8z/ShQ3HO1Oc1g8i0Nm4hLF
	uMO6W4oOHCuofB+zpmLhYlbjbVdld/kqJfes1Y1qYNiWxzgj/fCXHw8EXl468/dWw/YghnCh
	/dYP5sm7+21wP/DCrvJd84X6pVHq7H5brO44xRisan/VmiBQbl5zzd/LsvLKOb35CQ+SzePX
	vLN7E3azSkT9p02Oq5ibxLSjGWbLp18SEvK0FXjVPL/J3UH+KkOFT9WfAEZX9vxZOaE93vEW
	19lilM5+nbdgbvKEd0p5H895NNekMvr8T7yuxFKckWioxVxUnAgAWi1KsfkDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213110307epcas2p4651ce4cb7784dec582ef2301ffcde812
References: <CAOzEdP9v7t6aAZ2guJRmT_HnJs5TVJPjPok5enG4sHErLmf=ug@mail.gmail.com>
	<CGME20231213110307epcas2p4651ce4cb7784dec582ef2301ffcde812@epcms2p6>

On Wed, Dec 13, 2023 at 04:32:42PM +0530, NISHAD TAKSANDE wrote:
> Hello,
>
> Thank you for the advice and sorry for the delayed response.
>
> It is right to deduce that the device is not enumerated from the BIOS
> side, (and we are constantly trying to achieve this enumeration)
> as we have checked the kernel dmesg and also in the UEFI shell with
> 'pci' command in our Host machine, we didn't see our vendor id or
> device id.
>
> We have also checked the acpi tables list and the following tables rae visible:
> APIC  BGRT   dynamic/  FACS  HEST  IVRS  SLIT  SSDT1  SSDT4  WSMT
> ASPT  data/BERT  ERST  FIDT  HMAT  MCFG  SPMI  SSDT2  SSDT5
> BERT  DSDT   FACP      FPDT  HPET  MSCT  SRAT  SSDT3  SSDT6
>
> So can you tell if we are also supposed to get CEDT (CXL Early
> Discovery Table) and CDAT (Coherent Device Attribute Table) get listed
> among these?
>
> I have also uploaded the kernel log and other information if it helps,
> on the following link: https://pastebin.pl/view/38173eff
>
> We have followed the cxl 1.1/2.0 specification while creating the
> bitstream file but seems there is some problem in it.
> So we believe that, if we could get some guidance on the design side
> from you (for eg. minimum requirements) for creating a stable
> bitstream file,
> which will have the capability to get the device enumerated and
> detected in our host machine, then remaining issues would start
> settling.
> so please let me know and once again, thank you for taking the time
> and probing into this issue.
> I await earnestly for your suggestions.
>
> with regards,
> Thank you

As far as I know, cxl pci probing in OS level works fine without CEDT.
However, to configure a CXL topology, you might need to make the ACPI
object in the BIOS.

Once the device is enumerated, it would be good to check with memmap
in the UEFI shell to see if the BIOS recognizes it as a memory area.
After the OS boots, you can check the efi memmap or SRAT log on dmesg.

Thanks,
Wonjae.
