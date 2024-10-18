Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7F1201277
	for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265782; cv=none; b=PqtEt42ajDu8Z3SwFQny0EDQ+YFpPEXA60rahVVEUD9xSFohN4k5a6OiAGv15nb8LuCoAB5Iq9zrhhfTLjxOcghF0M0MNY4xwVjFE713yIoSSphBDP5y0NghPsD7/g2MbidgiEb6k0GQu84scGN2v0wGFmmCu3YL2VCNAszE3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265782; c=relaxed/simple;
	bh=p5ymkF/bkJ0/aR/zOfrawrqMDLdHLfd/xfqCEZ9Ka3U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lni/sKqkaXSz8QQ+maabKio9hZwBzMQB0TdaCXW8oQ4/aM+KgAPzM41eYhQvU2d3k2ehR+9HRLmbRYQAeoAPDlIWAfH/Vlx9kzye2NxFcni9jfrCHUKcEbcAlc2TjpifTMjY5nMA+vExb+4/PYF1NSxoEIMRBn/FbW+D+UIMiKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLmdF4W0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLmdF4W0"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b5affde14so16102615ad.3
        for <linux-cxl@vger.kernel.org>; Fri, 18 Oct 2024 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729265780; x=1729870580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTlUoKlg4r25iHgIu+jKaR0sgzj787sAcjBNi0pT5bo=;
        b=gLmdF4W0G0recBsSsReWeMbjFxSxqB0mhs6GvQ8+/Kkg2vAiXp3OLD1hjIfYX1RAz0
         H2IS8oaIsssSORP1JERcTYdHQlzyUUzW7/aIiOPB18IZMoedJ7rRa0fjBhkUJJF2byA6
         GOPwCIJMFvCih9g94Nu3Bv1HkL381yRl+jvdSVDvnwKKRMvo2xXrs4R1o0tgtLgFLHTk
         P8exdy6gUAu3CbIL6lpka1TYtlyorgMcIH6MDA0/uqpn5wWQ0UcK9Oz3qOvstcnzd63o
         hnEdCdL+XDdXQAVXsScjAOMlPNNigCWZJFRx1jbjxgEHNzTCKXtHa2IDKNJZYWP/v9LV
         1UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729265780; x=1729870580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTlUoKlg4r25iHgIu+jKaR0sgzj787sAcjBNi0pT5bo=;
        b=tChz9T3JxX2pZK8E9jkXdiCih3lu5QvLqmIzikXwMh9VXEHF74zYdTOmTvZkV3fO+6
         S8EsGs7XaOx/kbkUWdFH2IErs5/v92zQfimNfbcp/ZFANfufm9OlHpLdJBz3kWqn7WKU
         VjejMhisPD7qHY5Gm1uGpgrZZaVE0uX/pLdMUHdBnVro5oPWDeTSImvjia0suUksb80a
         +DWVjeDAZt0npUluhGDz0pZzogGgh54UCi0pFMCjbba4UfC9klXJ4qUBg2GSI7Ed4g8t
         0xY3IBmg9wBbdqsrgJg9sD0psUn8bNnoFQQLr8j7/j5FvqUiq+koTYesJVM+20tIOghZ
         0ojg==
X-Forwarded-Encrypted: i=1; AJvYcCU/1NpcLhbxxF7Y+bHA926QndIME7SJX1e0GkHqhHTYR5MXbt6FWns9vAuvrbGld6EoG0JOpQ1Cg4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWkVIBhpG56MvjTWkG9tRd+BAQFyXmAFcXbck0KmHDxT9f412
	dNj2Y5QtXaO8l1RFvVFa6OVs99EnmKl7Ql1P9YRsTWLv/Sgiy4ZH
X-Google-Smtp-Source: AGHT+IFM9wMUoV2RnUxgeeSL5PIjuz3bCo1cgk8ZhHffUBSTBvQojN4p121NHi1hkCVWB5hXY+Y6Sw==
X-Received: by 2002:a17:902:ea0e:b0:20c:7c09:b2ac with SMTP id d9443c01a7336-20e5a93a6fdmr31900095ad.52.1729265779922;
        Fri, 18 Oct 2024 08:36:19 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:a6cf:738d:e6be:c278])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8d6768sm14052785ad.161.2024.10.18.08.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 08:36:19 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 18 Oct 2024 08:35:56 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com
