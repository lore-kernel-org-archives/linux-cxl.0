Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A641799F
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949089; cv=none; b=lF6egCKfmOXQyzBvwhNUtcONGBRIYtSo8gXLZD7PrcixdvUdwMbHMyjk4o67rI0+fw8+tUhqNBH6gNYlksVd3yfXesnf7+ucmE4pHwVeN9nfLg5O9tVMmo6Eq0zUm+wQdt83cIOG4yfizIa1VW+h1MlFDrAWrlX0XZkYNlKijr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949089; c=relaxed/simple;
	bh=WYNp6PEVD2my7cLQN45NWWBE/XqHb4lWz/iUWbjbxe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jehl2Vta7Qklz6MTNioe6LJXVq0eIVFzwfIl7Po4ZDgWZDLP8tdyr3g7AchjbWjL9auk/IOsKxYk+6A46bS3qw5SLI3oelhPjWjIiJkNlrQGvhn2SitUBBuQdqCZEKBiA2hHAit1FW8I7Z+yhlJHsuNhh2V4oNNjDRTH3Jqc4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gkFKPAdy; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gkFKPAdy"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fa26e497feso1929282137.3
        for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771949087; x=1772553887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUQZ9ZZpLUEJDgWCcqmsUYgG7Ph2Tdme7Hc3EOm7UmI=;
        b=gkFKPAdyF3JHbRTEvssOEqKboGpeX24BUUO7m7o9OcO12+UvpXBfW/BlJr21PvqSP1
         pIXF1q0YsQyTDSiKRpX1Mxxm3/ldqDeT4nznDdT7u8+GXSOEOG/xYwsRNSmcrlz13J/f
         kCtp2wffyVmfkuHep5njsYfvnynqZaDGOGWz6eEFb3jdv3acxOoPl+nxT0UjEp/MthrT
         DP0R/Jn7yQoVNhqCvfYFFa++vHeYkBQH9j0w91ilzUsNd6cF3rtpTCl0Pa5HeX4259Sk
         IGgO0uZOkzs2Vu3oynYMz0sQSWrBhpRW/MTlv1eOTVZGIxftmPvNQDgfHecXAL2WUnYG
         /JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771949087; x=1772553887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUQZ9ZZpLUEJDgWCcqmsUYgG7Ph2Tdme7Hc3EOm7UmI=;
        b=AyPBOTlmcxtW1blKTa05L+opDIblTZEOHNAf6NUtF4Q9T6e1v2kNfwXS/2A0QQKkcG
         qo8XXuUW79jHuvOEVNo4p4zrfdEXn2XZhG/08saloI7e70IihSvQvwPjbXxtWTpxfuqR
         mRPi1YPEmwcT5PZFoZV04VKkTFnVuTzJ+77rtTVpsZ8XgMiCM0LyQE6JUK71HO9XstxZ
         hB1kKBqDlcorPLZC1D6NuJqId//BQDnroqJyZ8PMlDlG+MvV7B6+vWGdHYjZXBk4T989
         2Hs//EnMBQyqrk46QxXA2v2VCmPm5UX1a83wcKy1iSg3O2MBYbQEfPhT9cXziVlu3+yw
         gQmA==
X-Gm-Message-State: AOJu0YwkUROrWjy0OGnQN3PV0LXaeUyAwdsffutfYD/qrmQCdOG/pKwE
	2DnMICpfnfyo0irfBxgUmJPb6PJY1hFbwUQiqT4U6zgEveCXzyCNyFPcv0kd9XANf/0=
X-Gm-Gg: ATEYQzwZMBIoYsZFN2Pi6CjtQHczdxT2OlkBqLZe09eGq8cc0+fPIBzJfMBf9zeS6Ll
	ootCmBiJ6eT/hOewc7fwmP8lPLszBOgXrnbR2n74S5NMrLvRUf1fK5JEPnFK8hQ9+caUlTPum02
	P/WGX1kk0+1OS1kz9yX/zRseBleCLKVf+TiktiOQgknO7vpqxfGwzfw90XeS4bMa7Z6KbOqExIM
	GSCu+X7xSHLhQjkGwhyOWcWCxfyQo6QaFqKzUsfbQEbuQjyfQueQ6zONN/KwoHSXeV2I1aYNHh1
	1w1585Bf7VNyBGpzjM2pfmNWRov/Yf1KVVGhwvg+Ot9N6HKrWZYTOyYRtNHxnJhPnd1oueCbMua
	QKsDPnoFPLV78CFPs9Sm/QnvC+dgjXRl1Y9tbfI6UgqL3QVu/ArRbceQf5hI/vF7cmZqFH5DYqQ
	gL6uoF6UvMDFWSYGafST39oMW4oAga54mVVXqgpDnpfy+GGATLC/r4WC7f9eEIt3NuGoWiN+PEY
	9XvUc/dNg==
X-Received: by 2002:a05:6102:2929:b0:5db:f920:fa9a with SMTP id ada2fe7eead31-5feb313aa12mr4565530137.41.1771949087269;
        Tue, 24 Feb 2026 08:04:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6bba49sm113220186d6.15.2026.02.24.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:04:46 -0800 (PST)
Date: Tue, 24 Feb 2026 11:04:45 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <daves@stgolabs.net>
Subject: Re: [PATCH v1 1/3] cxl: Make region type based on endpoint type
Message-ID: <aZ3MHVcheVVoooiC@gourry-fedora-PF4VCD3F>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <20260224152645.3441489-2-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224152645.3441489-2-alejandro.lucero-palau@amd.com>

On Tue, Feb 24, 2026 at 03:26:43PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type HDM-D[B] instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Davidlohr Bueso <daves@stgolabs.net>


Reviewed-by: Gregory Price <gourry@gourry.net>
