Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245091DDC9
	for <linux-cxl@vger.kernel.org>; Sun, 10 Mar 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710110354; cv=none; b=QyjvxaHZFVO9cWtMWl2oFlZKRJIOZ7U3gEyJXQOyOgsPO8ANC3rBqaZ7c+FaQPYyPmjTu9WXU04HqUAMIxZjShRko6w0xJrA4VYMjCHsJaQMDqJGYWExdyq/KolPal6OtbxJSCgfa8/FDwb27UDk1pktJgmYs0uZbMZEcaPt05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710110354; c=relaxed/simple;
	bh=ThY8vgw29XUt+LXEgDB+ZDzPZJh3cC/S/bK+aCVT8yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elXIw0wgxCHvP2JRlg8MygRnM7r0Eck1pHXyVWr+PAjRFRXIsLmnLcyj14mGlW8bobbCSyiFzgNSZ8BFKcyvvRxI1V4axna7gjg4IMdF8TmqxiWYe5dQfIXbALWLF/Gno0uYJL5CeHTf5WUpyQG+eTqGbMI+IkQ72l1JridmbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gMI9oMsA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gMI9oMsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710110352; x=1741646352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ThY8vgw29XUt+LXEgDB+ZDzPZJh3cC/S/bK+aCVT8yk=;
  b=gMI9oMsA1gIwONFs6thWJnhvGLpCZtljdP7HgTqWoO4ueD7pFSC5o47Q
   4J/OWivtfgrq/4zVk0NEAMQofEeCLHUpM4LWooxGAkQ/3KzBhmCptIPNm
   sAcjuZNob4S+ak0ReRVBJB8obF/fP2M1XDRQjoZ2gfsV9skaB/pd/kN0X
   CbETREsKRRLH6+42MO5nT8L2fcF9PYlMfLz5DnocWjhhatPtV3PEH6rXd
   gMfKKY3xushgj896Z10GvD7DQbfDuuCGo62H1BKq7VSnwICu3k7J4hOhx
   1CUr8aQ2pO9h/3M6i1VkVUBdaHWgcnR6lMz4e0xpLKogfIcfTghVG6oWG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4611626"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="4611626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 15:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="11078439"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.25.157])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 15:39:11 -0700
Date: Sun, 10 Mar 2024 15:39:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [ndctl PATCH v10 3/7] cxl/event_trace: add a private context for
 private parsers
Message-ID: <Ze42jVuoaFcshrV4@aschofie-mobl2>
References: <cover.1709748564.git.alison.schofield@intel.com>
 <6e975df49a62cdb544791633fdd1a998a0b60164.1709748564.git.alison.schofield@intel.com>
 <65e8fe00756cd_12713294f2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e8fe00756cd_12713294f2@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Wed, Mar 06, 2024 at 03:36:32PM -0800, Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > CXL event tracing provides helpers to iterate through a trace
> > buffer and extract events of interest. It offers two parsing
> > options: a default parser that adds every field of an event to
> > a json object, and a private parsing option where the caller can
> > parse each event as it wishes.
> > 
> > Although the private parser can do some conditional parsing based
> > on field values, it has no method to receive additional information
> > needed to make parsing decisions in the callback.
> > 
> > Add a private_ctx field to the existing 'struct event_context'.
> > Replace the jlist_head parameter, used in the default parser,
> > with the private_ctx.
> > 
> > This is in preparation for adding a private parser requiring
> > additional context for cxl_poison events.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  cxl/event_trace.c | 2 +-
> >  cxl/event_trace.h | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/cxl/event_trace.c b/cxl/event_trace.c
> > index 93a95f9729fd..bdad0c19dbd4 100644
> > --- a/cxl/event_trace.c
> > +++ b/cxl/event_trace.c
> > @@ -221,7 +221,7 @@ static int cxl_event_parse(struct tep_event *event, struct tep_record *record,
> >  
> >  	if (event_ctx->parse_event)
> >  		return event_ctx->parse_event(event, record,
> > -					      &event_ctx->jlist_head);
> > +					      event_ctx->private_ctx);
> 
> Given ->parse_event() is already a method of an event_ctx object, might
> as will pass the entirety of event_ctx to its own method as a typical
> 'this' pointer.

Thanks, done!
Now passing event_ctx struct as a param to its parse_event method.

> 
> You could then also use container_of() to get to event_ctx creator data
> and skip the type-unsafety of a 'void *' pointer. However, I say that
> without having looked to see how feasible it is to wrap private data
> around an event_ctx instance.

Got rid of the void but didn't go down above path.

First off, I don't see need to find an event_ctx field from private_ctx.
I can see the use, but not the need. There are 2 users presently, one with
no private data and one with private data (cxl_poison).

If there were multiple users, or multiple users in sight, adding a flexible
array member to a private context struct and using that in container_of to
find the event_ctx might be useful. 

Next rev simply includes the poison_ctx directly in the event_ctx,
avoiding the void ptr usage.

Please take a look at next rev.

Thanks,
Alison






