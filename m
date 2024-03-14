Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB4DDDA
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455813; cv=none; b=eN5zg09xWGv30y85qa8zBQSJti7RXEfJYuGs+slC7ogxTSm42D4tgBTGaIuu0jAKEfy6ISIoch6RVjyPx7tShsRTHpZtA18cOGMd9T42drVuZel/IPcI5j2Oc+e7KooXZwI+eS+WZOU+ZDurHyCznHDHyKBwcbzX2Da3jF9wkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455813; c=relaxed/simple;
	bh=6x1QjYVRSNKMD4pMjflLkG6Ez8XayoOzqneR4+oDFwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6W9oh3ZYRajkXtlgE2IUEmWOe9f6SWD7Jq//y+QOUair66oV5Pas/QIfnAyGB6o60N+Xlt361EsvCW4vbDj65MForGwygCokh1VDVDwOrxRzuNRbBqlO8PFOLhtry+tuoJFA7S0fg7FDwcCFxRadkq9Llji8UYAAsBl0Lc6G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXI1wLtK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXI1wLtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710455811; x=1741991811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6x1QjYVRSNKMD4pMjflLkG6Ez8XayoOzqneR4+oDFwU=;
  b=FXI1wLtKxN8gZ6uXCXSdCoSmRdMtpx6R1a5oONVjbfEL6/9uxUq7K/rJ
   ekzZ3A0FuEO2AZi8oAJwrFI+QLxIaU7gHrJyKXFQ5xMOjnud0naQx1gWr
   iHyUItpKFdSwAYU9iyal/W0evKAm8uZZWjRCU9YxReIiovMSrkaVdbzOr
   DE7BY90uck8I3I3n2Gh10C7Na7/YgCeVubGyZX8F3/NIR4becIWY/qMS5
   fZx6OfGG2R7rMhXwluLI5W5aPiZUp9epQ4PPbWlavd7h3g72ivs+bcyCg
   J0a4GdbgGceed0pqrPgE+7sgp1YMlh59+IXLTEb2ntpq7MSH/9IrPsz5a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="9142409"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="9142409"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 15:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="12373044"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.214])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 15:36:50 -0700
Date: Thu, 14 Mar 2024 15:36:48 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region name
Message-ID: <ZfN8AP/KdbsN32l1@aschofie-mobl2>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
 <20240314164136.6d10aa28@gandalf.local.home>
 <ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
 <20240314171737.2025ef60@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240314171737.2025ef60@gandalf.local.home>

On Thu, Mar 14, 2024 at 05:17:37PM -0400, Steven Rostedt wrote:
> On Thu, 14 Mar 2024 14:05:00 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > > I'm still curious to why NULL didn't work. I guess it may never have as I
> > > noticed there's nothing else doing that. There are cases that a variable
> > > returns NULL and the __string() handles it. But I guess the compiler gets
> > > confused if the NULL is a possible return to the condition in __string().  
> > 
> > Here's the full warning spew:
> > 
> > In file included from ./include/trace/define_trace.h:102,
> >                  from drivers/cxl/core/trace.h:713,
> >                  from drivers/cxl/core/trace.c:8:
> > drivers/cxl/core/./trace.h: In function ‘trace_event_get_offsets_cxl_poison’:
> > ./include/trace/stages/stage5_get_offsets.h:50:21: warning: argument 1 null where non-null expected [-Wnonnull]
> >    50 |                     strlen((src) ? (const char *)(src) : "(null)") + 1)
> >       |                     ^~~~~~
> > ./include/trace/trace_events.h:263:9: n
> 
> The full warning didn't add any new information. The above was all I
> needed. But I'm curious if you applied this patch if the warning will go
> away. (Note I didn't test nor compile this).
> 
> -- Steve
> 
> diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
> index e30a13be46ba..dfae18d8f4df 100644
> --- a/include/trace/stages/stage5_get_offsets.h
> +++ b/include/trace/stages/stage5_get_offsets.h
> @@ -9,6 +9,13 @@
>  #undef __entry
>  #define __entry entry
>  

+#ifndef STAGE5_H_INCLUDED
+#define STAGE5_H_INCLUDED
> +static inline const char *__string_src(const char *str)
> +{
> +	if (!str)
> +		return "(null)";
> +	return str;
> +}
+#endif /* STAGE5_H_INCLUDED */

Happy to try it out...

Your diff, with the ifdef above, makes the compiler happy and it functions
as wanted - no garbage in the fields.

> +
>  /*
>   * Fields should never declare an array: i.e. __field(int, arr[5])
>   * If they do, it will cause issues in parsing and possibly corrupt the
> @@ -47,7 +54,7 @@
>  
>  #undef __string
>  #define __string(item, src) __dynamic_array(char, item,			\
> -		    strlen((src) ? (const char *)(src) : "(null)") + 1)
> +		    strlen(__string_src(src)) + 1)
>  
>  #undef __string_len
>  #define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
