Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158DF3A2E36
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906578; cv=none; b=kmMOgB5R06CzLtgHyWfz4aIPvEG0MkQAE7mZql9QBxcBSVjog5qOIcOx6PxDlCBgGKoOX6o/seUO8VFedzUP7Nwfd0ipB+TVv6uUmFPAlIMpgOuNidrdsvSiNTPjMEajXHkntlFkV9qIWgO08bdxeG8FUac+Mels06+x05sLq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906578; c=relaxed/simple;
	bh=2vKaBxTvz9jzeINMZsZsLZHSkx1hCtUNqNqQFAN63mo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oivrENk+omZlXDpUDkb05HBk28PjtJMC+lqLHHfdU/6Ytmx1yc9nLhZPLRcKLKNGaRzTi0hVo23pnPLg99gG9h1X0Yr9vqcAmigBLNAAZgRQ3R3o2LN5/emiRY+roOes+mS+fhDfksI66g7nXSZU/6BIPtK1sxfn2EgsJ7DCosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV7qXoCw; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV7qXoCw"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3074adb8fcaso6287147eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 08 Jun 2026 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780906575; x=1781511375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OsPExAFKo3RFUEYD1/zQ0f2f7dBwpkCxxAcFxkQBUYM=;
        b=lV7qXoCwbr93c16ZnhZwnfJa+g3MbBsWqDKtyN/heUI9KEOf17nF57elDmWsWJUgvm
         Xa6MHZwds7gjX3GWJV3X6++J+q35+ns3THvVo8s/Mte2Pw8Q0cRuKWX3AgUS4R9krTze
         aZ0FU7cWPC21IYqaa01N7NM4/qTqSRFYg1+sF3HZ6AKdwKk64/Qo0E2FutvNarpQiGSD
         wknemUFXom8uO5NqXDEN1F8WfP9qGf1/sUUQqJNZeqftCechc6CXdqHICqPHe4YR0csL
         Get0WzNgBWDPTa1HX9Jr6k1jMtMauv5izVMIfWUjS0q0uF9oLQ6OiFLQc5g77USTwCJl
         2nMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906575; x=1781511375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsPExAFKo3RFUEYD1/zQ0f2f7dBwpkCxxAcFxkQBUYM=;
        b=iOhMTXtrWgQDhaM1cFJ810AhT1gEQ0wFMt0NKtnxNdTvzw8Icy532Wuf7SsRLWi8Ri
         gPkJ+v7tho6h6s6Zfc2s+39nW/numoeKn7CUadBgqJ/i67dl+sptiDFB4ROCUGKTb4SS
         la9Ylqx0JYPQMvb7qv8so6c7OfNRvbNLs7wU85F3yW71vNyww3doY4io/sdRJQCpjnfK
         1EluWMvvFueqvGr2GStYqvcUatnjBf4iviltKcE4GMofLxzjpmmSoKA9qKMWZAdN7t/r
         B+49pjEGIYySXY+J17J/vaXTg0T9yIOkRLY96YWfyPP+dRkmH7i2VkJYHL4ShOmCJ49X
         Pz5g==
X-Forwarded-Encrypted: i=1; AFNElJ9QJFvGc0M/hzJZrc5kIHLpci/XYGLt7xphOl3r3p5b2dsduhMMHDOSSeWMOOfXIbTid8XP+P+lFts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MgISsGys5q5FzCb28GKx4WcDGTBzSW1pNUVWHrNPPJ0p7ibk
	kyn4l9qn+I5bFMFc9tyvO3sZSGQBrDA9FqEv/ZaD8kv21ELCWC3T2OtHdNLSww==
