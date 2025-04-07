Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3D20E6E8;
	Mon,  7 Apr 2025 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043060; cv=none; b=o9qMLH97BUahUg1dpreNYUUHBMK9p07QiMneyCpvcj1/kU/jmPlRUdPXBXV52xPjFW4uhBJB4ZCjmuaLMqNTCDM4FE0oqUpiDFJa8dSKHakrstjJMKGtVxglF6MmOIHr994+rP2B21/p4GKQA99n9x1gefu93sS9z2R7ndq8Eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043060; c=relaxed/simple;
	bh=BX2OylRjTEWyuqtrqriHr2iC8YNM9oUeFRa/G1yRxD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=OFZhkx+Rr5xEZKsIzIEWD8iDW5/kkOBPRv9xo8tXvrVmQ8bgSNz/OL4NJaKeLDTSaxEDUBpJo8d0umc5u7FEnJEF2sb34YYM2PxvdvZRm0IYGUB7mQLZ0QJm47YOi0SyHpmzK4f5Fe0YwHXud8C7T0n/veSfwS+EmR3P/ThNCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g3JHyA5R; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g3JHyA5R"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20250407161445usoutp015fc88e0ee24a742e0fd18536a99fe488~0FWZ9sq4V3037730377usoutp01n;
	Mon,  7 Apr 2025 16:14:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20250407161445usoutp015fc88e0ee24a742e0fd18536a99fe488~0FWZ9sq4V3037730377usoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744042485;
	bh=BX2OylRjTEWyuqtrqriHr2iC8YNM9oUeFRa/G1yRxD4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=g3JHyA5R06HxUMnmT3+2yDysUc+dH2ZStLOaOLPD/Tqfv9Q+fW6RpMZE6TxlT65ei
	 tUrsNpKBIq2+5F0TV1tjnIcMHP0fb1IAn60DTKbtSJc+xHo6xFeQZjnbhJCimjwkSt
	 Kxpf0ker3OQ3aJYOevYOf2ayqv9xt+KSwZicYq3M=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250407161445uscas1p1c684f440defe1b5e3597e9ca65c9d07b~0FWZ3UGC40076300763uscas1p1w;
	Mon,  7 Apr 2025 16:14:45 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id BD.9B.10853.5F9F3F76; Mon, 
	7 Apr 2025 12:14:45 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250407161445uscas1p19322b476cafd59f9d7d6e1877f3148b8~0FWZqaSGt0283302833uscas1p1M;
	Mon,  7 Apr 2025 16:14:45 +0000 (GMT)
X-AuditID: cbfec370-527bf70000002a65-36-67f3f9f5023b
Received: from SSI-EX3.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 58.CC.23118.5F9F3F76; Mon, 
	7 Apr 2025 12:14:45 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.44; Mon, 7 Apr 2025 09:14:44 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.8.30]) by
	SSI-EX3.ssi.samsung.com ([105.128.8.30]) with mapi id 15.01.2507.044; Mon, 7
	Apr 2025 09:14:44 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Gregory Price <gourry@gourry.net>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>
Subject: Re: [LSFMM] Updated: Linux Management of Volatile CXL Memory
 Devices
Thread-Topic: [LSFMM] Updated: Linux Management of Volatile CXL Memory
	Devices
