Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C07723F40D
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825056; cv=none; b=Tum8bN5kxdm7OyWkrFkyCT99/ZAVfZpx/vxkbGFqJgk3FtMO+O23XWb1ttkCMFxypU6F4dgnL4dyKamfKYsCjnsoFpd/BlzG11QJ20MC6vgn9Kd4M5yC8HMfclWuuZT9+uiAcm1hhOaUM6J7efjkQvBZYTtr4b/wKdWrf3uMCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825056; c=relaxed/simple;
	bh=Z4/Hz+3pOH8Nn+96aF9/ARq4sB9Ybd+yeC/klssY9ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXTf09DDDNhImof/N/q1BjBZWwnxF2MwbhD6gA72Aw1UrD+TpsS/JYsisQMZVSM/wUNvR6sQFpBzoodHsZ+F+pLtXtFcmjwPhUUwYJ1FsTrN5P0p9uS0OQLF4xwlAbUIhc1Z8iDL2iFuB3IjPAWVnFwhhkECsz5B1pTFQbP+jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw/5Wotb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw/5Wotb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4E81F00A3D;
	Mon,  7 Sep 2026 23:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788825055;
	bh=A6VXYGze+t7TBB9TQO7Kr93RJhbJi0Z2NUAcXldgy18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yw/5Wotbz7KkK1KCvBleNr3p9coRHDtCmMGYU3s7HacMGkAB3vLOZDcO42FLhFZJf
	 rCTelrZ2XBnAVwFyYZ2Q3rJYQPeGOYxmobUVgz6j3/byuk2G8BYlwWuygKZ33jI8rJ
	 B3TW0qhLGpPBVD3F4NFAoMqBN2iGSCDXBXnvnhsTZ+VkclJPTfoxhMqq2IVl8yD0PK
	 Dsm2PyLQkwSQpJjtZ5hLiXa1zS8ms3aeMrWvOIMY41p3WaR7aSz0OgQJIsobyI56K6
	 V2WtoctReAJIlXqDNjyVCsG2+IV19FqmE7fguOPJcplGbWwzyDZnI3gQztPYx3uIMq
	 JTWTng6PPqxUw==
Date: Tue, 8 Sep 2026 00:50:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/7] cxo_ol/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <20260908005049.32763a31@jic23-huawei>
In-Reply-To: <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
	<b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 16:23:46 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_port_setup_targets() derives the interleave granularity of one decoder
> from the granularity and ways of the decoder above it, and takes that
> decoder's own ways from the topology below it. The values from the level
> above are named parent_iw and parent_ig, but the values being derived are
> the bare iw and ig, so the reader has to work out which level each one
> describes.
> 
> Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> for the level above.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

I was wondering a bit about having ceig and ceiw but those would be
very local so I guess not worth it.

Given how often we use ways_to_eiw() not to make the conversion
but just to check if it is possible, I wonder if a ways_valid()
helper is useful?

static inline int ways_valid(unsigned int ways)
{
	u8 eiw;

	return ways_to_eiw(ways, &eiw);
}

Maybe similar for granularity.  Would remove some confusion over whether
we actually want the encoded values or not, making this function more
readable. I didn't look for whether it was helpful elsewhere.

Anyhow this change is good

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
