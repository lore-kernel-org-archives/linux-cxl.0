Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FB223DF9
	for <linux-cxl@vger.kernel.org>; Mon,  6 Oct 2025 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759746424; cv=none; b=UNCkloYuiPi3RmjqBvqFQFxIhWjlwcSM79oHBHtT/YNySZkQOx5zI4kz9MPWKNg2wct9OW8awIGOz4G0X1u0um0gmBvSlGOtNMSABAaVg9z2rCsgM2pM+GlRw81fbhAhmxjWodg1OLHL9xRY/fgBA7bwTk7m/O1Wph9VYJcd+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759746424; c=relaxed/simple;
	bh=pd+Wnlj7Q7smr1JlYgfSkU+nPVzlRWrx+A+2ISIkSmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tJBVsTfT2YfqBe2MzHp+UP3tPZaMECBm0lrrgkJOHUnLi0QFSS1zbczaZXz/1tL969Q8vuKRUMa0854xAwKnpZ/6A6f7CCmlK+ZstIgw3XRVswm97BkUPIP2l/+z37YXnHbhIN2lpBaNBIc9WzEFlWQx6mM1eWoDw5vRgNNQZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4eEXIvY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4eEXIvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759746421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hx1eRPIFFxHOm4a9J7E46IkAGP6DTYAnqRweVWO3UhI=;
	b=E4eEXIvYZYApedhD9A/LHOx3s6AxHHyFrTFj4vGySah6Sp4/3QzhL/oL1rjQWNxeFG21vH
	26VYn/TaPmPm4Rgq/xHZLepif80WT0pXLoNiIpi5gOuERF75mEo5w+DQJdJvF4ZqlGCLEA
	aDTcDwQDdc4btNzgR2+9Vb4VimYt568=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-J_7PfE-GNmC16InQVMK1YA-1; Mon, 06 Oct 2025 06:26:58 -0400
X-MC-Unique: J_7PfE-GNmC16InQVMK1YA-1
X-Mimecast-MFC-AGG-ID: J_7PfE-GNmC16InQVMK1YA_1759746417
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42558f501adso2072489f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 06 Oct 2025 03:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759746417; x=1760351217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hx1eRPIFFxHOm4a9J7E46IkAGP6DTYAnqRweVWO3UhI=;
        b=L98AmUtpqci1wAUXro4cWwN8CXdoS50aO9bPkxhY2fuxYmyTmwHvtMZgwx5a5waXOp
         0kn0NQQc35BwZNnI1U20TmI6Kvdqf0ColELqKbCJEj9I0ZYc0dHD4FVuaUJ0xblBbg90
         OIyuJqeHHp/fzhYF79dfVBwkbr3tNXIqoGHJ/nxFdqU5xb+SbeoVbHQYEptfehZNQ8Wm
         CJn5sks57YeNLRx1YnZWs+d0FiR6UTEaFcy1WNPRQkiXQyCuv2w+Oey9DhAjI8wniBA9
         ApgvKwC7z7DisXiFVW9+ZJYnBLjvvtkDNJwexvw384+t55IjD5R2w6GfTm2Vwn/pVFjh
         bF3w==
X-Forwarded-Encrypted: i=1; AJvYcCVH8MRq7DejV0J/V1SKKz9NFUgZUYILl/rp3XaBffpCDmqQY8WXKnXlmU1t0aWZiou3eoe+M8ZM5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweqWq4RE/yHBBJzQv1M04deO+VTtnsxV13MqHLgcbJj/ayvBgt
	D8YG6mbsRMlCj5DZU7jbU7NvmoXDwIjlVksuyyWAecDmsiVwgWljoA1kPb/j7JZztLZ3INip8vN
	7+Ly2n1PaCRbEcSlt6fJ1UjWzn2e8RU40DIRKNtYYQ9423exk42jUBnw/00qdbA==
