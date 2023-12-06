Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q/oMezMg"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D4D3
	for <linux-cxl@vger.kernel.org>; Wed,  6 Dec 2023 00:09:48 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231206080946epoutp01698edc3c1bfb49d3ff54b3c52892435c~eL7pHFRaZ2095520955epoutp01I
	for <linux-cxl@vger.kernel.org>; Wed,  6 Dec 2023 08:09:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231206080946epoutp01698edc3c1bfb49d3ff54b3c52892435c~eL7pHFRaZ2095520955epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701850186;
	bh=Fso5/pPuQYfyNxzsgIMy5JApCqfEarIJMA8gEwbKDn8=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=q/oMezMg07sg7gnhTvA6SAApKpfcFEJdo6SmcSKq1q3gr4tKRIg5PoBh8Dop1BT/f
	 vhsAT98mmPiP3gMCOnovh6GehOCAM7QmKMlsxFE32RgxjPkQhcnAXnVz7rMWYoG/AX
	 t7+lbCMkvYrH8dQ1P04YkKaWVI4hzWStDoDhXYug=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20231206080945epcas2p110d896b28b21405358d79f4bcd6b30fc~eL7orLbRl0665606656epcas2p1L;
	Wed,  6 Dec 2023 08:09:45 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.98]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SlVS91rnwz4x9Q8; Wed,  6 Dec
	2023 08:09:45 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-13-65702c49eb89
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.53.10022.94C20756; Wed,  6 Dec 2023 17:09:45 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [RFC PATCH v2 4/4] mm/mempolicy: implement a
 weighted-interleave
Reply-To: seungjun.ha@samsung.com
Sender: Seungjun Ha <seungjun.ha@samsung.com>
From: Seungjun Ha <seungjun.ha@samsung.com>
To: Gregory Price <gourry.memverge@gmail.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Gregory Price
	<gregory.price@memverge.com>, KyungSan Kim <ks0204.kim@samsung.com>, Wonjae
	Lee <wj28.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7>
Date: Wed, 06 Dec 2023 17:09:44 +0900
X-CMS-MailID: 20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmha6nTkGqwaYWbosXf54zWTQ0PWKx
	OLqHw+L8rFMsFhvvv2NzYPXYOesuu8fGj//ZPfq2rGL0+LxJLoAlKtsmIzUxJbVIITUvOT8l
	My/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2itkkJZYk4pUCggsbhYSd/Opii/
	tCRVISO/uMRWKbUgJafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y8qWuawF9zQrfnzbxtLA
	uE+ji5GTQ0LAROLLkQOMXYxcHEICOxglWjoaWLoYOTh4BQQl/u4QBqkRFvCXmHVjHROILSSg
	KPHjyw5WiLiuxNzHBxlBytkEtCVObI8HCYsAhXd0HmYDGckssJVR4tzeHYwQu3glZrQ/ZYGw
	pSW2L98KFdeQ+LGslxnCFpW4ufotO4z9/th8qBoRidZ7Z6FqBCUe/NwNFZeSmPPpKNTMYonN
	W3axQtgFEn2PLrBB2PoSjdffg9m8Ar4S687PBKthEVCVmLXiIVS9i0Tz2Ttge5mBflm28DUz
	yF/MApoS63fpg5gSAsoSR26xQFTwSXQc/ssO89WOeU+YIGxViYb9TcwwH37bug7qMg+JEx8e
	QUMwUGLGnjlMExgVZiHCeRaSvbMQ9i5gZF7FKJZaUJybnlpsVGAMj9rk/NxNjOD0p+W+g3HG
	2w96hxiZOBgPMUpwMCuJ8Oacz08V4k1JrKxKLcqPLyrNSS0+xGgK9PFEZinR5HxgAs4riTc0
	sTQwMTMzNDcyNTBXEue91zo3RUggPbEkNTs1tSC1CKaPiYNTqoFpwg0mH6ecnce/7isQW3/7
	TetOxlsMFfaH4tqkqlT+yKXd+5ez7Y37x6vrJpUqXUiZcXa+1xGpPSvmbl63KFus/o/8hY3V
	6WuVtiyQFwp2TrofEtDK3uO6505K9e3ET8EtswJmOnivDWFU+pyst11muYaL8ePE6hjOHzs6
	l9zwvqP0gj3w65qYnbErPy5//jm0oU7EZuEKMXm93wJtrh4pJkwS1i/Fdzucm72gqkL1fINq
	yJ+MqS9+x+7y/LdAbsc7W0GJ9KWJrVqrFR1LeAv/e0uK2G74Xrn9e3LvPWPDfdpn9k9UO/qS
	fVbZnyU+V3vmfV08I8s6bOW8Rg6r4t5jkulqqxkk10zoOt/yyahPiaU4I9FQi7moOBEAEOXs
	uAgEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce
