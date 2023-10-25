Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74D17CA
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yz02Xm9V"
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58010CF
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 18:37:24 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231025013723usoutp027567bd9e66667421a4783688df409eec~RNfER451I2227522275usoutp02K;
	Wed, 25 Oct 2023 01:37:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231025013723usoutp027567bd9e66667421a4783688df409eec~RNfER451I2227522275usoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698197844;
	bh=negu06U5JV3WgM1hDqTCJ2H9YlU+PScJ7khIqWR6Frw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=Yz02Xm9VmZvva1aUOIf7/iopAJH9lElsFPBYi9+gnnyF5L6DFd3yCKGYQUGUNbnPj
	 XSyj/0TV55XIwZlwWhSlChijVaqwSbY6Xb9dGTOhsjgbbqm1+5GlXtolgRZr9NsHT0
	 3Od8h7Y2vi2RbBKkg61D57z51Ft31HYiqkQVv7Ko=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231025013723uscas1p267c591d2c87fbe200b2f1cbfe8115371~RNfEDSXO02490324903uscas1p2O;
	Wed, 25 Oct 2023 01:37:23 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 8C.74.50148.35178356; Tue,
	24 Oct 2023 21:37:23 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231025013723uscas1p175810a5b85477378a925bb634498bcdf~RNfDq9rLm2129221292uscas1p1m;
	Wed, 25 Oct 2023 01:37:23 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-4b-6538715375a8
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id E2.9C.28590.35178356; Tue,
	24 Oct 2023 21:37:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 24 Oct 2023 18:37:22 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	24 Oct 2023 18:37:22 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
Thread-Topic: [PATCH v2] cxl/region: don't try to cleanup after
	cxl_region_setup_targets() fails
