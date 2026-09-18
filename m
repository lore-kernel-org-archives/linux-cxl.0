Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28E32B121
	for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789774744; cv=none; b=RHtLFjnDG8GmAvFDzXK39RWd2q/bheevyjLRkD0OcABo2AONN+hbnQcMbC6QzGFJMSuv8Jqeq+J40W99lrnaufQmDGGTFHLDn6ThsOQqMTc0kAgyGwJVmmKaXDo0EMolvYQjmwES18tG42knGIPIp/FUm0WB9Jrq+2KEXr/fJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789774744; c=relaxed/simple;
	bh=+GbvnoXlY6z0/CWeAbuTV9SRZnV1I/IG5We8XpcaB5Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmBAE0isPfMhr/bJfwbVyBFMgv5XJSYro1GieJwgN7OFARpBJnS+LGaXR4rera5+oUwmY3BlIrJ1i9i1NZ1+HRLq5dPIoI4iTnflryeu94R4hUd+Istb5eLVr1tCN4BVYJNuLdxvyf6/q8H7iRVRNoXNHPtOM6tyVCl3LKtCpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrDk7CEZ; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrDk7CEZ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aa8d882so1528032d50.0
        for <linux-cxl@vger.kernel.org>; Fri, 18 Sep 2026 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789774742; x=1790379542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGEupli9b96SIb011q5IBfF/vCVL9Kbgj58l6jXVGLc=;
        b=HrDk7CEZj4jEN8yNhLcaCVHkrgfnpoaxNsK2upnx3R4QxAl8vxGyR3Xfelrr2vKZqq
         063sQ8kYHj9gC0kOSnk4ipzlXd8DjaEVWgiV+OD/+IMNUxU9z99lMClW8RMmmA282wNF
         kmQ7IAKkHS+BjqQ0fJ2ItHhdjDNrNvU4mlbiIT5gteGWBPS8TDlvnoaWiHNZmqcWuCfz
         53r+KfCTa8dVI2knvKkG2eVDWBFnxPBRYMDO7ybebZAbJ4IVnjIzTXT24lygiwrutMpY
         uJVvWgcRT9o0zbtjyByp/sdxAYX5UqfVr62PDQWkcbON3leNo9qAdNdyCbSitHSOdZ7W
         6X7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789774742; x=1790379542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZGEupli9b96SIb011q5IBfF/vCVL9Kbgj58l6jXVGLc=;
        b=oWOCGY+z/MXU4Xaw9Zd+r4Xl1ZmIkvCBR6GN2wIZZ94wzoxO5WdQaLqPFWX7m+aKQO
         thZlk/nNRA7uRxdyK0vmmL9AR4dJQARLi4lDMJrYqqaEKh4XLCN5aieWlPv5oWHyWfJx
         DgdvJwgkY2NLkGwIKEawdUjDAMfIYEoaB6Ma39YEqROgLimd5Q7hWmSBlqCYFKLVmH0F
         sIuEQbS6ytLSHgxUE5ovvy1fY5axoWG/X3fsfVcX9j+eoPQzmu4b0CXjLS0rPkxBjBu3
         ajTvwFJJOYYuP3wUkrQiccVNGVDWTcNln5yCHuWt5pHKlXp6zZmcY3ZMNCElMf9f/pwR
         74GQ==
X-Forwarded-Encrypted: i=1; AKwUvBziq+W19ev2llA4/4qP9pVQWz/NSTGmglXHUx+vXZAvsyR/nn/nU8zzwLXYcFVrEbGO+59z411eW0w=@vger.kernel.org
X-Gm-Message-State: AFuF++lmgfMigzzw+UKyjpsfAaaic1U8Sg+lvZOuZzwwp958uVNV6ti0
	xDi9ZOPt91vRM7aFl4S1tVxHu2IugQ2kKKsrICon+pfSdwnUbUQpgDvG
X-Gm-Gg: AYBFou1lat+/v5/Tnt2lOlkvB4gOCpTrMxg7T/90cMpCXxk2biRvfOIX8fvf+hnZ04f
	c+qnLGGH/80GSm3OPxQWyyIJ/WH2jhwuJuYvmxTHoqkcy2vuWMHfA0Kh7IezCzT+KfoDiPIvxex
	VB1jKKK/tqwxtWtStn4LuDBp9PS7/2pisegQG0OzvTw+F+5FYoYn5bVfAKHSmzHrMqq8VSMhDaV
	JCfW6zZc+6Cv7IVSk7PuYj6KdzC/Kao6x3/0/3l9IICE5CzhZXXu05+XvTSXIXuSl/rLqgnhRdp
	Ss/NDVtBssCIjxzz+wGE7+i9CLOrm0UX2QAPKbAaMcZTwBXYcPobALdZiPUPFU/hleiNm2vpECi
	Pv+GU9FYClbq+U60voLsMMQEU32BPXLjNyOK8HynI2A6XX9qEuUdiZhVVkJRf02PP/fsLj10Gi2
	E0APQWGQzznXIrqsMhQf6zU0wBEDIb/T+eO1V+MnXbWZV6NGv8iJkiTTIiqQyOAoNu6m11hJfYl
	b2rLzGg7wxg4lm8aBBdrC7QFCTTBBVjzdGroj2svkXFM00Hs2A8ofXYtT0N
