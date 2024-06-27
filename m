Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CA18645
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511176; cv=none; b=d0Q6oEXZfmWbcXUr5cZZxu5XLQqS4kg/SU75U1XCXpq0eHkdKNdDosJ0BPpZxCHHSMeAGFqo7/tExeHQ4mioWO4DyLz+vN95uoMixNDQjrj93U6ump7+yjUWa2vMUBegc2d8uMJM3rWduFKXk2acSuHKthFRm/9Utj4Gk0rt9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511176; c=relaxed/simple;
	bh=Ddo9Xdw4VWgc3o7suurohRbEXX+4qI8s8qSsvqDkzt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=qaA9rCwHQucPVGnSelU9kPs9kqPHwq0HHdurg7D+hz6BjTcGWgmwvO0QNlv3wqyGHOkAaIU11mQblfK7yXg3RP1Kxi9ULwec3xff/2LQ2/VWgUIxiJcODG+7JZziqkLru8Dzt9G4Tosti1FEmIKglg1d07iRLHh4cw3TXMKFTaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CZYSRISC; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CZYSRISC"
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240627175231usoutp01b59c194d07dadb747d7b2fbec8225bf8~c7er7QJIr1507115071usoutp01Q;
	Thu, 27 Jun 2024 17:52:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240627175231usoutp01b59c194d07dadb747d7b2fbec8225bf8~c7er7QJIr1507115071usoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719510751;
	bh=C2BRf4E/gqBmicVLjb4FbQbicfoP0VGbqpelNiQECGs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=CZYSRISCYDNbKqNrcVrVioVCRPUnuONxaIu9RN1wymSNgHpSMI03Qn5PQlvtFdARL
	 9G1qtso7ot3lizv1IE933vdUwrMEj8ZB9V1bsPmYn673Q9XcqxSJ2yYjj7iVGnUk+o
	 cCHyAfGNDBTGhGKSDQqMWBsjFImK3GTsXoKHRE5s=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240627175231uscas1p1adac43ccefc93820ecdbfb6118ea7c18~c7ervLrJZ2426524265uscas1p1C;
	Thu, 27 Jun 2024 17:52:31 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 0A.55.09616.ED6AD766; Thu,
	27 Jun 2024 13:52:30 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240627175230uscas1p1ab1beb18a2a87313be0d665ebefccd27~c7eraqYrV0824908249uscas1p1A;
	Thu, 27 Jun 2024 17:52:30 +0000 (GMT)
X-AuditID: cbfec36d-ff7ff70000002590-41-667da6de5535
Received: from SSI-EX3.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 82.26.56602.ED6AD766; Thu,
	27 Jun 2024 13:52:30 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Thu, 27 Jun 2024 10:52:29 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Thu,
	27 Jun 2024 10:52:29 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Thread-Topic: [PATCH] Documentation: CXL Maturity Map
