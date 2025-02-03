Received: from cross.elm.relay.mailchannels.net (cross.elm.relay.mailchannels.net [23.83.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF9220F071
	for <linux-cxl@vger.kernel.org>; Mon,  3 Feb 2025 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615701; cv=pass; b=BAleiSMXYbZtJDCMfu6zvoPYNBz4eCYZn8L0koV1YOG3s+ApqhOzUyT3GcbbuYtsSRoDYPvFdt6l19RV2R4YQkkHCYgrANQXodEWCjma4qka2APfvO/CvycVJl3ZHicJaHu3ifFyP5wcXym+wdlFVRrrk8M2hpFsQClgyIWm8ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615701; c=relaxed/simple;
	bh=3t7lXOrkdiLVoRSduaQMwD8A8X223SsUN/FDdfDGM+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvKB1TgbZXB9cd6qNyH37PALSVPrY41h7iHtJA5/UDYE8bHgjTx4PtOEOEYAZMVkHQ5Ua22jT7YCxcepUYZ4PXk9kCRJWyd/aYAXU5bW6/pOSpU4lOurK2x+VATMkC78fc+80sk2WSwIOhFCSihZnUQ9MVHnZQFbMG1AC6HVJSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YCXsF9vL; arc=pass smtp.client-ip=23.83.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YCXsF9vL"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 499973214CB;
	Mon,  3 Feb 2025 20:48:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com (100-124-184-92.trex-nlb.outbound.svc.cluster.local [100.124.184.92])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BBEEC322000;
	Mon,  3 Feb 2025 20:48:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1738615691; a=rsa-sha256;
	cv=none;
	b=45V86dzd5IIDSPef/dM/WBsQpEHAJNbUZIcdYctgnG7LcwzepBy1YX7Jei0MDXam8tGZRx
	O4L1y2+kCGxm4DGePiUkJu4HYPvv0zroaHq4B/UHDlCqlv/CT+N9/aFo1somnvMC2XpxFC
	NxKsZKpwjftlOiA5P9Y+lg3MHJOrk8BEwViHWwtLnN1WrwiVo2LA46oA1kMdzWADif8LBz
	M9CJ0W2gHZVcwP3xEkuJTxXJHZk8x91iIewKsnEj+Lxf25fswD0bmzTMLRzH7plMOJm7YX
	GedmdWS85ndQ9z+CGFeSdusiCvU49kPDwB4+7cwn0Xk7Wj7Z4mzuc0cOhpjuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1738615691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3t7lXOrkdiLVoRSduaQMwD8A8X223SsUN/FDdfDGM+Q=;
	b=46ww6K8XS0uxEfPU+mljx7bWTNNPsJ9RiS6B9NEp26fgZe3TJqSO7m26bIoEIvwBIurfi5
	RJllFwCk9DQRNOlKg1BBQcBkfNwnAcm38q+mS/kGrWuNHgC6FS9yR3udW2PWBHmMurAj+6
	7/9RQQMjE9RzWkBTiccjcKcGGVLlJejFVFncnuvTooeDNDZcwS7KzoP4AavV+pk851v74R
	m4tRkxUFREagLH3uAGsAXQXxjVZh5yVuyteRygksOOirYT8s5m64Sc0ZlF5wjhcNkSe4Mh
	/IjjBXPSdvglm2zrwOj7A4u5LJofoXHPgsZltgqS8kntAU/QN8jU8J4wXwdEXg==
ARC-Authentication-Results: i=1;
	rspamd-854f7f575d-sp8xt;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bubble-Army: 421df66b41f2a4ea_1738615692100_2549867002
X-MC-Loop-Signature: 1738615692100:3734295062
X-MC-Ingress-Time: 1738615692100
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.124.184.92 (trex/7.0.2);
	Mon, 03 Feb 2025 20:48:12 +0000
Received: from offworld (unknown [104.36.25.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4Ymz966HyWzBS;
	Mon,  3 Feb 2025 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1738615691;
	bh=3t7lXOrkdiLVoRSduaQMwD8A8X223SsUN/FDdfDGM+Q=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=YCXsF9vLuObbKnWVA2YjxQztGfe8ycWJDC1/LTrqb+2uuoNHDuSmQU6fTyhaMLzpi
	 4eICTy44YnFMXLP1G3bw7sBWJU1YbIUbmeYecVb5av3y3gN8O5Gf/p6uHDkXTd1/VO
	 jnBgaqS8tnrHDsaqEZnrNiLlMRKJq0riByRbiwPNCL+cZOjy1mwllmN0wNhosdgcq0
	 SBDJ0DoB3LB6QSqaWgXxGBx2JYarmOkT+RGJv3RZol69iJVO6OG+Y1TVEe4RskAILv
	 JhtdBEEXAtc77JdAqaBnfrbnR6Y/LwjWcG+3PHQjBwsOef8SCaPFOGM2iN3t6IddyH
	 R5AyB5hOjvnZg==
Date: Mon, 3 Feb 2025 12:48:06 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com, hch@infradead.org,
	a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <20250203204806.gpc5x5vojoxci7yv@offworld>
References: <20250124233533.910535-1-dave@stgolabs.net>
 <da4fb0dd-9770-4368-b047-ba877e67bbbc@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <da4fb0dd-9770-4368-b047-ba877e67bbbc@intel.com>
User-Agent: NeoMutt/20220429

On Mon, 03 Feb 2025, Dave Jiang wrote:

>
>
>On 1/24/25 4:35 PM, Davidlohr Bueso wrote:
>> Add support for GPF flows. It is found that the CXL specification
>> around this to be a bit too involved from the driver side. And while
>> this should really all handled by the hardware, this patch takes
>> things with a grain of salt.
>>
>> Upon respective port enumeration, both phase timeouts are set to
>> a max of 20 seconds, which is the NMI watchdog default for lockup
>> detection. The premise is that the kernel does not have enough
>> information to set anything better than a max across the board
>> and hope devices finish their GPF flows within the platform energy
>> budget.
>>
>> Timeout detection is based on dirty Shutdown semantics. The driver
>> will mark it as dirty, expecting that the device clear it upon a
>> successful GPF event. The admin may consult the device Health and
>> check the dirty shutdown counter to see if there was a problem
>> with data integrity.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>Applied to cxl/next with some of Jonathan's change requests. Please check for accuracy.

Looks good, thanks. I will follow up with the dirty_shutdown sysfs
file.
