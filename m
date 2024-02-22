Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460617BB6
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587931; cv=none; b=liViYkHId4G7uQbApjkUA/Y65n7TqRwbYObjxBte530DngXzrKRGJnbuo3AKBUMESuOGfOAAauGi1KD9J5UukwvEXGNCD2MzLBX/5+wNDq1Bz6VH2ixyXD5N+E/xZVVVoltX9xlmRvhIxXeCr35SFMtCGlHdgi2Yj1ukubUJPHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587931; c=relaxed/simple;
	bh=6yNpf9xY8UYwU6FaMK0qoxOAPH1rDnT3fos0LnaIISQ=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=m0k2ncODhn+7IibOGYFxRoZPeevzOYxiLzX9irfiycHA+/BIMQiYzTJvOanBaS4v3eu1YO4ngjXcLTeePW5wzLQolF+9bsQaIItzC0zzo4vaTQ2xZ8I9xIqxqri+rAHAsdTW+t4J63nvMyy8LjOMOhfG1cs8pttVtmVKqq5kG4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L9U4vdB3; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L9U4vdB3"
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240222074526epoutp022bbf08d76447bef3a69e56d604f00512~2H6q1z-Iw1422614226epoutp02n
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 07:45:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240222074526epoutp022bbf08d76447bef3a69e56d604f00512~2H6q1z-Iw1422614226epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708587926;
	bh=WO5vv8iXnfXWEVyIv/JdS6NWHIGqgzMh1bKqgfERsw8=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=L9U4vdB3EeJVKM3qPgptB8iboTxca9r4tOhiJU9//cfw17NnRtuhoKD9gqTL+gcZ1
	 RE5VeTydQEkBnvrf9+fNK3gg25CDcdTXpcQtQ3v/YXE5VvuVqbYK1ZFadaB4NTZFHf
	 m/8KOO11M5sck3I+JguSAYTKv0bki6L4VqTVoK18=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240222074526epcas2p174c274773d75015c457c7f1738a67aa1~2H6qQ-6QR2971329713epcas2p1F;
	Thu, 22 Feb 2024 07:45:26 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.98]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TgQD53sl2z4x9QM; Thu, 22 Feb
	2024 07:45:25 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-62-65d6fb95a1f2
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	01.77.10006.59BF6D56; Thu, 22 Feb 2024 16:45:25 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Reply-To: wj28.lee@samsung.com
Sender: Wonjae Lee <wj28.lee@samsung.com>
From: Wonjae Lee <wj28.lee@samsung.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Adam Manzanares <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "nmtadam.samsung@gmail.com"
	<nmtadam.samsung@gmail.com>, Jim Harris <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam
	<hj96.nam@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20240221182020.1086096-3-nifan.cxl@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff@epcms2p1>
Date: Thu, 22 Feb 2024 16:45:25 +0900
X-CMS-MailID: 20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmme7U39dSDV7OkrWYfljRYvrUC4wW
	q2+uYbRoWn2X1aKh6RGLxYc3/1gs9j99zmKx9ICGxaqF19gsju7hsDg/6xSLxd9texktli55
	xGxxvHcHiwOfx85Zd9k9Wo68ZfVYvOclk8fGj//ZPZ5c28zk0bdlFaPH1Nn1Hp83yQVwRGXb
	ZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdraRQlphT
	ChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzjh9
	5gFLQRt3Rff8b8wNjD2cXYycHBICJhIn+54zdzFycQgJ7GCUaGmexNbFyMHBKyAo8XeHMEiN
	sEADo8ShnzkgtpCAnMTd26eYIOKaEm+mrWIBsdkE1CV+dJ4Ei4sIJElMmLIIbCazwAEWiY7H
	PxghlvFKzGh/ygJhS0tsX74VLM4pYC1xdOoCqLiGxI9lvcwQtqjEzdVv2WHs98fmQ80RkWi9
	dxaqRlDiwc/dUHEpia8n/rKD3C8hUC7xZr05yA0SIPc/WfkXao65xIQ9E8FsXgFficsXf4Ad
	zSKgKnHmzQk2iBoXiWmTT4HdwywgL7H97RxmkJnMQA+v36UPMV5Z4sgtqAo+iY7DMNN5JXbM
	e8IEYStJTGk7AnWZhERD41ao6R4Sp7c8ZJ3AqDgLEdCzkOyahbBrASPzKkax1ILi3PTUYqMC
	Q3jcJufnbmIEJ18t1x2Mk99+0DvEyMTBeIhRgoNZSYSXpfxKqhBvSmJlVWpRfnxRaU5q8SFG
	U6AvJzJLiSbnA9N/Xkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFIN
	TLPcRdXnL9Nyrfe/nX705ouzLW7HA+YtePNBOO6g54e5NzUcOlemn+4K/e1u9LP+3L1ZHoW6
	W47sXdH/bb9HTEWcjdBkqSOz+BvU5c8EaYiUTdp0bL/8Qavvb9NFBRrXn16ZneNT5Hw3edOf
	nRrXJz974ZPO81869A77npv+82Xsrzz4fP6ChEr+768lK9xLUw+x+Ozr6frJ37JULeJp0R7u
	veZT654f/322k4dhM8vldRMeRwVtnPO05WmTylFLj9akDQf9Iqe7G2RsOP6jjaEh93NGRWfS
	rCufGPjX/7dUufuB9aFarXTGyvCJe0wWqD9ZfGpemG7aU6kZHc+PN0v/Dc396u7/Lm32j9xn
	uauVWIozEg21mIuKEwEBQIGhRwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240221182126epcas2p1b684f9239e4262f17ff484939658a382
References: <20240221182020.1086096-3-nifan.cxl@gmail.com>
	<20240221182020.1086096-1-nifan.cxl@gmail.com>
	<CGME20240221182126epcas2p1b684f9239e4262f17ff484939658a382@epcms2p1>

On Wed, Feb 21, 2024 at 10:15:55AM -0800, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
>
> Per cxl spec r3.1, add dynamic capacity region representative based on
> Table 8-165 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
>
> Note: decode_len of a dc region is aligned to 256*MiB, divided by
> 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> mailbox command.
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  16 ++++++
>  2 files changed, 126 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ba1d9901df..88e3b733e3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -22,6 +22,7 @@
>

[snip]

> +#ifdef CXL_SPEC_AFTER_R30
> +    /*FIXME: need to set valid values in the future*/
> +    stq_le_p(&extra_out->num_extents_supported, 0);
> +    stq_le_p(&extra_out->num_extents_available, 0);
> +    stq_le_p(&extra_out->num_tags_supported, 0);
> +    stq_le_p(&extra_out->num_tags_available, 0);

Hello,

It's a trivial comment and doesn't have any impact yet, but shouldn't it
be stl_le_p()?

Thanks,
Wonjae
