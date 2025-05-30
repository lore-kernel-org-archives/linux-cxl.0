Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DDE17A2F5
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612622; cv=none; b=LxYTtXGanwTtAjIDT4IiHviZOPbtWbwYMdwlco2dB96dSkdcMljYO5iCWNLv2jvGRDHXEJzIAsvc/WTrDLYGl1YE8elXlvrEuikS/Ew+zDgSrkfY4FyzThyVAXZU0mi+BLyu2iK9wC26nlFtrNqN3E6dYtk9gAPFmeSAzp4nNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612622; c=relaxed/simple;
	bh=jVGAxopxBp2Bc/MSI2zgEorHWaU4548/4zz7tcU+6xI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scTL8iePTiin5EMYHYgizrzfrz9cCpzN5NibsutyFw2dL5PaElaVshlRHEsTegyhzKzKoNNOCFGNqWHDXIw+bO+fPAV0OYEOntkvg1OYdcPgrVO7jOepetADxS5+Ot0Vf3gCBeINXUaUdMXt8oz+hVxnez2QwJU+BHZednF03wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b84Fb2Jxcz6GFS4;
	Fri, 30 May 2025 21:43:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD0F1402FF;
	Fri, 30 May 2025 21:43:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 15:43:36 +0200
Date: Fri, 30 May 2025 14:43:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: Fan Ni <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<dave@stgolabs.net>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <20250530144335.000064f3@huawei.com>
In-Reply-To: <aCy8-vMEYsFaOiWC@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
	<20250508001754.122180-2-anisa.su887@gmail.com>
	<aCyhv8Qz1LUpJKd3@lg>
	<aCy8-vMEYsFaOiWC@deb-101020-bm01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 17:33:46 +0000
Anisa Su <anisa.su887@gmail.com> wrote:

> On Tue, May 20, 2025 at 08:37:35AM -0700, Fan Ni wrote:
> > On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:  
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> > > for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> > > certain command sets are bound with the correct MCTP binding.
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
> > >  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++  
> > 
> > Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
> > creating a new file. cxl_mailbox.h only has some macros.
> > 
> > Fan
> >   
> I had some discussion with Jonathan in the v1 thread about this. We
> agreed it is fine to use mailbox.h because it only has a few macros in it,
> but in case more things get added to it later, I made a separate file.
> Then no need to re-organize later.
> > 

We can always move them in future if it turns out cxl_mailbox.h is
not a good home.

Also, note that the include file added in this patch has no descriptive
comments or ifndef magic which would have wanted to be there.

Jonathan

