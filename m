Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76F34BA53
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201995; cv=none; b=lhoiiPQBcyP6haldf24Z9Wp824yBlPu+E8EUxauF0FvXqv4itruV+VfCwaaASYPDcx0M02lphQyLOsPUg0Tp2La9yScC1Vl+Sx30nL3ItRd7xSUEBvY/8xl6VtWqwrlCHNjUhYk0Th6L0hFrf+5MmCa/vfBcEqcEKVlbxMdAAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201995; c=relaxed/simple;
	bh=1omX2rC5hpD8TszoQX/iIoOUdNYlcNz3F7LNrVXmo3Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsOpI+nCh2J8x8wsP2c3lFf0132+tAapyw74dSXFkKeOetExI6lOW16dI3hwauR4JITXVM0hWEDDXWjZS1coE5N0xthmShWzZ5VKD6JC0jDJnixMIGtGSNUyCjDhBdUXUfPAWTdB8VPv5FfQ/n/wv1IQTpw/jOQOJwhLZ9tbBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFbuFGDq; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFbuFGDq"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dc6fbf3e86so1901617b3.3
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781201993; x=1781806793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ddH+eXH24NtmehhRI7L/9GO3TOPMJUuuZMHBikOY13M=;
        b=qFbuFGDqoJKOcpMZ2Ham0lBi5yKdvkYgiLMbE1efwDo2BEIvM1wR3A3TFVNE1f9LKS
         BZfVnQkqsa0Umh8RWTbY7UG6a6xHFNyCmZiVnnh/jflGZa97+AmrCyt0Yp/BcXJdQLtr
         13yiyG4NuCVN4Nbq4Yel1Q6emDLgKDArRmCkpR3hthzy3qbXmR6zmIELcgJUpCfMkmej
         fIZpDQk8Dlaw/H7icpNDrzHurBKEQz0wguVjAN5++dWphaasP641ZwMBq1OeF1VNm44a
         Q6jVGZVl2iHzD4s7xpwM9d6FxtSc3A0hyBMCStQB/XpLXFKL8q37Pn3G6mDv/bmuI+7s
         bA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201993; x=1781806793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddH+eXH24NtmehhRI7L/9GO3TOPMJUuuZMHBikOY13M=;
        b=RYrJDZ7FIEFETIZqx0JNh4EvobQqNOQ0ba1hLZ85GmHMjxyfeqiuMjjXB7P06u96wV
         doZieJa/alo1NgZLb+LIHo4gSjRYnV1IFrx/C30pSy+gxnk60RoyZJjUHwYYsQWorE1R
         JNMTIpCZXmmxUCoJUKrdf1zLNcuvoFZC9ZUUaZvnJPNSfab+8KMXUT2s7UVNvMWQKrUx
         t3Sj9qi1RoUqtQFi1Mo2yDLPXn9jW9slCvxiaO9LY+izDh0MbcYy0o6+03OEtfSPu9bE
         GhDNFgW3Jul6tXuhz6KdhHYw2SWs+paVxCmy5v5Th0FxupK4JkVPLynTUYTQ/vSw919K
         tLdA==
X-Forwarded-Encrypted: i=1; AFNElJ95bt5S/nmwQkSDEwR//KGeg+24hDCA7OaYHg5J+wzRiiDmpzCndM1ThL2coPuj6dr/U5C+8SAWL7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOK8c6PpOz8CKJeCVfyrsVZ5E7hyqxF/fWZUt52CWW5PNUuEU
	Yi5jUY+J3u0UJ33IPyx8O/6BNzrXgFGJaP23s9PNVC6GPAW7hSnp8nbU
X-Gm-Gg: Acq92OH8CqBch8owAhfSfmNrSUl2KEqFQIS1VHDAfDezgUqdyfNLvgiQFeeFDj0T7uk
	64xV95ivLad3+4XyOvTIupWxUWnceWbF7bIUPbQAlKzx49hSur3GWBbYN9kmsxf/CDQSULwbKWd
	YqcH/JHBSuTKZGMPeIQJmqZidIlai1aqyGuTSPlq17F1LOoA8tP31QvpYHNPhRPwfF6XXb7GT78
	hqz5gux6IAl8e2iZrJYqJpkiZbem4Z4V9AoSLWYe0koasyMwAVBjX1FKb3k/x/aAul5315nXK2F
	ETKgGz6+D+h1o2v6PnAts1sMnyqsF3a5iK/9i2jJhZ067wQiTlsoqey/78pPrlNgf5s/MJ3GrNQ
	eLfPXItr5dG6PhcQa0REey2lTUBrRvKgXQtoCEBg85DA2Hlz4GKt+Iq4FVa/VytZ2f18V1yvzOd
	Si2JvEf30FDgxKf4nmxZPYAuo09idXEXL9+pslqSLYTQ==
