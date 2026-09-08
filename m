Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D5F580391
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887865; cv=none; b=HmAG3gP343BDN+CP8GWqYT2z+CSY6aCI5DEJlpjNndNZWQ2B0JzDXufboq8Z7KHNjW7eaNxr4f/Re/iaXodhnPZN/xc5lsj056p7GSpvpERIVxCLOdYg1jdJ5q6na5MFqcHjAly5KYtiUbd2x8LzKadsxjIeCvdOqDiptWSx2Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887865; c=relaxed/simple;
	bh=d2x9QM9TI/Ky+7psvnJ5D+rVYdh95UfKOn2mvAMUIHQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZOCdoRG7/nd47mzx03z0RjxhCDxVoMdg4WwZ7GHY3EheuhgzxH5qkg1hUqtQUjVqneiFlYgjyqclkgAY3osQGIP3ku3nMG2Gi0V3H5aYaHZ+P32ecLv3nnXdHpHKmtqBA/kGq4fszpLMxOFYv91pquf0bfbYbU9FVq8Cnbtql+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WVPQh6DU; arc=none smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WVPQh6DU"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A9817A32EB;
	Tue, 08 Sep 2026 17:17:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.99.41.105])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E70747A2E19;
	Tue, 08 Sep 2026 17:17:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Abortive: 2956a41a10d7bf7c_1788887857139_870462238
X-MC-Loop-Signature: 1788887857139:1718954542
X-MC-Ingress-Time: 1788887857139
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.41.105 (trex/8.0.2);
	Tue, 08 Sep 2026 17:17:37 +0000
Received: from pdx1-roundcube52 (ip-66-33-200-4.dreamhost.com [66.33.200.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4hfVxX4VsWzPH;
	Tue,  8 Sep 2026 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788887856;
	bh=5RmV9MmTuMHN/EVbE0LPaHM7dj+IFXvZTWQy0kyrqoc=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=WVPQh6DUkhf70stD8ie5NP7/Mz5rKJj6d7dv6+A3X4vyxGTEa9nf3RTUeAckURHSU
	 lFeFf9E72ryziSY7cpzngn50HSg+3MNvvEW4gVi1Dc8lCzgV7ST1RUpC8zQ1STCvJm
	 yGjMVbOBQnGcfI8+GkjJGNglRP0HdKQ5POf3x904HrPVAaLyF5m+xBH655Cfgo1XS0
	 p59sQNj2W/cOwyP5c/+wz0q/T6IFUInZxW84AumQ7zYXjrrS4Bjvcfo+y5I+5U9k/5
	 aXVI63W4nVmRQ1R5MjC2Fx3y3hZ2NegbB95TSvnoACp0XKTH2VBtzLdRmAibi2Ni/g
	 k0HmLysYQJM7w==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 10:17:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, alison.schofield@intel.com, jic23@kernel.org,
 dave.jiang@intel.com, gourry@gourry.net, icheng@nvidia.com,
 ming.li@zohomail.com, vishal.l.verma@intel.com, benjamin.cheatham@amd.com,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Anisa Su
 <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>, Junhee Park
 <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>, Fan Ni
 <nifan.cxl@gmail.com>
Subject: Re: [RESEND PATCH v13 5/8] cxl/pci: Factor out interrupt policy check
In-Reply-To: <20260908102124.2231730-7-anisa.su@samsung.com>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-7-anisa.su@samsung.com>
Message-ID: <65fb25e13a910f93cce392b2f5dfdbe8@stgolabs.net>
X-Sender: dave@stgolabs.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-08 03:15, Anisa Su wrote:
> From: Ira Weiny <iweiny@kernel.org>
> 
> Dynamic Capacity Devices (DCD) require event interrupts to process
> memory addition or removal.  BIOS may have control over non-DCD event
> processing.  DCD interrupt configuration needs to be separate from
> memory event interrupt configuration.
> 
> Factor out check for firmware ownership of memory event logs.
> 
> Link:
> https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/
> [1]
> Suggested-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Ira Weiny <iweiny@kernel.org>
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> Tested-by: Junhee Park <jh9934.park@samsung.com>
> Tested-by: Heesoo Kim <habil.kim@samsung.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Reviewed-by: Fan Ni <nifan.cxl@gmail.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
