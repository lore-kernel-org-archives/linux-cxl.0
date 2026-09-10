Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA447ACF5;
	Thu, 10 Sep 2026 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041518; cv=none; b=OQfRPA7O2YtB4Tivm6S5t7MZBlthqt95ALAZik31lYRPwWc8/yy+VE9KhK7r/LeAdtzZM9BLrFzKs2/emjqnOCPk0BryQkYEcuvVs2ZMUEtC4e+0nEfRuHQ58h58vQdmNIUnqHwM2UC7WzSWIVOIiX8N+J717A4irLrbh61Ico8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041518; c=relaxed/simple;
	bh=sZTPiI9pq8B6ch5ZN8oYM4tHsLIRWG79pQ7BcoCas74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqlTn+F9cUep9r5BbHw/zRiOs7VEsyQJbmG7ls2a2xNtyNYkqZHIIvrse03uAmCPn6/IneC7YCh8ZNxbAFPbC9FbZqaiW+iZMnsXkiLJHr+k8MnZNLC7rOUUKp+XnAjW69LdWVRjV3Z/8XukK58v5ZJ4XNSyNAMBoziA1bq4kwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ejo5NtW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ejo5NtW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DC21F000FF;
	Thu, 10 Sep 2026 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789041517;
	bh=FXMWPG+SGC8fr6JFhkp5MngVOCjeqziDFf4ZklQ+Lcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ejo5NtW6YoWhE+TEJRHH8tUCUpgPNKotRHbM/H6/kR6JQdkGHtOhsXr0XH3KpsDSZ
	 EIQVoX8fzs+6iSeVlp+VjwS2GYmAC4t3dfK7sM1dV6uHByey+J/6EsTVOri/Lp966z
	 dGBFJeh4ASwoIdsM37Tu4HCxT9C9ettl0ATuXyR4=
Date: Thu, 10 Sep 2026 13:58:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH v3 2/2] cxl/memdev: Fix deadlock between poison debugfs
 and cxl_mem unbind
Message-ID: <2026091021-could-rockiness-15db@gregkh>
References: <20260910094017.4032170-1-kanie@linux.alibaba.com>
 <20260910094017.4032170-3-kanie@linux.alibaba.com>
 <2026091013-deepness-astronaut-471a@gregkh>
 <ea74384f-714a-495a-8d78-d47a9657e05e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea74384f-714a-495a-8d78-d47a9657e05e@linux.alibaba.com>

On Thu, Sep 10, 2026 at 07:28:03PM +0800, Guixin Liu wrote:
> 
> 
> 在 2026/9/10 17:52, Greg Kroah-Hartman 写道:
> > On Thu, Sep 10, 2026 at 05:40:17PM +0800, Guixin Liu wrote:
> > > The poison debugfs handlers take the memdev device lock so that the
> > > region lookup sees a stable cxlmd->dev.driver. debugfs holds a reference
> > > on the file across the handler, and cxl_mem unbind removes that file
> > > while holding the very same device lock, so a handler that waits for the
> > > lock deadlocks against a concurrent unbind.
> > > 
> > > Both tasks then hang. The unbind side is uninterruptible, and it also
> > > blocks the memdev detach work, which runs on an ordered workqueue and so
> > > stalls every other CXL bus work item.
> > > 
> > > Take the lock with the trylock guard and return -EBUSY instead of
> > > waiting. An unbind that wins the race removes the file first and the
> > > write fails with -ENOENT.
> > > 
> > > Found by code inspection. Reproduced by writing inject_poison in a loop
> > > while unbinding and rebinding cxl_mem, and confirmed fixed by the same
> > > test.
> > Why would anyone normally "unbind" cxl_mem at all?  That will taint
> > kernels soon, so you don't normally want to do that, right?
> > 
> > And debugfs is root-only, so this is a "root did something bad, and gets
> > to keep the mess", right?  This should not ever be a normal operation.
> Agreed, nobody should unbind cxl_mem in production. The sysfs unbind is
> in the reproducer only because it's the cheapest trigger.
> 
> The window itself is not sysfs-unbind specific.
> The debugfs directory is torn down from a devm action, so every path that
> ends
> in device_release_driver_internal() hits the same wait: rmmod cxl_mem, and
> the
> memdev detach work that PCI hot-remove schedules. That detach path is the
> third
> task in the reproducer stack, the one wedged on cxl_bus_wq.
> A poison write racing an rmmod or a hot-remove is not root misbehaving,
> and no taint flags it either.

But how can cxl_mem ever be removed, it doesn't live on a bus that is
hot-removable, does it?

rmmod doesn't count either, that never happens except by developers.

thanks,

greg k-h
