Received: from slategray.cherry.relay.mailchannels.net (slategray.cherry.relay.mailchannels.net [23.83.223.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EE38DF9
	for <linux-cxl@vger.kernel.org>; Sun,  8 Jun 2025 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749341102; cv=pass; b=dZHlR1iICiQDjmO6U9czTccZqzB/5nLltBzJrJ5jIrFSOBkZujI8eG5drgt2m9w3CPES1o1oKjcvo87v6uB5gxZ14f/aIsPuiCq4mIHglfeVyw+ZDsKETcn+HwvP926RqOXEwufHGVu9Q+c3fubqaShUAA38WjUl6QTVQyEJyik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749341102; c=relaxed/simple;
	bh=XyydQKDO7pVnUAhZ6fCQcImoS/9N+qK1Zt3D70QIQHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xry+Nfckj7NqPE8dmTFMeRQDBHC9EtUF2u/wzkR4tHawl3qIZG8yJcJ0RggycUAyGSEe3jbbZKZWrYnxJyxUTvi2Muzp+k8/VCOqbDvXo5AAS3k4DrMH6+KJP4W1XG1Q25SX/ifFSHu1UGAWkmlMDLP+Lrd27+Nf8gtYYRXFaeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nekW9h7t; arc=pass smtp.client-ip=23.83.223.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nekW9h7t"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 972651C344F;
	Sat,  7 Jun 2025 21:43:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a278.dreamhost.com (trex-green-5.trex.outbound.svc.cluster.local [100.122.29.47])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1E8461C3E63;
	Sat,  7 Jun 2025 21:43:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1749332607; a=rsa-sha256;
	cv=none;
	b=EGG3dqw91QD06ztZtWlgLh5EGFzBM31nYkk/lzvVG/LSMSltM4wTNlSD1Rqbw9n9Alvfd3
	OMvwShAQdT6vtBaXkC4afN8L/8d8FQK5JcwIqDblHAg03/taj3r826WURJ9SXxztpfu8tj
	hQJ7iDtH9NiS/DSkA8fcttLqXTu2JxnUE+y7OlKVIhFh9nSxJdhTJIkyImcSQyahuUvcJF
	KlwIZ/lVO2A8eB2luQvA7Dr6bWSIsutYajKYUgGASrTS2mT4dw+H9SLyX/oRanb6gDz+qm
	mCydanyUmc5OUX+aKczQj+yVf6C0JNdNegQAd0zeuV5DImGjXRZXYOLFWWhW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1749332607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XyydQKDO7pVnUAhZ6fCQcImoS/9N+qK1Zt3D70QIQHQ=;
	b=WuIY5OmbzvERESRKQoZwoAvXLI3blZpCfzptSwFBsyOjHs8JKF7YSHRBbad6oBeYXqPcGV
	7as+9ml3fq7P6aszsxPDg+aBYD3otsbgdFfmjNvytfg/UFoTp+CaaYSAvmaTZZ+ThwX9v2
	V/lzzMhoRAOyd/GPK+V3NWeD65HmxTK9U/5jsq4iNOddBfLFtrPnCMyLqt9YQ+3fVSSPK0
	m9waakWjfVT/KvEnWMGZmeEMSsUI2fndtn0MSSWYX285EAnohZTQnwN1G7xJ5C7MbhlUFW
	DzaUFtLqM18qBLpFhw1jmPOAYHZDrj6U0RZIXGN9XFcXvsL6ddE4dMG1FDv8Rw==
ARC-Authentication-Results: i=1;
	rspamd-5674bcf875-dxrr8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Interest-Juvenile: 30197fa5050511c9_1749332607390_2626663010
X-MC-Loop-Signature: 1749332607390:1491282788
X-MC-Ingress-Time: 1749332607390
Received: from pdx1-sub0-mail-a278.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.29.47 (trex/7.0.3);
	Sat, 07 Jun 2025 21:43:27 +0000
Received: from offworld (syn-076-088-099-182.res.spectrum.com [76.88.99.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a278.dreamhost.com (Postfix) with ESMTPSA id 4bFBWf4GQfzTd;
	Sat,  7 Jun 2025 14:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1749332607;
	bh=XyydQKDO7pVnUAhZ6fCQcImoS/9N+qK1Zt3D70QIQHQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=nekW9h7tNiyOriqKfhQPZQh1vzzZKify5u6cpTRHC3TbDXgsimK5wrEscN3ywPdrM
	 twHr4DVQkNyDTn2nvFmSN0hDQBt0m10QmB4m/qAEnC2ind8OKpLzoVDEwgb/ojref2
	 Tt5IjE1nQ+aC1xVkavo8wae1PPDKwAdqhFrpp1mIG1CNM83B7Ry1SsCbKkzsPbMsoF
	 bXkhzHy2D74vbCIixGafMHlz7cV9qRz6EoOOTASXfMP8VfhV/kw+5sz2Ffvrju06+R
	 qFnVkXqXEFPWwxOeLkXyfZY9dKho2933XQWVlvW0yDSW/kNcxp0gUZqp7kRhtzAY4h
	 2hRbBmNz7kYig==
Date: Sat, 7 Jun 2025 14:43:23 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: alison.schofield@intel.com
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH] cxl/pci: Replace mutex_lock_io() w mutex_lock() for
 mailbox access
Message-ID: <20250607214323.lhgbopu3rwyw64md@offworld>
References: <20250529205117.1990465-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250529205117.1990465-1-alison.schofield@intel.com>
User-Agent: NeoMutt/20220429

On Thu, 29 May 2025, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>mutex_lock_io() differs from mutex_lock() in that it may call
>io_schedule() when a task must sleep waiting for the lock. This
>distinction only makes sense in block I/O or memory reclaim paths,
>where giving I/O a chance to make progress is useful.
>
>At this call site, cxl_pci_mbox_send(), the mutex protects an MMIO
>mailbox. The task holding the lock is not blocking I/O progress, so
>calling io_schedule(), as mutex_lock_io() may do, has no practical
>effect.
>
>Although there is no functional change, using the correct locking
>primitive, that more accurately reflects the semantics and intended
>use of the lock, improves code clarity and avoids misleading readers
>and tools.
>
>Reported-by: Alok Tiwari <alok.a.tiwari@oracle.com>
>Closes: https://lore.kernel.org/linux-cxl/0d2af1e8-7f1b-438c-a090-fd366c8c63e0@oracle.com/
>Suggested-by: Dan Williams <dan.j.williams@intel.com>
>Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Yes, please.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
