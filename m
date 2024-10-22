Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A31A08B5
	for <linux-cxl@vger.kernel.org>; Tue, 22 Oct 2024 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607049; cv=none; b=NAYM4hDrFWl0cWMC/oiGiLMvDCGe1AIwl941VNX5RJKrE0I1oOgb5sceYFzCmHFG15y4BUtv3PPpgcSg7A4o0O/b106ecp22rH4smjqrhbBKZLF8xjSzo7YdT5ToiKYswYx9zBGUX76gaDcR249hBCMozg3fnpuZfb6sNQqfN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607049; c=relaxed/simple;
	bh=EhL9si2Aq9wHNWf9k5afcj+BM8ybMHw5TENWRjpVaig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH8l6Rc6wbBOhu0oUgqHyowBsykgtj4U2wXQ/Uk3+rpaU/rocz10jDu8jxL8pObD/Guhccvemnof14tnyxtt2PqWHZgFi5b4yk5FFhLzxkzjI0JowRqCW/3J/sROsHGHDyXCaCownIBX7MGquVU+RtmszbV/k+m/tKus7L44x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qnUogee4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qnUogee4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46094b68e30so44289641cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 22 Oct 2024 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729607046; x=1730211846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSO/dlnnjdqEtRccDwku+xGxeoL8AGwZjql6S0C/leE=;
        b=qnUogee4G67CC2EaRwxfbpJTjC/fD9PetF7uxSHIgi851rFqnRDXJWsh7jt4W9IE1a
         sOT1JsPuqrqUCt0Xk/XduqTxGVnn1wYxBnnVeuTfz+g0Hjubh94Csmh3PH7JM+cmmFjX
         ko0L7phY/tOpMml/J8o6tlUqr3sQM+0F5i8gF3fxkEmMfshUldee9SBGSWAQwszNboHK
         rli9hRqNaa6yev2oD3Tz1ATJqKqFD5f/SaywE1wWrBaH7ftAJ7rJ4yOBkeCvwetTgOO3
         eKV11ySWl8wOIAbiEMitZ4+Nr5UzH2gC2zHG714Q+Q1h7SKSnD+tZ6QQUqkeW/+6dV1V
         eXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607046; x=1730211846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSO/dlnnjdqEtRccDwku+xGxeoL8AGwZjql6S0C/leE=;
        b=GG2mxIpOb6fppXeg0qT2ISbUVcbmhG15TmzZ2WZF0ZIp0Q2zgAJKysCddCUC3boR8s
         jGFfn7emjctaovb1d/RurTwbhFaFt7Crju56ZuFkAXWYgNTYzNZk/4maVPE6wdkilTKD
         hH0o1K+/A7YRWC3Kzlm8r6Cx0LnvOxwKOigX77Pr9C4X1SqNQzxS16DWUaj9DW8Om5/b
         hJt7XbAoUuKcnzPjSwpSkl53qxXSwO/aZluTUWBM7aqt+b0O8CVggm2paWOTGzoY8Hwb
         Uei/NXJRX0YUQoyOxrOLD6cKH6qnUEbCK8Wd5HHfA6l6OXEoQ1d8WpDwVA75HvTPEsZ/
         MRBA==
X-Forwarded-Encrypted: i=1; AJvYcCXmAdcbG4v8DtBJBMY5eFNJzhodhhLAirahoaIMCmcLumlQ3Z5Yr3R6GhhB/ACCVnbqvnnDAa3ePo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11mah4jSnNXt/1bg5C4picgRaHl4rwJkd7UpocEMsy/96I2xs
	ydLHyzdeCefnIvYoJVQxodSin3RAUb6FsLWrnzt7a5b4gJ8ycjHQLmyIGKhgCWQ=
X-Google-Smtp-Source: AGHT+IF5fbaOto1AQAWktpGH/+6Tqp835/6zpFVXMyPZpiyi3+BOxKZkfPeAjgw/eug8GyrAW4p2RQ==
X-Received: by 2002:ac8:5f07:0:b0:460:8f9a:9760 with SMTP id d75a77b69052e-460aed02689mr228595451cf.2.1729607046421;
        Tue, 22 Oct 2024 07:24:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3d70a6bsm29593711cf.63.2024.10.22.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:24:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:24:07 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>, John Groves <John@groves.net>,
	virtualization@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
	qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linuxarm@huawei.com,
	wangkefeng.wang@huawei.com, John Groves <jgroves@micron.com>,
	Fan Ni <fan.ni@samsung.com>,
	Navneet Singh <navneet.singh@intel.com>,
	=?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <Zxe1h8-E-OcO9cG3@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
 <Zu07AU3aUrHBMXaw@PC2K9PVX.TheFacebook.com>
 <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238f2a3-88a2-4996-92f2-05735801002b@redhat.com>

On Tue, Oct 22, 2024 at 11:33:07AM +0200, David Hildenbrand wrote:
> On 20.09.24 11:06, Gregory Price wrote:
> 
> > The only concern is when insufficient ZONE_NORMAL exists to support
> > ZONE_MOVABLE capacity - but this is unlikely to be the general scenario AND
> > can be mitigated w/ existing mechanisms.
> 
> It might be worthwhile looking at
> Documentation/admin-guide/mm/memory-hotplug.rst "auto-movable" memory
> onlining polciy. It might not fit all sue cases, though (just like
> ZONE_MOVABLE doesn't)
> 

I managed to miss auto-movable in my last pass through there. Though for
our use-case, forcibly preventing ZONE_NORMAL for all CXL is the preferred
option in an effort to keep as much kernel resources out of high latency
memory.

So I think we're just going to end up using memhp_default_state, and that'll
be mostly fine.

> > 
> > Manually onlined capacity defaults to ZONE_MOVABLE.
> > 
> > It would be nice to make this behavior consistent, since the general opinion
> > appears to be that this capacity should default to ZONE_MOVABLE.
> 
> It's much easier to shoot yourself into the foot with ZONE_MOVABLE, that's
> why the default can be adjusted manually using "online_movable" with e.g.,
> memhp_default_state.
> 
> It's all a bit complicated, because there are various use cases and
> mechanisms for memory hotplug ... IIRC RHEL defaults with its udev rules to
> "ZONE_MOVABLE" on bare metal and "ZONE_NORMAL" in VMs. Except on s390, where
> we default to "offline" (standby memory ....).
> 
> I once worked on a systemd unit to make this configuration easier (and avoid
> udev rules), and possibly more "automatic" depending on the detected
> environment.
>

Appreciate the additional context, thanks!

~Gregory
 
> -- 
> Cheers,
> 
> David / dhildenb
> 
