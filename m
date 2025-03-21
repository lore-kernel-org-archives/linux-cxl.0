Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3ED7494
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579060; cv=none; b=PU8IPHrneLheXN9SID506/XT23qZT2hYAtt5+tYuAbKXv0KXK7H6gTED5GJ8OMPg1ie441CKWUXNPfA79D+WeKYFzfMJ2deQYsw8TGzA4Be8/e5pBKXvZRbUu2qMsuHBS73iaeJz5wkKJ5Z1oZP/oA5S5b5F0owhxTIkV4hlzXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579060; c=relaxed/simple;
	bh=50CAvgM2Vx7mRZuIP2hdqV4GT0stFE0r4d6oKfYrFlM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=FZrStEnEQi2sCCSUUro+Uyvux0SEznjiJmnO+h6WS7DYhve9tUE58RpETHc2jPQOK3RXOMatQW11a6sUy0O9cpQPmSQqmWRL7DGUS/qisbP/vfmojvBWeVoyaYHq9TzPQ4Q4ywcXonwilqK3/RrsHAalcCLnpnGauHcGCGFGGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SAcZIJ5r; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SAcZIJ5r"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20250321173545usoutp014ef65c7425bdbf279e92cc3cbc821586~u4fRluVro2518125181usoutp010;
	Fri, 21 Mar 2025 17:35:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20250321173545usoutp014ef65c7425bdbf279e92cc3cbc821586~u4fRluVro2518125181usoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742578545;
	bh=50CAvgM2Vx7mRZuIP2hdqV4GT0stFE0r4d6oKfYrFlM=;
	h=From:To:CC:Subject:Date:References:From;
	b=SAcZIJ5rP0ZvdV2+1YDrhXFwDhaByDCRdgpMzrZeKD6ZOl5tyU34miwtZaTDYJcXR
	 JbCv1rL+WiojRNhYIWwirlS899d+HyHId/kPn98COt1vNhaC51Yc1xvcxcbmoclXw7
	 fRSeD4bVDHq+ITctCpPZ8oh+gdDvn9tqGlJoqY6Q=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250321173545uscas1p2ceb4d01aba6bcc2e880b514eec7d4ead~u4fRay0vw2811728117uscas1p2f;
	Fri, 21 Mar 2025 17:35:45 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id 21.4B.10853.173ADD76; Fri,
	21 Mar 2025 13:35:45 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250321173545uscas1p13ddcb034757adaf41dcc3f64dbedb509~u4fRELpyE1469214692uscas1p11;
	Fri, 21 Mar 2025 17:35:45 +0000 (GMT)
X-AuditID: cbfec370-4b7ff70000002a65-ab-67dda3717642
Received: from SSI-EX3.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id C3.CC.23118.073ADD76; Fri,
	21 Mar 2025 13:35:44 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.44; Fri, 21 Mar 2025 10:35:44 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.8.30]) by
	SSI-EX3.ssi.samsung.com ([105.128.8.30]) with mapi id 15.01.2507.044; Fri,
	21 Mar 2025 10:35:44 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: [LSF/MM/BPF BoF] CXL F2F
