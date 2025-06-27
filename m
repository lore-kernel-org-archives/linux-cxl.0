Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AFD293C63
	for <linux-cxl@vger.kernel.org>; Fri, 27 Jun 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042301; cv=none; b=UT3cGzpJTT7AIKH3TqCPK9c44F5pUZ3hURmGYYV17hoDeRVU1W4Xus5CeEClURBEr4xHuukqJ2dwTI+T+7LIkr2+OoEmlCYcVUbL5+89bammZkW24Da3O9GQqPQgT71eVUTRNeUtNQgYrIdJ9sOjDuY81utqhvgxBuk04DpHB3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042301; c=relaxed/simple;
	bh=YANN8pS+SWSx1I87hwzxsqQc9cmMzsMUGj5aq8uIl+E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0uwBBshwSbyLCpfFT/KxZVBl5DmrzJOTZ1aoZFtLn60Z9nZRIU88QfSrwq0jIUEiBIZMyvMLZTK1U6lr6qHJ11Lhk4e5i20dIbI0dPKLXBjho2UAEwk6yzAKTeuYIwIskxovhrMIGw88oGIm7TQT7fAbYOgaQ/rXiRkHMRqRvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJZifM+U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJZifM+U"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748d982e92cso2059210b3a.1
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jun 2025 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751042299; x=1751647099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KrP4NrgRfqKvj7KEsF377Ymituu2ngJplzC+zDSckM=;
        b=EJZifM+UZ1JfHpVTz+WwhwWAZp/G+4Oeji/1AHI+z9o3Io7SZ8YeB1NRodLhTCjwli
         9LIKglXNnYF2jpJrJiJvEORBD4dJAjOLJXCe2jd/yNuQ/R67EdmtiIkcg3XUH3KvGr3H
         clJpw706PHac1tyCZPii/XN6UGqmOGFJN1wZp/9/jXDRwaHWPC3yemBN6+JV1DbzI21B
         I7Uk/7AeAPokgaa2FYaMbO2t47LOvQrJrvbR64iQ2ZsapzVv1y0LM4lHUR9vzsAPv1/C
         mMyJLn+JcZbYUuIwfOKb/1g0GyRMA5RN7Yw5CcNwZkCDS0A/+CpIpXS/y3et2iDGqsbV
         5JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751042299; x=1751647099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KrP4NrgRfqKvj7KEsF377Ymituu2ngJplzC+zDSckM=;
        b=e7rTecWzN/Mm6iVU1+nZvfyJzZt3mH7wgjiA4x/Y8oLG1sHrEBTEvUd5XlgQ4nAMA1
         PKCm5tl2QTYp99IB1/LlH2DwD+s67ob/Ehja/ImPxxiGMZD5zQvCH1CUhK5jWDmr4LwT
         eIYRs3iBM6hi2LMEheZe5U9S5aJNBZrLFA+f8kRNQxiNEaPTMN3Nqloc1BwV6YiZQEKt
         nZyXlKbJo7zhHtlz11cq4F4ansqHr4j0zkatqPKKblMtQpCI0YFsPrSBS+haGMMJG3jF
         It1Q5Jzftj+27ph6gdn2TiGLdjPV6gbmum5d5+nTiqSgjxPF/skXrF8Yqk24ZLI5C2RL
         enqA==
X-Forwarded-Encrypted: i=1; AJvYcCWgVYapspiuZZXGF6y+B96wWx0BrW7NDp7L7g6kPP4XKZyxGs8o7jDM+1q1AkzthLSfMopOGuLaR5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCTjieplsE2qvzDnY8lk3uc5wZncIopvwEdkcwzr0At0s1ma8
	AaKx6c0inRRYD4VPmNTHnzxKvg0yZaa0kfYdg7/RKH4SGDEPWZXHrCWr
X-Gm-Gg: ASbGnctBnoqq6Vp2CzZ4j56hUIvso1VqRyrm3gE7kiD2epNxzhN7hC7w/KjsoIZrXfV
	dr9kh1HHhAvNIarG72bcoGE1tVUA0CR6X+785fWlnm1dDopc4AOOjXGYNA92r4A1pE39FWcHfxa
	FIoImD1F4MVdxg9la49xWGJifQHyb8tiQ6w1ZMrskfOBRbHjYy9upgE1v1mUhOS5TWnATA4Hi5e
	fQwubLcsZvvhoPT/xtxeETkw8AYjvORfdiRbx8isWw9G519dmfHNsLHEs9e2coOg73MNbX3QSYs
	1ZTmCBe+sZtQIk5Kkx0cJ46lKa1AodK5smcwBOvHPNPqwbtdvYVHiufTewdB8Ep49/8DHg7CLe4
	1QR8bHu0Q2URlO6fPEnAKAlo=
X-Google-Smtp-Source: AGHT+IFEGzayuaUZPPDUntzB46BhlvyBWNVdIiBGBzdvEUIpwGJfB0HiDIzF6jM+3w0dl/cI9PShew==
X-Received: by 2002:a17:902:d58f:b0:235:2e0:ab8 with SMTP id d9443c01a7336-23ac3cf54a7mr51063175ad.6.1751042298751;
        Fri, 27 Jun 2025 09:38:18 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e300468esm2027696a12.7.2025.06.27.09.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 09:38:18 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 27 Jun 2025 16:38:16 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [HACK QEMU PATCH v1 1/1] hw/cxl: Fix MCTP Binding Check
