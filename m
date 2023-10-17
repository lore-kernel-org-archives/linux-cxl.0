Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02C28DD2
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mkUC1fwx"
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B81A4
	for <linux-cxl@vger.kernel.org>; Tue, 17 Oct 2023 15:59:18 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231017225915usoutp01f1d72e6fa40a22b62c13f930b73e915d~PBz-Fucoy0043100431usoutp01F;
	Tue, 17 Oct 2023 22:59:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231017225915usoutp01f1d72e6fa40a22b62c13f930b73e915d~PBz-Fucoy0043100431usoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697583555;
	bh=odT4aQQb3LsrqDnQCSCUaQmO28GbPXO32o7/+cIzVQk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=mkUC1fwxONjN8/D2jXzih3e/474L1N2gWBgvJq9JVmvPgR1w7DSQMTXWLS+Ehm9Je
	 bRdqUfrBS8H5wGaF5X8pJ4c7vXGwd5vWCUD//lAx1Q85jtUnQc+MvzEUpUSRrQ5eTA
	 5fGahnYk2tMLrJBgdWQ42vxKHTfvbi2JijV+mxKQ=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231017225914uscas1p272378b3f074670c168c95e4cd0419ef1~PBz_wRFde0319703197uscas1p2r;
	Tue, 17 Oct 2023 22:59:14 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 4E.45.40279.2C11F256; Tue,
	17 Oct 2023 18:59:14 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231017225914uscas1p12e0cc510119b45e36b4e61a3147b39f8~PBz_bDDqM2962329623uscas1p1F;
	Tue, 17 Oct 2023 22:59:14 +0000 (GMT)
X-AuditID: cbfec36f-4cbfe70000009d57-2c-652f11c2557c
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B7.2C.31200.1C11F256; Tue,
	17 Oct 2023 18:59:14 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Tue, 17 Oct 2023 15:59:13 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
	17 Oct 2023 15:59:13 -0700
From: Jim Harris <jim.harris@samsung.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>
Subject: Re: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
 helper for reuse
Thread-Topic: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
	helper for reuse