Thread-Index: AQHbo4sSrr/1aO9zr0GJmcBOzZoej7OY3pYA
Date: Mon, 7 Apr 2025 16:14:44 +0000
Message-ID: <Z_P573QpYuWB4Zud@sjvm-adma01.eng.stellus.in>
In-Reply-To: <Z-zB86WcoMEQ9lKV@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0A32597186D05144A2FC7D8A5AE86327@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djX87pff35ONzh8U9bi593j7BbnZ51i
	sbi8aw6bxb01/1kt9r3ey2xxv8/Bgc2ju+0yu8emT5PYPSbfWM7osX7LVRaPz5vkAlijuGxS
	UnMyy1KL9O0SuDI2bHzAXLCBpWL12c9sDYzXmbsYOTkkBEwkjnz5wt7FyMUhJLCSUWJ5+1YW
	CKeVSWLd4zXsMFX/z7+CSqxhlNg0YxUThPORUeLPrXZWCGcxo8SeGxfZQFrYBAwkfh/fCLSE
	g0NEQFWi7Yo7SA2zwEwmiV23e1hBaoQF/CX6N/1hBLFFBAIkbv3azgxhG0m8aLwIVsMioCKx
	5voesDivgKXE96+/wOZzCphJ3Oq8AmYzCohJfD+1hgnEZhYQl7j1ZD4TxNmCEotm74F6VEzi
	366HbBC2osT97y/ZIep1JBbs/sQGYdtJNE1qYoWwtSWWLXwNtVdQ4uTMJywQvZISB1fcAAeF
	hMAVDolpM5ZCw8hFYsm3RlYIW1ri791lUEfkS+xquwJ1RIXE1dfdUEdYSyz8s55pAqPKLCR3
	z0Jy0ywkN81CctMsJDctYGRdxSheWlycm55abJyXWq5XnJhbXJqXrpecn7uJEZiWTv87XLCD
	8datj3qHGJk4GA8xSnAwK4nwWp76lC7Em5JYWZValB9fVJqTWnyIUZqDRUmcV+VAa7qQQHpi
	SWp2ampBahFMlomDU6qByb3G6t92BfH9K0JmO+UYVv833K/FeCc+S+vQzi9CNazO4Ye0N/9K
	yDF582dnS9EkzT1aSiXTZn0pjWrb9G9pzLHyvs02M55kTOMOTk1/8DL9e9+6GXZ2k0vXv/90
	3IvPlcejPPn4XNvD1yfKOXPqr5zat5Lr4frfs27dffv63F1paRH/g8CwmKUsfEl7ofu2r9Gy
	Pm/yWu+nHzx1qZd7NePi1exRE8I9na/eLlokbMyY2Cfzfuu5A5+3GMwzWjeF1/vroRspPI9W
	Lffn3Gx2Uytr52Uez/yE9GdlD1ieTKsTn/t6+eeX6Z99NPavXd8pYf6zvcDyf3aW8tcw3/df
	bpgFbjFSfpzi4/3t3aq6DiWW4oxEQy3mouJEAG06wbS6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWS2cDsrPv15+d0g/WX+Sx+3j3ObnF+1ikW
	i8u75rBZ3Fvzn9Vi3+u9zBb3+xwc2Dy62y6ze2z6NIndY/KN5Ywe67dcZfH4vEkugDWKyyYl
	NSezLLVI3y6BK2PDxgfMBRtYKlaf/czWwHiduYuRk0NCwETi//lXLF2MXBxCAqsYJTqen2CC
	cD4ySuxpf8kO4SxmlHi6ZCtYC5uAgcTv4xuBbA4OEQFVibYr7iA1zAIzmSR23e5hBakRFvCV
	2DJ5EjuILSLgJ/Fw9QE2CNtI4kXjRbAaFgEViTXX94DN5BWwlPj+9RcbxLJeRokXM3uZQBKc
	AmYStzqvgDUzCohJfD+1BizOLCAucevJfCaIHwQkluw5D/WPqMTLx/9YIWxFifvfX7JD1OtI
	LNj9iQ3CtpNomtTECmFrSyxb+BrqCEGJkzOfsED0SkocXHGDZQKjxCwk62YhGTULyahZSEbN
	QjJqASPrKkbx0uLi3PSKYqO81HK94sTc4tK8dL3k/NxNjMCYPv3vcPQOxtu3PuodYmTiYDzE
	KMHBrCTCa3nqU7oQb0piZVVqUX58UWlOavEhRmkOFiVx3rsPNFKFBNITS1KzU1MLUotgskwc
	nFINTFIO2j2lPH/9GnVkmyY0zJv4MTdgrbvWS0Odhk77I0f/6noK7978tqTFxnbSHPHaV/sX
	5rply084qOdguDmye5foyeOZEnZTUhN32c9IY1j+/ZGRQeFxgcWPdjEeZWstnPnv7vbZmjP6
	uW30ziV73X9+923Uvm928968EnFYyb7k3Nt3MxSdWmU8y09kJuw8biT0LcX9vdPBZ5f7f2aW
	+OytuSH+3GyfzoIbJmXRTw3nGptWznCYuXCbdYTfG9+aMx8S1HeqXHAKms5woYPr1BHZy+WX
	P3+bFtWtzhqwl/0v8+odr59vTjGf80pXpP/j4QPXBLyt05a9eh1r8/qyyKcZj3nvmfD9mtz+
	aEvx5CYlluKMREMt5qLiRAAYRNGSWAMAAA==
X-CMS-MailID: 20250407161445uscas1p19322b476cafd59f9d7d6e1877f3148b8
CMS-TYPE: 301P
X-CMS-RootMailID: 20250407161445uscas1p19322b476cafd59f9d7d6e1877f3148b8
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
	<Z9mo5qCpdlE-KZ7P@gourry-fedora-PF4VCD3F>
	<Z-zB86WcoMEQ9lKV@gourry-fedora-PF4VCD3F>
	<CGME20250407161445uscas1p19322b476cafd59f9d7d6e1877f3148b8@uscas1p1.samsung.com>

On Wed, Apr 02, 2025 at 12:49:55AM -0400, Gregory Price wrote:
> Slides up at:
> https://github.com/gourryinverse/cxl-boot-to-bash/blob/main/presentations=
/lsfmm25.pdf
>=20
> Docs Transitioning to:
> https://github.com/gourryinverse/cxl-boot-to-bash/tree/main
>=20
> Browsable Page:
> https://gourryinverse.github.io/cxl-boot-to-bash/
>=20
> All help hacking on this is welcome. I imagine we'll convert some
> portion of this over to kernel docs, but not sure what.

Thanks for presenting at LSF/MM and posting links

>=20
> ~Gregory Price=
