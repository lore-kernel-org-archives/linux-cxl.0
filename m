Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426426;
	b=AJgq8xJEFACJ8aG6Hyh8d5QvyhlK99x0BIwzmZSs5XCfr0/Pr2lcjNP/2kSELNwTFdJ6
	 ycpjw9oOzMRpkJVctZxupt9sJ/C6KhWiSIeMpxyvgIZkrCRHvv0itb9ZxG0y98bC1u9Kc
	 LR89/C3wt+VNBzIr0hNTtJx2xJFXd74mrPM+JfmsKQb7nQ2N2mJFAgtd8MiHOFXOWxEv/
	 L+gTrgDIY6HxSUKh6hnmcIh4E+neKALHRjh5tFsOrSldiTDYUJwB39uKi5odyMXBTrWNE
	 68+cfCjuMjFKAooVyeSqaIxHr2Y5/EogxiFdtfLZXHRgrnGa5CYw0y+iuGTRXdKN1XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426426;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pL6+1vpFLA3texzfTFC0Sa5jQGTB8JdtyM8Q9G8vvjI=;
	b=oW6yar7mGI4gOHXn50w1W5IU+GnUmbDCM+aUbBn6SkIwzoIEwbt3J7kbmdAJDkA7s70E
	 It6bGj7oNrE/qMSxi0tFsfkTAYEmEpsVieHwTp+xuGN+1+RK1LIeindK0n7dyT+iXfrGx
	 2Pc/k4NCcACHs6+tyrghwQuT3VZjPSq0pFyo6UH6OOZmgsjKvXEMlWSrTSrQKvwXA3ooG
	 IY5buqXaXZdzn5+0aqRFMbI0gA2pYGlpmz9TDhBlVFOXq9y0pa7xiFeSK23aeKGUp9MHZ
	 Tgj95s7KFiYWk/uj8q84E54t3ypWn0d88+XOZjqSDARzfwSgJ2PgNx9LcMvYKvyHlTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCfxhYVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C46A606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 11 Nov 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZCfxhYVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE131F00A06;
	Wed, 11 Nov 2026 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426425;
	bh=pL6+1vpFLA3texzfTFC0Sa5jQGTB8JdtyM8Q9G8vvjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZCfxhYVfwmrHFGDlpHpCSLkmONht94E6afBxO1xRsrgvflZKJQVLajSPKCpeo0HLX
	 PKTw0pya2l0pHq0LEvqhuStY0bMe/r8uhfldviOFExNxa8BG06E2dPfx29LnfbyDaY
	 J6lNCBAfuMeNnrUQfY8F/ydcGDO0QDV+vqQ5R2H9gXj5xy6esCY/iw7MgcjRxA1Qes
	 7LQFqfI5sbNtsYuc6LDYJHbbR6XEJNLzDeYkIez86kzUBQys5uV9HKE/QSgim8ayT0
	 mftN2JlFLDfs87XLt7tcy24WxdS2D3RwNvOiIOrPpFON400SdohqnGjJOWWh6F7bfe
	 VmKI86BCMLynw==
Date: Wed, 11 Nov 2026 19:47:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cxl/region: Reject a repeat write of an endpoint
 decoder to targetN
Message-ID: <20261111194703.61800b8a@jic23-hlaptop>
In-Reply-To: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 09:07:10 -0800
Alison Schofield <alison.schofield@intel.com> wrote:

> Writing an endpoint decoder to a region targetN attribute that already
> holds it returns -EBUSY, but leaves the partially populated region in an
> inconsistent state. The targetN attribute still names the decoder, so the
> failed write gives no indication that the region was damaged.
> 
> Filling the remaining target positions can then trigger a NULL pointer
> dereference in cxl_region_setup_targets(). This can be reproduced through
> sysfs:
> 
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $decoder > /sys/bus/cxl/devices/region0/target0
>     echo $other_decoder > /sys/bus/cxl/devices/region0/target1
> 
> An existing check recognizes the repeated assignment but incorrectly allows
> the attachment to proceed, damaging region state. Remove that check so the
> repeated write is rejected without disturbing the existing attachment,
> consistent with the documented targetN ABI.
> 
> Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
