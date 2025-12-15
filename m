Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC6286D5C
	for <linux-cxl@vger.kernel.org>; Mon, 15 Dec 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765795989; cv=none; b=fhXPG8MpovbXR41FOkHCGbLIgUmeIlAIW1/oX3WtrAYJe2atI40MvNrtlQng+jbjOqxkpAvfRHCEOZiTEyaDoKG2MI8qU/Xyv6UINFAosckyO/eDEHEpXJCGE0R2JD1rXYf5Qu/4lBQC6j5hjctn8k+SEQUx4NVF5jLNVA3HKBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765795989; c=relaxed/simple;
	bh=SFN6Br3QE3azNF1cwCtUqlkwp40eKlpvDs/ENDj/aY0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXZni3T0wWx5qfnmDg5/TNHNU9QYK01qIGtCjPqzyUmyc5P/IqqDVfN4BwjTx9gPLQrv5Ib2mVvJmEBBB4OGEAjSJsX5rPjgRfsdXDF9AT4Ee61dgtAZiYgA3QWqrHsa2wYQ/SrIeIaQPdC2JLUHxD4tpBo9thrbSgvqrlbbFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVH2Q0kCXzJ46m0;
	Mon, 15 Dec 2025 18:52:30 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 13E0C4056A;
	Mon, 15 Dec 2025 18:52:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 10:52:55 +0000
Date: Mon, 15 Dec 2025 10:52:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] cxl/events: Update memory event type for patrol scrub
 cycle end event
Message-ID: <20251215105253.00003fd6@huawei.com>
In-Reply-To: <a98e51a3-7939-4fca-9983-413d250f178a@intel.com>
References: <20251210131235.1731-1-shiju.jose@huawei.com>
	<a98e51a3-7939-4fca-9983-413d250f178a@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 10 Dec 2025 07:47:20 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 12/10/25 6:12 AM, shiju.jose@huawei.com wrote:
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
> > According to the CXL Specification Revision 4.0, Advanced CVME (Corrected
> > Volatile Memory Error) enhancements added additional granularity control
> > and event generation for Patrol Scrub cycle end.
> > 
> > Update Memory Event Type field in the trace events for section
> > 8.2.10.2.1.1, Table 8-224 (General Media Event Record), and section
> > 8.2.10.2.1.2, Table 8-225 (DRAM Event Record), to include the event type
> > 'Patrol Scrub cycle end'.
> > 
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>  
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> > ---
> > Open Question,
> > Option to enable event generation for 'Patrol Scrub cycle end' is given in
> > the Memory Error Threshold feature, Section 8.2.10.9.11.3 Advanced
> > Programmable Corrected  Volatile Memory Error Threshold Feature Discovery
> > and Configuration. Does support of this Memory Error Threshold feature is
> > required in the kernel or via fwctl?  
> 
> Any thoughts Jonathan? Is that something that would be exposed through EDAC?

I asked Shiju to add this comment because I wasn't sure of the answer about those
controls.  Given the current conservative view point being taken around more
complex scrub features in general in EDAC (which I'm not saying I disagree with!),
these might be very hard to land unless there are similar facilities in other
Scrub controllers and we can argue it is about generalizing the interface.

For anyone following along this new stuff is about counting granularity,
thresholds, resets of counters etc not the reporting of individual errors.
So more telemetry than error detection. 

So gut feeling is these are probably a fwctl / userspace tool problem but I may
well be wrong and then we run into that question of whether we can rip out
exiting functionality exposed via fwctl later. IIRC correctly we decided
we could but still don't want to do that unless we have to!

Jonathan



> 
> DJ
> 
> > ---
> >  drivers/cxl/core/trace.h | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index a972e4ef1936..e79c2bd415af 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -367,6 +367,7 @@ TRACE_EVENT(cxl_generic_event,
> >  #define CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x04
> >  #define CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
> >  #define CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
> > +#define CXL_GMER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END	0x07
> >  #define show_gmer_mem_event_type(type)	__print_symbolic(type,				\
> >  	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
> >  	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
> > @@ -374,7 +375,8 @@ TRACE_EVENT(cxl_generic_event,
> >  	{ CXL_GMER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },		\
> >  	{ CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
> >  	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
> > -	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }		\
> > +	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" },		\
> > +	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END,	"Adv Prog CME Patrol Scrub Cycle End" }	\
> >  )
> >  
> >  #define CXL_GMER_TRANS_UNKNOWN				0x00
> > @@ -554,6 +556,7 @@ TRACE_EVENT(cxl_general_media,
> >  #define CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x04
> >  #define CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
> >  #define CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
> > +#define CXL_DER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END	0x07
> >  #define show_dram_mem_event_type(type)	__print_symbolic(type,					\
> >  	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },				\
> >  	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },		\
> > @@ -561,7 +564,8 @@ TRACE_EVENT(cxl_general_media,
> >  	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" },			\
> >  	{ CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },			\
> >  	{ CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
> > -	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }			\
> > +	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" },			\
> > +	{ CXL_DER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END,	"Adv Prog CME Patrol Scrub Cycle End" }	\
> >  )
> >  
> >  #define CXL_DER_VALID_CHANNEL				BIT(0)  
> 
> 

