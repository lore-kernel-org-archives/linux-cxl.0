Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4E31A81C
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624640; cv=none; b=sZKFCmsef2IyIbk9vcVV/nblgql2dfdbwe+UEfuuHPs2Pt92b29tjoFInWjL2jESXuTCyVSrGAXHtnSPSU1m1c69wrh4uDmAbJmxkA65f3CK3mIa9Xv4kdlJPZuskd+4eCkF9dyhff/P0f2vPu3kFfCI86nUvgKIYdxNJhXexlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624640; c=relaxed/simple;
	bh=pis06wkXD4RWAfuRxuug5rKUZx3VJQr1v7l+fB6zzzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJImvHUNxvRhbhRSGLymxv7wAJN1dHAjHdHV+6IgOpQB0sYixqP/bkai4JImkWxrevVwYqjmHyU3Plg2TyaXTWVPJ782l8TqXt2d5ou6QhOpaCCV0AXP0/G5WsxscEhWcRS4rA1qC9OhrMVkq3xT/O4fD1do/wI7gm8AGbnNXTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 51A061B9962;
	Fri, 27 Mar 2026 15:17:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf14.hostedemail.com (Postfix) with ESMTPA id 70A0830;
	Fri, 27 Mar 2026 15:17:05 +0000 (UTC)
Date: Fri, 27 Mar 2026 10:17:01 -0500
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com, 
	alison.schofield@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	dongjoo.seo1@samsung.com, anisa.su@samsung.com, linux-cxl@vger.kernel.org, 
	John Groves <jgroves@micron.com>
Subject: Re: [RFC PATCH 0/1] cxl: Media Operations
Message-ID: <acaes_gqFt-LLFrC@groves.net>
References: <20260323204013.4010634-1-dave@stgolabs.net>
 <20260324153238.0000750e@huawei.com>
 <20260324180754.et4gwn6dobdplurt@offworld>
 <20260325120613.00007003@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325120613.00007003@huawei.com>
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 70A0830
X-Stat-Signature: jde38t4c6xgfw9omomu7uho7qau5xnyc
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX19MkH3PTVbriYSiZRCQz1ujHn/a+sbAtv8=
X-HE-Tag: 1774624625-677811
X-HE-Meta: U2FsdGVkX19rC4hhL6LiP66cYCh5UY5FsoWT5SjTeyaRM0KlwKwJxkHcCTT4MmvnTMyFRxI7wijutmsXfMdhXo25+AEVvLk/gz8C959KgvjKKBURb/1LU6EdFJu3uLtPdBI3g1YemBx1Qwym8woztsAPzsyl7gjTpLJES7rxjHW0Is3PbAFLBcuC629yCnsAlDsk+ni2i/IhdHhMoCqzAJHwVYHHVbRuFbJ3sNIwOTWgSuhFBD+3Mbvlk8ynnsrdFaPyTVPK7dDiaOsPW6zSemH4Wh4fQpkV9XEXQz32zFKB3N7PMwxGdw4mn0Gz6aA5hH+Uu1UStqA8b70XVYXyuSQ/cft9nJ9J1SJgeIO9E4FcYpjtD1eXCqSpuKYvX4r6

On 26/03/25 12:06PM, Jonathan Cameron wrote:
> On Tue, 24 Mar 2026 11:07:54 -0700
> Davidlohr Bueso <dave@stgolabs.net> wrote:
> 
> > On Tue, 24 Mar 2026, Jonathan Cameron wrote:
> > 
> > >On Mon, 23 Mar 2026 13:40:12 -0700
> > >Davidlohr Bueso <dave@stgolabs.net> wrote:
> > >  
> > >> Hello,
> > >>
> > >> This implements support for Media Operation cmd. It is marked RFC because of these
> > >> noteworthy points:
> > >>
> > >>  (i) Sysfs interfaces. These changes implement 'security/zero' and multiplex
> > >>      'security/sanitize' to allow dpa, len pairs for the range (no impact for
> > >>      current usage as whole-device). This breaks the 1 value per file "rule",
> > >>      and would be a first for drivers/cxl/*, so am I open to suggestions.  
> > >
> > >Value is a vague sort of term.  It's one thing (an range) so seems fine to me.  
> > 
> > I agree.
> > 
> > >  
> > >>
> > >>  (ii) Background cmd handling semantics. Media operations are synchronous,
> > >>       which for raged zeroing operations makes sense and for range sanitize  
> > >
> > >ranged
> > >  
> > >>       differs from the current async handling for whole-device, so user response
> > >>       differs significantly, something I am not crazy about. Another downside
> > >>       of this is that it exposes lock hold times to be user-controllable, but is
> > >>       no different than what we do for fw. Fundamentally, users have the
> > >>       responsibility to break up the work into sane ranges.  
> > >
> > >We could apply a limit on this and make that discoverable via another sysfs attribute.
> > >So let userspace request in say 1Gig chunks.  Would have to check that the device
> > >supports that granularity though.  
> > 
> > If we agree that this will be performed synchronously, then yes, adding a size cap
> > would be necessary. I don't love having it in ie: security/range_limit(?), but that
> > could be created at discovery time when we know the granularity. Another way would
> > be to avoid the extra file and just print the limit in the error message - but I
> > guess dev_dbg() would be needed to not spam the dmesg. In any case with a cap,
> > while no guarantees, this also reduces the chances of the user triggering driver timeouts.
> > 
> > >I don't think there is anything in the spec today to let us query how long
> > >something takes (which would be a better way to bound this).  
> > 
> > Correct, that is just something Scan Media allows for - and yes, that's exactly
> > the sane way to do the work breakup.
> > 
> Yo John,
> 
> I'm sure you are keeping a list of potential improvements for the appropriate group
> that I believe you have some leadership role in ;)
> 
> I'd like devices to provide info to allow us to establish an upper bound on how
> long a zero / sanitize media operation would take.  This one doesn't need to be
> code first so we can consider this a potential feature request.
> 
> Jonathan
> 
> > Thanks,
> > Davidlohr
> 

Acknowledged. Are you thinking of a one-off for sanitize, or is there
a class of commands that might ought to provide such an upper-bound?

I'd be happy to try to push something through, but the solution ought
to come from somebody who experiences the inconvenience directtly :D

Regards,
John

