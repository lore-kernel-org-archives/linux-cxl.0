Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC52F84F
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635069; cv=none; b=NzOsBqb3cQdlot7lN3mZqhr8fDdzySFd+5svpUVYi2r6lIwzmyw/m22GefMJjd0Y3K0xy1fNntgzNPiWNmydrwIuhUZyGAWLZ+gT0rm7xY/M/oB64DMACOBPfY+IfN3YqlqbzDl5tBLNqF/e/Ff+J84SoAs6rhpxUIdxd/CUntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635069; c=relaxed/simple;
	bh=vVgyf4+z2b0d/vQpJxFdP87+qp7pytDQHy3HtlELev4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCVmpICgn09BnUZosp81PgCWRQU11bgz+KqMPZsuBR0QMz+VLX4wBrTmTjdRcV0UQjmHlKdPF08ft0OI3t8Kw+Juqd11j2ktlUO8jhgzDNEe0T00pCOjpm3IR5hw4uLzRkpNucrutiuIaIjCRT0cC4yktZFhWxnBUFQNXd5S+4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgy0jUEF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgy0jUEF"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c9907967so2529615b3a.1
        for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748635067; x=1749239867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/ErOmswlJOoVR4M1ZO3vfVuY1CrD+LRjJ2SE66WtCc=;
        b=Bgy0jUEFRqDW7sdygcMgHDgfZEOuFO+8mHvDa00AlDAckOQ/A+MS0pYpDzL4STP+wI
         0rH6eudga+Hlx0G9DUWP4ZQLBqH9+0W5MaXJnuddSHSyX6RzmgDZXxcXd6a6GjuD2QGh
         YEsK5T9hibxyqAknkPwFs4oVo+754KCwPphEPFhKud4AKk+UqHMaKYy0GKFFE5NQALlg
         zM2vZhvIy8PhwIJDbag/CnVaRepTDdJU/9ftB0yUtZS+uwy2CFdWx9crKXNC1XDVk6sG
         2Nn5Q5e78+kIdgv22922b3tOqZDxVut3T17mjSUwUGnSSeztRwlcEeDGlph7dCfdN555
         1p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748635067; x=1749239867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/ErOmswlJOoVR4M1ZO3vfVuY1CrD+LRjJ2SE66WtCc=;
        b=P/HFU53noRJ9Kov4ZkNcS19PwWq4BMjb5IMcSIS0ob5fhz7RCUl5Wymj9EOintVQsC
         iUFArkzhHaQcygcdmG18agOMeOHRHW2wbcotghCKCDskDS1/d07ZBUB6gnIEQQCV3shY
         +MwQGb6cFSluMIUt3wXOdz3I88e8EbRWwVb3qv6/pZB4A8T/iFxSZxZuNVkNtjzjZP3i
         cebku4ffckBa/Hy6mn+fr9/ZUhSjZneir7yELt8/teM9bULJFcqL/JcBoyC0YolPH84K
         ecKPstuvGhEiFDHLVpsDc5/aslIex4077/yC77g5RAnTuk+walYDjaOWrw1NqT0swLom
         Z3JA==
X-Forwarded-Encrypted: i=1; AJvYcCXREqLp/+v4J93qoASO7Uuaemei4FM87MwDkpf/YE6OBf7U+/Y9Cdjv5JBaAgkmVOPiT07/FcqnHGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8K5TIIXUPJ7D8pxkw7u56JXb94T2IY5nwV2kxVpMzPae/cQaL
	e8oAlmDO2qOh0NEEr3lZbGXe4yn7CTZweRZf+Tv65M0McclqhIifVBdsBJhdgQ==
X-Gm-Gg: ASbGncuLahx+CLuHJEIXbxsHJG6+VBgTlQBFHu4lvI50a0i2npa7sORRNp2AHp76nj+
	StFth9SQ9a4KE44+uJhTZdPos7AOkihJ4vvD5ukyBMB/ua/NRiCmldGQuFX++25lmA2MHjvQ+mT
	f+uqLAJNvR7AwHRK4BBnlYduhzk1jxzPR6ioj4socZe3xZoySgUurJoIeFQBHcnE7qc3aOtwA0X
	IPH370FowFlSZk4MULn1R8/syK5UbJFsxZGCb/3I1jX3gExBgmzUAPNldSITRBctOcBD1f7qnTK
	26He6mpZPr8Az75daNa3+ZBrQLHdabuROt83EQUmwV0LrZcYoBkpVedNNRfPRUXmXR3FAuvkLir
	wWg==
X-Google-Smtp-Source: AGHT+IFT8s+hVa62EhYMJFJNvdliv5us6aWbRl3wyQxz6lZ8/5/4ozmHl3yjNVl32O3S9+dAsSjyVA==
X-Received: by 2002:a17:90b:1dce:b0:312:26d9:d5a0 with SMTP id 98e67ed59e1d1-312413f60famr6676212a91.3.1748635056663;
        Fri, 30 May 2025 12:57:36 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb02662sm1909385a12.5.2025.05.30.12.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 12:57:36 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 30 May 2025 19:57:34 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Anisa Su <anisa.su887@gmail.com>, Fan Ni <nifan.cxl@gmail.com>,
	qemu-devel@nongnu.org, dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <aDoNrrGFWtTMsyEw@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-2-anisa.su887@gmail.com>
 <aCyhv8Qz1LUpJKd3@lg>
 <aCy8-vMEYsFaOiWC@deb-101020-bm01.eng.stellus.in>
 <20250530144335.000064f3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530144335.000064f3@huawei.com>

