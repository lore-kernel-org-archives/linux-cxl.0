Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60EE30EF97
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211608; cv=none; b=Un9dahcBfSJvFf++dZPQQDGa5kvYSHq13au6XIxXqo8IQKgOEQUGZbwviTyiPYKWgSte539rZ/LPGIS6qlj/Dz8+UcaKimDn/dnH48elX356p8MFjVc/2jTRkhC+HWP7zoOX13R99Zt210BbYjxAN1plWJBr4dZ3yEQSs1+NSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211608; c=relaxed/simple;
	bh=iUrsVHKsgDmwfg7fK0oldIASjxrV/ADNgB1Hm+Q9iK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgRRyt3YC0dLDbBeBvfjXjY5dPwTiPeROb+rroZbav6vdDwvDvOIt6IE4qWKU7cZO7b9+LG+4dS9PNVKbO4koTziB/+szIatGAzolhqCiUGDqJgThIcJ8nlNwx03gROhZAPjrgGoXuCFmZ5O0m35XvabbIrjx6fiXgFb63nUnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoxkB/xe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoxkB/xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1769A1F000FF;
	Thu, 24 Sep 2026 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211606;
	bh=T/tQ9GzmdWPHAnk8DShbDV7IjgTNUjRLPo8kuCIKXEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OoxkB/xelNuRl3ZtajyiwD0Oj5VDjJ/WXonH3IWOwyKAeyO8ON8EVPfmz/p7GLl6e
	 harmm30eyYHAHr/6ljHGxdUkK+rSVtk0W9IG862A/Q/+99EQBzcDniTfIp3g1srkvb
	 RlcO0XYTFn/9P8UDCiq7iVNC94W0xIv3ClPkk7QjzPXT4RSPBdi1NkR5URjAdxF5Vf
	 vkCV70ToyJD3464Jh/0D1n26eMiTG4H4ku+hX0r+BkIeUpXd+oMhUc+oE+BTmJI6c6
	 CYDsCla7xATBIUaN+s/cER3RQYva+XBlUzq/zlpgibQBvEB5EWHBq47JlnyNQjIMV+
	 pNeGAbMF35ctQ==
Date: Thu, 24 Sep 2026 02:00:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] cxl/events: Test CME counter expiry with equality,
 not bitwise AND
Message-ID: <20260924020000.390875d2@jic23-hlaptop>
In-Reply-To: <20260922082214.3526355-1-kanie@linux.alibaba.com>
References: <20260922082214.3526355-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 16:22:14 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> The Memory Event Type field in the General Media and DRAM event records
> is an enumeration, not a bitmask. The validity checks for the advanced
> programmable CME counter expiration event (05h) test the field with a
> bitwise AND, so types 01h, 03h, 04h and 06h match it as well.
> 
> A device reporting one of those types trips WARN_ON_ONCE once the
> general media or DRAM tracepoint is enabled, which is the case anywhere
> rasdaemon collects CXL events. Under panic_on_warn=1 that kills the
> machine.
> 
> Compare the type field for equality instead. Type 05h records that do
> violate the spec conditions still warn.
> 
> Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
> Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
