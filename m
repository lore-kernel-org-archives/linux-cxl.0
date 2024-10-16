Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1754F95
	for <linux-cxl@vger.kernel.org>; Wed, 16 Oct 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094505; cv=none; b=QexKJTwTQ9J32tVP6zMEGXHC0La6XzDaf4rs8oWWYBtiVFbQq2V85lhbzmqXldUx1ZidrB3ge5ApBRQfkSiB+ThCb6C5dBgJIW+0h+plrq7+9N9dQcHfB00tToZAPM2D7VCEeBGykzibYf+TGX5YeJstb9rtVyPoZdxeL0+hRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094505; c=relaxed/simple;
	bh=Ac322tThEXPomOZzgrlGRTMvqRz1CLjLhgZCuPU4X6Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc5NOljEICW7fIwkEg5MflN0DaN0ijGXyRhlztP5mzuu6DDGY7pQUTyFbdejvE5zaKPzBvjj/ZoxRfw6Qvm8O0RTKwxNVsz/CbEHi/a4yxvlXDTM/+mdLDBLz0RMD+7YQKL3MxG6pQvsNO8GixTwnPL0NAVbe6yntOOeg6XIADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTFzM3pcmz6FGy5;
	Wed, 16 Oct 2024 23:59:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B856C140558;
	Thu, 17 Oct 2024 00:01:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:01:39 +0200
Date: Wed, 16 Oct 2024 17:01:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
	<nmtadam.samsung@gmail.com>, <abhi.n@samsung.com>,
	<alok.rathore@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <20241016170138.000001cf@Huawei.com>
In-Reply-To: <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
References: <20241008164624.78608-1-nifan.cxl@gmail.com>
	<uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 20:01:07 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 08 Oct 2024, nifan.cxl@gmail.com wrote:\n
> >From: Fan Ni <fan.ni@samsung.com>
> >
> >In the function cmd_firmware_update_get_info for handling Get FW info
> >command (0x0200h), the vmem, pmem and DC capacity size check were
> >incorrect. The size should be aligned to 256MiB, not smaller than
> >256MiB.  
> 
> Can get rid of a level of parenthesis (other cmds as well), otherwise:
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
I missed this one when gathering up fixes the other day.
I'll queue it up now with the excess brackets dropped.

Jonathan

> 
> >
> >Signed-off-by: Fan Ni <fan.ni@samsung.com>
> >---
> > hw/cxl/cxl-mailbox-utils.c | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >index 9258e48f95..c82ad50ac8 100644
> >--- a/hw/cxl/cxl-mailbox-utils.c
> >+++ b/hw/cxl/cxl-mailbox-utils.c
> >@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> >     } QEMU_PACKED *fw_info;
> >     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> >
> >-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> >-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> >-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
> >+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> >+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> >+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
> >         return CXL_MBOX_INTERNAL_ERROR;
> >     }
> >
> >--
> >2.43.0
> >  

