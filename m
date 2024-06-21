Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B18DDC4
	for <linux-cxl@vger.kernel.org>; Fri, 21 Jun 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989105; cv=none; b=SidltihNVc0KPaybCSmCZVRPusyglZm07wJyNie4ACXv2+x5aw250DZL0vs4H9HtqVldhm5ogVEV2HIlu6+mrPyQFCDdBuQgXeUaYGanb6pP19b9O4C6hvgvg3uOrUpmVTIsgmPdGqdsXFg2DYplNS4jg4WxfjF+LUa9ITGzkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989105; c=relaxed/simple;
	bh=hbLByqnK/AVXgZaaAmfOI9Qtli1gHliDCiHqGFXBX/Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo+gUbhv/7r7jbt2VfciPCXn/M+BDQDGlwnUXtApQ0gbgAz53IIbOAwoVKorFcOFyI3g9dDOpE4dRsnMr+J+FhywjTqcnXdyoJZEiI9VBtzpxQ2P1/6VBqdBS8GAAX170J8N0RNGYq+SadyvlOjcCWqY1bxqRE8zhOgwvfxHQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W5Nms01pzz6K9BG;
	Sat, 22 Jun 2024 00:56:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 017C2140A30;
	Sat, 22 Jun 2024 00:58:20 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 17:58:19 +0100
Date: Fri, 21 Jun 2024 17:58:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: fan <nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>,
	<fan.ni@samsung.com>, <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Message-ID: <20240621175818.00007705@huawei.com>
In-Reply-To: <20240319204818.p6qbkyktgsadmkhi@offworld>
References: <20240205172942.13343-1-dave@stgolabs.net>
	<ZfnR1jTLG_e5KCIE@debian>
	<20240319204818.p6qbkyktgsadmkhi@offworld>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 19 Mar 2024 13:48:18 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 19 Mar 2024, fan wrote:
> 
> >> +/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
> >> +#define CXL_FW_XFER_ALIGNMENT   128
> >> +
> >> +#define CXL_FW_XFER_ACTION_FULL	    0x0
> >> +#define CXL_FW_XFER_ACTION_INIT	    0x1
> >> +#define CXL_FW_XFER_ACTION_CONTINUE 0x2
> >> +#define CXL_FW_XFER_ACTION_END	    0x3
> >> +#define CXL_FW_XFER_ACTION_ABORT    0x4  
> >
> >The above definitions have "tab" used, cannot pass checkpatch check.  
> 
> I was not aware of a checkpatch for qemu, will clean up.
> 
> >> +
> >> +static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
> >> +                                               uint8_t *payload_in,
> >> +                                               size_t len,
> >> +                                               uint8_t *payload_out,
> >> +                                               size_t *len_out,
> >> +                                               CXLCCI *cci)
> >> +{
> >> +    struct {
> >> +        uint8_t action;
> >> +        uint8_t slot;
> >> +        uint8_t caps;  
> >
> >Based on table 8-66, I cannot find the field "caps" and it is unused.  
> 
> Hmm yep don't know how that snuck in, will get rid of it.
> 
> Thanks,
> Davidlohr

I fixed both on my tree.
