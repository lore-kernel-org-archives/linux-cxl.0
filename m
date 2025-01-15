Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2711DB14C
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736982158; cv=none; b=pntPeZLwShzDjnKq5UYuZjt+0aQK+6t+7/EgY4GKCk8H8pq0W2iw+vNfuWf2ErFzlCsZr9zHKjLj+ycBbstEW7j+bdjeaWBkFeIBsqbyC8QL1OY2LTZ6wLNPwS77EV5NnHETrlE9z/VNpLBF5NCkjYYbtYWAWinYSMQiU5jmXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736982158; c=relaxed/simple;
	bh=9Y+K4LpOVgDPYUBwCgoBtlhRh6bBW1kFvanHqjOPH8Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fN1HMnDGVxob3W+XA+DPMX/ilyps1C7OYjSBk2IZrn9+vWUIB//PTOvUEx7By0ik7aU/4ipP4QNpH5dRj73sGfu/FB/E4UV1FhPap2rqeoA9VUbsfZwF3f/Bl+pR0PhBM9E3LZ679D5xRB2iULS8LQPtHSgVcF8Z9940aMRLDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLvnmI1l; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLvnmI1l"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21636268e43so4855725ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736982155; x=1737586955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9d3uYSIPYWNud+YDQsOCHfkq3IiZOUwPDKvG3lAzMk=;
        b=OLvnmI1lC6N+CGvv+uwWK4VWjDNQTIN2GMhuApMYBK8RkvYjhmfIDsz08CcxMyfm55
         IZFvt6ZvCylCgTFmRHZuqWWeZKYiHRDgyfxQrQvPy5LTePr792N8B0jjkMtJYLf61ygr
         cd3Q6oMVI6SqZ54oEYWsBUxY+JEWI1YRNOkMN+WvuSA4AUTbHc2ZmgGCdQkfZAKlXkhH
         g4kmi2a3XWt5ox/DqN9xX/RL0y1dGkKIbonA706HvZObaFrdKsH6UF7bT0fwSFY4tn4d
         rIQ7pxLgtcIArf2U6Nj/pHpWHSfUsraqNRZC5EHo/g/GyO3q+ibUNmx6HjswsP6oQcno
         N/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736982155; x=1737586955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9d3uYSIPYWNud+YDQsOCHfkq3IiZOUwPDKvG3lAzMk=;
        b=EdnBkGv3UmaeWgMUoey4ua1MVx0jn5zgIMYuRKJa9UEelxjLmdmEsvcXs5iI3H+CEG
         SgOuLHetW5iwSi809k2z0UHdi+qZj2QhuvigxteRk6KUAXPvVaNnlkqGroysLX67jJah
         abbfHQN+59GcT0ssrDq9kisRD6ELl7+ttOzB5GYyr8L1wEU5RMEHZx25MIdt2FUNZjET
         P87kFrgHYucku0k6mAOm0YTOSvnyAcgzuxXtrWMn+b3qwbgrxqQlqTqZGyeFcIQUO0+7
         iHaB2oEWoCaLI8dgik1Z31ViQEFpxSZtZxl50xZLbCKMRc+PvOZONcXGbOnojpR/rPPq
         Sktg==
X-Forwarded-Encrypted: i=1; AJvYcCWrQDUM00QZ44FUFW6MOR+qyDshEVwDpZ/lxxqr1JWxdyzKKA0r9qOmHHYj1FCZsIP6zW814ZynjhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIZ9HIcoHs2M7prrjq5WnoT/H9SFuhPKd2AQLhk0EABysZS47
	u31bz0mRX2e1vzmVOdNAlnlsRofygRPIToPQOAIR/2q8OWHRn6e9Kj8V+Q==
X-Gm-Gg: ASbGncuX+C0p8mzIa+Qf5oWivYKWttq2JMmEyX2ckkkKanAC+LtUz458yiHc/mpopC1
	pDdgorAyq4G6XHLHUengDFM5A5U8iKueIWHZ4GXtRpGvj5nPhoHBqwY43dZfncJSvad3oPzYw05
	U0eazhS/WMYwFDuAER2vr+2Jc1cu3PLYnmvm6UMd2n0oWibckt8nyekUXU+ODSINiPcp1AEa78u
	q0wCxIIsv0AfUed1tEONI6odQm4QZ/Op4BZscz5fgvannzU0x9+yl5X5p9d
X-Google-Smtp-Source: AGHT+IH3g4QHIMuDRVS0YnWIWvg4zTkwKT2DoinlYse6FjEVmTgx30vwMXAVTILqmo1vF6KJ4iR9Xw==
X-Received: by 2002:a05:6a21:4a41:b0:1e3:e836:8ad8 with SMTP id adf61e73a8af0-1e88d0ef9f6mr53073682637.38.1736982155451;
        Wed, 15 Jan 2025 15:02:35 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318130b711sm10278212a12.10.2025.01.15.15.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 15:02:34 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 15 Jan 2025 23:02:32 +0000
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Fan Ni <nifan.cxl@gmail.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"anisa.su887@gmail.com" <anisa.su887@gmail.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [ISSUE] memdev cannot be enabled after reboot due to failed
 dvsec range check [QEMU setup]