> >   
> > >  2 files changed, 66 insertions(+), 66 deletions(-)
> > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index a02d130926..ed3294530f 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -23,6 +23,7 @@
> > >  #include "qemu/uuid.h"
> > >  #include "system/hostmem.h"
> > >  #include "qemu/range.h"
> > > +#include "hw/cxl/cxl_opcodes.h"
> > >  
> > >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> > >  #define CXL_DC_EVENT_LOG_SIZE 8
> > > @@ -36,7 +37,7 @@
> > >  
> > >  /*
> > >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > > - *  1. Add the command set and cmd to the enum.
> > > + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
> > >   *     FOO    = 0x7f,
> > >   *          #define BAR 0
> > >   *  2. Implement the handler
> > > @@ -59,71 +60,6 @@
> > >   *  a register interface that already deals with it.
> > >   */
> > >  
> > > -enum {
> > > -    INFOSTAT    = 0x00,
> > > -        #define IS_IDENTIFY   0x1
> > > -        #define BACKGROUND_OPERATION_STATUS    0x2
> > > -        #define GET_RESPONSE_MSG_LIMIT         0x3
> > > -        #define SET_RESPONSE_MSG_LIMIT         0x4
> > > -        #define BACKGROUND_OPERATION_ABORT     0x5
> > > -    EVENTS      = 0x01,
> > > -        #define GET_RECORDS   0x0
> > > -        #define CLEAR_RECORDS   0x1
> > > -        #define GET_INTERRUPT_POLICY   0x2
> > > -        #define SET_INTERRUPT_POLICY   0x3
> > > -    FIRMWARE_UPDATE = 0x02,
> > > -        #define GET_INFO      0x0
> > > -        #define TRANSFER      0x1
> > > -        #define ACTIVATE      0x2
> > > -    TIMESTAMP   = 0x03,
> > > -        #define GET           0x0
> > > -        #define SET           0x1
> > > -    LOGS        = 0x04,
> > > -        #define GET_SUPPORTED 0x0
> > > -        #define GET_LOG       0x1
> > > -        #define GET_LOG_CAPABILITIES   0x2
> > > -        #define CLEAR_LOG     0x3
> > > -        #define POPULATE_LOG  0x4
> > > -    FEATURES    = 0x05,
> > > -        #define GET_SUPPORTED 0x0
> > > -        #define GET_FEATURE   0x1
> > > -        #define SET_FEATURE   0x2
> > > -    IDENTIFY    = 0x40,
> > > -        #define MEMORY_DEVICE 0x0
> > > -    CCLS        = 0x41,
> > > -        #define GET_PARTITION_INFO     0x0
> > > -        #define GET_LSA       0x2
> > > -        #define SET_LSA       0x3
> > > -    HEALTH_INFO_ALERTS = 0x42,
> > > -        #define GET_ALERT_CONFIG 0x1
> > > -        #define SET_ALERT_CONFIG 0x2
> > > -    SANITIZE    = 0x44,
> > > -        #define OVERWRITE     0x0
> > > -        #define SECURE_ERASE  0x1
> > > -        #define MEDIA_OPERATIONS 0x2
> > > -    PERSISTENT_MEM = 0x45,
> > > -        #define GET_SECURITY_STATE     0x0
> > > -    MEDIA_AND_POISON = 0x43,
> > > -        #define GET_POISON_LIST        0x0
> > > -        #define INJECT_POISON          0x1
> > > -        #define CLEAR_POISON           0x2
> > > -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > > -        #define SCAN_MEDIA             0x4
> > > -        #define GET_SCAN_MEDIA_RESULTS 0x5
> > > -    DCD_CONFIG  = 0x48,
> > > -        #define GET_DC_CONFIG          0x0
> > > -        #define GET_DYN_CAP_EXT_LIST   0x1
> > > -        #define ADD_DYN_CAP_RSP        0x2
> > > -        #define RELEASE_DYN_CAP        0x3
> > > -    PHYSICAL_SWITCH = 0x51,
> > > -        #define IDENTIFY_SWITCH_DEVICE      0x0
> > > -        #define GET_PHYSICAL_PORT_STATE     0x1
> > > -    TUNNEL = 0x53,
> > > -        #define MANAGEMENT_COMMAND     0x0
> > > -    MHD = 0x55,
> > > -        #define GET_MHD_INFO 0x0
> > > -};
> > > -
> > >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > >  typedef struct CXLCCIMessage {
> > >      uint8_t category;
> > > diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> > > new file mode 100644
> > > index 0000000000..26d3a99e8a
> > > --- /dev/null
> > > +++ b/include/hw/cxl/cxl_opcodes.h
> > > @@ -0,0 +1,64 @@
> > > +enum {
> > > +    INFOSTAT    = 0x00,
> > > +        #define IS_IDENTIFY   0x1
> > > +        #define BACKGROUND_OPERATION_STATUS    0x2
> > > +        #define GET_RESPONSE_MSG_LIMIT         0x3
> > > +        #define SET_RESPONSE_MSG_LIMIT         0x4
> > > +        #define BACKGROUND_OPERATION_ABORT     0x5
> > > +    EVENTS      = 0x01,
> > > +        #define GET_RECORDS   0x0
> > > +        #define CLEAR_RECORDS   0x1
> > > +        #define GET_INTERRUPT_POLICY   0x2
> > > +        #define SET_INTERRUPT_POLICY   0x3
> > > +    FIRMWARE_UPDATE = 0x02,
> > > +        #define GET_INFO      0x0
> > > +        #define TRANSFER      0x1
> > > +        #define ACTIVATE      0x2
> > > +    TIMESTAMP   = 0x03,
> > > +        #define GET           0x0
> > > +        #define SET           0x1
> > > +    LOGS        = 0x04,
> > > +        #define GET_SUPPORTED 0x0
> > > +        #define GET_LOG       0x1
> > > +        #define GET_LOG_CAPABILITIES   0x2
> > > +        #define CLEAR_LOG     0x3
> > > +        #define POPULATE_LOG  0x4
> > > +    FEATURES    = 0x05,
> > > +        #define GET_SUPPORTED 0x0
> > > +        #define GET_FEATURE   0x1
> > > +        #define SET_FEATURE   0x2
> > > +    IDENTIFY    = 0x40,
> > > +        #define MEMORY_DEVICE 0x0
> > > +    CCLS        = 0x41,
> > > +        #define GET_PARTITION_INFO     0x0
> > > +        #define GET_LSA       0x2
> > > +        #define SET_LSA       0x3
> > > +    HEALTH_INFO_ALERTS = 0x42,
> > > +        #define GET_ALERT_CONFIG 0x1
> > > +        #define SET_ALERT_CONFIG 0x2
> > > +    SANITIZE    = 0x44,
> > > +        #define OVERWRITE     0x0
> > > +        #define SECURE_ERASE  0x1
> > > +        #define MEDIA_OPERATIONS 0x2
> > > +    PERSISTENT_MEM = 0x45,
> > > +        #define GET_SECURITY_STATE     0x0
> > > +    MEDIA_AND_POISON = 0x43,
> > > +        #define GET_POISON_LIST        0x0
> > > +        #define INJECT_POISON          0x1
> > > +        #define CLEAR_POISON           0x2
> > > +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > > +        #define SCAN_MEDIA             0x4
> > > +        #define GET_SCAN_MEDIA_RESULTS 0x5
> > > +    DCD_CONFIG  = 0x48,
> > > +        #define GET_DC_CONFIG          0x0
> > > +        #define GET_DYN_CAP_EXT_LIST   0x1
> > > +        #define ADD_DYN_CAP_RSP        0x2
> > > +        #define RELEASE_DYN_CAP        0x3
> > > +    PHYSICAL_SWITCH = 0x51,
> > > +        #define IDENTIFY_SWITCH_DEVICE      0x0
> > > +        #define GET_PHYSICAL_PORT_STATE     0x1
> > > +    TUNNEL = 0x53,
> > > +        #define MANAGEMENT_COMMAND     0x0
> > > +    MHD = 0x55,
> > > +        #define GET_MHD_INFO 0x0
> > > +};
> > > -- 
> > > 2.47.2
> > >   
> > 
> > -- 
> > Fan Ni  

