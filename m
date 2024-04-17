Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375213D26F
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354620; cv=none; b=p1mJr5klfZ+HIneA3FgoGaf6BKFeW+7xodButC9+a3Aj3tsOmqSDiRy5ilTnQ+U/mrWziHql6mkE9XX2LKnbXVvmbxLk/yC7ZvQppkRfZ0xZMXgr4j7/hRcoCi+955V1LKCxhMdJXstJ43A3Ceubci0q4s3inS+neLLTupklzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354620; c=relaxed/simple;
	bh=/LE2UxkRiFBxDOe2MTxFP/5MAGiNhq4xLAH5YiqFD1k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZvcjY+i42IPLuxYT/wODzz0QnBzFA/37P2Fh6hdkE+caRsiaafdkq11Fa0marCVyiMTWZ2M2VLGqefEdNJQkaenCI3hMImcY0zMm3sCq9tJopVBKf/qWOJzJ8GNSBJ1fjTweWYaKzSimbboZ9PEVbkZYEZq5BN0PQiMKI4Pm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKJxT1r16z6K9WL;
	Wed, 17 Apr 2024 19:45:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C73A3140A08;
	Wed, 17 Apr 2024 19:50:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 12:50:14 +0100
Date: Wed, 17 Apr 2024 12:50:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240417125013.00000a74@Huawei.com>
In-Reply-To: <Zh6swM5SbnXkB76H@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
	<20240325190339.696686-10-nifan.cxl@gmail.com>
	<20240405131856.000025e7@Huawei.com>
	<ZhWym2yHoh6YIaXj@debian>
	<20240410204911.0000590b@Huawei.com>
	<Zh2IrA8TQDJn1ft_@debian>
	<20240416155822.00004fce@Huawei.com>
	<Zh6swM5SbnXkB76H@debian>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> > >  
> > >      ret = cxl_detect_malformed_extent_list(ct3d, in);
> > >      if (ret != CXL_MBOX_SUCCESS) {
> > > +        cxl_extent_group_list_delete_front(&ct3d->dc.extents_pending);  
> > 
> > If it's a bad message from the host, I don't think the device is supposed to
> > do anything with pending extents.  
> 
> It is not clear to me here. 
> 
> In the spec r3.1 8.2.9.9.9.3, Add Dynamic Capacity Response (Opcode 4802h),
> there is text like "After this command is received, the device is free to
> reclaim capacity that the host does not utilize.", that seems to imply
> as long as the response is received, we need to update the pending list
> so the capacity unused can be reclaimed. But of course, we can say if
> there is error, we cannot tell whether the host accepts the extents or
> not so not update the pending list.

Can try and get a clarification as I agree 'is received' is unclear,
but in general any command that gets an error response should have no
affect on device state. If it does, then what affect it has must be stated
in the specification.

> >   
> > > +
> > > +#define REMOVAL_POLICY_MASK 0xf
> > > +#define FORCED_REMOVAL_BIT BIT(4)
> > > +
> > > +void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t hid,
> > > +                                      uint8_t flags, uint8_t region_id,
> > > +                                      const char *tag,
> > > +                                      CXLDCExtentRecordList  *records,
> > > +                                      Error **errp)
> > > +{
> > > +    CXLDCEventType type = DC_EVENT_RELEASE_CAPACITY;
> > > +
> > > +    if (flags & FORCED_REMOVAL_BIT) {
> > > +        /* TODO: enable forced removal in the future */
> > > +        type = DC_EVENT_FORCED_RELEASE_CAPACITY;
> > > +        error_setg(errp, "Forced removal not supported yet");
> > > +        return;
> > > +    }
> > > +
> > > +    switch (flags & REMOVAL_POLICY_MASK) {
> > > +    case 1:  
> > Probably benefit form a suitable define.
> >   
> > > +        qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
> > > +                                                      region_id, records, errp);
> > > +        break;  
> > 
> > I'd not noticed before but might as well return from these case blocks.  
> 
> Sorry. I do not follow here. What do you mean by "return from these case
> blocks", are you referring the check above about the forced removal case?

No, what I meant was much simpler - just a code refactoring thing.
        case 1:
            qmp_cxl_process_dynamic_capacity_prescriptive(path, hid, type,
                                                          region_id, records, errp);

            //break;
            return;
> 
> Fan
> 
> >   
> > > +    default:
> > > +        error_setg(errp, "Removal policy not supported");
> > > +        break;
               return;
> > > +    }
> > > +}  