References: <CGME20231206080944epcms2p76ebb230b9f4595f5cfcd2531d67ab3ce@epcms2p7>

> The weighted-interleave mempolicy implements weights per-node
> which are used to distribute memory while interleaving.
>
> For example:
>=C2=A0=20=C2=A0=20nodes:=200,1,2=0D=0A>=C2=A0=20=C2=A0=20weights:=205,3,2=
=0D=0A>=0D=0A>=20Over=2010=20consecutive=20allocations,=20the=20following=
=20nodes=20will=20be=20selected:=0D=0A>=20=5B0,0,0,0,0,1,1,1,2,2=5D=0D=0A>=
=0D=0A>=20In=20this=20example=20there=20is=20a=2050%/30%/20%=20distribution=
=20of=20memory=20across=0D=0A>=20the=20enabled=20nodes.=0D=0A>=0D=0A>=20If=
=20a=20node=20is=20enabled,=20the=20minimum=20weight=20is=20expected=20to=
=20be=200.=20If=20an=0D=0A>=20enabled=20node=20ends=20up=20with=20a=20weigh=
t=20of=200=20(as=20can=20happen=20if=20weights=0D=0A>=20are=20being=20recal=
culated=20due=20to=20a=20cgroup=20mask=20update),=20a=20minimum=0D=0A>=20of=
=201=20is=20applied=20during=20the=20interleave=20mechanism.=0D=0A=0D=0AI=
=20found=20an=20issue=20while=20using=20the=20RFCv2,=20and=20want=20to=20re=
port=20it.=C2=A0=0D=0AIn=20my=20testbed,=20calling=20set_mempolicy2()=20cau=
ses=20pthread_create()=20failure=20or=20system=20hang,=20depending=20on=20w=
eight=20combinations.=0D=0A=0D=0AFYI=20please=20find=20my=20testbed=20where=
=20there=20are=203=20memory-nodes.=C2=A0=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20Node=200=C2=A0=20Node=201=C2=A0=20Node=202=
=C2=A0=C2=A0Result=0D=0AWeights=C2=A0=C2=A0=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=206=20>=3D=C2=A0=20=20=201=C2=A0=20=C2=A0=20=C2=
=A0=20=201=C2=A0=20=20=20=20=20=20pthread_create=20error:=2011(Cannot=20all=
ocate=20memory)=0D=0A=20=20=20=20=20=20=20=20=20=20=C2=A0=201=7E5=C2=A0=20=
=20=20=201=C2=A0=20=20=20=20=20=201=C2=A0=20=20=20=20=20=20Pass=0D=0A=20=20=
=20=20=20=20=20=20=20=20=C2=A0=201=C2=A0=20=20=20=20=20=208=20>=3D=C2=A0=20=
=20=201=C2=A0=20=20=20=20=20=20pthread_create=20error:=2011(Cannot=20alloca=
te=20memory)=0D=0A=20=20=20=20=20=20=20=20=20=20=C2=A0=201=C2=A0=20=20=20=
=20=20=201=7E7=C2=A0=20=20=20=201=C2=A0=20=20=20=20=20=20Pass=0D=0A=20=20=
=20=20=20=20=20=20=20=20=C2=A0=201=C2=A0=20=20=20=20=20=201=C2=A0=20=20=20=
=20=20=208=20>=3D=C2=A0=20=20=20pthread_create=20error:=2011(Cannot=20alloc=
ate=20memory)=0D=0A=20=20=20=20=20=20=20=20=20=20=C2=A0=201=C2=A0=20=20=20=
=20=20=201=C2=A0=20=20=20=20=20=201=7E7=C2=A0=20=20=20=20Pass=0D=0A=0D=0A=
=20=20=20=20=20=20=20=20=20=20=C2=A0=206=C2=A0=20=20=20=20=20=207=C2=A0=20=
=20=20=20=20=207=C2=A0=20=20=20=20=20=20pthread_create=20error:=2011(Cannot=
=20allocate=20memory)=0D=0A=20=20=20=20=20=20=20=20=20=20=C2=A0=205=20=20=
=20=20=20=C2=A0=208=20=20=20=20=20=C2=A0=207=C2=A0=20=20=20=20=20=20Pass=0D=
=0A=20=20=20=20=20=20=20=20=20=20=C2=A0=205=20=20=20=20=20=C2=A0=207=20=20=
=20=20=20=C2=A0=208=C2=A0=20=20=20=20=20=20Pass=0D=0A=0D=0A=20=20=20=20=20=
=20=20=20=20=20=C2=A0=2040=20=20=20=20=C2=A0=2030=C2=A0=20=20=20=20=2020=C2=
=A0=20=20=20=20=20Kernel=20Hang=0D=0A=0D=0A=0D=0ABelow=20is=20the=20test=20=
code=20to=20reproduce=20the=20issue.=0D=0A=0D=0A=23define=20_GNU_SOURCE=0D=
=0A=23include=20<stdio.h>=0D=0A=23include=20<stdlib.h>=0D=0A=23include=20<n=
uma.h>=0D=0A=23include=20<errno.h>=0D=0A=23include=20<numaif.h>=0D=0A=23inc=
lude=20<unistd.h>=0D=0A=23include=20<pthread.h>=0D=0A=0D=0A=23define=20MPOL=
_WEIGHTED_INTERLEAVE=20MPOL_DEFAULT=20+=208=0D=0A=23define=20SET_MEMPOLICY2=
(a,=20b)=20syscall(454,=20a,=20b)=0D=0A=0D=0Astruct=20mempolicy_args=20=7B=
=20on=20this=20RFC...=20=7D=0D=0A=0D=0Astruct=20mempolicy_args=20wil_args;=
=0D=0Astruct=20bitmask=20*wil_nodes;=0D=0Aunsigned=20char=20*weights;=0D=0A=
int=20total_nodes=20=3D=20-1;=0D=0Apthread_t=20tid;=0D=0A=0D=0Avoid=20set_m=
empolicy_call()=0D=0A=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20weights=
=20=3D=20(unsigned=20char=20*)calloc(total_nodes,=20sizeof(unsigned=20char)=
);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20wil_nodes=20=3D=20numa_allocate=
_nodemask();=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20numa_bitmask_se=
tbit(wil_nodes,=200);=20weights=5B0=5D=20=3D=2040;=0D=0A=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20numa_bitmask_setbit(wil_nodes,=201);=20weights=5B1=5D=20=
=3D=2030;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20numa_bitmask_setbit(wil_=
nodes,=202);=20weights=5B2=5D=20=3D=2020;=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20wil_args.maxnode=20=3D=20total_nodes=20+=201;=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20wil_args.wil.weights=20=3D=20weights;=0D=0A=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20wil_args.nodemask=20=3D=20wil_nodes->maskp=
;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20wil_args.mode=20=3D=20MPOL_WEIGH=
TED_INTERLEAVE;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20wil_args.flags=20=
=3D=200;=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20int=20ret=20=3D=20S=
ET_MEMPOLICY2(&wil_args,=20sizeof(wil_args));=0D=0A=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20fprintf(stderr,=20=22set_mempolicy2=20result:=20%d(%s)=5Cn=22,=
=20ret,=20strerror(errno));=0D=0A=7D=0D=0A=0D=0A=0D=0Aint=20main()=0D=0A=7B=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20total_nodes=20=3D=20numa_max_node=
()=20+=201;=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20set_mempolicy_ca=
ll();=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20pthread_create(&tid,=20NULL,=
=20func,=20NULL);=0D=0A=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=200=
;=0D=0A=7D