On Fri, May 30, 2025 at 02:43:35PM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 17:33:46 +0000
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > On Tue, May 20, 2025 at 08:37:35AM -0700, Fan Ni wrote:
> > > On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:  
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
> > > > In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> > > > for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> > > > certain command sets are bound with the correct MCTP binding.
> > > > 
> > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > ---
> > > >  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
> > > >  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++  
> > > 
> > > Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
> > > creating a new file. cxl_mailbox.h only has some macros.
> > > 
> > > Fan
> > >   
> > I had some discussion with Jonathan in the v1 thread about this. We
> > agreed it is fine to use mailbox.h because it only has a few macros in it,
> > but in case more things get added to it later, I made a separate file.
> > Then no need to re-organize later.
> > > 
> 
> We can always move them in future if it turns out cxl_mailbox.h is
> not a good home.
> 
> Also, note that the include file added in this patch has no descriptive
> comments or ifndef magic which would have wanted to be there.
> 
> Jonathan
> 
Ah ok~ I'll have it in cxl_mailbox.h for v3 then.

Thanks,
Anisa
> > >   
> > > >  2 files changed, 66 insertions(+), 66 deletions(-)
> > > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > > 
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index a02d130926..ed3294530f 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include "qemu/uuid.h"
> > > >  #include "system/hostmem.h"
> > > >  #include "qemu/range.h"
> > > > +#include "hw/cxl/cxl_opcodes.h"
> > > >  
> > > >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> > > >  #define CXL_DC_EVENT_LOG_SIZE 8
> > > > @@ -36,7 +37,7 @@
> > > >  
> > > >  /*
> > > >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > > > - *  1. Add the command set and cmd to the enum.
> > > > + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
> > > >   *     FOO    = 0x7f,
> > > >   *          #define BAR 0
> > > >   *  2. Implement the handler
> > > > @@ -59,71 +60,6 @@
> > > >   *  a register interface that already deals with it.
> > > >   */
> > > >  
> > > > -enum {
> > > > -    INFOSTAT    = 0x00,
> > > > -        #define IS_IDENTIFY   0x1
> > > > -        #define BACKGROUND_OPERATION_STATUS    0x2
> > > > -        #define GET_RESPONSE_MSG_LIMIT         0x3
> > > > -        #define SET_RESPONSE_MSG_LIMIT         0x4
> > > > -        #define BACKGROUND_OPERATION_ABORT     0x5
> > > > -    EVENTS      = 0x01,
> > > > -        #define GET_RECORDS   0x0
> > > > -        #define CLEAR_RECORDS   0x1
> > > > -        #define GET_INTERRUPT_POLICY   0x2
> > > > -        #define SET_INTERRUPT_POLICY   0x3
> > > > -    FIRMWARE_UPDATE = 0x02,
> > > > -        #define GET_INFO      0x0
> > > > -        #define TRANSFER      0x1
> > > > -        #define ACTIVATE      0x2
> > > > -    TIMESTAMP   = 0x03,
> > > > -        #define GET           0x0
> > > > -        #define SET           0x1
> > > > -    LOGS        = 0x04,
> > > > -        #define GET_SUPPORTED 0x0
> > > > -        #define GET_LOG       0x1
> > > > -        #define GET_LOG_CAPABILITIES   0x2
> > > > -        #define CLEAR_LOG     0x3
> > > > -        #define POPULATE_LOG  0x4
> > > > -    FEATURES    = 0x05,
> > > > -        #define GET_SUPPORTED 0x0
> > > > -        #define GET_FEATURE   0x1
> > > > -        #define SET_FEATURE   0x2
> > > > -    IDENTIFY    = 0x40,
> > > > -        #define MEMORY_DEVICE 0x0
> > > > -    CCLS        = 0x41,
> > > > -        #define GET_PARTITION_INFO     0x0
> > > > -        #define GET_LSA       0x2
> > > > -        #define SET_LSA       0x3
> > > > -    HEALTH_INFO_ALERTS = 0x42,
> > > > -        #define GET_ALERT_CONFIG 0x1
> > > > -        #define SET_ALERT_CONFIG 0x2
> > > > -    SANITIZE    = 0x44,
> > > > -        #define OVERWRITE     0x0
> > > > -        #define SECURE_ERASE  0x1
> > > > -        #define MEDIA_OPERATIONS 0x2
> > > > -    PERSISTENT_MEM = 0x45,
> > > > -        #define GET_SECURITY_STATE     0x0
> > > > -    MEDIA_AND_POISON = 0x43,
> > > > -        #define GET_POISON_LIST        0x0
> > > > -        #define INJECT_POISON          0x1
> > > > -        #define CLEAR_POISON           0x2
> > > > -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > > > -        #define SCAN_MEDIA             0x4
> > > > -        #define GET_SCAN_MEDIA_RESULTS 0x5
> > > > -    DCD_CONFIG  = 0x48,
> > > > -        #define GET_DC_CONFIG          0x0
> > > > -        #define GET_DYN_CAP_EXT_LIST   0x1
> > > > -        #define ADD_DYN_CAP_RSP        0x2
> > > > -        #define RELEASE_DYN_CAP        0x3
> > > > -    PHYSICAL_SWITCH = 0x51,
> > > > -        #define IDENTIFY_SWITCH_DEVICE      0x0
> > > > -        #define GET_PHYSICAL_PORT_STATE     0x1
> > > > -    TUNNEL = 0x53,
> > > > -        #define MANAGEMENT_COMMAND     0x0
> > > > -    MHD = 0x55,
> > > > -        #define GET_MHD_INFO 0x0
> > > > -};
> > > > -
> > > >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > > >  typedef struct CXLCCIMessage {
> > > >      uint8_t category;
> > > > diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> > > > new file mode 100644
> > > > index 0000000000..26d3a99e8a
> > > > --- /dev/null
> > > > +++ b/include/hw/cxl/cxl_opcodes.h
> > > > @@ -0,0 +1,64 @@
> > > > +enum {
> > > > +    INFOSTAT    = 0x00,
> > > > +        #define IS_IDENTIFY   0x1
> > > > +        #define BACKGROUND_OPERATION_STATUS    0x2
> > > > +        #define GET_RESPONSE_MSG_LIMIT         0x3
> > > > +        #define SET_RESPONSE_MSG_LIMIT         0x4
> > > > +        #define BACKGROUND_OPERATION_ABORT     0x5
> > > > +    EVENTS      = 0x01,
> > > > +        #define GET_RECORDS   0x0
> > > > +        #define CLEAR_RECORDS   0x1
> > > > +        #define GET_INTERRUPT_POLICY   0x2
> > > > +        #define SET_INTERRUPT_POLICY   0x3
> > > > +    FIRMWARE_UPDATE = 0x02,
> > > > +        #define GET_INFO      0x0
> > > > +        #define TRANSFER      0x1
> > > > +        #define ACTIVATE      0x2
> > > > +    TIMESTAMP   = 0x03,
> > > > +        #define GET           0x0
> > > > +        #define SET           0x1
> > > > +    LOGS        = 0x04,
> > > > +        #define GET_SUPPORTED 0x0
> > > > +        #define GET_LOG       0x1
> > > > +        #define GET_LOG_CAPABILITIES   0x2
> > > > +        #define CLEAR_LOG     0x3
> > > > +        #define POPULATE_LOG  0x4
> > > > +    FEATURES    = 0x05,
> > > > +        #define GET_SUPPORTED 0x0
> > > > +        #define GET_FEATURE   0x1
> > > > +        #define SET_FEATURE   0x2
> > > > +    IDENTIFY    = 0x40,
> > > > +        #define MEMORY_DEVICE 0x0
> > > > +    CCLS        = 0x41,
> > > > +        #define GET_PARTITION_INFO     0x0
> > > > +        #define GET_LSA       0x2
> > > > +        #define SET_LSA       0x3
> > > > +    HEALTH_INFO_ALERTS = 0x42,
> > > > +        #define GET_ALERT_CONFIG 0x1
> > > > +        #define SET_ALERT_CONFIG 0x2
> > > > +    SANITIZE    = 0x44,
> > > > +        #define OVERWRITE     0x0
> > > > +        #define SECURE_ERASE  0x1
> > > > +        #define MEDIA_OPERATIONS 0x2
> > > > +    PERSISTENT_MEM = 0x45,
> > > > +        #define GET_SECURITY_STATE     0x0
> > > > +    MEDIA_AND_POISON = 0x43,
> > > > +        #define GET_POISON_LIST        0x0
> > > > +        #define INJECT_POISON          0x1
> > > > +        #define CLEAR_POISON           0x2
> > > > +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > > > +        #define SCAN_MEDIA             0x4
> > > > +        #define GET_SCAN_MEDIA_RESULTS 0x5
> > > > +    DCD_CONFIG  = 0x48,
> > > > +        #define GET_DC_CONFIG          0x0
> > > > +        #define GET_DYN_CAP_EXT_LIST   0x1
> > > > +        #define ADD_DYN_CAP_RSP        0x2
> > > > +        #define RELEASE_DYN_CAP        0x3
> > > > +    PHYSICAL_SWITCH = 0x51,
> > > > +        #define IDENTIFY_SWITCH_DEVICE      0x0
> > > > +        #define GET_PHYSICAL_PORT_STATE     0x1
> > > > +    TUNNEL = 0x53,
> > > > +        #define MANAGEMENT_COMMAND     0x0
> > > > +    MHD = 0x55,
> > > > +        #define GET_MHD_INFO 0x0
> > > > +};
> > > > -- 
> > > > 2.47.2
> > > >   
> > > 
> > > -- 
> > > Fan Ni  
> 
