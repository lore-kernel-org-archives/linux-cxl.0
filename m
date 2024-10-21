Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6F15575F;
	Mon, 21 Oct 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493884; cv=none; b=lNZwx26ACldlekEWPwJ7MNdsQyy61u/rQy9oJ75v2ua4zOJ6GYbswQSMIM114eVYwXQvD+Xk7mypoqiwI2t77qP7t/hGlH7FkPcAPt8JtuF/iK0OufS5K31cqfsbHeI0ypFby9FY7Vkq9kyHgsPVypPWMlfVz/maCFbNY9ZhdM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493884; c=relaxed/simple;
	bh=IiPcz/ByZa0vEMsnAb+L+ohy/99zqiBcnsh87LOh/Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQzh7V1Fb//0PL+5FyvfuYonsmSyDmxhLnFXSk96SaYoLugPGvcaSglVItFRXVBjF/wJEwwIMzFF7+m/iTtvdDUAKWHR3g9LldUUfKeL/SEv+ybkrDK8PpvuuUDqde/evvoi28htAyeW+Un+D0WKs0KX/8WKQ0k4Oq75SRmcM2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1o9ZO03; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1o9ZO03"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729493882; x=1761029882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IiPcz/ByZa0vEMsnAb+L+ohy/99zqiBcnsh87LOh/Lk=;
  b=Z1o9ZO03WX44w77UQ5nMG4q+la058ychSbeE7XaYU6woCkUxsgQgziya
   z2FnyQ4hL/lPncBAtEc6d+HR50bDBkqO1wbZmxOkKU8RwHPxeNtpx8GYR
   Xa9m6SKhFkjIgVRrlhPwMyVoy5bvqQkfmwxEDBElgGoTaiyKIdgCSO8X+
   ZJxxmWbMd1sN1mZuQgTo9ITBv+6cIwtkC0h4hmwxIVfzzqddJWQ8RH6CI
   05VO66rKP/UpSxfQlqmd7gkMDv/kD7B8EYQMcJQQ7D1ttSUMHpPXsvVhU
   jBukf+ObUcJQJOtA/3IfNlTVDNTRJ6WbxVeGcCR9dFb3BGdhl3Osqde2t
   A==;
X-CSE-ConnectionGUID: zr92viR1R5CMBqWtW+bSmg==
X-CSE-MsgGUID: TXGEKVcaQPyPuJ6EQzt4ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="29081696"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="29081696"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:58:02 -0700
X-CSE-ConnectionGUID: Dc6fbp8TShqAwhD/eE668w==
X-CSE-MsgGUID: aCechL/iTkKb3hcV7J22Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84223930"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 23:57:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2mMT-00000005OxN-44c7;
	Mon, 21 Oct 2024 09:57:53 +0300
Date: Mon, 21 Oct 2024 09:57:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <ZxX7cfx2kOssqR2H@smile.fi.intel.com>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
 <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 18, 2024 at 01:05:22PM -0700, Dan Williams wrote:
> Ira Weiny wrote:

...

> > +	%pra    [range 0x0000000060000000]
> > +
> > +For printing struct range.  struct range holds an arbitrary range of u64
> > +values.  If start is equal to end only print the start value.
> 
> I was going to say "why this special case that does not exist for the
> %pr case?", but then checked the code and found it *does* do this for %pr.
> So if you're going to document this special case for %pra might as well
> update the documentation for %pr too.
> 
> Alternatively, drop the new %pra documentation for this corner case as
> accommodating the U64_MAX size range case is arguably a mistake in the
> caller.

You probably meant "...(U64_MAX + 1) size..." as we end up with the same value.
But yeah, I also noticed the same.

-- 
With Best Regards,
Andy Shevchenko


