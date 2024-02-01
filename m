Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334C3CF76
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 05:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765497; cv=none; b=tIfphW1WCNOFy7YgYYFjdXgCQrvVhJ8r9ciKqG9sqS3FzvLCn84yz5OVSE5ffo/2D6/Px4tgAmlaf7xg5vIXDqG9/xQyOJKr8ITfYm1rSjp3aNmm3/rpwpxes02BTMluq14C/zkL7Ak4zMkjYmDtOF0i9wB5yjt6TmlTlit3cnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765497; c=relaxed/simple;
	bh=0inrzEAlceRV/ORGeRwkyV+U8EIQ5Gcqr2QDdLJRj68=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=VLlETPbnVy/JdB2An6igTLutQLlXWDRQJYH9vIr6ozCnqkucW/ckbULFOzpeynZBuNwmqAml55f8Mmxc9Bu00dGckAVJz8Y+P0VA7XGp+dtrmbWaqhhvhombOLxA3ffiD7ypLHadm2iF16kIILHOk8Fm0h6ejPzV4DpwSV3wjc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M2arArQ3; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M2arArQ3"
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240201053132epoutp0425977cf923938dcb15a1aceed43a859b~vpiwtp-4Y1243712437epoutp04J
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 05:31:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240201053132epoutp0425977cf923938dcb15a1aceed43a859b~vpiwtp-4Y1243712437epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706765492;
	bh=3nHsYjSwvGu0DNh2WX4OxE/KraWWaFRYNo5jJ40v+VI=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=M2arArQ3BYqw6X1VPjtbEVRSXcJPLE2GiELa8s9gL23t/mkaAN0igspJy6UbkYgha
	 N833F4GUBb9AvvJIEvNEKTIPnoX6wLU6lBvfV8A3uvcHmGLn7t5ur564so+KfkPrgp
	 Xc/naDrrGod0kipTkexIjdnaQGBOZy/sFAWp9uP4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240201053131epcas2p36a6f029529d3d828eaa93780b4086dcd~vpiv2795J1959419594epcas2p3V;
	Thu,  1 Feb 2024 05:31:31 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.89]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TQSFG73nzz4x9QC; Thu,  1 Feb
	2024 05:31:30 +0000 (GMT)
X-AuditID: b6c32a46-d61ff70000002596-2f-65bb2cb28013
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	F8.30.09622.2BC2BB56; Thu,  1 Feb 2024 14:31:30 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH v3 0/2] Allow out of order auto-region assembly
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
	Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, KyungSan Kim
	<ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <65bac886d1459_37ad29475@dwillia2-xfh.jf.intel.com.notmuch>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240201053130epcms2p6b402936a9c25861acfbad7bdad774827@epcms2p6>
Date: Thu, 01 Feb 2024 14:31:30 +0900
X-CMS-MailID: 20240201053130epcms2p6b402936a9c25861acfbad7bdad774827
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRmVeSWpSXmKPExsWy7bCmue4mnd2pBj1NVhZ3H19gs5g+9QKj
	xYmbjWwWq2+uYbT48OYfi8X+p89ZLFYtvMZmcXQPh8X5WadYLG5NOMbkwOXRcuQtq8fiPS+Z
	PPq2rGL0mDq73uPzJrkA1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
	3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWl
	eel6eaklVoYGBkamQIUJ2RlH5v5kLtjAVtG98C9jA2MLaxcjJ4eEgIlEU/tEli5GLg4hgR2M
	En/bTwE5HBy8AoISf3cIg9QIC7hJvHn6FqxeSEBO4u7tU0wQcU2JN9NWsYDYbALqEj86TzKB
	zBERWMck8XDvRXYQh1mgjVFi4sXZjBDbeCVmtD9lgbClJbYv3woW5xTwkJjQuY8ZIq4h8WNZ
	L5QtKnFz9Vt2GPv9sflQc0QkWu+dhaoRlHjwczdUXEri64m/YIslBJoZJVYf62eFcBoYJTpm
	HobarC/ReP09G4jNK+ArceHTa7DfWARUJb5P+80GUeMi8athFdhmZgF5ie1v5zCDgoUZ6Of1
	u/RBTAkBZYkjt1ggKvgkOg7/ZYf5cce8J0wQtpLElLYjULdJSDQ0boWa7iHx5WYL6wRGxVmI
	sJ6FZNcshF0LGJlXMYqlFhTnpqcWGxUYwaM3OT93EyM4gWq57WCc8vaD3iFGJg7GQ4wSHMxK
	Irwr5XamCvGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MIXnlcQbmlgamJiZGZobmRqYK4nz
	3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAlPhOYNE/s28Gi4+b/P//qL+/tcSN8+OukoLJjKY8
	PzfyObVuEMhWiU8qLz60o8F0d3WIm7BGfHS1y+OMkmuznqtWzD5tFx7sO0Uw7SffW+fzq/3r
	khXmLZf1Nvp17EqQjr/H18kTxaXvvF81+fTxxE0Ctjf2/GZ6y87SG9R3QHqDt0JuFHPH5GNb
	jU59Zrm/Y++PNRxtQnFmYc4bQ0xXNlf/2Lhnb89s1zItF4W4CBF/3lm912f/b393IzUx9cHH
	zlnP7hlO/F5UyveRMWu/w4SCvOQZ7JrMjFv3fvshzWBx3ODZuZ3KM6L3lx0+X8GnebvMYp7q
	SQUT075P126zPf+nahoh9rJJacG9i/2rlFiKMxINtZiLihMBYMtgDikEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240131222542epcas2p2cfcadd1e14c2fc63a2ae66c37fc61a41
References: <65bac886d1459_37ad29475@dwillia2-xfh.jf.intel.com.notmuch>
	<cover.1706736863.git.alison.schofield@intel.com>
	<CGME20240131222542epcas2p2cfcadd1e14c2fc63a2ae66c37fc61a41@epcms2p6>

On Wed, Jan 31, 2024 at 02:24:06PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> >
> > Add a precursor tidy-up patch to existing Patch 2.
> >
> >
> > Alison Schofield (2):
> >   cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
> >   cxl/region: Allow out of order assembly of autodiscovered regions
>
> These look good to me now. It would be nice to get a Tested-by from
> Wonjae to close the loop. I'll give that a day or so to show up.
>
> Thanks, Alison!
>

Hello,

I found that it worked fine with a "check for HPA violation" log when I
applied the patch in the same environment where the problem occurred
previously. Thanks for your help!

Tested-by: Wonjae Lee <wj28.lee@samsung.com>

Thanks,
Wonjae
