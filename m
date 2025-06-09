Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6222576A
	for <linux-cxl@vger.kernel.org>; Mon,  9 Jun 2025 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509626; cv=none; b=GBJtUnOHP3RXzfGZg9d9mw33NNEAgYZu93LFUvAwBscau3ypGe9dlx85byYyNEJ/kgiAwX528FYUqspcPMo7IYTCt7eUzc+A6qMDQsPcuJH6gx69DacMfjqZ/KGLW6S8KNqTEm/IIi9OV43+VEP8zVYpgoyABYnP/o2CLMrPp1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509626; c=relaxed/simple;
	bh=4AYdgGY6rxuPVadvAr4KIxrafcwxqgFWS6n6kU7Z7OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r926C9UF+fHkTQJ6jdUXIrACsZP9iyTQvEW3YiseONMvwMfxCeZDbt/IZLb9vak6tUcGcQTGROxswW5a98aXtpQt16vuKZR0ZBEZXR0+A/nhCnXB58ag4y/UneFCjORTNvpRE98msV43VpwG4Ai/37gF0yPu2u+ctXOFE8GKQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o2JUa19n; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o2JUa19n"
Date: Tue, 10 Jun 2025 07:53:31 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749509621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jxOE58UHkmyNaPXHD2BEAW9G/zuBXBYxX7HObtol/Pk=;
	b=o2JUa19nU6VI9eHrFmLm25tJTWCrylx3+QZroe5AtZqrqHSWWwAc2MzoKO83N+hbDd8hjx
	HyQqaHCfTW8t5FzjBfT+L9eV6o0jHQyK/vdZp/MiRy1DmVuO5ZjFU+En4Khm3f1BbCz5oa
	4LZuymeS5mnmDQOre3uoa5uWqZUUvPA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
	Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: Re: [PATCH v14 2/5] hw/cxl: Make the CXL fixed memory windows
 devices.
Message-ID: <aEdl6xvqyOsU+Z2S@vm4>
References: <20250528110726.226389-1-Jonathan.Cameron@huawei.com>
 <20250528110726.226389-3-Jonathan.Cameron@huawei.com>
 <20250529160801.00003ade@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529160801.00003ade@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 29, 2025 at 04:08:01PM +0100, Jonathan Cameron wrote:
> On Wed, 28 May 2025 12:07:23 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Previously these somewhat device like structures were tracked using a list
> > in the CXLState in each machine.  This is proving restrictive in a few
> > cases where we need to iterate through these without being aware of the
> > machine type. Just make them sysbus devices.
> > 
> > Restrict them to not user created as they need to be visible to early
> > stages of machine init given effects on the memory map.
> > 
> > This change both simplifies state tracking and enables features needed
> > for performance optimization and hotness tracking by making it possible
> > to retrieve the fixed memory window on actions elsewhere in the topology.
> > 
> > In some cases the ordering of the Fixed Memory Windows matters.
> > For those utility functions provide a GSList sorted by the window index.
> > This ensures that we get consistency across:
> > - ordering in the command line
> > - ordering of the host PA ranges
> > - ordering of ACPI CEDT structures describing the CFMWS.
> > 
> > Other aspects don't have this constraint. For those direct iteration
> > of the underlying hash structures is fine.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I'll not post v15 for a while to give time for review, but I just realized
> this snippet was in a patch I was carrying on top of this and should have
> been in this patch.
> 
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index a610795c87..de66ab8c35 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -46,7 +46,6 @@ typedef struct CXLState {
>      bool is_enabled;
>      MemoryRegion host_mr;
>      unsigned int next_mr_idx;
> -    GList *fixed_windows;
>      CXLFixedMemoryWindowOptionsList *cfmw_list;
>  } CXLState;

With this one line removed on top of v14, today's Dave's cxl/next kernel makes
cxl test suite ran through without a single failure.

Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

Jonathan, Zhi jian of Fujitsu gave you feedback on the QEMU core CXL emulation code, 
are you still waiting on any other reviewers to take a look at the series v14 (or
v14-ish)?

Thanks,
Itaru.

> 