Thread-Topic: [LSF/MM/BPF BoF] CXL F2F
Thread-Index: AQHbmoes1f9CEVbsykW9UHBtqvxF3A==
Date: Fri, 21 Mar 2025 17:35:44 +0000
Message-ID: <Z92jav0f71F50-pI@sjvm-adma01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34B238BD4E60A447B0B1870B18E821DF@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzred3CxXfTDb6vkrA4P+sUi8W+13uZ
	Le73OTgwe0y+sZzRY/2WqywenzfJBTBHcdmkpOZklqUW6dslcGXsePmcreA0U8X0u3kNjE1M
	XYycHBICJhJvv0xl7WLk4hASWMko8XHGb2YIp5VJYvq0lcwwVYsvb2OESKxhlFjy5jYrSEJI
	4BOjxKwTHBCJJYwSyyavYAFJsAkYSPw+vhGsW0QgV+LB5C3sIDazgLVE/+mzYHFhAUWJqy8+
	sUDUqEnMn7iUFcLWk5h9ah7YfSwCqhL3T5wE6+UVsJTY8fMhI4jNKCAm8f3UGiaImeISt57M
	h/pHUGLR7D1QV4tJ/Nv1kA3CVpS4//0l1A06Egt2f2KDsO0k7l16BDVHW2LZwtfMELsEJU7O
	fMIC0SspcXDFDRaQJyUEOjkkJnRegFrmIrFv63RWCFta4u/dZVDxfIldbVegjqiQuPq6G+oI
	a4mFf9ZDLeOT+PvrEeMERuVZSH6YheS+WUjum4XkvllI7lvAyLqKUby0uDg3PbXYOC+1XK84
	Mbe4NC9dLzk/dxMjMMGc/ne4YAfjrVsf9Q4xMnEwHmKU4GBWEuEV6bidLsSbklhZlVqUH19U
	mpNafIhRmoNFSZxX5UBrupBAemJJanZqakFqEUyWiYNTqoGpp2DKU9d3bH5L1YU1VHZ/nWIr
	f3RjlfTpU8+/ZqbXvrRtib/jsrAiSuhm9iPh/16lxtsivv3Sl3dX3/bGgfESg/WDsrqQA0pK
	1ZuOh9Uc7v1xWGPNVK7Lk4/Ur4lYs0Vve6F00mfLPSdebr+S0Fn1yHeqyf32nUKrZbZ+S3YR
	j/vg4LorexGzvrPatMuvhc38DvlFex/WPfIue827M6LnxPLllmf8XHH28ubiUj25B/6Ci6Za
	/+w+sV15sqp1SWL+Tr+W+bWxcxpDSqrCrG42TxMOijuW3PYv1L88bt6zGcGSF94uNpsda34t
	f+FLsQf1zAxt61tt/3wW/DhzetaDHU2duxiaD28TVlNn0hRVYinOSDTUYi4qTgQANUYdCJ8D
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWS2cDsrFuw+G66wew11hbnZ51isdj3ei+z
	xf0+Bwdmj8k3ljN6rN9ylcXj8ya5AOYoLpuU1JzMstQifbsErowdL5+zFZxmqph+N6+BsYmp
	i5GTQ0LARGLx5W2MXYxcHEICqxgldkx4yQ7hfGKUmDptNpSzhFHiVPc8NpAWNgEDid/HNzKD
	2CICuRIPJm9hB7GZBawl+k+fBYsLCyhKXH3xiQWiRk1i/sSlrBC2nsTsU/PAVrMIqErcP3ES
	rJdXwFJix8+HjCA2o4CYxPdTa5ggZopL3HoyH+pUAYkle84zQ9iiEi8f/2OFsBUl7n9/CXWD
	jsSC3Z/YIGw7iXuXHkHN0ZZYtvA1M8QuQYmTM5+wQPRKShxccYNlAqPYLCTrZiEZNQvJqFlI
	Rs1CMmoBI+sqRvHS4uLc9Ipio7zUcr3ixNzi0rx0veT83E2MwGg7/e9w9A7G27c+6h1iZOJg
	PMQowcGsJMIr0nE7XYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv3QcaqUIC6YklqdmpqQWpRTBZ
	Jg5OqQam5Gtb7nXkhshrzZFlTE0W5GWUmCKyfc1FjnN8X3hcFDZIbpqctMB61VZ/RcGvAkuz
	GVwan2tVC0/13f/MZC1XT82c7e8DZk/4uzhle3yD1z8TEb6kk5YbEhReSBgeWv/121SLkoP8
	8gU5H5gVFtzMrrfatfq11Z0Z67okNk9+MfFxUHqTlU1ZfkDXnqaf88JD36w9Ycu3pCnyN8dB
	8yAjXaNAgW+L9l6RNe19/cMo8oJK9trI9MlXnmX7rT2W+HjVe8PMO5cy7gtvDVnUJzHjsvDv
	uXyH2+dbm5yuOV978EpJv3Hh7uJ6s8xHT0pYTxWvUctfc+zvvPJVoi3lr1c4qrz/mBd0T0P8
	aWv6biU/JZbijERDLeai4kQAiMgCqSUDAAA=
X-CMS-MailID: 20250321173545uscas1p13ddcb034757adaf41dcc3f64dbedb509
CMS-TYPE: 301P
X-CMS-RootMailID: 20250321173545uscas1p13ddcb034757adaf41dcc3f64dbedb509
References: <CGME20250321173545uscas1p13ddcb034757adaf41dcc3f64dbedb509@uscas1p1.samsung.com>


Hello,

I would like to have a BOF/encourage hallway chat for those interested
in CXL driver development. A couple of suggested topics:

- Type2 Support
- DCD support
- RAS evolution
- CXL Device virtualization
- CXL.io control plane + non cxl data plane

Please add others who many be interested.

Take care,
Adam=
