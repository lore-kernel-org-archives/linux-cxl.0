Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E24182BC
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747762431; cv=none; b=Z62ItQyZL4F76XR9W2NCLPl46DwDMQo4EEvMNsjGBAsSgPfghZRKsbcVZvyCwZHydo2Z4Qyhk4G1ihlN2opsdgWBgBbIKhALNX2KE0F5AL2hmo+xmiqiEEQZ63FNYQiRKEsUpVJC/cISxSIWcHc1NC6dB6xiS6rn2+O0+/dQJUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747762431; c=relaxed/simple;
	bh=cohThi4WbsSy03gA1sZvUvfti7oqy7C5XBc31R4vwu0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy8un3O9bPytPPC7ZfjrrLovA4zJSTtdL97BzY3rL+jTLbz2ZzeJTW4Zsd5VTPzT1D470eqcJMM1MHCs7/o4cfmt7iz8/3bk1NSJ7pttj6fXYpS6mNlV52m+u92H4i6DZFQ86/zE8X8jES8AYK0CirfkQ8aZ+HHRwRuRl9fAZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa9yWLnP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa9yWLnP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so5999731b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747762428; x=1748367228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvHt4MKWTx6H9SefAKaE6RmCWcY4eukSsVO+Nryfw4E=;
        b=Qa9yWLnP6kcXX3LRD4602HzZLk5Ppm7V8S3CrpCBjO9+cbDA0jKGi16Xbyd3c5mpoS
         sZIbGF4fRh9/c7oRmQG4qqWg0aLpU22W3rYEs0gDeRsRSXp8m0gQgZNJyGekl56VsGTL
         q3ncyCU3fZbPixk+Znn9iSCRPbJQOX28ONXGuUtuGJKDiD6+NYtZvh5qRWaAiM/Jlrdo
         J5J4OnrHy0Vd3dr1Oh43U0vMHmhXUn26De/eGdcFmw8T8GpOuNbceEM4L/pYz5yWKBeb
         3My25LG3hPoPEEjH1i3ZSUmYjMbvzN6o1i7vpz6TQe3njkb/9aLOJaDaf6CM7/f4KxgH
         RVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747762428; x=1748367228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvHt4MKWTx6H9SefAKaE6RmCWcY4eukSsVO+Nryfw4E=;
        b=WMKovHmA6u+j+fkBkvYxLOiwsYEqsBXfQXWjzU6rmhcZvX16Er5XrTHa7vmOT2WJPV
         3ryCupCBZL94kS6lfX2aD6G9bv2jGMzZAZclEvxSep/dBgxdW3uorZP//olvipdorDpb
         wajh3yBHRbLTPOi5v3uDqSAlWswa5LSJnSq7tIq1l1L86cuyWjYjP+mmasJkWMimeWEq
         urrMRum+BJvegdebtwwEZiS2RQmsWN1FLxJb63a7vYbChsod7g8hwW5MifHYxdLMnB74
         X/2x1IeQqf5h07qzzDarQHzP1xMHikVD3y0Xg3qDnBiLNwWuohwfsMZZBrmwteAeQ8tU
         lu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+QCa7Z5pEAqlN/I2GkXltF83e42ssbgnrZZ3/SJDZgjnCDQoh7UYfIecC7i0RGQMXbgHb+RzgsB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQjBhCX197zkTdyJqQTqUAyg16OKjF4gsq+ffhvv2gn10iP/h
	mlgwYeb2pEhSlCr1uEqqSxbnu6C43IJkbGj+rVOUk37dYnnij8QlaM7/YllgLA==
X-Gm-Gg: ASbGncseewLjzp915AaH7H0jx+xkE1//iwR8ZsFoFiaVbtOldjg3cNEmfOX1DiUGJ/n
	Z13+oOasDlu27C+9TfBABBWQf+1R2qw1ujzMFpMxAmitmKpzEQKJs/1BksfbKAVaIdVIpkYlF5c
	XiiHBXY89YH03Hnr52U8gn83Bhw9899nKfArAsATPVxnBbRhhpNCK9mAJStSTPkbAHNPzwCWwM9
	8HuFnc81KRViTVtGK9oyNXu0D7S91b0rkbet483MIZjttGU9ha5f5grp+lzuGA3RSTkWaHIN3CQ
	QGHLPU4XI3QmJD77JQO7i2t6uwwKsuFm+Vfv2wQH5Pjw9a0wKKzOnQzJx0PefbdNks9YqIIWq+Q
	z1RRTW2YrHWTj
