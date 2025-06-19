Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B422154B;
	Thu, 19 Jun 2025 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750376755; cv=pass; b=GkTBol3n4R0+6prxx7FSByWnuplo5Gxfp962WXqCCPFyC2IzDOQUO6RUoH8Kl9a0UGxHeKteHhKOOuxbnFeF0sZPH5xoDwbqj93LmLAnhC+HG1yNBRm+rd6TClZUialSjGdVaBw4VuLnUuZjxuBScNRN1mMnAm7CIFfzp3/fCks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750376755; c=relaxed/simple;
	bh=L4dSHdkCOmLBy3SWCtOKHfW4EI2/uu2b+5DOvbtU8KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D79vcw4wfqIxrzleibLm1RZC07ugQiogKIRa+k8wNQr/xrb8ObegiWd8QjY38q1hJ86kDpREqbPV4AtCqdM4XUgPy2a8RDy1332TZrw2ZKAGmOMw9vxtlwIjHtrQnMMNuKmZg9Qhnl6ped1OerQUgIr/DW8ILBmZxzLliR/Megw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=iO7Y518Q; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="iO7Y518Q"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9815F44F56;
	Thu, 19 Jun 2025 23:40:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.195.136])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1496E44F2B;
	Thu, 19 Jun 2025 23:40:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750376428; a=rsa-sha256;
	cv=none;
	b=Y0KKa9/1a1j8Troi4xiWSeEcNMDwM082Ik/g9R5RAGg6mySDpdSAzigbf6MzTp2pgMcbya
	9Of6esI3uP8cW73KA1dk53MqXhNtrjDpTeLI6SbeKL4c7Cf5gQ+oHMC85bI9Hokl/LKvMa
	yzUUmFLHpqVmbDLRPqME35JQlnYyOOlhZWVIeo8csr0G8NZUqk12FJg0XwjYVOVVfCZCPd
	Ive2Bbdgrgou0VSda4zs64GKntk+S9u+Z1vKxgjC7aROFYK5cwViwYNMyH9XI7xIxHjyHL
	LrJi+e96rPWZK7erTNN1aQPuFtM5A6cfNKGwRQuoxyZQwxGZ+Pm8FanT/QyiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750376428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=L4dSHdkCOmLBy3SWCtOKHfW4EI2/uu2b+5DOvbtU8KI=;
	b=WFwxP1Uxvp5WZT+m6u/h4ZKIAHTBGTCuLEw2yyIYicWMeJ8aeqKFxPytVKoHFkXKnYJ4Lx
	iuXI6k7hUtkQAz5yyXWMKXs0EcqAu9NidgD1UeY5iWvlPl/wcQQsqP9dik/SD/cyg0hHrS
	FHtyUpDjqjjZsreDNPtA/KDtGLiWHxQPARgW9S8RytTFaWWuEte+C28cu5a3lyQa/OarG5
	pUL43zWJNCIJxht62dPB8dTQzF7TTXNwcgNdR94jf7L4VBLO8GNlplcEc54C7arwbKFiCk
	epZZb8UBwcxmbYeComr32K9wh53XCY5gTCe+KpyAj/33iikbn/QPmve/1DiQTA==
ARC-Authentication-Results: i=1;
	rspamd-6597f9cdc7-n4fh2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Society: 106c49bb093fb471_1750376428345_2560380918
X-MC-Loop-Signature: 1750376428345:4088892011
X-MC-Ingress-Time: 1750376428344
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.195.136 (trex/7.0.3);
	Thu, 19 Jun 2025 23:40:28 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4bNcY73FG0zYg;
	Thu, 19 Jun 2025 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750376427;
	bh=L4dSHdkCOmLBy3SWCtOKHfW4EI2/uu2b+5DOvbtU8KI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=iO7Y518Q+5XizyG9oJcO1zrkk0Mxhv7fH6qAuyPE9BgE+diG1T3xutCG8PT//TqCH
	 dlrk1+qmpECgQ9WnwFHUuinx4yl+irMEgvyHP3rDcEy19eF2BRy0IeKH7WHpqTXDDF
	 R28cuxDwhliTdzNSBmZVDOb13HrnsERZUgkDrt1FSMYQLRi+nUr0N/YpGiVbBAXGkI
	 bChn2jqA3eS5WnEV28Q0BJ7fhGRSzx04K9WJTHBWoiVoVpuIVP2E3gHCntZHUFGkGg
	 F1HUGUjdkqVUZkt7j/vsQ7TwlGnAs45BrDJS/e/d3XJCwCqoyhWhet/nJvcwz36Doj
	 q9LW6Qa6mvJgQ==
Date: Thu, 19 Jun 2025 16:40:22 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/8] cxl/decoder: Drop pointless locking
Message-ID: <20250619234022.6ucg5bktq66fmhoi@offworld>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
 <20250619050416.782871-5-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250619050416.782871-5-dan.j.williams@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 18 Jun 2025, Dan Williams wrote:

>cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
>decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
>dpa settings since it is merely clearing out whatever was there previously.
>
>Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.
>
>In preparationg for converting to rw_semaphore_acquire semantics, drop this
>locking.
>
>Cc: Davidlohr Bueso <dave@stgolabs.net>
>Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>Cc: Dave Jiang <dave.jiang@intel.com>
>Cc: Alison Schofield <alison.schofield@intel.com>
>Cc: Vishal Verma <vishal.l.verma@intel.com>
>Cc: Ira Weiny <ira.weiny@intel.com>
>Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
