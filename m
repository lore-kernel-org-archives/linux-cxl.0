Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E911C7019
	for <linux-cxl@vger.kernel.org>; Thu, 24 Apr 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490087; cv=none; b=XzLPaBE/oTU5/a8fGqe9G8HnB59VHXVZZgc7/6r8H1YgOxScOvHnxcff5I8w/p/3i03A3DQiDsZB06XjmcYXNpxiDMzKXd0LuwfJLug119+e71Oq2TTLQTh0BfwBxjyBJjriXQcAKx/dAHl5U0UikUEAFL3Qybw3pYV68lS+Pfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490087; c=relaxed/simple;
	bh=wRbxtAJ8xutCHWIeU/Ely1L8xQRfSuH72STuR6Mx4FM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trGpYH0N3maTQCMiXmVhQGUUnsC8KX3p9m12ldEgk2iEi1O6YclBDsmRyR3m1C6upNYcDHkpT90XpJAl05Y0FioiY8gtBfgnvWD7lozHZ9dBtRegJ9IuBT0PYQA2VGYDfb0C1gEKYG1rw/t3R7UOt8KPvUwdG8NjBW/pfHKYfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjsN73zNyz6M4Ph;
	Thu, 24 Apr 2025 18:17:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 234A414025A;
	Thu, 24 Apr 2025 18:21:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:21:18 +0200
Date: Thu, 24 Apr 2025 11:21:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Anisa Su <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <20250424112116.000024d0@huawei.com>
In-Reply-To: <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
	<20250317164204.2299371-3-anisa.su887@gmail.com>
	<20250318155624.00006410@huawei.com>
	<Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 31 Mar 2025 19:38:45 +0000
Anisa Su <anisa.su887@gmail.com> wrote:

> On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 16:31:29 +0000
> > anisa.su887@gmail.com wrote:
> >   
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> > > 
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > --- a/hw/cxl/i2c_mctp_cxl.c
> > > +++ b/hw/cxl/i2c_mctp_cxl.c
> > > @@ -46,6 +46,9 @@
> > >  /* Implementation choice - may make this configurable */
> > >  #define MCTP_CXL_MAILBOX_BYTES 512
> > >  
> > > +/* Supported FMAPI Cmds */
> > > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > > +
> > >  typedef struct CXLMCTPMessage {
> > >      /*
> > >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > > @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> > >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> > >                msg->command_set < 0x51) &&
> > >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > > +              msg->command_set >= 0x51 &&
> > > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {  
> > 
> > Hmm. There is a visibility problem here we should address but probably not
> > by introducing a new define.  Maybe we should move the enum from
> > cxl-mailbox-utils.c in a precursor patch.
> > 
> > Jonathan  
> Thanks for the feedback and review Jonathan.
> 
> According to the comment above this condition, "Any command forming part
> of the CXL FM-API command set... is valid only with the CXL Fabric
> Manager API over MCTP binding (DSP0234)."
> 
> From my understanding, this check is to ensure that any message
> sent from the FM API command set (0x51 - 0x59) has the MCTP_MT_CXL_FMAPI
> binding and all other commands (opcode < 0x51) are are sent with the
> MCTP_MT_CXL_TYPE3 binding.

Yes. That is the intent. Why the spec requires this distinction is a long
story we won't go into here...


> 
> Although I see from r3.2 Table 8-230 CXL Defined FM API Command Opcodes
> that commands from sets 0x57-0x59 are prohibited from being implemented
> in the MCTP CCI, would it be more correct to change the condition for
> FMAPI commands  to msg->command_set < 0x59? Then if/when commands from sets
> 0x57-0x59 are implemented, if they are implemented according to the spec, they
> should not be added to the FM MCTP CCI.

Agreed. For this check, if we are changing it we should update it to
incorporate the additional FM_API commands so < 0x59 to include the
various CXL fabrics things that have been added.

> 
> Please correct my understanding if this is incorrect.
> 
> Regarding the visibility problem, I intend to move the enum defining all the
> opcodes in cxl-mailbox.utils.c to cxl-mailbox.h and including cxl-mailbox.h
> in i2c_mctp_cxl.c
Ok.  I was going to suggest a separate header to avoid info about mailboxes
that wasn't relevant bleeding over into this mctp bridge device but that
header has very little in it so we should be fine. We can reorganizing things
in some future set if that header gains lots of other stuff.

Thanks

Jonathan

> 
> Let me know if that is what you intended.
> 
> Other than that, I have removed the extraneous TO-DO's from the other
> patches and plan to send out v2 with relevant corrections soon.
> Hopefully that makes the remaining patches easier for you to review.
> 
> Thanks,
> Anisa
> 
>  
> > 
> >   
> > >              buf->rc = CXL_MBOX_UNSUPPORTED;
> > >              st24_le_p(buf->pl_length, len_out);
> > >              s->len = s->pos;  
> >   

