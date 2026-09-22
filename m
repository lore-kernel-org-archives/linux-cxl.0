Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7C34A79D
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038335; cv=none; b=kp5T2jMmUUuUyU5TeWgYflrgRnCTdDojDzjYZPPmwetHcvAJghFBIE6qxlD/zU70Ov2TvRlWHiAPLO9a4qfgaXH0rd0Z9VLbCgnxDGd71cWTXRCYUOFhMXv06Yyt26JE2o5lJAR+EsoXDY3uPj37HWS/rMDTVc90EV85huSStfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038335; c=relaxed/simple;
	bh=IY5kSutBT9Z11Dr2gAk7UtYvFA6niVU+fTglioNtqYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgSI3dlWYp8Y4pxxnQJHHlDclfaMiS+sXZ4u7mQiZtRb37zZo0F2kKzjshIJ6TAp8pR7vMg0ADv9eFKul0NjXsnQXVQwBdXT4E/WYWUa1YpicbWQr17vhFXaca9Cu8g/nwZdzm1QGEfYzlQnJDDDEBIh8xJY2y/rPJcWdhjWsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0e7Go/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0e7Go/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756DD1F000FF;
	Tue, 22 Sep 2026 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790038333;
	bh=Pb3g+fzUh/thaZ71z9Xl1PmXFKl24rStrJzyQqArrlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K0e7Go/+hIFLmVeW8mqM/X7sL/fIDhqZcv/7/PTJ99q5JQPBDF/wvpxrDABitB3Hw
	 QmYAJhEbVDal+eezZupErC2pRaKLZbWXkWQ5Vc9k8QR8+ZTeE8GUCbYy7YQ6KTGrXJ
	 FYpyTezYj3QLhe5mh0mNHrbOEZ6WkqGmBTJXUNsSYIjl0uQcgWGmoUKyx2G71mT0jO
	 GlZDI8r3EohY7bntUs7jwMymCXQ0bmfRYlfiffJ+06COd/iY0fm7Xv66qLAL45Mo4n
	 c26uW9g1BLjiLE4DAFVONSn5uozy8g2hZ0E/o1UZdpxu/sATIAscVhknaH182rmhe7
	 Mkl9CY+XPoF+Q==
Date: Tue, 22 Sep 2026 01:52:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, Srirangan Madhavan
 <smadhavan@nvidia.com>, Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v5 1/4] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <20260922015209.4106942b@jic23-hlaptop>
In-Reply-To: <af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
References: <cover.1786143520.git.alison.schofield@intel.com>
	<af094094813d7f51d86cbf608936270b7d85526e.1786143520.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 17:05:48 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Switch decoder enumeration validates that the interleave ways encoding
> is legal, but not that the resulting number of ways fits the available
> targets. This can overrun the target array (target_list.target_id[])
> during enumeration of 12 or 16 way interleaves.
> 
> Bound the target count where it is established rather than at each use.
> Reject an HDM capability whose reported target count is zero or exceeds
> the target list register capacity, and reject a zero target switch
> decoder allocation in cxl_switch_decoder_init(). Enumeration is then
> left with a single check: reject a decoder whose interleave ways exceed
> the targets it has.
> 
> Add a clarifying comment that target_count is a direct count, not
> 0-based like decoder_count.
> 
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Tested-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
