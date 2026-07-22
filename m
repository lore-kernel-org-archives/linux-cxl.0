Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2D2D7817;
	Wed, 22 Jul 2026 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680913; cv=none; b=KwY4BsXNJUJlZ7Xlr2gNyvU9Uswh+ZkT5hQMrHJGAzOSXcEs8C8UDqKJXM8aSyTRPnhQPgsS98Led3Ja0z83gqL7UK5jNRUXzLWDeJoONZN7PMtfA29rMPflH3GL+Y6jarKiPT9bhtmsNgKxmlTQUM9DaJ8N/46iON6oX6wt0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680913; c=relaxed/simple;
	bh=tbcvG+C44K9IfbZhSls3bUb5kDriuv6wQzNkANvtmpU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuC6VSGeIL9qeCsrvegwl/IZx/3tIqEjQeoA9YMc9oFdrNMLB7/s2kfmJQUzr9C8JQzv8vVC2C1SRmSUCHnsimgvKPHznOe2h9V8G0tpawxeSxWTYxfsJJVeyr+dD/mn3EZ/ztVVFdEhg/07thgtEHQ1skzVfeBAmClJqjFWtWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdgzf8le; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdgzf8le"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B52B1F00A3A;
	Wed, 22 Jul 2026 00:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784680910;
	bh=fSXq0j1GOkl8cyhAzw6R7UeSnE98OJbdwYCNPwSgZS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wdgzf8le3r3xxPKHavifdztuelXsRgxWLRxmjUuVVYFBMvvzTxt0VANGAR7g34Htv
	 VOxPGI7SbeuMoThVFcYNIsuJ8nkCHeRXTBg4uaw6gm+hi4HPHEJ8eRgqy/kb1HP+lE
	 0ugORtVwsAIvBYjnB+cyByu3BpKXZqeZYFYtFfCqmdGoLAPllD/bQUwIsTb1xzuqa8
	 8AqsA3gw4ht1vWNU2aq6EunlPOdrcCkpYxOniMOhWvDY6BuF2dHq91qR+Poj93juQG
	 qQRGjpnu9qsjZC1eBaD+FJNHey2n6e/C2/kW4cPRu1xeKlGIUMdOTHLzSI0iVdqlHf
	 Qg6O5JK4fwQzA==
Date: Wed, 22 Jul 2026 01:41:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com,
 iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com, Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [PATCH v7 2/2 RESEND] tools/testing/cxl: Enable zero sized
 decoders under hb0
Message-ID: <20260722014143.4b7165ab@jic23-huawei>
In-Reply-To: <20260721085715.39322-3-icheng@nvidia.com>
References: <20260721085715.39322-1-icheng@nvidia.com>
	<20260721085715.39322-3-icheng@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 16:57:15 +0800
Richard Cheng <icheng@nvidia.com> wrote:

> The kernel now allows committed zero-size HDM decoders so BIOS can lock
> empty decoders; cxl_test needs to exercise that path.
> 
> Add a mock_zero_size_decoders module parameter (default off). When set,
> the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4)
> commit decoders 1 and 2 as zero-size + locked above the decoder[0]
> auto-region, mirrored on the parent switch and host bridge. The mocks
> take a real zero-size DPA reservation, like enumeration of real
> hardware, so commit_end lands on a zero-size decoder and the
> reservation, poison-by-endpoint, and teardown paths all run.
> 
> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
