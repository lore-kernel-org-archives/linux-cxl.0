Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21616C6A5
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978750; cv=none; b=lCdjoQTTa4Rhfo1cNw6CfpC9p6M9XUFseOzSTsiO1I5Bpcv0imKpEX8FPUKTFAVwPPsUtiyEZPkzhffcfDPraXjAc//d7pCH3zrFsL3hVHSGvUiOATN/5qjvAJuJBbVFLXhVTFswacVu01xzb+OAouzb/fSeWNLnQ64CnmI418c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978750; c=relaxed/simple;
	bh=5pCFDMelHsl1xqk9VX7yfcEzZcykVDUn+tPFvqtQGIg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1YvAITwLPBMDVo/ibNnFTQ3d/pSAadLDhqHcan1q0UHL8qAISlpxS83M9jc/vzW2AvluSW9/rxFNksrmZ/QD14+GzLTngAOIm3IINh0SqBPekR8cOTMU/QcmhOH9qYzVqs3oh4wn/ptiuc7pCyer/dGhm3fpuOPN/aHcRM/XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3qMJjTo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3qMJjTo"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so143993b3a.1
        for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713978749; x=1714583549; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PJx7B4fgRPYu09r5fjNBdBPXGt14luISrtxZ4rM/dAA=;
        b=H3qMJjTo57+iY/CkbKfxkG0W6Qz1e48syDwIKk7D8D3p/MOxW46WMgw6du6IlCLPSe
         6qlNAmDNSVmmVskpmhJaosS/v2jV+qM5n3BPxI/FNwsMYszxdyZGR0BD9zKP7Wo9YHPm
         qQnBW5Lu4hO3pS3ysJu5CEZbwppIIrIInzeqWeZb5C9UIPVIAU0JnlbZfoTy5vs21qJN
         FJbgDpzR4U2OCBVFibtZR0DMTWGG7XqDMK4Dp2ewTKn4Y9HV/Y7NZhWJjYeKwQgltPtA
         15H6yi98tIhYa1ZwfCPxUxCaVXni33JTHWYwfHRfXEJ9hIsrLfz8jvp+j8J85uQL40KO
         /JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713978749; x=1714583549;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJx7B4fgRPYu09r5fjNBdBPXGt14luISrtxZ4rM/dAA=;
        b=IltZ3lFTEVtOrqAa+ALtkGc+T5tZPV7W8kvKDkqLiRaMoydyuMCzMVbBm5ppHHkHsV
         SUqrynLuBSEkKuk/I5STRTHPCFf/b8Leqs+L/o9XaBX3b7sOVQMUH8TQPY7RYfgFWlv+
         fbmv65B/dDAvdNL8xyhCs6w4ETUEqo62e5Epfi4eaQSNb5Bqg32auOvmpz3sGv/ED8gg
         UOcWu+EsOxisbzNHkEVri+XAggqDQlhOXld9AKPp7k6VxMS4GGHFASUv8oC+0YxJzami
         e3Ey18WKW2e5jgxtZ9XqgVy9DaLHX6EQQHFQJmRq4OjDLbnYJHvNz78Q8SZthxr0biLd
         aQ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWebOXCJ6WED4EXww0p4PHz/XtCwy7XXP34LMRTphAi9ZOX7XemAjcZI6wBV+1H9FQnDoO7tj4UWTh2cu8EVO83vtXW+FwVF4al
X-Gm-Message-State: AOJu0YxhWnSrJHF9Kh+fSXY+fzAuDF7TvgpirAc7tTqS8nEhze/3ng2F
	AzD9pWs2cuvGyWOtG0yp6xRnJ50jfwdvR1c3tqBTZcSkCfgI8BPh
X-Google-Smtp-Source: AGHT+IEIE1XN1WJXhjD/39WDyRmROHsSznUnr2Qdm0ZdIYmjrfNZpwKAz0Ik5fOx2a0ZGv6qGRjxCw==
X-Received: by 2002:a05:6a20:244d:b0:1a9:11e4:72b6 with SMTP id t13-20020a056a20244d00b001a911e472b6mr4112692pzc.57.1713978748469;
        Wed, 24 Apr 2024 10:12:28 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b318:9476:706a:e82a])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d30100b001e451abffebsm12157336plc.86.2024.04.24.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:12:28 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Apr 2024 10:12:23 -0700
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	fan <nifan.cxl@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	gregory.price@memverge.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <Zik9dxGopfrifCzU@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
 <20240305160908.000010c5@Huawei.com>
 <ZedFIp5gK4aXsqD-@redhat.com>
 <ZedRsZee2WhTi_Nd@debian>
 <ZedTEa8aktb-kKwt@redhat.com>
 <8734ravr99.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734ravr99.fsf@pond.sub.org>

On Wed, Apr 24, 2024 at 03:12:34PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Mar 05, 2024 at 09:09:05AM -0800, fan wrote:
> >> On Tue, Mar 05, 2024 at 04:15:30PM +0000, Daniel P. Berrangé wrote:
> >> > On Tue, Mar 05, 2024 at 04:09:08PM +0000, Jonathan Cameron via wrote:
> >> > > On Mon,  4 Mar 2024 11:34:08 -0800
> >> > > nifan.cxl@gmail.com wrote:
> >> > > 
> >> > > > From: Fan Ni <fan.ni@samsung.com>
> >> > > > 
> >> > > > With the change, we add the following two QMP interfaces to print out
> >> > > > extents information in the device,
> >> > > > 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
> >> > > >    the device;
> >> > > > 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
> >> > > >    DC extents in the device;
> >> > > > The output is appended to a file passed to the command and by default
> >> > > > it is /tmp/dc-extent.txt.
> >> > > Hi Fan,
> >> > > 
> >> > > Is there precedence for this sort of logging to a file from a qmp
> >> > > command?  I can see something like this being useful.
> >> > 
> >> > This is pretty unusual.
> >> 
> >> Yeah. I cannot find anything similar in existing code, my initial plan
> >> was to print out to the screen directly, however, cannot find out how to
> >> do it nicely, so decided to go with a file. 
> >> 
> >> Is there a reason why we do not want to go with this approach?
> >> 
> >> > 
> >> > For runtime debugging information our strong preference is to integrate
> >> > 'trace' probes throughout the code:
> >> > 
> >> >   https://www.qemu.org/docs/master/devel/tracing.html#tracing
> >> 
> >> I am not familiar with the trace mechanism. However, I think the
> >> approach in this patch may be useful not only for debugging purpose.
> >> Although not tried yet, maybe we can also use the approach to set
> >> some parameters at runtime like what procfs does?
> >
> > Please don't invent something new unless you can show why QEMU's existing
> > tracing system isn't sufficiently good for the problem. QEMU's tracing
> > can dump to the terminal directly, or integrate with a variety of other
> > backends, and data can be turned off/on at runtime per-trace point.
> 
> Seconded.
> 

Thanks. 
This patch is removed from the latest version (v7):
https://lore.kernel.org/linux-cxl/ZiaFYUB6FC9NR7W4@memverge.com/T/#t

Fan