Thread-Index: AQHZ/FJsHCzEUiok5USCGGYrUKwmDbBaGLOAgAArlIA=
Date: Wed, 25 Oct 2023 01:37:22 +0000
Message-ID: <ZThxTYon1WOI3iAd@ubuntu>
In-Reply-To: <65384cbf52621_1ce4592949@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BBDBA77568720429B5480E9E8ABD7EE@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduzrOd3gQotUgw3NKhYf5rWyW0yfeoHR
	4vysUywOzB6L97xk8rhzbQ+bx+dNcgHMUVw2Kak5mWWpRfp2CVwZxzZeZizYzFnxYcUUtgbG
	PexdjJwcEgImEsv397GC2EICKxkl+u7GdjFyAdmtTBJfXy5khSna/OIFI0TRGkaJrv0lEEWf
	GCXerv7HDuEsY5RouXaIDaSKTUBT4teVNUwgtoiAtsTEOQeZQWxmgRKJOzNnga0WFkiU2Dpx
	NyNETZLE87lT2CBsK4mFjy8D1XNwsAioSjy4B1bOC2Q+vf8L7CBOAU+JnYs/gZUzCohJfD8F
	sYpZQFzi1pP5TBBHC0osmr2HGcIWk/i36yEbhK0ocf/7S3aIeh2JBbsh5jAL2ElMn7GeEcLW
	lli28DUzxF5BiZMzn7BA9EpKHFxxgwXkXwmBlRwSE56+g4aQi8SixV+gFkhLXL0+FWpxtsTK
	9R1MIL9ICBRINBwJgghbSyz8s55pAqPKLCRnz0Jy0iwkJ81CctIsJCctYGRdxSheWlycm55a
	bJiXWq5XnJhbXJqXrpecn7uJEZheTv87nLuDccetj3qHGJk4GA8xSnAwK4nwRvpYpArxpiRW
	VqUW5ccXleakFh9ilOZgURLnNbQ9mSwkkJ5YkpqdmlqQWgSTZeLglGpgWrdi+t0QASt/x2wJ
	6QMzVNdFbTS3K3Q28Py0bvrR9um9FgZJBtxXu845CO7WjFogd+3b908v5V9WTuKZdeHIw1ie
	HQHVixoOTsqpcjGIqEquTXl2KpzvcnG7oOG65q+6/8I+blO99P93w79FSWsX5nbcqTczvfXv
	dtjT38ysboqVmr9LNRnCNaXVdkew/yrdwBxc3ri+XS37esAyO51tMesSpWYuqdmSohpSLmLK
	fOrI7MYJ3hbvna/mPSqZsFiSfXbw3QkmP3f+3fJgcnVWK0fVf7GqExt+cDnl8s5Tduxov7x9
	j9EElsnbrrvYx3ukhj6N21x0Jqjwf9DFquXrPBfKTPnxtnZvpJrRXp5gJZbijERDLeai4kQA
	y2koPp4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWS2cDsrBtcaJFqMGUtr8WHea3sFtOnXmC0
	OD/rFIsDs8fiPS+ZPO5c28Pm8XmTXABzFJdNSmpOZllqkb5dAlfGsY2XGQs2c1Z8WDGFrYFx
	D3sXIyeHhICJxOYXLxi7GLk4hARWMUr83HqSBcL5xCjx9/JrVghnGaPE286FTCAtbAKaEr+u
	rAGzRQS0JSbOOcgMYjMLlEjcmTkLbKywQKLE1om7GSFqkiSuN12Dsq0kFj6+DFTPwcEioCrx
	4B5YOS+Q+fT+L6hdB5kkjq1cDFbPKeApsXPxJzYQm1FATOL7KYi9zALiEreezGeCeEFAYsme
	88wQtqjEy8f/WCFsRYn731+yQ9TrSCzYDTGHWcBOYvqM9YwQtrbEsoWvmSGOEJQ4OfMJC0Sv
	pMTBFTdYJjBKzEKybhaSUbOQjJqFZNQsJKMWMLKuYhQvLS7OTa8oNsxLLdcrTswtLs1L10vO
	z93ECIzQ0/8OR+5gPHrro94hRiYOxkOMEhzMSiK8kT4WqUK8KYmVValF+fFFpTmpxYcYpTlY
	lMR57z7QSBUSSE8sSc1OTS1ILYLJMnFwSjUwqTuJyyfPNFp+8unNVxs//Lte8Xaal2W+YMjs
	r68WHll6d+/Z/U5eM6KYsqfsEVKeH6S9/A1/ucGpnsPCuxP/vwpMPhD0cM6Lz5rX6q6dri6a
	nqyT/OEx05EStQl/75pJmgUZCR6LKZsz5dPV6as50r4unFZ88Pj68ARd8d3bb1nI5P5kvrpX
	/n7GComAXTpiF2qfu9twSln+sbl/0L5sbm7VYt6Vyy4Gn95mepPXclNs8c/2WUsfsKrHN9kW
	seTrMHK68XJ4/yzVdbDN3qi9tfIs48Kezu+/j8i3zqhcHB/IMeto/Ln5/q4zlBSZfq/RXVUx
	4Wpa0VKHb9FdL9ySOf78YNgTfmnabx6T9ce91yuxFGckGmoxFxUnAgBNtjsnPwMAAA==
X-CMS-MailID: 20231025013723uscas1p175810a5b85477378a925bb634498bcdf
CMS-TYPE: 301P
X-CMS-RootMailID: 20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013
References: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
	<CGME20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013@uscas1p1.samsung.com>
	<169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
	<65384cbf52621_1ce4592949@dwillia2-xfh.jf.intel.com.notmuch>

On Tue, Oct 24, 2023 at 04:01:19PM -0700, Dan Williams wrote:
>=20
> Patch looks good, but I did reflow the above paragraphs to have commit
> references per checkpatch expectations. I believe it did not flag them
> for you as it did not recognize "Patch <SHA>" as referring to a commit:
>=20
>     Commit 5e42bcbc3fef ("cxl/region: decrement ->nr_targets on error in
>     cxl_region_attach()") tried to avoid 'eiw' initialization errors when
>     ->nr_targets exceeded 16, by just decrementing ->nr_targets when
>     cxl_region_setup_targets() failed.
>    =20
>     Commit 86987c766276 ("cxl/region: Cleanup target list on attach error=
")
>     extended that cleanup to also clear cxled->pos and p->targets[pos]. T=
he
>     initialization error was incidentally fixed separately by:=20
>     Commit 8d4285425714 ("cxl/region: Fix port setup uninitialized variab=
le
>     warnings") which was merged a few days after 5e42bcbc3fef.
>=20
> I also went ahead and added:
>=20
>     Fixes: 5e42bcbc3fef ("cxl/region: decrement ->nr_targets on error in =
cxl_region_attach()")
>     Cc: <stable@vger.kernel.org>
>=20
Thanks Dan, I'll keep an eye out for these in the future.=
