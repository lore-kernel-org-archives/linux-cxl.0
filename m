Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD291DCB26
	for <linux-cxl@vger.kernel.org>; Wed,  4 Sep 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468643; cv=none; b=AKGpBUyits3axpWZx3U0Xf1tky8QC9jk/bU9cF1ai/J5niN1RBtGW3yP1Hxr0+pqdQ8qjYzlBSg9tbJFnWq7YgV/FbB1GoeN/Z4pG5NnqSIIiEN7QDIitz6vmkr4jPLthT7KrE6mK/053zFW+oi5obrs3CJW2JM+AeSGN9Se4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468643; c=relaxed/simple;
	bh=FOcg7xMxnAIFCv17uHXmaVa2pqL9tYIIyqUMroFAEBc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3UGGSOZRf8i4hxqMqyMMRztFYpsfpE6Y5nT5xokqset1mJzUf7p5qjtE++7DuPw2gJFdcv3WCEWO9zwLSK87i60caUf8tQd2y3ZAGwIeEekz78wyi1ZYT6B+X7VOKA3tbtUMhwyN3TQ693+kE7z5xOwcpQf4njsvWKJXIlbQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBHAhBhO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBHAhBhO"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6d5a4615a56so10025667b3.0
        for <linux-cxl@vger.kernel.org>; Wed, 04 Sep 2024 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725468641; x=1726073441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HU7OztcxC4dGOh1jD0or8NoLTJ47z4j1W9gRHRA+RV4=;
        b=BBHAhBhObAAzKhTxNTDP5vU7mbe9unQzmpJUYBCusqT9LhlX1tWT9NUt7Bj6hvgV7u
         44dAjCwK62vdEPLu7ayDukzc8wx1QnTpCftwP7pxPBLQJfkO4B+SLMqO06ZS1cR2AbNn
         DbvH0VgQOO8R3HfbpO1h9lz7HtKwLxidN5SnpnySm7MbBMkDztCb40MuFr+iWSK+9/Hk
         HpfPGwrrgpqOZtdW98n1iNpP5VdHgg406i0nKUgEqA/VfpqVHEMl+pNcaNVoGE4ysjD3
         8TZurpB4yJ+MRrXpPY82P7Rb4S1hZIHlyE0gChEV0iZyIC4P7FpUkHHUyvQurtuM57qb
         gArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468641; x=1726073441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HU7OztcxC4dGOh1jD0or8NoLTJ47z4j1W9gRHRA+RV4=;
        b=B0d1Zyj7mN230cTERA1CZf0ej1MhKB0R/bcoTDIhZTte7GldGfUewqdlf5oMK4Ac4s
         7AdjMUAgtaqjPpZBQeKOz3Yk4/G8SHCQNOgYm7VDun1stYXYI4FCpJuh+ym6KGpCIUTp
         w82OA7Gr4BNU9Qav1L4i8lwEN9d/Y0SpUg0yGj0YB0PjRk5gEzF5cs8JXKmNnOio7dag
         gzB7OWOJwjHBcDBrgIGI0QB4Ws4QXdDWMCB+qcgxKBf1R/KEw5F4N3flfO76gRreI4LL
         yP/TuzRl7riC54u0ileD7Tlf4REEeXLdkT48A6JKjAs+S45MMtOD6YRB9jwoz9l35gHd
         qsDg==
X-Forwarded-Encrypted: i=1; AJvYcCW9blgOJ/9eV3Svdy0FcZ03V/JEcMgKt3a2a7v0WDkc6aur+HI2Y+NGacFRgfflPqqMCwoPj6eegYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIgn8ego3GkrYM1IR2/GQqCsiRZofpxJrZ5bFaKHPRhk0kNYv
	mGeHxL/WmchTji2jxqqk3r5SVtbxJPCTf9RedggzD4MJzbqqk1cp
