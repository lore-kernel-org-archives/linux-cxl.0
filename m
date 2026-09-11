Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587983C9EE4;
	Fri, 11 Sep 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167980; cv=none; b=bVdKtAjkmy62oTPb7Rs7Qk1n7NlLQtXjMoHZHkgZCMOABQheLNc2IG2fNH2Sosh80sHdK1SaK66TPV+AJNkoKGwEoB9krRf/mYOIQKfzVN+Vro2iQja91VZq8BC296VQGCiAfMoUZHldCBCPsvVdYefGlTs0z8moFdLK+viakzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167980; c=relaxed/simple;
	bh=0VCH5NCRgRtIzwVP0kH5G+5iNrACjPZ8Yts0hN4+o5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkBEUix0WOKWIHGDrCnS0h2xkKjKpZlrz/DK8GBBQc5MeukWcLQFpLC2ENeee3lrm2ZhbO7BTuOOWPLXKL+1guYTTNiEWlUnlXm6z8W80Z+caRUgcgoTYEHGKm2K3bjMlo+cegeDfM6GPX17vAr6WaqKsThzgzN2Ng3+YWrLCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDM0WBWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDM0WBWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3FE1F000FF;
	Fri, 11 Sep 2026 23:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789167978;
	bh=TuemfR5prOo9YKyEbLnJqziamu6niqd8PU/Qykp5HsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YDM0WBWq7RlUnfRODKuStKNlicVd5cv7Rg3RblCB+fCeHDUZWLitHNEidI0NEN0+d
	 6ge7gXHK7+Kq2v3VJqLoe3xc2phszP0KppoLlp4exWvjKf8eDxlNTfwAmZJpm2W/gq
	 NkDTsk2itbhMYlxjGMA5S8lYEZ1NW0YSJdeKBHVLpKzIWa0epUNd4hctBvri4OfZpd
	 pXZkkn3w0PD9hH8KYvduIkKHolCS3hjc86gIuGvu5Se4NWCIemHO0uC6frdyu7o64a
	 UWMNHLDY+3jdAw7X9Rz7id++btxmkxya6tN0XCOWWRFKRbB8aDI6S7MIEhKHtcymbZ
	 FCAow0Y0kybgw==
Date: Sat, 12 Sep 2026 00:06:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Ben Widawsky
 <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Fix the return value in
 devm_cxl_add_region() kernel-doc
Message-ID: <20260912000612.04db0b2a@jic23-hlaptop>
In-Reply-To: <20260911221748.7212-1-kmehltretter@gmail.com>
References: <20260911221748.7212-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 00:17:48 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> devm_cxl_add_region() returns the new struct cxl_region, or an ERR_PTR()
> on failure, but its kernel-doc says "0 if the region was added to the
> @cxlrd, else returns negative error code", which was never true.
> Describe the pointer.
> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