X-Received: by 2002:a05:690e:130e:b0:671:23de:14d9 with SMTP id 956f58d0204a3-6717fcacb69mr1447072d50.31.1789774741774;
        Fri, 18 Sep 2026 16:39:01 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67299071d4dsm593207d50.4.2026.09.18.16.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 16:39:01 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 18 Sep 2026 16:38:59 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <aq3LkzNk5zOjn-5U@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
 <20260918204302.F17761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918204302.F17761F000FF@smtp.kernel.org>

On Fri, Sep 18, 2026 at 08:43:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl: probe fails on non-native CXL systems if DCD event config fails
> --
> 
> commit 7a8483673c7e3c3849faf44e013fead5e793c1b6
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Configure dynamic capacity interrupts
> 
> Configure DCD event log interrupts on devices supporting dynamic capacity.
> Disable DCD if interrupts are not supported. Care is taken to preserve the
> interrupt policy set by the FW if FW first has been selected by the BIOS.
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 7b754af2168d0..fee3a704b73ba 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> 
> [ ... ]
> 
> > @@ -651,32 +707,57 @@ static bool cxl_event_fw_owns_mem_logs(struct cxl_event_interrupt_policy *policy
> >  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  			    struct cxl_memdev_state *mds, bool irq_avail)
> >  {
> > -	struct cxl_event_interrupt_policy policy;
> > +	struct cxl_event_interrupt_policy policy = { 0 };
> > +	bool native_cxl = host_bridge->native_cxl_error;
> > +	size_t policy_size;
> > +	u32 mask;
> >  	int rc;
> >  
> >  	/*
> >  	 * When BIOS maintains CXL error reporting control, it will process
> >  	 * event records.  Only one agent can do so.
> > +	 *
> > +	 * If BIOS has control of events and DCD is not supported skip event
> > +	 * configuration.
> >  	 */
> > -	if (!host_bridge->native_cxl_error)
> > +	if (!native_cxl && !cxl_dcd_supported(mds))
> >  		return 0;
> >  
> >  	if (!irq_avail) {
> >  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> > +		if (cxl_dcd_supported(mds)) {
> > +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> > +			cxl_disable_dcd(mds);
> > +		}
> >  		return 0;
> >  	}
> >  
> > -	rc = cxl_event_get_int_policy(mds, &policy);
> > +	rc = cxl_event_get_int_policy(mds, &policy, &policy_size);
> >  	if (rc)
> >  		return rc;
> 
> [Severity: High]
> If native_cxl is false and cxl_dcd_supported(mds) is true, does this early
> return abort the entire device probe instead of gracefully degrading?
> 
> If the firmware rejects the mailbox command, it looks like this will propagate
> the error and fail the probe instead of calling cxl_disable_dcd(mds) and
> returning 0 like before.
>
Mailbox errors in other spots already fail probe (Identify, Get Partition Info,
Set Timestamp, etc.).

Also the other places where we disable DCD and move on are for scenarios where the
device is otherwise healthy but missing the DCD IRQ capability (we couldn't get
the IRQ vector for DCD, the interrupt policy doesn't hold the DCD bit, etc.). A
mailbox error isn't the same and maybe better to just fail fast here.

But I'm not against changing this part to turn off DCD and let probe
continue either. Just lazy...

> >  
> > -	if (cxl_event_fw_owns_mem_logs(&policy)) {
> > +	/*
> > +	 * dcd_settings cannot be sent to a device whose policy is too short
> > +	 * to hold it, so the device would never accept the setting
> > +	 * cxl_irqsetup() arms the DCD interrupt with.
> > +	 */
> > +	if (cxl_dcd_supported(mds) && policy_size < sizeof(policy)) {
> > +		dev_warn(mds->cxlds.dev,
> > +			 "DCD supported but interrupt policy is only %zu bytes\n",
> > +			 policy_size);
> > +		cxl_disable_dcd(mds);
> > +		/* DCD was the only reason to be here */
> > +		if (!native_cxl)
> > +			return 0;
> > +	}
> > +
> > +	if (native_cxl && cxl_event_fw_owns_mem_logs(&policy)) {
> >  		dev_err(mds->cxlds.dev,
> >  			"FW still in control of Event Logs despite _OSC settings\n");
> >  		return -EBUSY;
> >  	}
> >  
> > -	rc = cxl_event_config_msgnums(mds, &policy);
> > +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl, policy_size);
> >  	if (rc)
> >  		return rc;
> 
> [Severity: High]
> Similarly here, if the SET command fails on a non-native CXL system, does
> this propagate the error and abort the probe?
> 
> Should it also disable DCD and return 0 in that scenario?
> 
Same as above for Get.
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918203049.7273-1-anisa.su@samsung.com?part=6