X-Google-Smtp-Source: AGHT+IHuJimfGTXEpdqlFDSiMK+DYE/CcnQ1wPzFxlkDDkQ6qmhmI6vJl7XI3nPcT888+1D4k/M/7A==
X-Received: by 2002:a05:690c:82:b0:6b0:3303:803b with SMTP id 00721157ae682-6db236c88f4mr41479387b3.23.1725468641082;
        Wed, 04 Sep 2024 09:50:41 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d5a267d5basm16086937b3.15.2024.09.04.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:50:40 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 4 Sep 2024 09:50:15 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, nifan.cxl@gmail.com,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for
 dynamic capacity events grouped via More flag
Message-ID: <ZtiPxyDYatbP8p98@fan>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
 <20240827164304.88876-3-nifan.cxl@gmail.com>
 <20240828123919.00005b5f@Huawei.com>
 <66d88ccd15efb_1e915829439@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d88ccd15efb_1e915829439@iweiny-mobl.notmuch>

On Wed, Sep 04, 2024 at 11:37:33AM -0500, Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Tue, 27 Aug 2024 09:40:05 -0700
> > nifan.cxl@gmail.com wrote:
> > 
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > When inserting multiple dynamic capacity event records grouped via More flag,
> > > we should only trigger interrupt after the last record is inserted into the
> > > event log. Achieving the goal by letting cxl_event_insert return true only
> > > for the insertion of the last dynamic capacity event record in the sequence.
> > 
> > I'm not sure this one is accurate.  We might well have a slow
> > system provisioning capacity one extent at time (and interrupting).
> > 
> > The event buffer might also not be large enough to hold all records so
> > the device might 'wait' before figuring out the next extent for there
> > to be somewhere to put the record.
> > 
> > Overall I think we can interrupt on each one and it should 'work'
> > as should interrupt only once there are lots of them or
> > every (n).
> 
> Indeed I think it should work.  But you won't see any extents as they will
> be pending in the memdev.
> 
> Did this fail in some way?  I'm sorry I did not try and use qemu to test
> the more bit.  Rather I used cxl_test for that.
> 
> Ira

It works with or without this fix in my test. Until the last extent is
notified to the OS, the extents will be pending as you mentioned. 

Fan

> 
> > 
> > Interrupt only fires on a 0 to >= 1 transition anyway, not
> > on repeats after that unless the log has been cleared.
> > It's up to OS to keep clearing records until it at least
> > momentarily hits 0 if it wants to get any more interrupts.
> > 
> > Jonathan
> > 
> > 
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > ---
> > >  hw/cxl/cxl-events.c         | 8 ++++++++
> > >  include/hw/cxl/cxl_events.h | 1 +
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > > index 12dee2e467..90536c0e68 100644
> > > --- a/hw/cxl/cxl-events.c
> > > +++ b/hw/cxl/cxl-events.c
> > > @@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> > >      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> > >      cxl_event_set_status(cxlds, log_type, true);
> > >  
> > > +    /*
> > > +     * For dynamic capacity event records grouped via More flag,
> > > +     * Only raise interrupt after inserting the last record in the log.
> > > +     */
> > > +    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
> > > +        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
> > > +        return (dCap->flags & MORE_FLAG) ? false : true;
> > > +    }
> > >      /* Count went from 0 to 1 */
> > >      return cxl_event_count(log) == 1;
> > 
> > If there are multiple this will fail I think as cxl_event_count(log) will go from 0
> > to X not 1.
> > 
> > >  }
> > > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > > index 38cadaa0f3..b0e5cc89c0 100644
> > > --- a/include/hw/cxl/cxl_events.h
> > > +++ b/include/hw/cxl/cxl_events.h
> > > @@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
> > >   * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
> > >   * All fields little endian.
> > >   */
> > > +#define MORE_FLAG BIT_MASK(0)
> > >  typedef struct CXLEventDynamicCapacity {
> > >      CXLEventRecordHdr hdr;
> > >      uint8_t type;
> > 
> 
> 

-- 
Fan Ni
