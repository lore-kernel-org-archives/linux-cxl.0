Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E917571
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129368; cv=none; b=OFzbVBm2jcoMDkWeKjbzAVzwDViMXsYUqBIeyQKVioIRtvapzJmmNZuFH7FzRwQFXCZoyzlp5NWseduapcew06Zw+OdfBwCcnp7Plx3uGUcslxedCvL81k/K99uqQYj295XjZrTCH+NBD/Eqc/TnD/68Kw0wPGgG84Zq+iTsC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129368; c=relaxed/simple;
	bh=OTCAhBEXyE64cRaM/urBNTy2kxRcCEzbQtSIcwK8jV0=;
	h=Mime-Version:Subject:From:To:CC:Message-ID:Date:Content-Type:
	 References; b=I9S8T20IshWQKuTR3nchfyt9xYFeTISDsAz8KTJ/hKZ261d2dv0AswQmgIy0JlmTDinEJwnSgdN1VYAjpqVAlHU7zOXIUGcHfEiHnj+9YkQ3gu5/poAPyfnA3ACzrxkAE/g4UM2DmsJjTNgN4M7LpSW/i5gkV0N+0ZhkL33tN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dhZyKAHD; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dhZyKAHD"
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240205103604epoutp011e1a835837ba2babe6b146ba4c2a3b88~w8Ryn3Pdf1536015360epoutp01b
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 10:36:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240205103604epoutp011e1a835837ba2babe6b146ba4c2a3b88~w8Ryn3Pdf1536015360epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707129364;
	bh=CSa+DTzdrMmmy4GwFfOhGfViJQP7INb0OUZQp765ca0=;
	h=Subject:Reply-To:From:To:CC:Date:References:From;
	b=dhZyKAHDG6IQYvNo9pNTSLiq64fYHIUul1Nj1L0kCURVhYjwUO9zonn/dcp/2gXrR
	 OjHIl/tdgIaf805W8JQQ6UFCXw7DR5DicwEG0Oqf167GnLc9CfBpWM0Z5bIYh8q0l/
	 Xu+2E93NDriwRs5cl6ZZNh9lrhVJ+uZhKWVPksOE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20240205103603epcas2p303be92973906451d07402cd99a331a12~w8RyS47xh3207732077epcas2p3i;
	Mon,  5 Feb 2024 10:36:03 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TT2pq1wTzz4x9Pq; Mon,  5 Feb
	2024 10:36:03 +0000 (GMT)
X-AuditID: b6c32a46-5d04aa8000002596-97-65c0ba13c969
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	25.33.09622.31AB0C56; Mon,  5 Feb 2024 19:36:03 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: cxl: question about cxl qos_class verification
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, KyungSan Kim
	<ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>
