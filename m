Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149691;
	b=aLrX06TUxEDlEhEStbbdC+XP1xWFTLVLMTfsmEwxO8XTWEZsQoVt/6KsXbVijW1vVp2v
	 kXLKR6sNCzQ8fl7LeV4foPHeSFOSlOuA287TcpP0Z0zqnJGU3AWINzLScBhTSUljBpuGH
	 /LkvKQgn8n18TpFh05PHkbEZQhUeBQjC7lJ+oE5VuRyJ2CvDEGV1CIGiyjRtIhsGrqS1u
	 FiBAAT/nXZLeTCwHJlobYonQTanKBnyNJ1TWroYnLNfepQWGlBzSmHaxODySZ9yTa2xY2
	 Q3VoUrF3cHHid39BBa2lUjbMt2CPbwKXI1/K+GWevKtnx8QvOnYcCMmviMFeudHv7/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uQqvHZeml9zlcAW+zQiQu6gvc56YKRa54A1NBtgKXaE=;
	b=2PeE1Gu8zFemyRGznArXujOyfqstreKnRT1EB3aKoURfA2OtnV/3pvRqygO2rwvY39bF
	 N8taHDyGIOjKecypAn2Mqsp6+tYV9Dvt0G23V5W/Wgn4zPp/GmTolKRDSP/sl/tq9Wl7s
	 SNVgOQ/tbVB93UxFBygXU24jX+b43Hc9wEcigcTBye0FjNE1r47pvyXFmPv+h2ePzWUbN
	 GDJQaSFp76IwNzV1QYIWvM3BZNniBCsO4S3CJGSeqhCGjFSnl8nKfQkrrFUe7JwPYCWFv
	 aooeAiE2crSBF8+/yuqnwVGY5eMl733AgGllLheSdlhcGmsEvaqtDqZjr6ZdLuF6urg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFcEgdWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCAD606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WFcEgdWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421BA1F01825;
	Wed, 28 Oct 2026 01:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149691;
	bh=uQqvHZeml9zlcAW+zQiQu6gvc56YKRa54A1NBtgKXaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WFcEgdWZ8tfTGQ7OZOx3jEnw89gQOs0/EzByFxDEhxIRinYxlnE9ARh9aOgCTDXgG
	 VYmX5BVJzcLDqc8oUupAWFAEiumATnDZIBgFueJFbiZBqHwGys/4/cfbMSXEnknBv6
	 DSEcHHZKx9SYQQiXt+pYcJPrt/+rDQe2tRkx37S/6tSVP1Al9QFizxz2kNYTer89r0
	 b3kLcqKtFVVFyB3UwSLFf0iWY0eWUyJZnzT4PRNehejmPY01vZylixY2YhHP3XIfC+
	 wvek2FmB3km+r7NcI8UKpkgUYoAaS88N/wSIMDaBek/vZP6Zu2BSbOs8olnzz6VDN2
	 znobdN1s1Ha3g==
Date: Wed, 28 Oct 2026 01:08:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/2] cxl/region: Make repeated targetN writes no-ops
Message-ID: <20261028010802.5eeccf33@jic23-hlaptop>
In-Reply-To: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
References: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
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

On Mon, 26 Oct 2026 09:16:49 -0700
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
> An existing check recognizes when the decoder already occupies the
> requested position, but does not prevent the attachment from proceeding
> and modifying region state.
> 
> Move the check ahead of the attachment work, so a repeat write succeeds
> as a no-op without modifying region state.
> 
> Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
