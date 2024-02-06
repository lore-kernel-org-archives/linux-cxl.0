Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279191361
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182608; cv=none; b=TiAYv8OUvrNBF5lPjYrOT78zd8C3/syC/bisBq85tS9EbQ4+w8Ne+ZGQdMM1H1B9p0WePusz6YX1sFgeJOC6T/U2fmVksHHfY7vyz33XJ30MP/ympPpzS0eNyK9ArKvr5IF+E6sErqFuWaDj8qUMWFKib9a4ArWdiLvkF7pR6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182608; c=relaxed/simple;
	bh=SNLGexdfbilCmz7bZcaiGcywmkaxl16O934nUjEmVCA=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=hCo1DByVDt9EX8gKDRYodqM4+usFPp96Xp3FXawPXgWy2BSXK8HK4kr3Wno4oNYRj/5crhehaSR/9Z5z7xAz/Db0AfXcX4/BVgdPjP2qIfeqbZ4akTUJUart4XLGWFEIFhkuIAupd7Rwa+JWRXqaZmNYdWwTWqvcGNdiNpZuP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CQy1DhY6; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CQy1DhY6"
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240206012322epoutp02d6e3c718862ec8cbdfdb230cb0e05653~xIYhGf0c91403014030epoutp02X
	for <linux-cxl@vger.kernel.org>; Tue,  6 Feb 2024 01:23:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240206012322epoutp02d6e3c718862ec8cbdfdb230cb0e05653~xIYhGf0c91403014030epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707182602;
	bh=GPIDy7HK6EhyTKtEEFHcEaNS7CruOQTDu+4dTg7KSTw=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=CQy1DhY6ZPks7klVoNGLAMVWqvp/NnIVFX1E51nbe8GTMK4xvvJoYOE/OkWug9kGA
	 0INaIBjhu4D4o4hbby0iYsA5J1/a0eSOqZ4n5z84EFstMNaE1SxaX+M797/Qsuxbhz
	 YQ2mViqTzC3zarCAM7fBD/nuEPfpAol7K1ZMD8p8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240206012322epcas2p4234f1d0ffc4f9c626e24ca071339a52b~xIYgs95oz0654106541epcas2p4J;
	Tue,  6 Feb 2024 01:23:22 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TTQVd6mZgz4x9Pp; Tue,  6 Feb
	2024 01:23:21 +0000 (GMT)
X-AuditID: b6c32a45-179ff70000002716-3e-65c18a097217
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.4E.10006.90A81C56; Tue,  6 Feb 2024 10:23:21 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) cxl: question about cxl qos_class verification
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ebc9c00d-06f1-4d7f-b551-267301758e16@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240206012321epcms2p6609fae86aaeb23ff377fce94578fc15b@epcms2p6>
Date: Tue, 06 Feb 2024 10:23:21 +0900
X-CMS-MailID: 20240206012321epcms2p6609fae86aaeb23ff377fce94578fc15b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmqS5n18FUg61bzSymT73AaHHiZiOb
	xYc3/1gsju7hsDg/6xSLA6vH4j0vmTz6tqxi9Pi8SS6AOSrbJiM1MSW1SCE1Lzk/JTMv3VbJ
	OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
	v7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PLljOsBZ8lKh49X8DWwLhBuIuR
	k0NCwESi+cZkVhBbSGAHo8S8KWldjBwcvAKCEn93gJUIC9hJ3GuexQZRIidx9/YpJoi4psSb
	aatYQGw2AXWJH50nweIiAgkS22+/A6rn4mAWaGGUePJuGSPELl6JGe1PWSBsaYnty7eCxTkF
	bCWu/G5gh4hrSPxY1ssMYYtK3Fz9lh3Gfn9sPtQcEYnWe2ehagQlHvzcDRWXkvh64i87yGIJ
	gWZGidXH+lkhnAZGiY6Zh6E260s0Xn8P9g6vgK/Epl03wGwWAVWJufv7oaa6SBw8DWEzC8hL
	bH87hxkUKsxAL6/fpQ9iSggoSxy5xQJRwSfRcfgvO8yPO+Y9YYKwlSSmtB2Buk1CoqFxKxuE
	7SHxofka+wRGxVmIoJ6FZNcshF0LGJlXMYqlFhTnpqcWGxUYwiM3OT93EyM48Wm57mCc/PaD
	3iFGJg7GQ4wSHMxKIrxmOw6kCvGmJFZWpRblxxeV5qQWH2I0BfpyIrOUaHI+MPXmlcQbmlga
	mJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTTx8TBKdXAJF/NEG7e8yNy9refyZf2avTv
	rQ+oMis52m96iE2y8uYPr3Xyk3NXqjLfD+zVPr8trMrzgI/S5LOB29fvKToeIXdm954DCpKb
	fx2fk3LRUrGea+ZT5axA3oUJVhtfFfqvTJCKqHJ7MDfJQXPTR/PdG3m8jVh/HPkj+jqgRXR6
	U8mMp1PP51h5zHzkN7PmCrfhhaf/ili+TAyJ+JX4hGX/Qym5A2wdfk8NMirPKP68VWCxOd9w
	igJ/r9omRWOXh7OEquzUjGQU1m3ZnrbN+bLDrJy1XiVfp73f6DVH+eTHEjE/1pCzTPEXRAsa
	Nk10l94Z8rhiMsvvI0GfXfZveufKt/9p5cKkZT8ex679ctFSXImlOCPRUIu5qDgRAHrjx5UF
	BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef
