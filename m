Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089F4BCABA;
	Tue, 15 Sep 2026 23:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514934; cv=none; b=IIS9cMWWFqtRJh6sVBfkzqtv1cUI4CQnLrgSpL959DPcWg9PDXMhXqxO/eNTz2TJjOn9MTgMcEuI8Bf9as1YUB36CyJjzLpHwDEoz8OPZFPiFS5RJ+M9cqAv79RmNGe+AL1LQuzEUAe8WoCBHRn88mYgGLTxb3rJmdCGBzSH/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514934; c=relaxed/simple;
	bh=qKoWvplAH6DgwyVkxaNOoPP54cwOiVLVAMhemT7u5CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1FlyvIfmDfADapN+9OBCNGfRTgVAycpO0KjgfYtf+3nTjiGzwTD+IEPsauZwkWpWq4cX0+fp7kLT6hHWEBud15DGOwBndcvHPGyEcnfVitY7XkcAEs0GUmwsX3B4ixfDsF0FT2cBFf8HppUwq2Q+NNZfF4eLwqaOYOC0AbD/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXQdE+GS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXQdE+GS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F61F000FF;
	Tue, 15 Sep 2026 23:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789514932;
	bh=nsnqk+K9KcVSTLlwNYyLqXbWMQBB5C/cAddubGUzGOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lXQdE+GSJSpOCX16sf+zbxKx16qkPkj+y3jKRksmoi3CuyPsZ5u7rLHkpZuE3cc9D
	 A5Aw6T2wOxtKTf4Y6SBcK+sqMyJB/Gvqssc6IrWOoiIcQ51y5ljWPVyX1Z45dzhNP5
	 D7xcyTEf4W2f7xzbiM6S8h0ZOQUwoULtaWUN7q0tX4B1uMUll9bnJ7F/rcPFPvXLxd
	 ClnxLSn67gsK8AqTylwROhWwz01o29W266RYQmcUuIH20zVqBoIJarBS1bMDWH6Sc0
	 tV2oajUsF3OL5Umx8G3AF/o47P1bWvTz4Pok3R/NMx+cjy2K3N2TwKokBPZu8pyh+b
	 jg/YA3IlkAV2Q==
Date: Wed, 16 Sep 2026 00:28:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, anisa.su887@gmail.com,
 benjamin.cheatham@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Message-ID: <20260916002851.4407b04f@jic23-hlaptop>
In-Reply-To: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 15:08:15 +0530
Shaikh Kamaluddin <shaikhkamal2012@gmail.com> wrote:

> CXL event interrupts may share an MSI/MSI-X vector with other event
> logs or device features. Consequently, cxl_event_thread() is registered
> with IRQF_SHARED and must determine whether the event-log facility
> claimed the interrupt.
> 
> The handler masks the Device Event Status register to the event logs
> supported by the driver. However, when no supported status bit is set,
> it exits the processing loop and still returns IRQ_HANDLED. This
> incorrectly reports that the interrupt was claimed and prevents the
> generic spurious-interrupt detector from accounting it as unhandled.
> 
> Track whether the CXL event handler claimed the interrupt and return
> IRQ_NONE when no supported event is detected. If no handler sharing the
> vector claims a sustained interrupt storm, the generic spurious-
> interrupt detector can eventually identify and disable the affected
> IRQ.
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
