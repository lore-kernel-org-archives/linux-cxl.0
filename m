Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A81374F1
	for <linux-cxl@vger.kernel.org>; Fri,  8 Nov 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077285; cv=none; b=Uj+Uuy86tmYxZw8m+Q0sObnBYuYCUE6N/MB/98Myp0nQTOEXAmWot/NSkXDrX15Kh84ZjY+3Br+p/cm9uFpYi2sItyXQ1z9ldKRzO48u0xEXCpokW+mxxGO3X4mLQ9S6rwsQAxGox+pOn9p6eQLpRL3IEEwsCW52HKlyiruTU6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077285; c=relaxed/simple;
	bh=EtDAOKa20/zo1nUQeFJ0sUUdrLbd8ZfXTx3KF04/StM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtOcVmFlfiT7gZol4o6l/O9y1kUUo7+/yl9hbK+tBHZ0qRSPT9xJE8EuLmElzhDcaC5MEhU1j0jxBqMyonZAoSKiVRNpgC6/ICYV6jFDklmAviPW5O79A9P2uJBfjFG2iRItyuuq6b+cNqBL84qQGtSdzRnd2VL37cQwX5CknKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlMDG5yMKz6J7DD;
	Fri,  8 Nov 2024 22:45:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B8FC8140A9C;
	Fri,  8 Nov 2024 22:47:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 15:47:56 +0100
Date: Fri, 8 Nov 2024 14:47:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>,
	Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond
 end of target attributes
Message-ID: <20241108144754.00003a92@huawei.com>
In-Reply-To: <CAFEAcA8LB3t0n_BqjBeEejfmVVYMbQ1rT9qwEbsNEoUDbkym9A@mail.gmail.com>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
	<20241101133917.27634-9-Jonathan.Cameron@huawei.com>
	<CAFEAcA8LB3t0n_BqjBeEejfmVVYMbQ1rT9qwEbsNEoUDbkym9A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 7 Nov 2024 15:39:13 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 1 Nov 2024 at 13:43, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> >
> > In cmd_features_set_feature() the an offset + data size schemed
> > is used to allow for large features.  Ensure this does not write
> > beyond the end fo the buffers used to accumulate the full feature
> > attribute set.
> >
> > Reported-by: Esifiel <esifiel@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index a40d81219c..078782e8b9 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> >
> >          ps_set_feature = (void *)payload_in;
> >          ps_write_attrs = &ps_set_feature->feat_data;
> > +
> > +        if ((uint32_t)hdr->offset + bytes_to_copy >
> > +            sizeof(ct3d->patrol_scrub_wr_attrs)) {
> > +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +        }  
> 
> Coverity complains about this code (CID 1564900, 1564901).
> Essentially it does not like that this check permits
> the memcpy for the case where hdr->offset is 2 and
> bytes_to_copy is 0, because memcpy(invalid_dest, src, 0)
> is still UB even though you might logically expect it
> to do nothing.
Huh.  Something new I learned today ;)

Anyhow, it makes little sense to have a set feature with zero length payload
so I can check for this before we even know what type of payload this is,
thus catching both cases here.

I'll spin a patch shortly.

thanks

Jonathan


> 
> >          memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
> >                 ps_write_attrs,
> >                 bytes_to_copy);  
> 
> > @@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
> >
> >          ecs_set_feature = (void *)payload_in;
> >          ecs_write_attrs = ecs_set_feature->feat_data;
> > +
> > +        if ((uint32_t)hdr->offset + bytes_to_copy >
> > +            sizeof(ct3d->ecs_wr_attrs)) {
> > +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +        }
> >          memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
> >                 ecs_write_attrs,
> >                 bytes_to_copy);  
> 
> Similarly here.
> 
> thanks
> -- PMM