References: <ebc9c00d-06f1-4d7f-b551-267301758e16@intel.com>
	<20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
	<CGME20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p6>

On Mon, Feb 05, 2024 at 03:31:35PM -0700, Dave Jiang wrote:
>
>
> On 2/5/24 3:36 AM, Wonjae Lee wrote:
> > Hello,
> >
> > To test the CXL driver with respect to QTG IDs on a real CXL device, I
> > connected one CXL device to a CXL 2.0 Compliant System (v6.8-rc3).
> >
> > However, during cxl endpoint probing, CDAT extraction and parsing works
> > fine, but cxl_qos_class_verify() for cxlmd does not run properly.
> >
> > To be precise, when cxl_qos_class_verify() is executed, the below error
> > handling code is executed since cxlmd->endpoint is NULL:
> >
> >     if (!cxl_root)
> >         return -ENODEV;
> >
> >
> > I'm not sure if I analyzed it correctly due to the complexity of the CXL
> > driver, but I think it's because the cxl_port driver execute
> > cxl_qos_class_verify() before cxlmd->endpoint = endpoint was executed in
> > the cxl_mem driver. See the dmesg log below, where I've added debugging
> > code.
> >
> > # cxl_mem driver is adding the endpoint
> > [] cxl_mem mem0: call devm_cxl_add_enpoint
> > ...
> > # endpoint port is probed, and cxl_qos_class_verify() runs
> > [] cxl_port endpoint5: call cxl_qos_class_verify
> > [] cxl_mem mem0: cxl_qos_class_verify: cxlmd->endpoint is NULL
> > [] cxl_mem mem0: cxl_qos_class_verify: cxl_root is NULL
> > ...
> > # cxl_mem driver sets cxlmd->endpoint
> > [] cxl_mem mem0: cxl_endpoint_autoremove: cxlmd->endpoint = endpoint
> > ...
> >
> >
> > I did an experiment to validate the hypothesis. If I call
> > cxl_endpoint_parse_cdat() after cxlmd->endpoint is set,
> > cxl_qos_class_verify() runs well without problems.
> >
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index c5c9d8e0d88d..33b39c6c46fd 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -74,6 +74,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> >         if (rc)
> >                 return rc;
> >
> > +       cxl_endpoint_parse_cdat(endpoint);
> > +
> >         if (!endpoint->dev.driver) {
> >                 dev_err(&cxlmd->dev, "%s failed probe\n",
> >                         dev_name(&endpoint->dev));
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index 97c21566677a..ee77aba62780 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> > @@ -111,7 +111,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >
> >         /* Cache the data early to ensure is_visible() works */
> >         read_cdat_data(port);
> > -       cxl_endpoint_parse_cdat(port);
> >
> >         get_device(&cxlmd->dev);
> >         rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> >
> >
> > Maybe there's something I'm missing. It would be very helpful if anyone
> > could comment on the above analysis.
>
> I think this should fix the issue you are seeing?
>
> https://lore.kernel.org/linux-cxl/b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com/T/#mcbce77b6584bd1031d6c1928fcb36fe67be66039
>

Oh, you've already fixed it. I found that on the same testbed the commit
you mentioned resolves the issue.

Thanks for your response!

>
> >
> > Thanks,
> > Wonjae
>
