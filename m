Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9CB64D
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456480; cv=none; b=hgX0RD02zriaiTgXyz9xAmlE9fLiMeTxqYlenCiGBphUpxsjqtjUFp0yDbVrh34kA+lhlPh7WPis0NOtPcjphzPz6FRm/Mmuapun5flmmvmP8V38gPFKs9Id7uAUjQ6s2HSorLnxiMdkdnZnXa0TkZ9p1WrnuncjTcIjrcF3BWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456480; c=relaxed/simple;
	bh=hTzcatGjAXWTqa8zkRaGEtL/JKXM3mdrrsYjsv1nXVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dj3VqehvgejeJUGMqbM1h9PcaNokaqD/XfXK4V/HPmDl5u6DDALpEcwOUxkvkq+HaIscP/LSkMdesQhwy22V8iggPRoFfXg9pYOZA8ZrvGrm+g/j+C86nizibU0eBGz+7sqViquSp/IIOZlmb6TlzefFG4iaq8+ZCPLnrCrmkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845A7C433C7;
	Thu, 14 Mar 2024 22:47:59 +0000 (UTC)
Date: Thu, 14 Mar 2024 18:50:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/trace: Properly initialize cxl_poison region
 name
Message-ID: <20240314185010.6162cbfe@gandalf.local.home>
In-Reply-To: <ZfN8AP/KdbsN32l1@aschofie-mobl2>
References: <20240314201217.2112644-1-alison.schofield@intel.com>
	<20240314164136.6d10aa28@gandalf.local.home>
	<ZfNmfCmgCs4Nc+EH@aschofie-mobl2>
	<20240314171737.2025ef60@gandalf.local.home>
	<ZfN8AP/KdbsN32l1@aschofie-mobl2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 15:36:48 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> > diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
> > index e30a13be46ba..dfae18d8f4df 100644
> > --- a/include/trace/stages/stage5_get_offsets.h
> > +++ b/include/trace/stages/stage5_get_offsets.h
> > @@ -9,6 +9,13 @@
> >  #undef __entry
> >  #define __entry entry
> >    
> 
> +#ifndef STAGE5_H_INCLUDED
> +#define STAGE5_H_INCLUDED
> > +static inline const char *__string_src(const char *str)
> > +{
> > +	if (!str)
> > +		return "(null)";
> > +	return str;
> > +}  
> +#endif /* STAGE5_H_INCLUDED */
> 
> Happy to try it out...
> 
> Your diff, with the ifdef above, makes the compiler happy and it functions
> as wanted - no garbage in the fields.

Hmm, I guess the:

 strlen((src ? (const char *)(src) : NULL) ? (src ? (const char *) src : NULL)) ? "(null)")) + 1

was too complex for the compiler, where as:

 strlen(__string_str((str ? (const char *)(src) : NULL))) + 1

is not.

Perhaps I should add this change. I would still submit your change with the
"" as that needs to be backported, but this probably does not.

Thanks for testing it out.

-- Steve

> 
> > +
> >  /*
> >   * Fields should never declare an array: i.e. __field(int, arr[5])
> >   * If they do, it will cause issues in parsing and possibly corrupt the
> > @@ -47,7 +54,7 @@
> >  
> >  #undef __string
> >  #define __string(item, src) __dynamic_array(char, item,			\
> > -		    strlen((src) ? (const char *)(src) : "(null)") + 1)
> > +		    strlen(__string_src(src)) + 1)
> >  
> >  #undef __string_len
> >  #define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)  

