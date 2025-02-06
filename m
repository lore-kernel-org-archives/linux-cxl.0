Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64315225A46
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738842569; cv=none; b=PuBruEOJm3yADyYIJLv0Q2EVE5sqnhnQRd6RYXRjyyX1hA5/9ltJxscFHBgcgBtNszS3S6YwSjhLN26tuJLwZHQ+Zvs+eGA83G/3bbUPkPpEgQ4BZRolvfRwRzqDaOgLl5yQWb8ibZWGXChAWm9eDSUWTVzp15tfIP+bCJLUNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738842569; c=relaxed/simple;
	bh=Bf4jpBStlBwJdDHvLNSW2OEbgSai2hxnx1rmK9UXIRc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=RaP56X7ePvk+U76G5JDLjVyKQSSL7rNDli68vHq1rDCV3rH04ch4m6G8E7NpUtDNnzKdNNSOVlcQAmxa29cUVYEsPQYgCbm3Nte7suizPYAS6/gSTGyNoYlLFsVR1E6ntnk4rCENaeeWo62KWX3+vlop/UxrLX0r0EJV3T97abA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bgo9jMlm; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bgo9jMlm"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250206114924epoutp0496dd7550e3dd1bfd217a5a16b5e38658~hnBlw3V1P3117431174epoutp04w
	for <linux-cxl@vger.kernel.org>; Thu,  6 Feb 2025 11:49:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250206114924epoutp0496dd7550e3dd1bfd217a5a16b5e38658~hnBlw3V1P3117431174epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738842564;
	bh=m7yJ9+izlaHmkk5Z2LA5XUP2er7VaaaSK923WNmaDng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bgo9jMlmStmGNjfxxaB8ee7uGvjDrHRxSt3rt3wqbHUZvkF6FtIiMwEyzHv5kMEJ9
	 ak6kJU6EFL6DHPLQFY9uyyixI/nBoMhSY2cxirFnumuBcupkW8uqLNy4pX830TnbjM
	 cd4fGrgelmJR8m5TdoQZoqJ/8ozvR1LDOB3b0CWc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250206114923epcas5p193853e1daed43301c1d6fbcfa7d48c57~hnBlRhza92074720747epcas5p1t;
	Thu,  6 Feb 2025 11:49:23 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Ypb412H4Tz4x9Py; Thu,  6 Feb
	2025 11:49:21 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.43.19710.1C1A4A76; Thu,  6 Feb 2025 20:49:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250206092940epcas5p4f08fe221d311a959c66215bcd6d6c92a~hlHlef8yf0102101021epcas5p4w;
	Thu,  6 Feb 2025 09:29:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250206092940epsmtrp21352d24f541a98b020ad383fda2d19e8~hlHlc5XpO2836828368epsmtrp2s;
	Thu,  6 Feb 2025 09:29:40 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-6f-67a4a1c11034
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.7E.18729.30184A76; Thu,  6 Feb 2025 18:29:39 +0900 (KST)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250206092938epsmtip24b3d909cd901e0e60b4975a18b6c7c7e~hlHkMsWA22698626986epsmtip2U;
	Thu,  6 Feb 2025 09:29:38 +0000 (GMT)