X-Gm-Gg: Acq92OFUXpihLni0UWo2S52DyRAVccMpe5rl7qD5/97PZWweK2s6AzXPZPru4Z6lZ5x
	iBhne+mF/iIlO7m6gl6/6/hfF5aJJB1oJ6t0h8zX0YrIGY6+D+0VVdC/eKVTOMrvl8vXFykALLr
	VwoNSyEjP8slWvssZ+DAP0J50CLLG6TJyid9sL/4ThyHIRRWoYV2+cE6No4QkoL82SagFOAo7iv
	e/e+exQ3HJW32RPSFEZo8QRkXOs75r+paS1DXKHTiGfsqpnWaAHwohztmlQXbLc7J+GMNDWhVqQ
	0KQH4tLDLgYnicB7wXBjvW2lNsPUcMc8ogkhp4ZWoHDfXRfP+QJPuQXKmoZbCatAC5zawGxpOdl
	bvFUuHR9aOboPWD5T3IXjs/lv1Gc/wJ78mP/MhRCyn7HdHqMtIY2bZWIkT3DomsjcmWNDUUgn1f
	3ooPAXhq3WbpU2eWQrTowAEQcKrob8c+g2gptvvJ30OA1AEMl7d9HXvwCfMiFHsRfPMoiYoXGRt
	Xo7cCdbQnargZZLZYljSR+yh9+b
X-Received: by 2002:a05:7301:9bca:b0:2ee:ade0:e0bf with SMTP id 5a478bee46e88-3077b311132mr6994119eec.30.1780906575005;
        Mon, 08 Jun 2026 01:16:15 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dea8e8csm16061190eec.16.2026.06.08.01.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:16:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 8 Jun 2026 01:16:12 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 10/31] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <aiZ6TLUwI11Yg1jh@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <7f2e4fe385415e0b77b58f4bd988bc5895557dcf.1779528761.git.anisa.su@samsung.com>
 <28a8e58d-5bf8-438e-b337-76944d67e297@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28a8e58d-5bf8-438e-b337-76944d67e297@intel.com>

