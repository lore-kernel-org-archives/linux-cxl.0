Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC313264D8
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683038; cv=none; b=kjUdSrKfURjIO8S3FINyUVlqKlAr6RaZa2wWvTVSUNv/AoWurGTiEDQZkT7TeygEBrcXwjWSyJA4WGOpzP1RqDU2kgcEBLn5kSh+rsu8GS7Ds9ZoKKROanG6myo0SrKzPOm42iHcrs6vcXHxoWlR2odwITKQyrYXqaSQPHSbdwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683038; c=relaxed/simple;
	bh=zIL83/zRvGVKD9ohhlc1nv8USmefWgeTcXbhee+Q+rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPpYboE3+ZK/tXHcGznFIQNzWaf9Y3nIqWpyOI0uO28XjvzQwjOUZpJKI4795QcDnDJCfgA5kvrrhEIyaeXIzrbBinkSLIjunZDmS1/M/bjqG1DYoe8B1D3ThRDU4kq5/pVaaxR/ZA9V4yns02yjZ/GscDAa+Xb7VFrMCTLoi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1ioLQ94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1ioLQ94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4481F000E9;
	Wed, 22 Jul 2026 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784683037;
	bh=KQKam5SGZE7gQrWnYRvhSCCBOx+HRR8W3YRgK/np0BU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B1ioLQ947YbSDPxpksdfUkeUwS7DpmryntXFctGdvGRRXykdz7pc8lD/6VEyEXm66
	 QfJRLhGa/b8tWLoycRHEvYuCbwIH4OdVrJ6HBBZZLc+miH/QvGyKQ3HWWcBnOwHmKe
	 YFHC1rxxFasFGBeBUYAwPM6RAMYy7eBBgqWXRC/t7D54K0c8T2Acklc3gFr/iPNg5P
	 uR5Ahkc3xtkoODGeukAmu4V7Byvj3fcMca2yDboUW5I/7SnTw9vPQUPho3yQGw2CqB
	 gEpqPPL63TV0s1NMXIOwWCV/jObMxiMhthLMrve8G6V6OQOwGyVkkvt7jWm1FTyNyZ
	 ml4Ocd5Hc84bA==
Date: Wed, 22 Jul 2026 02:17:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 4/4] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Message-ID: <20260722021712.0107f7fc@jic23-huawei>
In-Reply-To: <3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
	<3b2d66e380cb00b1365911a59f32739580d82563.1784595445.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 18:59:40 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> commit_end tracks the highest committed decoder on a port. It gets
> advanced before decoder enumeration is complete, so a later failure
> leaves it pointing at a decoder that was never added. The next probe
> then rejects decoder0 as out of order and enumeration fails.
> 
> Reset commit_end to the none committed baseline once the decoders are
> torn down, so a subsequent probe rebuilds it from scratch. Register
> the reset before the decoders are added so that on unwind it runs
> after every decoder has been unregistered. This prevents commit_end
> from dropping below the highest committed decoder still registered and
> exposing an inconsistent value to a concurrent reader.
> 
> Protect the commit_end advance in the DVSEC emulation path against
> concurrent readers, matching the register-programmed path.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
