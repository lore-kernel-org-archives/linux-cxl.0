Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAA08C05
	for <linux-cxl@vger.kernel.org>; Wed,  7 Feb 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707265203; cv=none; b=LcB4wieS8hTOjlWHgSB7Imh8eouxOMD9BMG8LHGGD6HgLKLUNEB8kCqHQ7MLoPcbHaufmjd9a7eqcDc+i2BrcQ0zsoDB/Jk+o+RLaR9XVBgLEHkpd6dbfadX6jykMKfFC9Q1HYLwFJKt726jA1sG4P3LWK4UnPOt9hIeJCkB3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707265203; c=relaxed/simple;
	bh=4s8YrR4DMGLbqPfzr3k7muBtE9qzkxRZNaz+eaLAcb8=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=dEUZTVPtq3iC0m0uuaczJCIICYijy34KAQWDZcJFV3vdjJytDocOajrMLtb/ohOAoizE7aICzxclS/E7dy7CVA67rauYmIvAQYk9qiFjHwC/biOCmgw8t/A159NbC0Mogei65NUB0WY+Znv8t+ebBZcgKIbuBFk5zpdqhcbaptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mqeQuup3; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mqeQuup3"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240207001951epoutp010a61abc26e4510d0e89dcecb695c6de3~xbKWAGRxE0288502885epoutp01Y
	for <linux-cxl@vger.kernel.org>; Wed,  7 Feb 2024 00:19:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240207001951epoutp010a61abc26e4510d0e89dcecb695c6de3~xbKWAGRxE0288502885epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707265191;
	bh=5knokuRq299+cUO09oseP7zYK8N8Oj1ENpEE7RPc5Cw=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=mqeQuup3K5B9Bac1nc2uy95u3EIWroAG5SCgVSzxAZjQXxQ49qmm+TWJIFgUhisMR
	 aKvjhzlb1ARNjZbnxE9mqDBAZGlFqDZeDT4j4f5/UcCG0JC7WfPdXYiVH6AN8t7sbr
	 t1KWVQ1fjkGiLEhdinXd8cRsYs1yd06F3VlR74wQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240207001951epcas2p139811384e9827444b0dbc8394d0593da~xbKVwH9tK0993409934epcas2p19;
	Wed,  7 Feb 2024 00:19:51 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TV12t74CNz4x9Pw; Wed,  7 Feb
	2024 00:19:50 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-25-65c2cca61dae
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.EE.10022.6ACC2C56; Wed,  7 Feb 2024 09:19:50 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) (2) cxl: question about cxl qos_class verification
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <c7e8fafc-b150-4232-b56a-215292f243e0@intel.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240207001950epcms2p77da4fac7be9061556a09c6044c878ee4@epcms2p7>
Date: Wed, 07 Feb 2024 09:19:50 +0900
X-CMS-MailID: 20240207001950epcms2p77da4fac7be9061556a09c6044c878ee4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmqe6yM4dSDY6cFLCYPvUCo8WJm41s
	Fh/e/GOxOLqHw+L8rFMsDqwei/e8ZPLo27KK0ePzJrkA5qhsm4zUxJTUIoXUvOT8lMy8dFsl
	7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygjUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
	/OISW6XUgpScAvMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IxP378xFrTKVMxs+czYwNgs1sXI
	ySEhYCLxYNseli5GLg4hgR2MEku+v2PqYuTg4BUQlPi7QxjEFBZwktj9qR6kXEhATuLu7VNM
	ILawgKbEm2mrWEBsNgF1iR+dJ8HiIgIJEttvv2MDGcks0MIo8eTdMkaIXbwSM9qfskDY0hLb
	l28Fi3MK2EqsOTAdKq4h8WNZLzOELSpxc/Vbdhj7/bH5UHNEJFrvnYWqEZR48HM3VFxK4uuJ
	v+wgiyUEmhklVh/rZ4VwGhglOmYehtqgL9F4/T0biM0r4Ctxft9fsLNZBFQlJjxbxgRR4yKx
	rf0JWD2zgLzE9rdzmEEhwQz08vpd+iCmhICyxJFbUBV8Eh2H/7LD/Lhj3hOoKUoSU9qOQN0m
	IdHQuJUNwvaQ+NB8jX0Co+IsREjPQrJrFsKuBYzMqxjFUguKc9NTi40KjOGRm5yfu4kRnPi0
	3Hcwznj7Qe8QIxMH4yFGCQ5mJRFesx0HUoV4UxIrq1KL8uOLSnNSiw8xmgJ9OZFZSjQ5H5h6
	80riDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnNTk0tSC2C6WPi4JRqYJrUFr2j+NynD9dn
	vnon/G8eZ2RBX33/6iodj4mPlk63frDc/PL9+R87pU5tOJchfcF26YZlE3gKuusLF6k6PPYp
	Ov59QV/0Evvn9+3iX/Yn2sxdHrMon2P7QW8RST3+FbsfS/1JPXUrTtvnz8r/QjttOlL+3Ezt
	33NJgP1t/4dPwV21H/5nvEhcnTAx5OG1V7Fn9z3Kjp1fnPcl8+kb3/8LQvY9LzETEX4n8mTl
	e6O4owH9pfaMzTos3TIaC4WX3OGxOP4s59m115/XrOvVehP4/L+jTtGFlZ5i8v2tHXZqd8xs
	jn4v4hV6cFmBeU37hjPLa3bmzZCOmyX6nH9FiaTwsRCh+S8qrptqXHRYrvlKiaU4I9FQi7mo
	OBEAcYwB5QUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef
