Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FECF1E493
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595234; cv=none; b=YES/Qut9NBM1tkrVLm6cuiOPnooXDeOPlP8Ic2pciGQbGEewx+UWCmlyC/Ls97Jmirc9+bPtssBUx8evlkwi/Q3iQbTQBGtlfuM/m2AkC6DmXjO77Nco+Ajvln4J8LlmYsbM7EB8S98qCuhHuj3Y+EpCaMQmxZvb8wi4PNIvvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595234; c=relaxed/simple;
	bh=n5vJzAWxrUmq4FNObWXgjGc9VDy4OZu6l8sDvTKR4MU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4s+KVjkHyh5DDTaZQ9rS7zJbM1wkKxuYydg6emibKbvMwPmrwCBaTyHlbY5Voa8Vgx+OCdrKYQMjtuG/0ZlkzkzfJaDbrgHLY5UAtvllotgKKFh0z0K0e4G0w3j+VoYlpcwj90xbiwrSqYIeB2d3173iZ1iIRCn/n+XnffURTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmqXh46vzz6K5x0;
	Mon,  3 Feb 2025 23:04:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3451400CA;
	Mon,  3 Feb 2025 23:07:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 16:07:08 +0100
Date: Mon, 3 Feb 2025 15:07:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <ajay.opensrc@micron.com>, <fan.ni@samsung.com>, <john@jagalactic.com>,
	<emirakhur@micron.com>, <ajayjoshi@micron.com>, <sthanneeru@micron.com>,
	<ravis.opensrc@micron.com>, <arramesh@micron.com>, <tmmulgund@micron.com>,
	<linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/cxl: Support aborting background commands
Message-ID: <20250203150706.00000e23@huawei.com>
In-Reply-To: <20241022180030.00004f68@Huawei.com>
References: <20240813221255.179200-1-dave@stgolabs.net>
	<20240827163357.0000228e@Huawei.com>
	<jdipjanthgt6atlksngodxjevfb5d43d5rshtxqxxwruszqa3e@vctljs77lg4e>
	<20241022180030.00004f68@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 22 Oct 2024 18:00:30 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 21 Oct 2024 20:23:46 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Tue, 27 Aug 2024, Jonathan Cameron wrote:\n  
> > >No comments inline and LGTM. I'll queue it on my tree and push
> > >that out on gitlab sometime soonish.    
> > 
> > I don't see this picked up, which is a good thing atm. While testing
> > the kernel side, I noticed the following is needed, will send a v2
> > with it folded in.  
> 
> Currently just on my cxl-2024-10-15 branch of gitlab.com/jic23/qemu.
> I'll pick up your v2 and replace that.

Hi Davidlohr,

Did I miss v2, or still to send?

Thanks, 

Jonathan
> > 
> > diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> > index 1a9779ed8201..0d429b59aafc 100644
> > --- a/hw/cxl/cxl-device-utils.c
> > +++ b/hw/cxl/cxl-device-utils.c
> > @@ -94,14 +94,15 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
> > 	     cxl_dstate->mbox_reg_state64[offset / size] = bg_status_reg;
> > 	 }
> > 	 if (offset == A_CXL_DEV_MAILBOX_STS) {
> > +            int bgop;
> > 	     uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
> > 
> > 	     qemu_mutex_lock(&cci->bg.lock);
> > -            if (cci->bg.complete_pct == 100 || cci->bg.aborted) {
> > -                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
> > -                                        0);
> > -                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
> > -            }
> > +            bgop = !(cci->bg.complete_pct == 100 || cci->bg.aborted);
> > +
> > +            status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
> > +                                    bgop);
> > +            cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
> > 	     qemu_mutex_unlock(&cci->bg.lock);
> > 	 }
> > 	 return cxl_dstate->mbox_reg_state64[offset / size];
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index d5b084388288..760a8571fda6 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -2731,9 +2731,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >       [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
> > 	 cmd_firmware_update_get_info, 0, 0 },
> >       [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
> > -        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
> > +        cmd_firmware_update_transfer, ~0,
> > +        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT },
> >       [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
> > -        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
> > +        cmd_firmware_update_activate, 2,
> > +        CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT },
> >       [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
> >       [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
> > 			  8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
> > 
> > Thanks,
> > Davidlohr  
> 
> 

