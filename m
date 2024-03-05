Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48818E1A
	for <linux-cxl@vger.kernel.org>; Tue,  5 Mar 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658565; cv=none; b=DIEQmYsdbw7/9K4CxeagxzeSAZPewKbEiYDekZTYCSLxYq8rJo4WDRxX++dtdwB0gIE6wsESofFM3zwB3MZGH6+BssCnhLCYxGPiJ+g3/cTSecokCDPWOk6AojHSkGXgZKVRIoKpFjZWEusM5gpZYe8/iFuVcJ2EAWWuCZBYDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658565; c=relaxed/simple;
	bh=Ip37TwWc/1jDdJfQy6v7uGKssQtnU3pvCdtljPYwAqY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V51Byx+F3rnF82y173mhgr49CyzG2FaND3rt4Z2oD8c2xe1NSKHaDIgMx7uj+ykegi1JAbkEKHvBA4HIr5g+fR3IyH0nPKCgMlyETUQWqn33dpOk78Q89iYZxqd/b8qfddlSskXjcaw0KqiMiASZk3nGlZKGaQke94RzwkxySKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hj3ie9Gz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj3ie9Gz"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e58d259601so3762119b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 05 Mar 2024 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709658564; x=1710263364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMyPSQNoZX6mCJEU1oJOANHIjsrabzXyzk2PurQx6yU=;
        b=Hj3ie9Gz4RD3k8AARMV7A2MVJYVmIGZZFzQHlVAWVSz9v0WijXU7dht+m1JS1PH1Fd
         nm5Sckk1BDS/IT85LVfY8RVBLxQTYm7s3DajgPSuyB6sw6ESQQC8PndKe85Vour006Jd
         oxgCrJ6CCCgcOvbIWL6F9FWMfegFsgdbt8Z37k+WC0Ou7BeXT9RyBIUaJD563+LoCn8Y
         hkvPkr5aWPmcfwTzbFlSk4QLV4IXgsxz29cgG8l3KwU2AIsilqAG27ixCDXuaEWWPczO
         2wT/O+ncEIP6S6nj4WC1TKLDwFZas1B+j33zeuE+5KjVuiFKfdNazUT2GsV2LpfRzcA7
         elnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709658564; x=1710263364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMyPSQNoZX6mCJEU1oJOANHIjsrabzXyzk2PurQx6yU=;
        b=poMui97hqsEiJ0cOxhqJH5eDcPK0DNCl9pde7BbDHPDBb8wqsQZA+3IunVTqnyEGEE
         VUDGhTl8/IiHG5svFSuzwekrOZLbhr0n6aqhNEa5WqkwisfKwn+7TkBYzIOK3jvDRE1s
         gQyq3YmKUuwoz7j5p82EEFbJO9eBCKeoBZVo/eTqxaP+0uHoTHx/OpU9TFqP641ikl41
         93JoVl9KxulcRDO0spG3N4QNc3GdL5HAwvvHTLl+I592bVqJKWiYc+oNQlWIua3nybca
         JhMWRBwUR0+tJd7HBtiNxXtPQAmRE1HwQO55LaGziYWg/9JJzdkIkfyC9IkMDp57ic55
         TFdw==
X-Forwarded-Encrypted: i=1; AJvYcCX1/5Qbuy9gQeKqAXIetcQ3d69g5jVjb6CcKLnsSp/HvgljcnGtCLsS3Pwb5HWyBzOp0oFfbpDBefgr+sMxOLZWMAcAQOB817eP
X-Gm-Message-State: AOJu0YyF47TEZO+0PJNlGtocRrRzA4wnlmOpbU+vrSJF8/m5T21WgdC/
	faRDy3CqKC90RNC+DYqtmJmKIA3UFLVCEmpZSFnfg61YiPTyEx6O
X-Google-Smtp-Source: AGHT+IGo9IutGEDzfw88MhEA1IBT1j5jFoOJfB77AyyqYzLqAchDwqAIZpHvJgOCb317KNKTV7WimA==
X-Received: by 2002:a05:6a00:2fd1:b0:6e5:d3b9:2d06 with SMTP id fn17-20020a056a002fd100b006e5d3b92d06mr11304820pfb.21.1709658563597;
        Tue, 05 Mar 2024 09:09:23 -0800 (PST)
Received: from debian ([2601:641:300:14de:8dce:12ff:6983:289])
        by smtp.gmail.com with ESMTPSA id w8-20020a056a0014c800b006e622f9175asm3660646pfu.217.2024.03.05.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:09:23 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 5 Mar 2024 09:09:05 -0800
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, nifan.cxl@gmail.com,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <ZedRsZee2WhTi_Nd@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com>
 <ZedFIp5gK4aXsqD-@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZedFIp5gK4aXsqD-@redhat.com>

On Tue, Mar 05, 2024 at 04:15:30PM +0000, Daniel P. Berrangé wrote:
> On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
> > On Mon,  4 Mar 2024 11:34:08 -0800
> > nifan.cxl@gmail.com wrote:
> > 
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > With the change, we add the following two QMP interfaces to print out
> > > extents information in the device,
> > > 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
> > >    the device;
> > > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
> > >    DC extents in the device;
> > > The output is appended to a file passed to the command and by default
> > > it is /tmp/dc-extent.txt.
> > Hi Fan,
> > 
> > Is there precedence for this sort of logging to a file from a qmp
> > command?  I can see something like this being useful.
> 
> This is pretty unusual.

Yeah. I cannot find anything similar in existing code, my initial plan
was to print out to the screen directly, however, cannot find out how to
do it nicely, so decided to go with a file. 

Is there a reason why we do not want to go with this approach?

> 
> For runtime debugging information our strong preference is to integrate
> 'trace' probes throughout the code:
> 
>   https://www.qemu.org/docs/master/devel/tracing.html#tracing

I am not familiar with the trace mechanism. However, I think the
approach in this patch may be useful not only for debugging purpose.
Although not tried yet, maybe we can also use the approach to set
some parameters at runtime like what procfs does?
Just a rough thought.

Fan


> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 
