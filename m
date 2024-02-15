Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD412BF06
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000020; cv=none; b=c5kGQivVNGEWPbdHvRZqjx1xeeH09Gm+NmHTwQI7vKqwUUQ4Oytz8+x4kpPyt418pb4Z9kXbzJVqAeu4x6gwmoc8gfpT72GT89KfjUlxZ6YEfy3uuS+aqJA503mvkXK4x8Q1nNWEDb14En4I4mE/vEvyM2f8OXmD2qZ2IBJ+kgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000020; c=relaxed/simple;
	bh=zfaQIN++tKyb8V2bMlvNU20THmKV1BdusCCF0q0eABg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNwPwzpS4WwMVfYWtEvWzOZt7nYaTFqSyeM7bunnZdIMvpEExurFPAypvREUTcs2WT6F++bpDM9mKSgy9n6jrNa5Mnn7pHW/h6/ihbK0iCzSCQibCRiq/ZmBKtm+LeNmCDT3OxDmnRs7F7ZrB08H+AuyTxGMKsXrRcSQMzgzwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbDjp48H4z6897v;
	Thu, 15 Feb 2024 20:23:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B1CFD140B55;
	Thu, 15 Feb 2024 20:26:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 12:26:54 +0000
Date: Thu, 15 Feb 2024 12:26:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "john@jagalactic.com" <john@jagalactic.com>,
	Eishan Mirakhur <emirakhur@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Srinivasulu Thanneeru
	<sthanneeru@micron.com>, "shiju.jose@huawei.com" <shiju.jose@huawei.com>
Subject: Re: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log
 and Get Supported Logs Sub-List commands
Message-ID: <20240215122653.00005ce2@Huawei.com>
In-Reply-To: <834c6fec2ed74f9da7643ee61843373d@micron.com>
References: <20240207103634.199-1-sthanneeru.opensrc@micron.com>
	<20240208125713.00004776@Huawei.com>
	<834c6fec2ed74f9da7643ee61843373d@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 16:09:01 +0000
Srinivasulu Opensrc <sthanneeru.opensrc@micron.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Thursday, February 8, 2024 6:27 PM
> > To: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>
> > Cc: linux-cxl@vger.kernel.org; linux-mm@kvack.org;
> > dan.j.williams@intel.com; john@jagalactic.com; Eishan Mirakhur
> > <emirakhur@micron.com>; Ajay Joshi <ajayjoshi@micron.com>; Ravis
> > OpenSrc <Ravis.OpenSrc@micron.com>; Srinivasulu Thanneeru
> > <sthanneeru@micron.com>; shiju.jose@huawei.com
> > Subject: [EXT] Re: [PATCH] cxl/mbox: Add Get Log Capabilities, Clear Log and
> > Get Supported Logs Sub-List commands
> > 
> > CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> > you recognize the sender and were expecting this message.
> > 
> > 
> > On Wed, 7 Feb 2024 16:06:34 +0530
> > <sthanneeru.opensrc@micron.com> wrote:
> >   
> > > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> > >
> > > Adding UAPI support for
> > > 1. CXL r3.1 8.2.9.5.3 Get Log Capabilities.
> > > 2. CXL r3.1 8.2.9.5.4 Clear Log commands.
> > > 3. CXL r3.1 8.2.9.5.6 Get Supported Logs Sub-List.
> > >
> > > Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>  
> > 
> > Hi Srinivasulu,
> > 
> > Whilst I can conjecture some valid reasons to expose these to
> > userspace, can you add some examples to this patch description?
> > 
> > We might want to filter the clear in particular to avoid a clash
> > with the driver log handling. That is only allow it for vendor
> > logs.  
> 
> Are you suggesting that I should restrict the "Vendor Debug Log" functionality to
> only apply to Vendor logs.? Why not include Component State Dumps logs that 
> support the clear log feature?
> 
> I might be overlooking something; please enlighten me.

I had an old copy of the spec open. Indeed component state dumps
should be safe to expose as well.

> 
> For example, following both supports Clear log in our setups.
> * 5e1819d9-11a9-400c-811f-d60719403d86 - Vendor Debug Log
> * b3fab4cf-01b6-4332-943e-5e9962f23567 - Component State Dump Log
> 
> > 
> > Perhaps split the patch into 2 parts. The less controversial
> > GET_LOG_CAPS and GET_LOG_SUBLIST, followed by a patch for the
> > destructive clear log.
> > 
> > The memory scrub handling might well
> > access the ECS log for example (I don't think the current proposal
> > yet does this).
> > 
> > Jonathan
> > 
> >   
> > > ---
> > >  drivers/cxl/core/mbox.c      | 3 +++
> > >  drivers/cxl/cxlmem.h         | 3 +++
> > >  include/uapi/linux/cxl_mem.h | 3 +++
> > >  3 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 27166a411705..64a44e286488 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -64,6 +64,9 @@ static struct cxl_mem_command  
> > cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {  
> > >       CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
> > >       CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> > >       CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> > > +     CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> > > +     CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
> > > +     CXL_CMD(GET_LOG_SUBLIST, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> > >  };
> > >
> > >  /*
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 5303d6942b88..4128c810051c 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -529,6 +529,9 @@ enum cxl_opcode {
> > >       CXL_MBOX_OP_SET_TIMESTAMP       = 0x0301,
> > >       CXL_MBOX_OP_GET_SUPPORTED_LOGS  = 0x0400,
> > >       CXL_MBOX_OP_GET_LOG             = 0x0401,
> > > +     CXL_MBOX_OP_GET_LOG_CAPS        = 0x0402,
> > > +     CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
> > > +     CXL_MBOX_OP_GET_LOG_SUBLIST     = 0x0405,  
> > 
> > Name should include something to make it clear this is getting
> > sublist of 'supported' logs.  Not the log.
> >   
> > >       CXL_MBOX_OP_IDENTIFY            = 0x4000,
> > >       CXL_MBOX_OP_GET_PARTITION_INFO  = 0x4100,
> > >       CXL_MBOX_OP_SET_PARTITION_INFO  = 0x4101,
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> > > index 42066f4eb890..d2df9782a5ef 100644
> > > --- a/include/uapi/linux/cxl_mem.h
> > > +++ b/include/uapi/linux/cxl_mem.h
> > > @@ -47,6 +47,9 @@
> > >       ___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
> > >       ___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
> > >       ___C(GET_TIMESTAMP, "Get Timestamp"),                             \
> > > +     ___C(GET_LOG_CAPS, "Get Log Capabilities"),                       \
> > > +     ___C(CLEAR_LOG, "Clear Log"),                                     \
> > > +     ___C(GET_LOG_SUBLIST, "Get Log Sublist"),                         \  
> > 
> > Likewise, mention it's list of supported logs.
> >   
> > >       ___C(MAX, "invalid / last command")
> > >
> > >  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a  
> 