X-Received: by 2002:a05:690c:e3ef:b0:7dc:a5a8:8b8 with SMTP id 00721157ae682-7f6553fa56amr44840507b3.7.1781201992856;
        Thu, 11 Jun 2026 11:19:52 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f76e2b5564sm1275747b3.6.2026.06.11.11.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:19:52 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 11 Jun 2026 11:19:50 -0700
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
Message-ID: <air8RktfkGYm2fHp@4470NRD-ASU.ssi.samsung.com>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <7f2e4fe385415e0b77b58f4bd988bc5895557dcf.1779528761.git.anisa.su@samsung.com>
 <28a8e58d-5bf8-438e-b337-76944d67e297@intel.com>
 <aiZ6TLUwI11Yg1jh@AnisaLaptop.localdomain>
 <9c3ab868-27b7-4d33-865b-9308269f764f@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c3ab868-27b7-4d33-865b-9308269f764f@intel.com>

On Wed, Jun 10, 2026 at 09:57:35AM -0700, Dave Jiang wrote:
> 
> 
> On 6/8/26 1:16 AM, Anisa Su wrote:
> > On Thu, May 28, 2026 at 09:21:59AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 5/23/26 2:43 AM, Anisa Su wrote:
> >>> From: Ira Weiny <ira.weiny@intel.com>
> >>>
> >>> Dynamic Capacity Devices (DCD) support extent change notifications
> >>> through the event log mechanism.  The interrupt mailbox commands were
> >>> extended in CXL 3.1 to support these notifications.  Firmware can't
> >>> configure DCD events to be FW controlled but can retain control of
> >>> memory events.
> >>>
> >>> Configure DCD event log interrupts on devices supporting dynamic
> >>> capacity.  Disable DCD if interrupts are not supported.
> >>>
> >>> Care is taken to preserve the interrupt policy set by the FW if FW first
> >>> has been selected by the BIOS.
> >>>
> >>> Accept the 4-byte CXL 2.0 reply on GET Event Interrupt Policy by setting
> >>> min_out to CXL_EVENT_INT_POLICY_BASE_SIZE; pre-CXL 3.1 firmware omits
> >>> dcd_settings and would otherwise fail the size check.
> >>>
> >>> Based on an original patch by Navneet Singh.
> >>>
> >>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >>> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> >>>
> >>> ---
> >>> Changes:
> >>> [anisa: rebase]
> >>> [anisa: accept 4-byte CXL 2.0 GET reply via min_out]
> >>> [anisa: drop Reviewed-by tags now that the patch carries new changes]
> >>> ---
[snip]
> >>>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >>>  			    struct cxl_memdev_state *mds, bool irq_avail)
> >>>  {
> >>> -	struct cxl_event_interrupt_policy policy;
> >>> +	struct cxl_event_interrupt_policy policy = { 0 };
> >>> +	bool native_cxl = host_bridge->native_cxl_error;
> >>>  	int rc;
> >>>  
> >>>  	/*
> >>>  	 * When BIOS maintains CXL error reporting control, it will process
> >>>  	 * event records.  Only one agent can do so.
> >>> +	 *
> >>> +	 * If BIOS has control of events and DCD is not supported skip event
> >>> +	 * configuration.
> >>>  	 */
> >>> -	if (!host_bridge->native_cxl_error)
> >>> +	if (!native_cxl && !cxl_dcd_supported(mds))
> >>>  		return 0;
> >>>  
> >>>  	if (!irq_avail) {
> >>>  		dev_info(mds->cxlds.dev, "No interrupt support, disable event processing.\n");
> >>> +		if (cxl_dcd_supported(mds)) {
> >>> +			dev_info(mds->cxlds.dev, "DCD requires interrupts, disable DCD\n");
> >>> +			cxl_disable_dcd(mds);
> >>> +		}
> >>>  		return 0;
> >>>  	}
> >>>  
> >>> @@ -676,10 +721,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >>>  	if (rc)
> >>>  		return rc;
> >>>  
> >>> -	if (!cxl_event_validate_mem_policy(mds, &policy))
> >>> +	if (native_cxl && !cxl_event_validate_mem_policy(mds, &policy))
> >>>  		return -EBUSY;
> >>>  
> >>> -	rc = cxl_event_config_msgnums(mds, &policy);
> >>> +	rc = cxl_event_config_msgnums(mds, &policy, native_cxl);
> >>>  	if (rc)
> >>>  		return rc;
> >>>  
> >>> @@ -687,12 +732,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >>>  	if (rc)
> >>>  		return rc;
> >>>  
> >>> -	rc = cxl_event_irqsetup(mds, &policy);
> >>> +	rc = cxl_irqsetup(mds, &policy, native_cxl);
> >>>  	if (rc)
> >>>  		return rc;
> >>>  
> >>>  	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> >>
> >> Issue that was always there probably, should this check native_cxl so the BIOS owned events are not retrieved?
> >>
> >> 	if (native_cxl)
> >> 		cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> >>
> >>
> > That makes sense. Would you prefer the fix as a separate patch?
> 
> Yes please.
> 
> DJ
> 
Oops I was wrong; the issue wasn't there before. This function used to return 0
if !native_cxl at the top of the function but this patchset added
&& !cxl_dcd_supported() to the condition.

Added the fix to this commit.

Thanks,
Anisa