X-Gm-Gg: ASbGncvfQjBCY+0OfohK3KBA6l1yOGj1CFgpP0XxeCTit9FOa3Ziby6u8gd74unC/2I
	YZA4RuBz7q1oH9YR5+KhJ3om3CWEwEehZztn6vFGlBZNjNOVahU8+HTbk15WHN55OWsD5lRZVgP
	j67pxuM9aT2zWosamwSK7RRR4oUfO3r6AmgC4a+UJ9V/VJEQaHx8IuhxyLjteY/dDfKu+WU7bva
	TTtKN3ot9s9hNmw4i+nSM5D/Iy+1nguM3NA1A9h/3xXkKegPAIRCIs9C2P0W2FjnnS8zKhp6ol/
	3mAbMHgSAvV8uUrh52zzWTPh8twx11UvxKCPU0k=
X-Received: by 2002:a05:6000:43c6:10b0:425:72b3:7368 with SMTP id ffacd0b85a97d-42572b3739fmr4111755f8f.56.1759746417035;
        Mon, 06 Oct 2025 03:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9tVSThEbRlfl5KMR9XUYu2gh6jOa/VYTVmmVj5xGGUg3oMhlQzAXj+FGtfCBlHW8wyoHL1A==
X-Received: by 2002:a05:6000:43c6:10b0:425:72b3:7368 with SMTP id ffacd0b85a97d-42572b3739fmr4111739f8f.56.1759746416515;
        Mon, 06 Oct 2025 03:26:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e980dsm21747095f8f.36.2025.10.06.03.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:26:55 -0700 (PDT)
Date: Mon, 6 Oct 2025 06:26:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, shiju.jose@huawei.com,
	Davidlohr Bueso <dave@stgolabs.net>, armbru@redhat.com,
	Fan Ni <fan.ni@samsung.com>, linux-cxl@vger.kernel.org,
	linuxarm@huawei.com, Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu for 10.2 0/3] cxl: Additional RAS features support.
Message-ID: <20251006062628-mutt-send-email-mst@kernel.org>
References: <20250917143330.294698-1-Jonathan.Cameron@huawei.com>
 <20251006101304.000055f8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251006101304.000055f8@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zakD4IMiMnYW0KQ29GXTeQoIoFAxNZybXLJWPxtAuVY_1759746417
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 06, 2025 at 10:13:04AM +0100, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 15:33:27 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > These two features have been used in testing the related EDAC RAS
> > features drivers in Linux which are now upstream. Only minor tweaks
> > from the second part of:
> > https://lore.kernel.org/qemu-devel/20250811085530.2263-1-shiju.jose@huawei.com/
> > [PATCH v6 0/8] hw/cxl: Update CXL events to rev3.2 and add maintenance support for memory repair features
> > 
> > I've split that series up as the two parts were only slightly connected.
> > However there is some churn if this is applied without the other part of Shiju's posted
> > series. That was sent a few minutes ago as:
> > https://lore.kernel.org/qemu-devel/20250917141355.293217-1-Jonathan.Cameron@huawei.com/
> > 
> > Based on: [PATCH qemu for 10.2 0/5] cxl: r3.2 specification events updates.
> > Based on: 20250917141355.293217-1-Jonathan.Cameron@huawei.com
> > 
> > Davidlohr Bueso (1):
> >   hw/cxl: Add support for Maintenance command and Post Package Repair
> >     (PPR)
> > 
> Hi Michael,
> 
> I see you have queued some stuff up on your gitlab tree.
> Just wanted to make sure these are on the radar for possible inclusion.
> No huge rush, but I'll queue some more series up on top of these
> shortly.
> 
> Thanks
> 
> Jonathan

thanks for the reminder, will queue.

> > Shiju Jose (2):
> >   hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature
> >     attributes in cmd_features_set_feature()
> >   hw/cxl: Add emulation for memory sparing control feature
> > 
> >  include/hw/cxl/cxl_device.h | 145 +++++++++
> >  include/hw/cxl/cxl_events.h |  47 +++
> >  hw/cxl/cxl-mailbox-utils.c  | 566 +++++++++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 169 +++++++++++
> >  4 files changed, 915 insertions(+), 12 deletions(-)
> > 