On Thu, May 28, 2026 at 09:21:59AM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Dynamic Capacity Devices (DCD) support extent change notifications
> > through the event log mechanism.  The interrupt mailbox commands were
> > extended in CXL 3.1 to support these notifications.  Firmware can't
> > configure DCD events to be FW controlled but can retain control of
> > memory events.
> > 
> > Configure DCD event log interrupts on devices supporting dynamic
> > capacity.  Disable DCD if interrupts are not supported.
> > 
> > Care is taken to preserve the interrupt policy set by the FW if FW first
> > has been selected by the BIOS.
> > 
> > Accept the 4-byte CXL 2.0 reply on GET Event Interrupt Policy by setting
> > min_out to CXL_EVENT_INT_POLICY_BASE_SIZE; pre-CXL 3.1 firmware omits
> > dcd_settings and would otherwise fail the size check.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > ---
> > Changes:
> > [anisa: rebase]
> > [anisa: accept 4-byte CXL 2.0 GET reply via min_out]
> > [anisa: drop Reviewed-by tags now that the patch carries new changes]
> > ---
> >  drivers/cxl/cxlmem.h |  2 ++
> >  drivers/cxl/pci.c    | 75 ++++++++++++++++++++++++++++++++++++--------
> >  2 files changed, 64 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 10175ca3b7ee..65c009b02da6 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -218,7 +218,9 @@ struct cxl_event_interrupt_policy {
> >  	u8 warn_settings;
> >  	u8 failure_settings;
> >  	u8 fatal_settings;
> > +	u8 dcd_settings;
> >  } __packed;
> > +#define CXL_EVENT_INT_POLICY_BASE_SIZE 4 /* info, warn, failure, fatal */
> >  
> >  /**
> >   * struct cxl_event_state - Event log driver state
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 8d12c684d670..83617439bbd3 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -557,6 +557,8 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> >  		.opcode = CXL_MBOX_OP_GET_EVT_INT_POLICY,
> >  		.payload_out = policy,
> >  		.size_out = sizeof(*policy),
> > +		/* CXL 2.0 firmware omits dcd_settings; accept the shorter reply */
> > +		.min_out = CXL_EVENT_INT_POLICY_BASE_SIZE,
> >  	};
> >  	int rc;
> >  
> > @@ -569,23 +571,34 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> >  }
> >  
> >  static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
> > -				    struct cxl_event_interrupt_policy *policy)
> > +				    struct cxl_event_interrupt_policy *policy,
> > +				    bool native_cxl)
> >  {
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > +	size_t size_in = CXL_EVENT_INT_POLICY_BASE_SIZE;
> >  	struct cxl_mbox_cmd mbox_cmd;
> >  	int rc;
> >  
> > -	*policy = (struct cxl_event_interrupt_policy) {
> > -		.info_settings = CXL_INT_MSI_MSIX,
> > -		.warn_settings = CXL_INT_MSI_MSIX,
> > -		.failure_settings = CXL_INT_MSI_MSIX,
> > -		.fatal_settings = CXL_INT_MSI_MSIX,
> > -	};
> > +	/* memory event policy is left if FW has control */
> > +	if (native_cxl) {
> > +		*policy = (struct cxl_event_interrupt_policy) {
> > +			.info_settings = CXL_INT_MSI_MSIX,
> > +			.warn_settings = CXL_INT_MSI_MSIX,
> > +			.failure_settings = CXL_INT_MSI_MSIX,
> > +			.fatal_settings = CXL_INT_MSI_MSIX,
> > +			.dcd_settings = 0,
> > +		};
> > +	}
> > +
> > +	if (cxl_dcd_supported(mds)) {
> > +		policy->dcd_settings = CXL_INT_MSI_MSIX;
> > +		size_in += sizeof(policy->dcd_settings);
> > +	}
> >  
> >  	mbox_cmd = (struct cxl_mbox_cmd) {
> >  		.opcode = CXL_MBOX_OP_SET_EVT_INT_POLICY,
> >  		.payload_in = policy,
> > -		.size_in = sizeof(*policy),
> > +		.size_in = size_in,
> >  	};
> >  
> >  	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > @@ -632,6 +645,30 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
> >  	return 0;
> >  }
> >  
> > +static int cxl_irqsetup(struct cxl_memdev_state *mds,
> > +			struct cxl_event_interrupt_policy *policy,
> > +			bool native_cxl)
> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	int rc;
> > +
> > +	if (native_cxl) {
> > +		rc = cxl_event_irqsetup(mds, policy);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	if (cxl_dcd_supported(mds)) {
> > +		rc = cxl_event_req_irq(cxlds, policy->dcd_settings);
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Failed to get interrupt for DCD event log\n");
> > +			cxl_disable_dcd(mds);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static bool cxl_event_int_is_fw(u8 setting)
> >  {
> >  	u8 mode = FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting);
> > @@ -657,18 +694,26 @@ static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
> >  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  			    struct cxl_memdev_state *mds, bool irq_avail)
> >  {
> > -	struct cxl_event_interrupt_policy policy;
> > +	struct cxl_event_interrupt_policy policy = { 0 };
> > +	bool native_cxl = host_bridge->native_cxl_error;
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
> > @@ -676,10 +721,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	if (!cxl_event_validate_mem_policy(mds, &policy))
> > +	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
> >  		return -EBUSY;
> >  
> > -	rc = cxl_event_config_msgnums(mds, &policy);
> > +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
> >  	if (rc)
> >  		return rc;
> >  
> > @@ -687,12 +732,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (rc)
> >  		return rc;
> >  
> > -	rc = cxl_event_irqsetup(mds, &policy);
> > +	rc = cxl_irqsetup(mds, &policy, native_cxl);
> >  	if (rc)
> >  		return rc;
> >  
> >  	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> 
> Issue that was always there probably, should this check native_cxl so the BIOS owned events are not retrieved?
> 
> 	if (native_cxl)
> 		cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> 
> 
That makes sense. Would you prefer the fix as a separate patch?

> Also, CXLDEV_EVENT_STATUS_ALL is missing bit 4 (Dynamic Capcity Event Log). CXL r4.0 8.2.9.3.1 Table 8-203.
> 
It was added in a later commit, but yeah it makes more sense to have it
in this one. Moved to this commit.
> 
> DJ
> 
Thanks,
Anisa
> 
> >  
> > +	dev_dbg(mds->cxlds.dev, "Event config : %s DCD %s\n",
> > +		native_cxl ? "OS" : "BIOS",
> > +		cxl_dcd_supported(mds) ? "supported" : "not supported");
> > +
> >  	return 0;
> >  }
> >  
> 