Subject: Re: [QEMU RFC] hw/mem/cxl_type3: add guard to avoid event log
 overflow during a DC extent add/release request
Message-ID: <ZxKAXPGHDxlr0U9q@fan>
References: <20241011202929.11611-2-nifan.cxl@gmail.com>
 <20241014122322.00001ad4@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014122322.00001ad4@Huawei.com>

On Mon, Oct 14, 2024 at 12:23:22PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Oct 2024 13:24:50 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > One DC extent add/release request can take multiple DC extents.
> > For each extent in the request, one DC event record will be generated and
> > isnerted into the event log. All the event records for the request will be
> > grouped with the More flag (see CXL spec r3.1, Table 8-168 and 8-170).
> > If an overflow happens during the process, the yet-to-insert records will
> > get lost, leaving the device in a situation where it notifies the host
> > only part of the extents involved, and the host never surfacing the
> > extents received and waiting for the remaining extents.
> 
> Interesting corner.  For other 'events' an overflow is natural because
> they can be out of the control of the device. This artificial limit
> was to trigger the overflow handling in those cases. For this one I'd expect
> the device to push back on the fabric management commands, or handle the
> event log filling so overflow doesn't happen.
> 
> > 
> > Add a check in qmp_cxl_process_dynamic_capacity_prescriptive and ensure
> > the event log does not overflow during the process.
> > 
> > Currently we check the number of extents involved with the event
> > overflow threshold, do we need to tight the check and compare with
> > the remaining spot available in the event log?
> 
> Yes. I think we need to prevent other outstanding events causing us trouble.
> 
> Is it useful to support the case where we have more than one
> group of extents outstanding?  If not we could simply fail the add whenever
> that happens.  Maybe that is a reasonable stop gap until we have a reason
> to care about that case. We probably care when we have FM-API hooked up
> to this and want to test more advanced fabric management stuff, or poke
> a corner of the kernel code perhaps?
As long as the last record with More flag cleared put in the log, the
kernel is able to handle it and clear the log after finishing
processing. The only issue I can see now is the last event cannot be
inserted into the log due to overflow, so i think as long as we have
enough space to hold all the records of a request in the log, it would
be enough, no matter the log already has some outstanding extents or
not.
> 
> I guess from a 'would it be right if a device did this' the answer may be
> yes, but that doesn't mean Linux is going to support such a device
> (at least not until we know they really exist).  Ira, what do you think
> about this corner case?  Maybe detect and scream if we aren't already?

Any thought, Ira?

Fan
> 
> Jonathan
> 
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-events.c         | 2 --
> >  hw/mem/cxl_type3.c          | 7 +++++++
> >  include/hw/cxl/cxl_events.h | 3 +++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > index 12dee2e467..05d8aae627 100644
> > --- a/hw/cxl/cxl-events.c
> > +++ b/hw/cxl/cxl-events.c
> > @@ -16,8 +16,6 @@
> >  #include "hw/cxl/cxl.h"
> >  #include "hw/cxl/cxl_events.h"
> >  
> > -/* Artificial limit on the number of events a log can hold */
> > -#define CXL_TEST_EVENT_OVERFLOW 8
> >  
> >  static void reset_overflow(CXLEventLog *log)
> >  {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 3d7289fa84..32668df365 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -2015,6 +2015,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> >          num_extents++;
> >      }
> >  
> > +    if (num_extents > CXL_TEST_EVENT_OVERFLOW) {
> > +        error_setg(errp,
> > +                   "at most %d extents allowed in one add/release request",
> > +                   CXL_TEST_EVENT_OVERFLOW);
> > +       return;
> > +    }
> > +
> >      /* Create extent list for event being passed to host */
> >      i = 0;
> >      list = records;
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index 38cadaa0f3..2a6b57e3e6 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -12,6 +12,9 @@
> >  
> >  #include "qemu/uuid.h"
> >  
> > +/* Artificial limit on the number of events a log can hold */
> > +#define CXL_TEST_EVENT_OVERFLOW 8
> > +
> >  /*
> >   * CXL r3.1 section 8.2.9.2.2: Get Event Records (Opcode 0100h); Table 8-52
> >   *
> 

-- 
Fan Ni