Date: Thu, 6 Feb 2025 14:59:33 +0530
From: Vinayak Holikatti <vinayak.kh@samsung.com>
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "krish.reddy@samsung.com"
	<krish.reddy@samsung.com>, "vishak.g@samsung.com" <vishak.g@samsung.com>,
	"alok.rathore@samsung.com" <alok.rathore@samsung.com>,
	"s5.kumari@samsung.com" <s5.kumari@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250206092933.a6tk53cuzhvyhwep@test-PowerEdge-R740xd>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z6D2jT6lp6tABnDL@sjvm-adma01.eng.stellus.in>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTS/fgwiXpBv+2cFlMP6xo8eX0HjaL
	VQuvsVks3LiMyeL8rFMsFsd7d7BYrDn3mQXIncPuwOHRcuQtq8eTa5uZPPq2rGL0+LxJLoAl
	KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+gKJYWy
	xJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2
	xpGOf0wFK6QqXm75w9zAuEiki5GTQ0LARGLRkWMsXYxcHEICuxkldq5czgrhfGKUuLB5NzuE
	841R4vr5FiaYli8HVkBV7WWU2LDvCgtcy53uo2BVLAIqEnsnTWUBsdkEDCQeNB9nB7FFBPQk
	Tp78wwzSwCzwiUli2p4eZpCEsEAro8SHVfkgNq+As8TdG3eZIGxBiZMzn4AN4hSwkji4vosN
	pFlC4CO7xImju9ggbnKRaNh0iBnCFpZ4dXwLO4QtJfH53V6ommKJcxc/MULYNRKvu1ZA1dtL
	tJ7qB7I5gC7KkDi7SxwiLCsx9dQ6sBuYBfgken8/gXqfV2LHPBCbA8hWkVj6NhNm05dnzVDT
	PSTm7F0HdoGQwHsmiQOLKiYwys1C8s0shGWzwBZYSXR+aGKFCEtLLP/HAWFqSqzfpb+AkXUV
	o2RqQXFuemqyaYFhXmo5PI6T83M3MYLTpZbLDsYb8//pHWJk4mA8xCjBwawkwnt6+4J0Id6U
	xMqq1KL8+KLSnNTiQ4ymwNiZyCwlmpwPTNh5JfGGJpYGJmZmZiaWxmaGSuK8zTtb0oUE0hNL
	UrNTUwtSi2D6mDg4pRqY5Nus3q83bgj8e/ds1ZuSohPvP9Ws9NHiONn3k1WrvmxHm+7VF89d
	jqfvfRZw2PyH17ft4f1537hfchq/n99wN/viijkiXXOTFFf46cnZPSnQ+p1e/2FnxD+//Ihb
	azaZOJ3maFp4kf1xantkmJassIR9zerXicWPsjJPtpoGzH3zvblhJevxnAnzBb7+rfr+RcWV
	u8Ukd9lX2SymyyXLW+6KGCecUVBOjA6bson54b/pSrZJCaoM+1ZoTQtOvOtXY7xnztEd8ydV
	PTnbePkfa7SMz4WUO4ndW1mX7NgrL/HyqfwXKb0KifnV+yY+tHJrE9UuL1p1X259Z+smvwcP
	xS1KHrFmid9Njt/UfFhfiaU4I9FQi7moOBEAtebTSyAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSvC5z45J0g8OTbSymH1a0+HJ6D5vF
	qoXX2CwWblzGZHF+1ikWi+O9O1gs1pz7zALkzmF34PBoOfKW1ePJtc1MHn1bVjF6fN4kF8AS
	xWWTkpqTWZZapG+XwJVx8Mwh5oJb4hWX+z4zNjC+E+xi5OSQEDCR+HJgBWsXIxeHkMBuRonW
	RVeZIBJSEsd2/mSDsIUlVv57zg5R9IFR4vSsTlaQBIuAisTeSVNZQGw2AQOJB83H2UFsEQE9
	iZMn/zCDNDALfGGS+LjkOCNIQliglVHiw6p8EJtXwFni7o27TBBT3zNJ9Oz6xQKREJQ4OfMJ
	mM0sYCYxb/NDoEkcQLa0xPJ/HCBhTgEriYPru9gmMArMQtIxC0nHLISOBYzMqxglUwuKc9Nz
	iw0LDPNSy/WKE3OLS/PS9ZLzczcxgoNdS3MH4/ZVH/QOMTJxMB5ilOBgVhLhPb19QboQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGphnJlipVDx9bThbb
	tmjCzgP1q+uLv1rsOmM+5XLWlv23duwwaNbWu+v7cqJZ8JPXl5yV5DbrnyhTNOCKC7n5JTpq
	c7jLueoZz/imxxr3ydpr9tkqxEWoXzRu/3NfeUKdniVP+TWx/1efXsg0eJcyjfcLY9w57icv
	d8/7eVxznfLU+Oj9BZb2y352Rk+zPm9vpOLNqWmxTLqbK+q78L96M3dl37gb4vp3TDb8cMlz
	iP29ucvT9IQsy6nbTjMXqbZWM+Yqi/zbtfVmylmWv0v2m/IxC3Q+Vcs9Lfkuw7dltrXwk71f
	/ijumBqdYiF6/EFOqM32l41LnVsZmPjWHvj5R9HMkXlG2p53b3Xb5wXpKLEUZyQaajEXFScC
	AGH+tM/lAgAA