Thread-Index: AQHawNeUKXOsAWVcaUO+8dv8siuo/rHNBkqAgA9i6gA=
Date: Thu, 27 Jun 2024 17:52:29 +0000
Message-ID: <Zn2m1E47Vk0N5QpR@sjvm-adma01.eng.stellus.in>
In-Reply-To: <6670bea716fde_310129436@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2701CC323F34B541B8D62F8E1CA10A0D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djX87r3ltWmGSw7YmExfeoFRosTNxvZ
	LFYtvMZmcX7WKRYHFo+WI29ZPRbvecnk8XmTXABzFJdNSmpOZllqkb5dAlfGtUWJBct4Kk6v
	OMjUwHiKs4uRk0NCwERiQ9dkpi5GLg4hgZWMEvPPnGCDcFqZJK5PuckCUzXt/3dmiMQaRomz
	s99BOZ8YJTY9egPVv4xR4vi2K2wgLWwCBhK/j29kBrFFBLQlJs45CNbBLLCaUeJS9y7WLkYO
	DmGguZvPpoOYIgKmEg++m0CUW0l83/ENrJVFQFXi6erPYDavgKXE7eNvWEFsTgEPicn/L4DZ
	jAJiEt9PrWECsZkFxCVuPZnPBHG1oMSi2XuYIWwxiX+7HrJB2IoS97+/ZIeo15FYsPsTG4Rt
	J/Hixm1mCFtbYtnC11B7BSVOznwCDQlJiYMrbrCAvCIhsIVDYlbfR0aIhIvEv4777BC2tMT0
	NZehGvIldrVdgTqiQuLq626oI6wlFv5ZzzSBUWUWkrtnIblpFpKbZiG5aRaSmxYwsq5iFC8t
	Ls5NTy02zEst1ytOzC0uzUvXS87P3cQITDan/x3O3cG449ZHvUOMTByMhxglOJiVRHhDS6rS
	hHhTEiurUovy44tKc1KLDzFKc7AoifMa2p5MFhJITyxJzU5NLUgtgskycXBKNTB5fylfrCWr
	yxrKEOggcD8ygfe19Se1xEkHV5SIpchcmqr1JnMn38Vrkxubfp7ImGbxR/3C2WlLsr49qAv+
	9sbfKvC8s3LNnkf5/xdv4l0Rxxv6IvVb8dakqYzbwloPdaopWkQYJe94tOH63R+fGXseHzh+
	SCHWOsty11Vjsw3ybVXL29ecCTyg+/3Spbj1R5tfN6TIXVgt3rw4wjz1oa17PRd/6LnL6jn/
	6/eee6145of7tgnTjty88mHDDLtvjxctMJy0pE3gaUbIL8MpT9Yxe3zRWufYI2LAr13ln2H3
	18PjVvcK7YrPKX4f9ydPCu0K0p3g0pY0KXzRo0treWcv4zhg9dTP8Y3OuwfXTJyclViKMxIN
	tZiLihMBmbUbSKUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWS2cDspHtvWW2awby1qhbTp15gtDhxs5HN
	YtXCa2wW52edYnFg8Wg58pbVY/Gel0wenzfJBTBHcdmkpOZklqUW6dslcGVcW5RYsIyn4vSK
	g0wNjKc4uxg5OSQETCSm/f/O3MXIxSEksIpR4sKVp+wQzidGiY6bPxkhnGWMEmfOnmYHaWET
	MJD4fXwjM4gtIqAtMXHOQbB2ZoHVjBKXunexdjFycAgDzd18Nh3EFBEwlXjw3QSi3Eri+45v
	YK0sAqoST1d/BrN5BSwlbh9/wwqxazqTxJFLk1lBEpwCHhKT/18AsxkFxCS+n1rDBGIzC4hL
	3HoynwniBQGJJXvOM0PYohIvH/9jhbAVJe5/f8kOUa8jsWD3JzYI207ixY3bzBC2tsSyha+h
	jhCUODnzCQtEr6TEwRU3WCYwSsxCsm4WklGzkIyahWTULCSjFjCyrmIULy0uzk2vKDbOSy3X
	K07MLS7NS9dLzs/dxAiM1NP/DsfsYLx366PeIUYmDsZDjBIczEoivKElVWlCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEee8+0EgVEkhPLEnNTk0tSC2CyTJxcEo1MO1adGjedDO3OpeSaIZ9D0+L
	BYacL9aLZU+eLzRZrrBo1WvN94anZnxOV1TK0w/TNdj16+LPP/UGpxrX83f4Kxren9zKrRBl
	5e9YaHbnKs/0s5+/dMyX+Hxalbsz7laMhSOb+6Q1b/UOt3bMl3k428YvscMsRGqnjPqSB8fu
	TvnqtWmzj5hIxUmznxEnNubVxHaVbRX3eFMpX80/y2zaH0NJi9xI558TNTpDNmzf5iBTW2ux
	8bg8W6zGuW3zNlRvOVg3eYKmfuuy2j93XG8zZ+g5b+3RWWhzyZ7TZl2cxI0p+/Ut7JaH2luu
	mPBPcNomDa/l9+o2Pwifdjq2pLuKe8sMNpvrTe9XBy64KS2bpcRSnJFoqMVcVJwIAPiw7/RD
	AwAA
X-CMS-MailID: 20240627175230uscas1p1ab1beb18a2a87313be0d665ebefccd27
CMS-TYPE: 301P
X-CMS-RootMailID: 20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
	<CGME20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f@uscas1p1.samsung.com>
	<ZnBrA-tUc9sWCUYR@sjvm-adma01.eng.stellus.in>
	<6670bea716fde_310129436@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Jun 17, 2024 at 03:54:31PM -0700, Dan Williams wrote:
> Adam Manzanares wrote:
> > On Fri, May 24, 2024 at 05:53:49PM -0700, Dan Williams wrote:
> > > Provide a survey of the work-in-progress maturity (implementation
> > > status) of various aspects of the CXL subsystem.
> > >=20
> > > Clarify that in addition to ongoing upkeep relative to specification
> > > updates, there are some long running themes in the driver that respon=
d
> > > to the discovery of new corner cases (bugs) and new use cases (featur=
e
> > > extensions).
> > >=20
> > > The primary audience is distribution maintainers, but it also serves =
as
> > > a guide for kernel developers to understand what aspects of the CXL
> > > subsystem need more help. It is a landing page to document ongoing
> > > progress, and a guide to discern exposure to work-in-progress feature=
s.
> > >=20
> [..]
> > > +- [0] Known gap: Feature is on a medium to long term horizon to
> > > +  implement.  If the specification has a feature that does even have=
 a '0'
> >=20
> > s/that does even have/that does not even have
>=20
> got it.
>=20
> [..]
> > > +Mailbox commands
> > > +----------------
> > > +
> > > +* [3] Firmware update
> > > +* [3] Health / Alerts
> > > +* [1] :ref:`Background commands <background-commands>`
> > > +* [3] Santization
> >=20
> > s/Santization/Sanitation
>=20
> Hmm, no, "sanitation" appears nowhere in the spec.

s/Santization/Sanitization

11.5.5.7.1


Feel free to add

Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>=
