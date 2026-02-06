Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236A53AEF43
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384378; cv=none; b=bbYlt2hhHpBUb5cwDWy0QUmSjpvUcVAWF6cr5v7B2JcpIe9wn7L3Zj5+E+v8yJcjxBKG+dl2t7S8LFzXAvsY0JjjsUam0gtVEUAvxoiVD/6YmOYNLt6d1tDhDjHqP9ZuDW2+/DwSXo41HoxRWF+Pbp2L7F7gp+wtBejvnUwUzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384378; c=relaxed/simple;
	bh=QOyk0cfOiJKWpzq43+ntxyiecyFc7tSymZehLwBs/7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMPoC6iwDmeWYgYr1qee7poYl46Pvx0T+0WwttbvaDXo+MpmoYn+2mKMnOvM5DTruZY8QIdDwduLFOZnnhIHb3jeG/88kYVOlk/CVdVPaPyYfWQI49K8FCe1+q5ddXaL3+hymGN4ppEsQTM+J2xm9R5YgrTY2spbiA/qC7CGTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=N6cBfi+V; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="N6cBfi+V"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c710439535so136006385a.1
        for <linux-cxl@vger.kernel.org>; Fri, 06 Feb 2026 05:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770384377; x=1770989177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bcoHR9we9sqx3MppgWDXe17DIO+ggzqTTd2+g0R34PI=;
        b=N6cBfi+VELTLXd+MB42/nKMWKzxlWSVDmzJQAw0jmBEE9ZumFotHUi9zV3KdQZUhW5
         IyrnFezD0cys67NGdgCt8M4wwf2fZc/zN1dEOjJ5ahgOnzS5SmctwpGukCyLIAkkvHVi
         IZBVtZV3YRHUMzDwEilnf2nTTMJ/pW6c1E7F3HWvQIRffePrrvo9Waqs5SFzB7+Sojzt
         8YZEI7WW2dIDgzwojfh9MKCdYUTc4ITNAIXhOgUqHHzDgk1kaTRMWLhWgCfyIlVSu7Q1
         BRFbGCcWag5aYKe+EP3vANe/yhjXg8pfnm9kBWpRhiGyLFGcHG3LJjBVMtcAKGnI7TQq
         CkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384377; x=1770989177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcoHR9we9sqx3MppgWDXe17DIO+ggzqTTd2+g0R34PI=;
        b=bnSyOz1yBaYBSUdNUx3j6zy1YG/qzGOBcaoi2wuEXyFauR/Rmlt9kwf4r/eAIgTHP5
         LlTvSsPqnU4EDgSfcrlBBeDBV54l2ixNVjxUTY5H/US4K0xNJ+lcO7TjYtpJSs36nHev
         YLcZnTPmEg2c4SMc6UgmcibqxMj8shc6Bo9kdw4BlLoWwi1sT6a18saHkKALSrtiYAqe
         udEqa8fO3HHLoqleQW3X5K5zY0f5SH9rLCXdiMj+XakCt0tmAW35iE8AXrw+ernNohrV
         teKcZQefx52+biFmr++sHWy6CFbzuOCxUxS/ovJDRVJy7nUKuPo+TKgjA+TLWdaCzkzB
         G1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCViM4ipzI60Q5Umy94Rlj38MfkFx+ZqH/D2KtcOBq18je6jcbCuZRVMQ1/cDKUohhEN3HVrqrto9hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz321BDExPSjPvGC7E+bSG4Tif8hNgVN3Ws6hEkhleKuytx9mV+
	jVSCu0lzWcA2WlVQEzeKz/5Hvv72yDkKM9syjqlGIGKOm7Vr4TGLfjuSE6CK2+295iPbKgDCfcH
	IqRs0
X-Gm-Gg: AZuq6aLyPeuQeqMsWxcgQRvA7QJzvIK91qncw48JDy9nfX9/r3cbKKQl8EnWqQIdWUz
	Zc0EcXevGzh9+qBrhf0fZYh4CmWS5ZjOi0NHXgpzxFM+2EI4aRXkoL22VqDl9e/tEEMkkR+dpZg
	ZsAPlJQcseEddW5Uv53QVRdUXMUcH/LlLMrBA7Pp5byYdqd7qbeCWUWpsf6GRVq1liTRXr/FrE4
	cdLWgkfQE+yt9WqJk+LBy15zqIBdqYlKHZN8RAs7SNt7eXbxKi8/CZbY5ztvTgjQNDRCXHtKZ8n
	1RmHq8kH2KvcHas28DO6miJrdWIaM550DvQYN4+OkBl7eKrNqnAXEXsOac3lQmWfnl/DXC5nP1h
	9khxkx9+qZryv4ioKDoxXoXqy1W5vV/+3oIff3ORlUHkHgzIx/sSL6jii4ed4fsh8k9U14rI3rG
	q004rJleUkUvdOjP2U/EVzLVakvBc0EAYbTy0BuAt2B1GyO+nesqlpQNwld7TWZjh47jJATQ==
X-Received: by 2002:a05:620a:46a9:b0:8c6:b315:1452 with SMTP id af79cd13be357-8caeeb510c0mr350205685a.7.1770384376891;
        Fri, 06 Feb 2026 05:26:16 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf81c118csm157292285a.24.2026.02.06.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:26:16 -0800 (PST)
Date: Fri, 6 Feb 2026 08:26:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v9 00/19] DCD: Add support for Dynamic Capacity Devices
 (DCD)
Message-ID: <aYXr9u1Y50MBtEP6@gourry-fedora-PF4VCD3F>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <aYEHmjmv-Z_WyrqV@gourry-fedora-PF4VCD3F>
 <698270e76775_44a22100c4@iweiny-mobl.notmuch>
 <aYNh-m8BEiOHKr9h@gourry-fedora-PF4VCD3F>
 <6983888e76bcc_58e211005e@iweiny-mobl.notmuch>
 <aYOVm6PVfmQdZvlI@gourry-fedora-PF4VCD3F>
 <20260205174847.000065a4@huawei.com>
 <20260206110130.00005fc2.alireza.sanaee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206110130.00005fc2.alireza.sanaee@huawei.com>

On Fri, Feb 06, 2026 at 11:01:30AM +0000, Alireza Sanaee wrote:
> On Thu, 5 Feb 2026 17:48:47 +0000
> Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> I think both of these approaches are OK, but looking from developers
> perspective, if someone wants a specific memory for their workload, they
> should rather get a fd and play with it in whichever way they want. NUMA may
> not give that much flexibility. As a developer it would prefer 2. Though you
> may say oh dax then? not sure!

DAX or numa-aware memfd

If you want *specific* memory (a particular HPA/DPA range), tagged dax is
probably appropriate.

If you just want any old page from a particular chunk of HPA, then
probably some kind of numa-aware memfd would be simplest (though this
may require new interfaces, since memfd is not currently numa-aware).

We might be able to make private node work specifically with membind
policy on a VMA (not on a task).  That would probably be sufficient.

~Gregory
