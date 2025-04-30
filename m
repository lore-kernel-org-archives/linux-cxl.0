Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E35235067;
	Wed, 30 Apr 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746016351; cv=none; b=Y8iyYkn/NAfr5WLSPaofIJbeLgGtThbiND0Pti4C4MNpfZ3ceqCHCNaoEzEcVAeG4jiMLm5EjyD4CKJqTqadx6m7n7ip3GzH7ChtfsJRn54em6HaYhTJ3EiCP9HiNGO8cXU46cKyWZ4j6SFRhBXNk5T/JCJlKflxdYtkdvyycwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746016351; c=relaxed/simple;
	bh=nloV9YlXjFS5erx/L4R5uVw+BB0aF1r/qK/bsiQaAD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iNNXm6vYQA6bvZxH9gad/ZSNWyyGOtFEnS3LGWG9EpN2t9k5YagBgiR/QE2odCDnMGRjosINEgQ6Gx9jZQlomuZy41V3BTTY69L1T0P8YZ7or04zWTuqDX8pWM98OiqPN6EDVh8f42UBJgg0qTCmhTNuL2Lx65bJ3CBj0pYMeHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YBaefr2H; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YBaefr2H"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6FC9841087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1746016348; bh=07rsvot5ahYpNd4X7E4eyB68XtcpUJCo+O5SXtg19XY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YBaefr2HHGUUA3Q3I34AGKOTlMXsT2PfAaTOUMOaDa51XNqRBLos2sm66EhGkSRJg
	 dkFtX+i2G1e5aNd3C0ct8DbwMXdm2Y7/13CRCQ/IrjmtbwpkU63ZbC2zxdCwbIe8w4
	 FoMMy8yC9LGalQUzEh8FSeL2b1wqLkAl7tfsK9gCHuoD95kqPLfh+XUlkq4tc82j6L
	 /2SsNjhE8JyWiwseNjSYJIFcZ3h0+5M8K5fBDD7ynGpJ+g2j/kvckhPWaeMxvEWeZm
	 zHVy9/9UPNubXVJCjKrcmQqkaWtdQPEy9K1CWef5xus3jIwKw/b4MxtOxAxQ1JNzr0
	 Z8tbUBc2G0LPw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6FC9841087;
	Wed, 30 Apr 2025 12:32:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [RFC PATCH 02/17] cxl: docs/devices - device reference and uefi
 placeholder
In-Reply-To: <20250430001224.1028656-3-gourry@gourry.net>
References: <20250430001224.1028656-1-gourry@gourry.net>
 <20250430001224.1028656-3-gourry@gourry.net>
Date: Wed, 30 Apr 2025 06:32:27 -0600
Message-ID: <87o6wdltic.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gregory Price <gourry@gourry.net> writes:

> Add a simple device primer sufficient to understand the theory
> of operation documentation.
>
> Add carve-out for CDAT with a TODO.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  .../driver-api/cxl/devices/device-types.rst   | 169 ++++++++++++++++++
>  Documentation/driver-api/cxl/devices/uefi.rst |   9 +
>  Documentation/driver-api/cxl/index.rst        |   2 +
>  3 files changed, 180 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
>  create mode 100644 Documentation/driver-api/cxl/devices/uefi.rst

I'm glad to see all this documentation!  One little nit...

> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> new file mode 100644
> index 000000000000..e8dd051c2c71
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -0,0 +1,169 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Devices and Protocols
> +#####################

If you could stick with the section markup conventions we have
established in Documentation/doc-guide/sphinx.rst, I'd appreciate it.

Thanks,

jon