X-CMS-MailID: 20250206092940epcas5p4f08fe221d311a959c66215bcd6d6c92a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32c31_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
	<20250124151946.0000134f@huawei.com>
	<Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
	<20250203113354.00007cd7@huawei.com>
	<Z6D2jT6lp6tABnDL@sjvm-adma01.eng.stellus.in>

------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32c31_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 03/02/25 05:02PM, Adam Manzanares wrote:
>On Mon, Feb 03, 2025 at 11:33:54AM +0000, Jonathan Cameron wrote:
>>
>> > >
>> > > > +    int dpa_range_count = san_info->dpa_range_count;
>> > > > +    int rc = 0;
>> > > > +
>> > > > +    for (int i = 0; i < dpa_range_count; i++) {
>> > > > +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
>> > > > +                san_info->dpa_range_list[i].length, san_info->fill_value);
>> > > > +        if (rc) {
>> > > > +            goto exit;
>> > > > +        }
>> > > > +    }
>> > > > +    cxl_discard_all_event_records(&ct3d->cxl_dstate);
>> > >
>> > > Add a comment on why we are deleting event records when sanitizing a small
>> > > part of memory?
>> > >
>> >
>> > See response below for disabling the media state. Same section referenced
>> > below, 8.2.10.9.5.1 states all event logs should be deleted. Outcome
>> > depends on how we interpret "follow the method described in 8.2.10.9.5.1".
>> >
>>
>> This also sounds like reading too much into that comment.
>>
>
>Agreed, Vinayak let's drop the discard of all event records
>from this patch.

Ok Adam will drop the discard of all event records

>
>> > > > +    }
>> > > > +
>> > > > +start_bg:
>> > > > +    /* EBUSY other bg cmds as of now */
>> > > > +    cci->bg.runtime = secs * 1000UL;
>> > > > +    *len_out = 0;
>> > > > +    /* sanitize when done */
>> > > > +    cxl_dev_disable_media(&ct3d->cxl_dstate);
>> > > Why?  This is santizing part of the device. As I undestand it the
>> > > main aim is to offload cleanup when the device is in use. Definitely
>> > > don't want to disable media.  If I'm missing a reason please give
>> > > a spec reference.
>> >
>> > Table 8-164, sanitize description mentions to follow method
>> > in 8.2.10.9.5.1, which does call out placing device in disabled
>> > state, but I'm not sure if method refers to all text in 8.2.10.9.5.1
>> > or the method devices uses to sanitize internally.
>>
>> I think it is meant to just be the method of sanitizing.
>>
>
>Ok, let's use this interpretation. Vinayak, can you remove this as well
>and then we put a comment in the patch that media op sanitize is targeted
>so no need to disable media or clear event logs.

ok Adam, will remove this as well and comment as needed

>
>
>> >
>> > I would imagine since sanitize is destructive we would not want to return
>> > any data from device ranges impacted by sanitize. I believe a simple
>> > way to achieve this is to disable entire device.
>>
>> Hmm.  That rather destroys the main use case I'm aware of for this
>> (unlike the general santize commands from earlier CXL versions)/
>> Superficially sounds like we need a spec clarification as
>> clearly not super clear!
>>
>
>For this series, let's drive the work with the use case you have in
>mind. We will start a thread with the consortium, but I don't think
>that should delay this work.
>
>> >
>>
>> Jonathan
>>
>>
Vinayak Holikatti


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32c31_
Content-Type: text/plain; charset="utf-8"


------MTAFpDJBIS7x0DorxmyomC-IKR7RHdtq514vGN5lDcSFRf5o=_32c31_--