Date: Mon, 05 Feb 2024 19:36:02 +0900
X-CMS-MailID: 20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmua7wrgOpBr0nOS2mT73AaHHiZiOb
	xYc3/1gsju7hsDg/6xSLA6vH4j0vmTz6tqxi9Pi8SS6AOSrbJiM1MSW1SCE1Lzk/JTMv3VbJ
	OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
	v7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PizQ6mgrXCFcvfPGVsYNzB38XI
	ySEhYCLx8Ntxxi5GLg4hgR2MEr0721i6GDk4eAUEJf7uEAapERYwl2ic9Y4NxBYSkJO4e/sU
	E0RcU+LNtFUsIDabgLrEj86TYHERAWuJCQ1L2EBmMgtsZZSYdOECK8QyXokZ7U9ZIGxpie3L
	tzJC2BoSP5b1MkPYohI3V79lh7HfH5sPVSMi0XrvLFSNoMSDn7uh4lISX0/8ZQdZJiHQzCix
	+lg/K4TTwCjRMfMw1DZ9icbr78Fe4BXwlZg7rRvsIhYBVYkPOw5DXeci8ef0DLANzALyEtvf
	zmEGhQQz0Jvrd+mDmBICyhJHbrFAVPBJdBz+yw7z1455T5ggbCWJKW1HoG6TkGho3MoGYXtI
	fGi+xg4yRkggUKLngNQERoVZiJCehWTtLIS1CxiZVzGKpRYU56anFhsVGMEjNzk/dxMjOPFp
	ue1gnPL2g94hRiYOxkOMEhzMSiK8ZjsOpArxpiRWVqUW5ccXleakFh9iNAV6eCKzlGhyPjD1
	5pXEG5pYGpiYmRmaG5kamCuJ895rnZsiJJCeWJKanZpakFoE08fEwSnVwMQyn3W/rq39xdvq
	Of8+HRFqvHRW4Zlm/ZuLf2dfq0yZ3KRsNmfJUT6vaaFSHDsuXbad8baljdfxuLfgh7o5yuyZ
	iQwOLquEOpfNK9vSZuE0K/ejbZ9o9FuJ/q3+v16Hi6bzxk6IOeu/9HeklFTjCmPJ+MaAOp1e
	/vu3r5muyXogu0g9vqlHzePn+vWO11pil/QmCc9yD513udgixdydqeq950E5p+3CLU62k57J
	Oy7fFSb1IcU+JTTw4opz8V5FZWcv6PHkdTlqx57Vcr17wuwhX8I/4y6p9aqzE2uiGu+vq0zV
	PryB32lx5qpXGft9RfJmKpT5Fsbe3HrD3+XMpvB53M9MT+4tfldlfWypEktxRqKhFnNRcSIA
	QlcPxgUEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef
References: <CGME20240205103602epcms2p8543d4f3a4bfb684c81f07a94627c7aef@epcms2p8>

Hello,

To test the CXL driver with respect to QTG IDs on a real CXL device, I
connected one CXL device to a CXL 2.0 Compliant System (v6.8-rc3).

However, during cxl endpoint probing, CDAT extraction and parsing works
fine, but cxl_qos_class_verify() for cxlmd does not run properly.

To be precise, when cxl_qos_class_verify() is executed, the below error
handling code is executed since cxlmd->endpoint is NULL:

    if (!cxl_root)
        return -ENODEV;


I'm not sure if I analyzed it correctly due to the complexity of the CXL
driver, but I think it's because the cxl_port driver execute
cxl_qos_class_verify() before cxlmd->endpoint = endpoint was executed in
the cxl_mem driver. See the dmesg log below, where I've added debugging
code.

# cxl_mem driver is adding the endpoint
[] cxl_mem mem0: call devm_cxl_add_enpoint
...
# endpoint port is probed, and cxl_qos_class_verify() runs
[] cxl_port endpoint5: call cxl_qos_class_verify
[] cxl_mem mem0: cxl_qos_class_verify: cxlmd->endpoint is NULL
[] cxl_mem mem0: cxl_qos_class_verify: cxl_root is NULL
...
# cxl_mem driver sets cxlmd->endpoint
[] cxl_mem mem0: cxl_endpoint_autoremove: cxlmd->endpoint = endpoint
...


I did an experiment to validate the hypothesis. If I call
cxl_endpoint_parse_cdat() after cxlmd->endpoint is set,
cxl_qos_class_verify() runs well without problems.

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c5c9d8e0d88d..33b39c6c46fd 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -74,6 +74,8 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
        if (rc)
                return rc;

+       cxl_endpoint_parse_cdat(endpoint);
+
        if (!endpoint->dev.driver) {
                dev_err(&cxlmd->dev, "%s failed probe\n",
                        dev_name(&endpoint->dev));
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 97c21566677a..ee77aba62780 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -111,7 +111,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)

        /* Cache the data early to ensure is_visible() works */
        read_cdat_data(port);
-       cxl_endpoint_parse_cdat(port);

        get_device(&cxlmd->dev);
        rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);


Maybe there's something I'm missing. It would be very helpful if anyone
could comment on the above analysis.

Thanks,
Wonjae
