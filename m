Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F71D618C
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738582442; cv=none; b=Dmmb2zkAVpoPBqXrAXjwUykQdQFHVIepOleyCZ27KsNhR0KU6HKF5+Z2Ozsq6iL7FU+YakW+x2GUv2DFunucVz/7jKREslYLoyPVefF2UvC3wDHv1WZSvXX2xIEcDnHRlKj33g0O3pyqvwXffkZyJmb+HUmSBmuD0syreFs7y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738582442; c=relaxed/simple;
	bh=9uMRUu4N4Cuv1+j7eXeEnvdN3N7fnWS1iNt0zUqBlTY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReLn8qHHU7+BxaSw3RLjtV8ReEK0lHYZYXiA5b1/2kJMYHfQ5x8b47V7nD8dth62jCjgxx7l3icJ+kiToGBhW6MQJKbN8JjAYl6i506WYMZ3KQfFK+sVvlutNHay1n1DWOCekcoz2WDA5FG17LvOAHo+45BLI/r8g0BcrXmcV4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ymkrg1J2Zz6K9C0;
	Mon,  3 Feb 2025 19:33:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BDE39140B73;
	Mon,  3 Feb 2025 19:33:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 12:33:56 +0100
Date: Mon, 3 Feb 2025 11:33:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Adam Manzanares <a.manzanares@samsung.com>
CC: Vinayak Holikatti <vinayak.kh@samsung.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "krish.reddy@samsung.com" <krish.reddy@samsung.com>,
	"vishak.g@samsung.com" <vishak.g@samsung.com>, "alok.rathore@samsung.com"
	<alok.rathore@samsung.com>, "s5.kumari@samsung.com" <s5.kumari@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250203113354.00007cd7@huawei.com>
In-Reply-To: <Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
	<20250123050903.92336-3-vinayak.kh@samsung.com>
	<20250124151946.0000134f@huawei.com>
	<Z503EpvqMczHIZqF@sjvm-adma01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >   
> > > +    int dpa_range_count = san_info->dpa_range_count;
> > > +    int rc = 0;
> > > +
> > > +    for (int i = 0; i < dpa_range_count; i++) {
> > > +        rc = sanitize_range(ct3d, san_info->dpa_range_list[i].starting_dpa,
> > > +                san_info->dpa_range_list[i].length, san_info->fill_value);
> > > +        if (rc) {
> > > +            goto exit;
> > > +        }
> > > +    }
> > > +    cxl_discard_all_event_records(&ct3d->cxl_dstate);  
> > 
> > Add a comment on why we are deleting event records when sanitizing a small
> > part of memory?
> >   
> 
> See response below for disabling the media state. Same section referenced
> below, 8.2.10.9.5.1 states all event logs should be deleted. Outcome
> depends on how we interpret "follow the method described in 8.2.10.9.5.1".
> 

This also sounds like reading too much into that comment.

> > > +    }
> > > +
> > > +start_bg:
> > > +    /* EBUSY other bg cmds as of now */
> > > +    cci->bg.runtime = secs * 1000UL;
> > > +    *len_out = 0;
> > > +    /* sanitize when done */
> > > +    cxl_dev_disable_media(&ct3d->cxl_dstate);  
> > Why?  This is santizing part of the device. As I undestand it the
> > main aim is to offload cleanup when the device is in use. Definitely
> > don't want to disable media.  If I'm missing a reason please give
> > a spec reference.  
> 
> Table 8-164, sanitize description mentions to follow method
> in 8.2.10.9.5.1, which does call out placing device in disabled
> state, but I'm not sure if method refers to all text in 8.2.10.9.5.1
> or the method devices uses to sanitize internally.

I think it is meant to just be the method of sanitizing. 

> 
> I would imagine since sanitize is destructive we would not want to return 
> any data from device ranges impacted by sanitize. I believe a simple
> way to achieve this is to disable entire device. 

Hmm.  That rather destroys the main use case I'm aware of for this
(unlike the general santize commands from earlier CXL versions)/
Superficially sounds like we need a spec clarification as
clearly not super clear!

> 

Jonathan