References: <c7e8fafc-b150-4232-b56a-215292f243e0@intel.com>
	<ebc9c00d-06f1-4d7f-b551-267301758e16@intel.com>
	<20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
	<20240206012321epcms2p6609fae86aaeb23ff377fce94578fc15b@epcms2p6>
	<CGME20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p7>

On Tue, Feb 06, 2024 at 08:24:04AM -0700, Dave Jiang wrote:
>
>
> On 2/5/24 6:23 PM, Wonjae Lee wrote:
> > On Mon, Feb 05, 2024 at 03:31:35PM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 2/5/24 3:36 AM, Wonjae Lee wrote:
> >>> Hello,
> >>>
> >>> To test the CXL driver with respect to QTG IDs on a real CXL device, I
> >>> connected one CXL device to a CXL 2.0 Compliant System (v6.8-rc3).
> >>>
> >>> However, during cxl endpoint probing, CDAT extraction and parsing works
> >>> fine, but cxl_qos_class_verify() for cxlmd does not run properly.
> >>>
> >>> To be precise, when cxl_qos_class_verify() is executed, the below error
> >>> handling code is executed since cxlmd->endpoint is NULL:
> >>>
> >>>     if (!cxl_root)
> >>>         return -ENODEV;
> >>>
> >>>
> >>> I'm not sure if I analyzed it correctly due to the complexity of the CXL
> >>> driver, but I think it's because the cxl_port driver execute
> >>> cxl_qos_class_verify() before cxlmd->endpoint = endpoint was executed in
> >>> the cxl_mem driver. See the dmesg log below, where I've added debugging
> >>> code.
> >>>
> >>> # cxl_mem driver is adding the endpoint
> >>> [] cxl_mem mem0: call devm_cxl_add_enpoint
> >>> ...
> >>> # endpoint port is probed, and cxl_qos_class_verify() runs
> >>> [] cxl_port endpoint5: call cxl_qos_class_verify
> >>> [] cxl_mem mem0: cxl_qos_class_verify: cxlmd->endpoint is NULL
> >>> [] cxl_mem mem0: cxl_qos_class_verify: cxl_root is NULL
> >>> ...
> >>> # cxl_mem driver sets cxlmd->endpoint
> >>> [] cxl_mem mem0: cxl_endpoint_autoremove: cxlmd->endpoint = endpoint
> >>> ...
> >>>
> >>>
> >>> I did an experiment to validate the hypothesis. If I call
> >>> cxl_endpoint_parse_cdat() after cxlmd->endpoint is set,
> >>> cxl_qos_class_verify() runs well without problems.
> >>>
> >>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> >>> index c5c9d8e0d88d..33b39c6c46fd 100644
> >>> --- a/drivers/cxl/mem.c
> >>> +++ b/drivers/cxl/mem.c
> >>> @@ -74,6 +74,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
> >>>         if (rc)
> >>>                 return rc;
> >>>
> >>> +       cxl_endpoint_parse_cdat(endpoint);
> >>> +
> >>>         if (!endpoint->dev.driver) {
> >>>                 dev_err(&cxlmd->dev, "%s failed probe\n",
> >>>                         dev_name(&endpoint->dev));
> >>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> >>> index 97c21566677a..ee77aba62780 100644
> >>> --- a/drivers/cxl/port.c
> >>> +++ b/drivers/cxl/port.c
> >>> @@ -111,7 +111,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
> >>>
> >>>         /* Cache the data early to ensure is_visible() works */
> >>>         read_cdat_data(port);
> >>> -       cxl_endpoint_parse_cdat(port);
> >>>
> >>>         get_device(&cxlmd->dev);
> >>>         rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> >>>
> >>>
> >>> Maybe there's something I'm missing. It would be very helpful if anyone
> >>> could comment on the above analysis.
> >>
> >> I think this should fix the issue you are seeing?
> >>
> >> https://lore.kernel.org/linux-cxl/b243e80f-1b24-4756-8bb3-8389d66ea13a@intel.com/T/#mcbce77b6584bd1031d6c1928fcb36fe67be66039
> >>
> >
> > Oh, you've already fixed it. I found that on the same testbed the commit
> > you mentioned resolves the issue.
> >
> > Thanks for your response!
>
> Ok if I add your Tested-by tag to that patch?

Oh, sure. Feel free to add it:

Tested-by: Wonjae Lee <wj28.lee@samsung.com>

Thanks,
Wonjae
