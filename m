Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E349CF5B;
	Tue, 15 Sep 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515231; cv=none; b=B/FBs06395mdIZP99v8iF1kARSltQeddDXvLi64cMpntvrCv806yH4837yK7TDRbpqjnsxh488vY8CqiHp9LQjFFQ6LE+oEQJ753rKEfkg0FaMnGwcvvRoulUkSdVDuvJWApx9yYEYHxBpJHehbEEayO3X4y1z7AvcmOwiZFyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515231; c=relaxed/simple;
	bh=Z57LOcg0OrLjjlaHVAOBTUjDHYIFxogNnEG+cClQOHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mi53zL29zkGGaU5QFQyTcYVEdyG+Y1d+qy6yzHgZiyY/vqgmLAImX/RuTIuVE1dnGE8hUcpTAgvAPD5SIPA5/wI6mgT50tKJoe1lXhoFjjXWU8YJY6eIG+K6SAX7rgAXs+b8CO5Q0yHvsxNwDoCtxfGpsxOL1yHDp2/yGmXT1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYngZS38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYngZS38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF1E1F000FF;
	Tue, 15 Sep 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789515229;
	bh=KF608vhfL9nsLc8v+HclhfNTNMosZ1VxzWv3+rwIhTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UYngZS38jyUG8QnBeYrend6hjZhfwvzGTdRlHBBwOJOwdC5ZxbCSkGkNVnIgtAUwO
	 hxoG4cmdp/XVn09X3Tjw92xB/7YxX9UBG6vDE4tsKDE67fB2x8XqiCC26ahMfqSqDA
	 2I9SXayKTg3jGUQpFFeeTX1VAUNOmVp1WK7TyXcQyp8v5ioiRPl+tHsQDd1DOUGe4q
	 1h9n6TEuehIuo3MHfsjdlSvIQdbl+6pXwQXXUgKHl/fhbiiIFi3RSti3+cN+/69qZS
	 SZC58Tyb+gbsdfo2pwHUahpx9+sP/WjNmKM6K2NKEmzkUnodaOkN3dd3D4vYL6Jl0g
	 BHZzhCgNHHCfg==
Date: Wed, 16 Sep 2026 00:33:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, iweiny@kernel.org, ming.li@zohomail.com,
 kaihengf@nvidia.com, kobak@nvidia.com, vaslot@nvidia.com,
 newtonl@nvidia.com, mochs@nvidia.com, kristinc@nvidia.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 1/3] cxl/region: Simplify poison_by_decoder() error
 handling
Message-ID: <20260916003346.74446134@jic23-hlaptop>
In-Reply-To: <20260914090858.19181-2-icheng@nvidia.com>
References: <20260914090858.19181-1-icheng@nvidia.com>
	<20260914090858.19181-2-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 17:08:56 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> "rc" carries both an error code and the loop control
> signal for device_for_each_child(), so returning it bare is misleading,
> the early guards mean "keep walking", not "no error". Zeroing "rc" to
> forgive an -EFAULT on a RAM partition adds to that by discarding what
> the device actually returned.
> 
> Return a literal 0 where the walk should continue, and test the
> forgiven case directly instead of rewriting "rc". Give that test a
> name, poison_efault_forgiven(), so cxl_get_poison_unmapped() and
> poison_by_decoder() spell the same rule the same way. No functional
> change.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