Thread-Index: AQHZ//ZioxMVLlTkYE+pVsAjGci0crBOoTqAgABJTICAACX9gA==
Date: Tue, 17 Oct 2023 22:59:13 +0000
Message-ID: <ZS8RwTnZW_oHlQiW@bgt-140510-bm03.eng.stellus.in>
In-Reply-To: <ZS7x48xnvGzkyBF1@aschofie-mobl2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DEF636F149175D469085AED361E0C6C3@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djXc7qHBPVTDfZeU7G4+/gCm8X0qRcY
	LU7cbGSzWH1zDaPFn0O+FvufPmexWLXwGpvF+VmnWCxuTTjG5MDp0XLkLavH4j0vmTymzq73
	+LxJLoAlissmJTUnsyy1SN8ugSujq/85c8FP1ooFs9ayNjCeYOli5OSQEDCRuPH1HlMXIxeH
	kMBKRokHj56zQDitTBKXW34AZTjAqt7Oq4GIr2GUuNrTD9XxiVHi3uMbzCCjhASWMUqcOsIP
	YrMJaEr8urIGrFlEwFBiwTQ1kHpmgftMEl0zloPFhQWiJBbPDgEpFxGIlnjTs4YRwnaSuH3y
	HDtICYuAqkRjXzxImFfAVuLhy69gmzgF9CQ+Xl3JCmIzCohJfD8FsokTaLy4xK0n85kgHhOU
	WDR7DzOELSbxb9dDNghbUeL+95fsEPU6Egt2f2IDWcUsYCdxdzErRFhbYtnC18wQawUlTs58
	Ag0rSYmDK26Ag0dC4AGHxNftsxkhEi4Svy9dgSqSlvh7dxnUDdkSK9d3QIOwQKLhSBBE2Fpi
	4Z/1TBMYVWYhuXoWkotmIVw0C8lFs5BctICRdRWjeGlxcW56arFRXmq5XnFibnFpXrpecn7u
	JkZgajr973D+Dsbrtz7qHWJk4mA8xCjBwawkwpserJMqxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nNfQ9mSykEB6YklqdmpqQWoRTJaJg1OqgWn1xlmGGWGKy0X/bhRW7L/j+71siUMn96r5tlXr
	/nkGL/HflhrxqCbz4Pz8mXvzt9bOVgq3vbInsdVqVttJ/ih5ATHB5WfOToxPjZ/RJjm9r0XJ
	7daFr+oPL3F8k7GQ1DBcxfJyp5wnZxrDBzUGLbciXfHMMMMdAgdWfX/ZXv5O7q/t/8TA/hjX
	wjcJaqKqRhNW/Wt7q6TWE3ptkm/fTk9txZfG257NNZASjHVWm/SZ93H0JjXr3w+KGgw7hIRe
	tfx1v7VTUWdeVIrzhIbfLSzir5SNGR7+XPjM4qYwR/Hlw/Vzjkp+LU7kc5mt/l5jQ/R9db43
	S76bHH37l6fDcHHlBy0Jjulr/m/mPfs1SImlOCPRUIu5qDgRAPzI3CK8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWS2cDspHtIUD/V4H4jt8XdxxfYLKZPvcBo
	ceJmI5vF6ptrGC3+HPK12P/0OYvFqoXX2CzOzzrFYnFrwjEmB06PliNvWT0W73nJ5DF1dr3H
	501yASxRXDYpqTmZZalF+nYJXBld/c+ZC36yViyYtZa1gfEESxcjB4eEgInE23k1XYxcHEIC
	qxglTnfeZINwPjFKLO19wwjhLGOUePPsLVAHJwebgKbErytrmEC6RQQMJRZMUwOpYRa4zyTR
	NWM5E0iNsECUxJ/eN6wgtohAtMSGJesZIWwnidsnz7GD9LIIqEo09sWDhHkFbCUevvzKDLHr
	KJPE0n37wOo5BfQkPl5dCTaHUUBM4vupNWDzmQXEJW49mQ9mSwgISCzZc54ZwhaVePn4HyuE
	rShx//tLdoh6HYkFuz+xgexlFrCTuLuYFSKsLbFs4WtmiBsEJU7OfMIC0SopcXDFDZYJjBKz
	kGybhWTSLIRJs5BMmoVk0gJG1lWM4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiB0X363+Ho
	HYy3b33UO8TIxMF4iFGCg1lJhDc9WCdViDclsbIqtSg/vqg0J7X4EKM0B4uSOO/dBxqpQgLp
	iSWp2ampBalFMFkmDk6pBqbM2D86XU77jFRmmG1csMVn+64VP325vgg1/v22YY6WkI5Wf538
	q5INa/nelfopygZ8qX6lH66SGuLz8JCWWHx/GucL+ztms4NaVnUc2BXc97Hf1VOLf+nc+urD
	x1rXeHiolx67nXz4PWP+f80VvSx1q3qXsPzvMbp26qXL1QlTm5Kv91a4sx1+5nU9SW++waLo
	b0EiD845iIleXGmzYk9GkcbvHW39NlMaTVLl7/xvP907+dj8meHc+QazRPNtqmIlcs6Vcb68
	paak+VJL8PfXnv+iH5LXz+TzDv62OVpPj9989dR5jtrXxa+pCslErtq+eEpLtZBGcXmcr8Rj
	nhKfo3cfhIr0TF+y5lTxByWW4oxEQy3mouJEAFsP8WhdAwAA
X-CMS-MailID: 20231017225914uscas1p12e0cc510119b45e36b4e61a3147b39f8
CMS-TYPE: 301P
X-CMS-RootMailID: 20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5
References: <cover.1697433770.git.alison.schofield@intel.com>
	<CGME20231016060244uscas1p15e15e2d44388f12511a67c003dc2bff5@uscas1p1.samsung.com>
	<8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
	<CDA18391-931B-4564-8B97-9DE92790C9CA@ssi.samsung.com>
	<ZS7x48xnvGzkyBF1@aschofie-mobl2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 01:43:15PM -0700, Alison Schofield wrote:
> On Tue, Oct 17, 2023 at 04:21:06PM +0000, Jim Harris wrote:
> >=20
> >=20
> > Hi Alison,
> >=20
> > This stray closing brace needs to be removed from this patch.
> >=20
> > Rest of the patch looks good, I agree the naming is much better with th=
ese
> > changes.
> >=20
> > Reviewed-by: Jim Harris <jim.harris@samsung.com>
> >
>=20
> Thanks for the review.
>=20
> Your replies are removing the leading indentation from the original
> patch. I see it viewing in my mailer and w browser:
>=20
> So, I think it's something on your end.
>=20
> ???
>=20
> Alison
>=20

My apologies, I'll stop trying to get macOS Mail to work with the
mailing list.

(Sent with mutt)