X-Google-Smtp-Source: AGHT+IHAcdZkKlC59Ap9+9J6DwBg1+sCLP3pEe1x9i6V8VGJKQJDJKTZL5PwZiNGuTRniFOPIQyZnQ==
X-Received: by 2002:aa7:888e:0:b0:742:39fa:13df with SMTP id d2e1a72fcca58-742a98a2520mr24472509b3a.19.1747762428380;
        Tue, 20 May 2025 10:33:48 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982b847sm8464446b3a.102.2025.05.20.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:33:48 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 20 May 2025 17:33:46 +0000
To: Fan Ni <nifan.cxl@gmail.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <aCy8-vMEYsFaOiWC@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-2-anisa.su887@gmail.com>
 <aCyhv8Qz1LUpJKd3@lg>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCyhv8Qz1LUpJKd3@lg>

On Tue, May 20, 2025 at 08:37:35AM -0700, Fan Ni wrote:
> On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> > for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> > certain command sets are bound with the correct MCTP binding.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
> >  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++
> 
> Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
> creating a new file. cxl_mailbox.h only has some macros.
> 
> Fan
> 
I had some discussion with Jonathan in the v1 thread about this. We
agreed it is fine to use mailbox.h because it only has a few macros in it,
but in case more things get added to it later, I made a separate file.
Then no need to re-organize later.
> 
> 
> >  2 files changed, 66 insertions(+), 66 deletions(-)
> >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index a02d130926..ed3294530f 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -23,6 +23,7 @@
> >  #include "qemu/uuid.h"
> >  #include "system/hostmem.h"
> >  #include "qemu/range.h"
> > +#include "hw/cxl/cxl_opcodes.h"
> >  
> >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  #define CXL_DC_EVENT_LOG_SIZE 8
> > @@ -36,7 +37,7 @@
> >  
> >  /*
> >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > - *  1. Add the command set and cmd to the enum.
> > + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
> >   *     FOO    = 0x7f,
> >   *          #define BAR 0
> >   *  2. Implement the handler
> > @@ -59,71 +60,6 @@
> >   *  a register interface that already deals with it.
> >   */
> >  
> > -enum {
> > -    INFOSTAT    = 0x00,
> > -        #define IS_IDENTIFY   0x1
> > -        #define BACKGROUND_OPERATION_STATUS    0x2
> > -        #define GET_RESPONSE_MSG_LIMIT         0x3
> > -        #define SET_RESPONSE_MSG_LIMIT         0x4
> > -        #define BACKGROUND_OPERATION_ABORT     0x5
> > -    EVENTS      = 0x01,
> > -        #define GET_RECORDS   0x0
> > -        #define CLEAR_RECORDS   0x1
> > -        #define GET_INTERRUPT_POLICY   0x2
> > -        #define SET_INTERRUPT_POLICY   0x3
> > -    FIRMWARE_UPDATE = 0x02,
> > -        #define GET_INFO      0x0
> > -        #define TRANSFER      0x1
> > -        #define ACTIVATE      0x2
> > -    TIMESTAMP   = 0x03,
> > -        #define GET           0x0
> > -        #define SET           0x1
> > -    LOGS        = 0x04,
> > -        #define GET_SUPPORTED 0x0
> > -        #define GET_LOG       0x1
> > -        #define GET_LOG_CAPABILITIES   0x2
> > -        #define CLEAR_LOG     0x3
> > -        #define POPULATE_LOG  0x4
> > -    FEATURES    = 0x05,
> > -        #define GET_SUPPORTED 0x0
> > -        #define GET_FEATURE   0x1
> > -        #define SET_FEATURE   0x2
> > -    IDENTIFY    = 0x40,
> > -        #define MEMORY_DEVICE 0x0
> > -    CCLS        = 0x41,
> > -        #define GET_PARTITION_INFO     0x0
> > -        #define GET_LSA       0x2
> > -        #define SET_LSA       0x3
> > -    HEALTH_INFO_ALERTS = 0x42,
> > -        #define GET_ALERT_CONFIG 0x1
> > -        #define SET_ALERT_CONFIG 0x2
> > -    SANITIZE    = 0x44,
> > -        #define OVERWRITE     0x0
> > -        #define SECURE_ERASE  0x1
> > -        #define MEDIA_OPERATIONS 0x2
> > -    PERSISTENT_MEM = 0x45,
> > -        #define GET_SECURITY_STATE     0x0
> > -    MEDIA_AND_POISON = 0x43,
> > -        #define GET_POISON_LIST        0x0
> > -        #define INJECT_POISON          0x1
> > -        #define CLEAR_POISON           0x2
> > -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > -        #define SCAN_MEDIA             0x4
> > -        #define GET_SCAN_MEDIA_RESULTS 0x5
> > -    DCD_CONFIG  = 0x48,
> > -        #define GET_DC_CONFIG          0x0
> > -        #define GET_DYN_CAP_EXT_LIST   0x1
> > -        #define ADD_DYN_CAP_RSP        0x2
> > -        #define RELEASE_DYN_CAP        0x3
> > -    PHYSICAL_SWITCH = 0x51,
> > -        #define IDENTIFY_SWITCH_DEVICE      0x0
> > -        #define GET_PHYSICAL_PORT_STATE     0x1
> > -    TUNNEL = 0x53,
> > -        #define MANAGEMENT_COMMAND     0x0
> > -    MHD = 0x55,
> > -        #define GET_MHD_INFO 0x0
> > -};
> > -
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> >  typedef struct CXLCCIMessage {
> >      uint8_t category;
> > diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> > new file mode 100644
> > index 0000000000..26d3a99e8a
> > --- /dev/null
> > +++ b/include/hw/cxl/cxl_opcodes.h
> > @@ -0,0 +1,64 @@
> > +enum {
> > +    INFOSTAT    = 0x00,
> > +        #define IS_IDENTIFY   0x1
> > +        #define BACKGROUND_OPERATION_STATUS    0x2
> > +        #define GET_RESPONSE_MSG_LIMIT         0x3
> > +        #define SET_RESPONSE_MSG_LIMIT         0x4
> > +        #define BACKGROUND_OPERATION_ABORT     0x5
> > +    EVENTS      = 0x01,
> > +        #define GET_RECORDS   0x0
> > +        #define CLEAR_RECORDS   0x1
> > +        #define GET_INTERRUPT_POLICY   0x2
> > +        #define SET_INTERRUPT_POLICY   0x3
> > +    FIRMWARE_UPDATE = 0x02,
> > +        #define GET_INFO      0x0
> > +        #define TRANSFER      0x1
> > +        #define ACTIVATE      0x2
> > +    TIMESTAMP   = 0x03,
> > +        #define GET           0x0
> > +        #define SET           0x1
> > +    LOGS        = 0x04,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_LOG       0x1
> > +        #define GET_LOG_CAPABILITIES   0x2
> > +        #define CLEAR_LOG     0x3
> > +        #define POPULATE_LOG  0x4
> > +    FEATURES    = 0x05,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_FEATURE   0x1
> > +        #define SET_FEATURE   0x2
> > +    IDENTIFY    = 0x40,
> > +        #define MEMORY_DEVICE 0x0
> > +    CCLS        = 0x41,
> > +        #define GET_PARTITION_INFO     0x0
> > +        #define GET_LSA       0x2
> > +        #define SET_LSA       0x3
> > +    HEALTH_INFO_ALERTS = 0x42,
> > +        #define GET_ALERT_CONFIG 0x1
> > +        #define SET_ALERT_CONFIG 0x2
> > +    SANITIZE    = 0x44,
> > +        #define OVERWRITE     0x0
> > +        #define SECURE_ERASE  0x1
> > +        #define MEDIA_OPERATIONS 0x2
> > +    PERSISTENT_MEM = 0x45,
> > +        #define GET_SECURITY_STATE     0x0
> > +    MEDIA_AND_POISON = 0x43,
> > +        #define GET_POISON_LIST        0x0
> > +        #define INJECT_POISON          0x1
> > +        #define CLEAR_POISON           0x2
> > +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > +        #define SCAN_MEDIA             0x4
> > +        #define GET_SCAN_MEDIA_RESULTS 0x5
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> > +        #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> > +    PHYSICAL_SWITCH = 0x51,
> > +        #define IDENTIFY_SWITCH_DEVICE      0x0
> > +        #define GET_PHYSICAL_PORT_STATE     0x1
> > +    TUNNEL = 0x53,
> > +        #define MANAGEMENT_COMMAND     0x0
> > +    MHD = 0x55,
> > +        #define GET_MHD_INFO 0x0
> > +};
> > -- 
> > 2.47.2
> > 
> 
> -- 
> Fan Ni