Message-ID: <aF7I-ByGLZOxqNXi@deb-101020-bm01.eng.stellus.in>
References: <20250626235102.1902427-1-anisa.su887@gmail.com>
 <20250626235102.1902427-2-anisa.su887@gmail.com>
 <20250627104859.00003cbe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627104859.00003cbe@huawei.com>

On Fri, Jun 27, 2025 at 10:48:59AM +0100, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 23:41:15 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Per the spec, FMAPI commands (0x51-0x59) must be bound with
> > MCTP_MT_CXL_FMAPI. Fix the conditions ensuring this in i2c_mctp_cxl.c
> > and dev-mctp.c
> > 
> > Move the opcode enum from cxl-mailbox-utils.c to cxl_mailbox.h to
> > allow i2c_mctp_cxl.c and dev-mctp.c to use the enum instead of
> > hardcoding the values.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Why HACK in the patch title?
> 
I guess this isn't really a hack but my intention was to make
it clear that this patch isn't intended for upstream. Seems like that
made things more confusing though, but now I know!

> In general this seems reasonable - the complexity is how I merge it
> into my tree given the code being modified slips in at various different
> points. I'll sort that out though.

I could also send you an alternate version of the FMAPI DCD Management patchset
based on this one?

> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
> >  hw/cxl/i2c_mctp_cxl.c        |  6 ++-
> >  hw/usb/dev-mctp.c            |  6 ++-
> >  include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 82 insertions(+), 77 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 4c01b25110..7f84e147f7 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -37,7 +37,7 @@
> >  
> >  /*
> >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > - *  1. Add the command set and cmd to the enum.
> > + *  1. Add the command set and cmd to the enum in cxl_mailbox.h.
> >   *     FOO    = 0x7f,
> >   *          #define BAR 0
> >   *  2. Implement the handler
> > @@ -60,78 +60,6 @@
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
> > -    FMAPI_DCD_MGMT = 0x56,
> > -        #define GET_DCD_INFO    0x0
> > -        #define GET_HOST_DC_REGION_CONFIG   0x1
> > -        #define SET_DC_REGION_CONFIG        0x2
> > -        #define GET_DC_REGION_EXTENT_LIST   0x3
> > -        #define INITIATE_DC_ADD             0x4
> > -        #define INITIATE_DC_RELEASE         0x5
> > -};
> > -
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> >  typedef struct CXLCCIMessage {
> >      uint8_t category;
> > diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> > index 1714f36e8e..3f17779562 100644
> > --- a/hw/cxl/i2c_mctp_cxl.c
> > +++ b/hw/cxl/i2c_mctp_cxl.c
> > @@ -29,6 +29,7 @@
> >  #include "hw/pci/pcie_port.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/registerfields.h"
> > +#include "hw/cxl/cxl_mailbox.h"
> >  
> >  #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
> >  
> > @@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> >           */
> >  
> >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> > -              msg->command_set < 0x51) &&
> > +              msg->command_set < PHYSICAL_SWITCH) &&
> >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > +              msg->command_set >= PHYSICAL_SWITCH &&
> > +              msg->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
> >              buf->rc = CXL_MBOX_UNSUPPORTED;
> >              st24_le_p(buf->pl_length, len_out);
> >              s->len = s->pos;
> > diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
> > index aafb9e7e96..b82a269561 100644
> > --- a/hw/usb/dev-mctp.c
> > +++ b/hw/usb/dev-mctp.c
> > @@ -25,6 +25,7 @@
> >  #include "hw/usb.h"
> >  #include "hw/usb/desc.h"
> >  #include "net/mctp.h"
> > +#include "hw/cxl/cxl_mailbox.h"
> >  
> >  /* TODO: Move to header */
> >  
> > @@ -504,9 +505,10 @@ static void usb_cxl_mctp_handle_data(USBDevice *dev, USBPacket *p)
> >           * onwards.
> >           */
> >          if (!(req->message_type == MCTP_MT_CXL_TYPE3 &&
> > -              req->command_set < 0x51) &&
> > +              req->command_set < PHYSICAL_SWITCH) &&
> >              !(req->message_type == MCTP_MT_CXL_FMAPI &&
> > -              req->command_set >= 0x51 && req->command_set < 0x56)) {
> > +              req->command_set >= PHYSICAL_SWITCH &&
> > +              req->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
> >              len_out = 0;
> >              usb_pkt_len = sizeof(MCTPUSBPacket) + sizeof(CXLMCTPMessage) +
> >                  len_out;
> > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> > index 820c411cbb..209a11ecbc 100644
> > --- a/include/hw/cxl/cxl_mailbox.h
> > +++ b/include/hw/cxl/cxl_mailbox.h
> > @@ -27,4 +27,77 @@
> >  #define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> >  #define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> >  
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
> > +    FMAPI_DCD_MGMT = 0x56,
> > +        #define GET_DCD_INFO    0x0
> > +        #define GET_HOST_DC_REGION_CONFIG   0x1
> > +        #define SET_DC_REGION_CONFIG        0x2
> > +        #define GET_DC_REGION_EXTENT_LIST   0x3
> > +        #define INITIATE_DC_ADD             0x4
> > +        #define INITIATE_DC_RELEASE         0x5
> > +    GLOBAL_MEM_ACCESS_EP_MGMT = 0X59,
> > +};
> > +
> >  #endif
> 
