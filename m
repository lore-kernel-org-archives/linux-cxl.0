Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7231327F;
	Thu,  3 Sep 2026 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400065; cv=none; b=gvD9jwIEyNK5hM/HZ8nEkdzAMlI+x3mLZ5I9LPJj5xkRTL9iXHeIZENne81wSgRH3IySg6SsWc1jSJ3H1VaZcJirBoVAMgfm6trOv1FyZg0gQVkV0QUp17CBKNxvDptvqu1mHgUajZpwpr611KLuaXJhvA8b/hiQcQzY1o05PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400065; c=relaxed/simple;
	bh=WmhNfmfG8dQE5KrX2lTKKCoxne+vqe9dgpbyiznrHxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syJKYmjGSqKaEsirGV8y0quO/GiZnhnCuJkVrnQ5G9SqyP+BjvCVgCPdFd1j/nVTDkHNsEFq2d8ZpOd2adBtYj48Y1iMF9ZittUlFRLgOO3v2luUMLk4P07tBOIVchBOn4H50uj8c430qFgmg75pJn7nZJyUm/LKwqIpSE51v3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ejUYuHkA; arc=none smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ejUYuHkA"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 005F07E1AC1;
	Thu, 03 Sep 2026 00:31:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (100-96-173-63.trex-nlb.outbound.svc.cluster.local [100.96.173.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 891BB7E205C;
	Thu, 03 Sep 2026 00:30:56 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Thoughtful: 377d3f9c71ca33bd_1788395460809_2385034430
X-MC-Loop-Signature: 1788395460809:3850894733
X-MC-Ingress-Time: 1788395460808
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.173.63 (trex/8.0.2);
	Thu, 03 Sep 2026 00:31:00 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4hb0rH6ndZz2h;
	Wed,  2 Sep 2026 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788395456;
	bh=JvtxgVNlZzjEobYeplB2jpWqIQAhMXTpfQsMGk30O5Y=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ejUYuHkA0r8+aN4wjmFFTUzRCwS31gby7n4U4S2Dh7SRikpihIYDrPjW8T6UC+Msl
	 42CZJwmPM4kUkDDli5LWF97NFsgosytazFyR9CyyWdKcItZaree1qgB5PMLTpwFd5b
	 tPYmMDMhlTDqO13Ps5WBZFMtvG+H67msO1f226Ub1/Hm/NhypaYNsvmeofRqjXtA9A
	 aKuc6GaAwWLTpuyqmTWrnSCyRgpyoi0UPq5NIUVMBiM2a1FITxQMK9y0ABJaqOLWM8
	 hTezkOLcWIJU8a0c3z8hIuurMP1sdYNsWBSZGvXZxrfjDttt2+6F/U/Lc3boiMzzST
	 6lRA9ufMNi+xg==
Date: Wed, 2 Sep 2026 17:30:53 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	icheng@nvidia.com, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Add Richard Cheng to CXL subsystem as a
 Reviewer
Message-ID: <20260903003053.qkzjtb6c2xe6fpq3@offworld>
References: <20260902235348.3563444-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260902235348.3563444-1-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 02 Sep 2026, Dave Jiang wrote:

>Add Richard as a reviewer for CXL subsystem.
>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jic23@kernel.org>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Richard Cheng <icheng@nvidia.com>
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 3a19da74d00c..25d61ce9506a 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -6567,6 +6567,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
> M:	Dan Williams <djbw@kernel.org>
> R:	Ira Weiny <iweiny@kernel.org>
> R:	Li Ming <ming.li@zohomail.com>
>+R:	Richard Cheng <icheng@nvidia.com>
> L:	linux-cxl@vger.kernel.org
> S:	Maintained
> F:	Documentation/driver-api/cxl
>
>base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
>-- 
>2.54.0
>