Message-ID: <Z4g-iMVj4D2sUE20@smc-140338-bm01>
References: <Z4bJdCliETI_t2DL@fan>
 <80665bcd-7d6e-4f7a-9ab4-e292486f2681@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80665bcd-7d6e-4f7a-9ab4-e292486f2681@fujitsu.com>

On Wed, Jan 15, 2025 at 01:06:24AM +0000, Zhijian Li (Fujitsu) wrote:
> Cced QEMU,
> 
> Hi Fan,
> 
> I recalled we had a reboot issue[1] months ago
> I guess your issue was caused by some registers not reset during reboot.
> 
> [1] https://lore.kernel.org/linux-cxl/20240409075846.85370-1-lizhijian@fujitsu.com/
> 
Hi Zhijian,
Thanks for the pointer. With the fix applied, the issue goes away.

Fan
> 
> On 15/01/2025 04:30, Fan Ni wrote:
> > Hi,
> > 
> > Recently, while testing cxl with qemu setup, I found the memdev cannot
> > be enabled successfully after reboot.
> > 
> > Here is the setup and the steps I have tried.
> > 
> > QEMU:
> > https://gitlab.com/qemu-project/qemu.git
> > branch: master
> > commit: 8032c78e556cd0baec111740a6c636863f9bd7c8
> > 
> > Kernel:
> > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/
> > branch: next
> > 2f84d072bdcb7d6ec66cc4d0de9f37a3dc394cd2
> > 
> > Steps to reproduce the issue.
> > 1.  start the vm with cxl pmem device attached directly to RP.
> > 2. Load the cxl drivers cxl_acpi cxl_core cxl_pci cxl_port cxl_mem, etc.
> > Everyting works expected, the memory is corrected enabled and shown with
> > cxl list.
> > 3. Reboot the VM (run reboot command inside vm, no shutdown);
> > 4. Load the cxl drivers as in step 2. the cxl pmem is not correctly enabled.
> > 
> > dmesg shows some error as below:
> > -------------------------------
> > [   17.131729] cxl_core:cxl_hdm_decode_init:443: cxl_pci 0000:0d:00.0: DVSEC Range0 denied by platform
> > [   17.135267] cxl_pci 0000:0d:00.0: Range register decodes outside platform defined CXL ranges.
> > [   17.138428] cxl_core:cxl_bus_probe:2073: cxl_port endpoint2: probe: -6
> > [   17.141104] cxl_core:devm_cxl_add_port:936: cxl_mem mem0: endpoint2 added to port1
> > [   17.143703] cxl_mem mem0: endpoint2 failed probe
> > [   17.145324] cxl_core:cxl_bus_probe:2073: cxl_mem mem0: probe: -6
> > [   17.171416] cxl_core:cxl_detach_ep:1499: cxl_mem mem0: disconnect mem0 from port1
> > ------------------------------
> > Compare the step 2 and 4 with debug info. we can see,
> > In step 2, when entry function: cxl_hdm_decode_init().
> > 
> > (gdb) p *info
> > $2 = {mem_enabled = false, ranges = 0, port = 0xffff8881097eac00, dvsec_range = {{start = 0, end = 0}, {start = 0, end = 0}}}
> > 
> > The info struct is from cxl_dvsec_rr_decode(), where if mem_enabled is
> > not enabled, it will return directly without reading dvsec range, so
> > ranges == 0.
> > This is what happened in step 2: no dvsec ranges are provided to the function for checking.
> > 
> > When init the hdm decoder in cxl_hdm_decode_init function, the memory enable bit will be set.
> > 
> > In step 4, after reboot, the enabled memory enable bit sustained and the dvsec range
> > register will be read from the device in cxl_dvsec_rr_decode.
> > So when entrying cxl_hdm_decode_init(),
> > ------------------------------------
> > $2 = {mem_enabled = true, ranges = 1, port = 0xffff888103c77400, dvsec_range = {{start = 0, end = 536870911}, {start = 0, end = 0}}}
> > Breakpoint 2 at 0xffffffffc0657bbe: file drivers/cxl/core/pci.c, line 416.
> > ------------------------------------
> > It will cause the dvsec_range_allowed() failing as the range from dvsec range
> > registers starts at address zero [0, 512], which does not match the hpa range
> > stored in cxld->hpa_range, causing the issue.
> > 
> > ------------------------------------
> > Thread 1 hit Breakpoint 4, dvsec_range_allowed (dev=0xffff888108af9848,
> >      arg=0xffffc9000059f9b0) at drivers/cxl/core/pci.c:265
> > 265		if (!(cxld->flags & CXL_DECODER_F_RAM))
> > (gdb) b 268
> > Breakpoint 5 at 0xffffffffc0657d31: file drivers/cxl/core/pci.c, line 271.
> > (gdb) p /x cxld->hpa_range
> > $5 = {start = 0xa90000000, end = 0xb8fffffff}
> > (gdb) p /x *dev_range
> > $7 = {start = 0x0, end = 0x1fffffff}
> > (gdb)
> > ------------------------------------
> > The hpa_range is set when parsing the cfmws in __cxl_parse_cfmws.
> > 
> > Any throughts?
> > 
> > Open question: do we need to update the dvsec range register after we parse the
> > cfmws to make the two above match.

-- 
Fan Ni (From gmail)
